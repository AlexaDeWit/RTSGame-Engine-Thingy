function love.load()

  --Load game libs
  MapLoader = require( "MapLoader" )
  KeyMap = require( "KeyMap" )
  KeyboardInputHandler = require( "KeyboardInputHandler" )
  ClientLib = require( "Client" )
  GameLib = require( "Game" )
  Mouse = require( "Mouse" )
  Player = require( "Player" )
  Human = require( "Races/Human/Human" )

  --Set up map
  map = MapLoader.load( "maps/theplains" )
  mapCanvas = map.renderMap()


  --set up a test player
  player = Player.new( Human, "Alexa", { r = 100, g = 100, b = 255 } ) 
  
  game = GameLib.new( map, {player})

  --set up the client
  client = ClientLib.initialize( mapCanvas:getWidth(), mapCanvas:getHeight() )
  love.keyboard.setKeyRepeat( true )
  love.mouse.setGrabbed( true )
  setScreenResolution()

end

function love.update()
  client.panCameraIfNeeded()
end

function love.draw()
  client.draw( mapCanvas, game )
end

function love.keypressed( key, scancode, isrepeat )
  local actionId = KeyMap.KeyDown[scancode]
  if actionId ~= nil and KeyboardInputHandler.KeyDown[actionId] ~= nil  then
    KeyboardInputHandler.KeyDown[actionId]( scancode,  client )
  end
end

function setScreenResolution()
  if not (love.window.setFullscreen( true )) then
    love.window.setFullscreen( false )
  end
end
