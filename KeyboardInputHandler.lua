local UserSettings = require( "UserSettings" )
local KeyboardInputHandler = {}
local KeyDown = {}

KeyDown.MapScroll_Down = function( scancode, clientContext )
  clientContext.scrollViewport( { x = 0, y = UserSettings.scrollSpeed } )
end

KeyDown.MapScroll_Up = function( scancode, clientContext )
  clientContext.scrollViewport( { x = 0, y = -UserSettings.scrollSpeed } )
end

KeyDown.MapScroll_Left = function( scancode, clientContext )
  clientContext.scrollViewport( { x = -UserSettings.scrollSpeed, y = 0 } )
end

KeyDown.MapScroll_Right = function( scancode, clientContext )
  clientContext.scrollViewport( { x = UserSettings.scrollSpeed, y = 0 } )
end

KeyboardInputHandler.KeyDown = KeyDown
KeyboardInputHandler.KeyUp = KeyUp
return KeyboardInputHandler
