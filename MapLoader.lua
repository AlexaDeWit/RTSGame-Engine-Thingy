local MapLoader = {}

function MapLoader.validateMap( mapData )
  return true
end

--Type Constructor
function MapLoader.load( filename )
  local mapData = require( filename )
  local memoisedQuads = {}
  local tilesetImages = {}

  --validate map immediately before constructing the Map type.
  if not MapLoader.validateMap( mapData ) then
    error("Invalid Map File: " + filename )
  end
  --construct the Map type
  local Map = {
    renderedMap = nil
  }

  function getLayerByName( name )
    for index,layer in pairs(mapData.layers) do 
      if( layer.name == name ) then
        return layer
      end
    end
    error( "No map layer found with the name " .. name )
  end

  function Map.getQuads( tilesetIndex )
    --return immediately if quads already calculated
    if memoisedQuads[tilesetIndex] ~= nil then
      return memoisedQuads[tilesetIndex]
    end
    --build uncalculated quads
    local tileset = mapData.tilesets[tilesetIndex]
    local quads = {}
    local i = 1
    for y=0, tileset.imageheight - tileset.tileheight, tileset.tileheight do
      for x=0, tileset.imagewidth - tileset.tilewidth, tileset.tilewidth do
        quads[i] = love.graphics.newQuad(
          x,
          y,
          tileset.tilewidth,
          tileset.tileheight,
          tileset.imagewidth,
          tileset.imageheight
        )
        i = i + 1
      end
    end
    --store quads in memoisation structure before returning
    memoisedQuads[tilesetIndex] = quads
    return quads
  end

  function Map.getTileset( tilesetIndex )
    if tilesetImages[tilesetIndex] == nil then
      tilesetImages[tilesetIndex] = love.graphics.newImage(
        mapData.tilesets[tilesetIndex].image
      )
    end
    return tilesetImages[tilesetIndex]
  end

  --[[
  --Return type:
  --{
  --  layer: table,
  --  tileset: {
  --    image: Love2DImage
  --    quads: Table of Quads
  --  }
  --}
  --]]
  function getVisibleLayerData()
    local visibleLayerData = {}
    local i = 1
    for layerIndex=1, #mapData.layers do
      if (mapData.layers[layerIndex].visible == true) and (mapData.layers[layerIndex].type == "tilelayer" ) then
        visibleLayerData[i] = {
          layer = mapData.layers[layerIndex],
          tileset =  {
            image = Map.getTileset( 1 ),
            quads = Map.getQuads( 1 )
          }
        }
        i = i + 1
      end
    end
    return visibleLayerData
  end

  function Map.renderMap() 
    if Map.renderedMap ~= nil then
      return Map.renderedMap
    end

    local layerData = getVisibleLayerData()
    local canvas  = love.graphics.newCanvas(
      mapData.width * mapData.tilewidth,
      mapData.height * mapData.tileheight
    )
    for k,v in pairs( layerData ) do
      Map.drawLayerToCanvas( v, canvas )
    end
    Map.renderedMap = canvas
    return canvas
  end


  --Sideffecting function which mutates an input canvas
  function Map.drawLayerToCanvas( layerInfo, canvas )
    --simplify data access
    local tileset = layerInfo.tileset.image
    local quads = layerInfo.tileset.quads
    local layer= layerInfo.layer
    --switch to the provided canvas
    love.graphics.setCanvas( canvas )

    for rowIndex=1, layer.height, 1 do
      for colIndex=1, layer.width, 1 do
        local number = layer.data[
        (rowIndex - 1 ) * layer.width + colIndex 
        ]
        if number ~= 0 then
          love.graphics.draw(
          tileset,
          quads[number],
          ( colIndex - 1 ) * mapData.tilewidth,
          ( rowIndex - 1 ) * mapData.tileheight
          )
        end
      end
    end

    --switch to the previous canvas
    love.graphics.setCanvas()
  end

  function Map.renderLayer( layerIndex )
    if Map.renderedLayers[layerIndex] ~= nil then
      return Map.renderedLayers[layerIndex]
    end
    local quads = Map.getQuads( layerIndex )
    local tileset = Map.getTileset( 1 )

    local canvas = love.graphics.newCanvas(
      mapData.width * mapData.tilewidth,
      mapData.height * mapData.tileheight
    )
    love.graphics.setCanvas( canvas )
    for rowIndex=1, mapData.layers[layerIndex].height, 1 do
      for colIndex=1, mapData.layers[layerIndex].width, 1 do
        local number = mapData.layers[layerIndex].data[
          (rowIndex - 1 ) * mapData.layers[layerIndex].width + colIndex 
        ]
        if number ~= 0 then
          love.graphics.draw(
            tileset,
            quads[number],
            ( colIndex - 1 ) * mapData.tilewidth,
            ( rowIndex - 1 ) * mapData.tileheight
          )
        end
      end
    end
    love.graphics.setCanvas()
    Map.renderedLayers[layerIndex] = canvas
    return Map.renderedLayers[layerIndex]
  end

  function Map.getSize()
    return {
      width = ( mapData.width * mapData.tilewidth ),
      height = ( mapData.height * mapData.tileheight )
    }
  end

  function Map.getPlayerSpawns()
    local spawnLayer = getLayerByName("Start_Locations")
    return spawnLayer.objects
  end

  return Map
end

return MapLoader
