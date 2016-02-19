local ClientLib = {}

  local UserSettings = require( "UserSettings" )
  local UILib = require( "Src/IngameUI" )

  function ClientLib.initialize( mapWidth, mapHeight )
    local Client = {}
    UI = UILib.initialize()

    function getViewportSize()
      return {
        height = love.graphics.getHeight() - UI.getHeight(),
        width = love.graphics.getWidth()
      }
    end

    local Viewport = {
      x = 0,
      y = 0,
      size = getViewportSize
    }

    local MapDimensions = {
      width = mapWidth,
      height = mapHeight
    }


    function Client.draw( mapCanvas, game )
      drawViewport( mapCanvas, game ) 
      UI.draw()
    end

    function drawViewport( mapCanvas, game )
      local viewportSize = getViewportSize()
      local viewportBounds = {
        x  =  Viewport.x,
        ex =  viewportSize.width + Viewport.x,
        y  =  Viewport.y,
        ey =  viewportSize.height + Viewport.y
      }
      local viewportQuad = love.graphics.newQuad(
        Viewport.x,
        Viewport.y,
        viewportSize.width,
        viewportSize.height,
        mapWidth,
        mapHeight
      )
      local buildingsToRender = game.getBuildingsWithin( 
        viewportBounds.x,
        viewportBounds.y,
        viewportBounds.ex,
        viewportBounds.ey
      )
      local treesToRender = game.getTreesWithin( 
        viewportBounds.x,
        viewportBounds.y,
        viewportBounds.ex,
        viewportBounds.ey
      )
      local rocksToRender = game.getRocksWithin( 
        viewportBounds.x,
        viewportBounds.y,
        viewportBounds.ex,
        viewportBounds.ey
      )
      
      --Draw the viewport regon
      love.graphics.draw( mapCanvas, viewportQuad )
      --Draw the units present in that area
      for k,v in pairs( buildingsToRender ) do
        love.graphics.draw( k.getImage(), k.getFrameQuad(), v.x - Viewport.x, v.y - Viewport.y )
      end
      for k,v in pairs( treesToRender ) do
        love.graphics.draw( k:getImage(), k:getFrameQuad(), v.x - Viewport.x, v.y - Viewport.y )
      end
      for k,v in pairs( rocksToRender ) do
        love.graphics.draw( k:getImage(), k:getFrameQuad(), v.x - Viewport.x, v.y - Viewport.y )
      end
    end

    function Client.panCameraIfNeeded()
      local x, y = love.mouse.getPosition()
      local width = love.graphics.getWidth()
      local height = love.graphics.getHeight()
      if x <  4 then
        Client.scrollViewport( { x = -UserSettings.scrollSpeed, y = 0 } )
      elseif x > ( width - 4 ) then
        Client.scrollViewport( { x = UserSettings.scrollSpeed, y = 0 } )
      end
      if y < 4 then
        Client.scrollViewport( { x = 0, y = -UserSettings.scrollSpeed } )
      elseif y > ( height - 4 ) then
        Client.scrollViewport( { x = 0, y = UserSettings.scrollSpeed } )
      end
    end

    function Client.scrollViewport( offset )
      local size = getViewportSize()

      -- scroll
      local yloc = Viewport.y + offset.y
      if MapDimensions.height >= size.height + yloc and yloc >= 0 then
        Viewport.y = yloc
      elseif offset.y < 0 then
        Viewport.y = 0
      else
        Viewport.y = MapDimensions.height - size.height
      end
      
      --X scroll
      local xloc = Viewport.x + offset.x
      if MapDimensions.width >= size.width + xloc and xloc >= 0 then
        Viewport.x = xloc
      elseif  offset.x < 0 then
        Viewport.x = 0 
      else
        Viewport.x = MapDimensions.width - size.width
      end

    end
    
    Client.Viewport = Viewport
    Client.MapDimensions = MapDimensions
    return Client
  end

return ClientLib
