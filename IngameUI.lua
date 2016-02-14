local UILib = {}
local background = love.graphics.newImage( "Assets/UI/HUD2.png" )

function UILib.initialize()

  local UI = {}
  UI.prerendered = nil

  function prerender()
    if UI.prerendered ~= nil then
      return UI.prerendered
    end

    local canvas = love.graphics.newCanvas( background:getWidth(), background:getHeight() )
    love.graphics.setCanvas( canvas )
    love.graphics.draw( background, 0, 0 )
    love.graphics.setCanvas()
    UI.prerendered = canvas
    return canvas
  end

  function UI.draw()
    local base = prerender()
    local position = getStartPosition()
    love.graphics.draw( base, position.x, position.y )
  end

  function getStartPosition()
    local pos = {}
    pos.x = ( love.graphics.getWidth() / 2 ) - ( background:getWidth() / 2 )
    pos.y = love.graphics.getHeight() - background:getHeight()
    return pos
  end

  return UI
end

return UILib
