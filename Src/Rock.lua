local RockConstructor = {}

RockConstructor.tileset = love.graphics.newImage( "Assets/Neutral/rock.png" )
RockConstructor.width = 64
RockConstructor.height = 64
RockConstructor.startingResource = 1000
RockConstructor.quads = {}

function RockConstructor.new()
  local Rock = {}

  Rock.remaining = RockConstructor.startingResource

  function Rock.getImage( )
    return RockConstructor.tileset
  end

  function Rock.getFrameQuad()
    return RockConstructor.quads[1]
  end

  function Rock.isPendingDelete()
    return Rock.remaining <= 0
  end

  return Rock

end

function buildQuads()
  local quads = {}
  local i = 1
  local tileH = RockConstructor.height
  local imageHeight = RockConstructor.tileset:getHeight()
  local tileW = RockConstructor.width
  local imageWidth = RockConstructor.tileset:getWidth()
  for y=0, tileH - tileH, tileH do
    for x=0, tileW - tileW, tileW do
      quads[i] = love.graphics.newQuad(
      x,
      y,
      tileW,
      tileH,
      imageWidth,
      imageHeight
      )
      i = i + 1
    end
  end
  RockConstructor.quads = quads
end

buildQuads()

return RockConstructor
