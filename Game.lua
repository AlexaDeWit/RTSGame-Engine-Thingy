local GameLib = {}

function GameLib.new( map, players )
  local Game = {} 
  local gameData = {}
  local unitList = {}
  local buildingList = {}

  gameData.playerSpawns = map.getPlayerSpawns()

  function spawnPlayers()
    if not ( table.getn(gameData.playerSpawns) >= table.getn( players ) ) then
      error( "Insufficient spawn locations available" )
    end
    for i,v in ipairs( players ) do
      buildingList[v.getRace().Buildings[v.getRace().StartingBuilding].new( player )] = {
        x = gameData.playerSpawns[i].x,
        y = gameData.playerSpawns[i].y
      }
    end
  end

  function Game.getBuildingsWithin( x, y, ex, ey )
    local buildings = {}
    for k,v in pairs( buildingList ) do 
      if v.x > x and v.y > y and v.x < ex and v.y < ey then
        buildings[k] = v
      end
    end
    return buildings
  end

  function Game.getUnitsWithin( x, y, ex, ey )
  end

  spawnPlayers()

  return Game
end

return GameLib
