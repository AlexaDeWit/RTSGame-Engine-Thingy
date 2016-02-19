local GameLib = {}
local Tree = require( "Src/Tree" )
local Rock = require( "Src/Rock" )

function GameLib.new( map, players )
  local Game = {}
  local unitList = {}
  local buildingList = {}
  local treesList = {}
  local rocksList = {}
  local playerSpawns = map.getPlayerSpawns()

  function spawnPlayers()
    if not ( table.getn(playerSpawns) >= table.getn( players ) ) then
      error( "Insufficient spawn locations available" )
    end
    for i,v in ipairs( players ) do
      local building = v.getRace().Buildings[v.getRace().StartingBuilding]
      buildingList[building( player )] = {
        x = playerSpawns[i].x,
        y = playerSpawns[i].y
      }
    end
  end

  function spawnTrees()
    local treeObjects = map.getTreeSpawns()
    for i,v in ipairs(treeObjects) do
      treesList[ Tree() ] = {
        x = v.x,
        y = v.y
      }
    end
  end
  
    function spawnRocks()
    local rockObjects = map.getRockSpawns()
    for i,v in ipairs(rockObjects) do
      rocksList[ Rock() ] = {
        x = v.x,
        y = v.y
      }
    end
  end

  function Game.getTreesWithin( x, y, ex, ey )
    local trees = {}
    for k,v in pairs( treesList ) do
      if v.x > x and v.y > y and v.x < ex and v.y < ey then
        if k:isPendingDelete() then
          table.remove( treesList, k )
        else
          trees[k] = v
        end
      end
    end
    return trees
  end

  function Game.getRocksWithin( x, y, ex, ey )
    local rocks = {}
    for k,v in pairs( rocksList ) do
      if v.x > x and v.y > y and v.x < ex and v.y < ey then
        if k:isPendingDelete() then
          table.remove( rocksList, k )
        else
          rocks[k] = v
        end
      end
    end
    return rocks
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
  spawnTrees()
  spawnRocks()

  return Game
end

return GameLib
