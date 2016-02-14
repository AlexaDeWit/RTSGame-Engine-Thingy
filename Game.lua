local GameLib = {}

function GameLib.new( map, players )
  local Game = {} 
  local gameData = {}

  gameData.playerSpawns = map.getPlayerSpawns()

  function spawnPlayers()
    if not ( table.getn(gameData.playerSpawns) >= table.getn( players ) ) then
      error( "Insufficient spawn locations available" )
    end
  end

  function Game.renderBuildings()
  end

  spawnPlayers()

end

return GameLib
