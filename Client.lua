local ClientLib = {}

  local UserSettings = require( "UserSettings" )
  local UILib = require( "IngameUI" )

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


    function Client.draw( mapCanvas )
      drawViewport( mapCanvas ) 
      UI.draw()
    end

    function drawViewport( mapCanvas )
      local viewportSize = getViewportSize()
      local viewportQuad = love.graphics.newQuad(
        Viewport.x,
        Viewport.y,
        viewportSize.width,
        viewportSize.height,
        mapWidth,
        mapHeight
      )
      love.graphics.draw( mapCanvas, viewportQuad )
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
