function love.load()

  --set up RNG
  math.randomseed( os.time() )
  math.random()
  --Load game libs
  MapLoader = require( "Src/MapLoader" )
  KeyMap = require( "KeyMap" )
  KeyboardInputHandler = require( "Src/KeyboardInputHandler" )
  ClientLib = require( "Src/Client" )
  GameLib = require( "Src/Game" )
  Mouse = require( "Src/Mouse" )
  Player = require( "Src/Player" )
  Human = require( "Src/Races/Human/Human" )

  --Set up map
  map = MapLoader.load( "maps/thegreatplains" )
  mapCanvas = map.renderMap()


  --set up a test player
  player = Player.new( Human, "Alexa", { r = 100, g = 100, b = 255 } ) 
  player2 = Player.new( Human, "Barbarian", { r = 255, g = 100, b = 100 } ) 

  
  game = GameLib.new( map, {player,player2})

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
