local GameLib = {}
local Tree = require( "Src/Tree" )

function GameLib.new( map, players )
  local Game = {}
  local unitList = {}
  local buildingList = {}
  local treesList = {}
  local playerSpawns = map.getPlayerSpawns()

  function spawnPlayers()
    if not ( table.getn(playerSpawns) >= table.getn( players ) ) then
      error( "Insufficient spawn locations available" )
    end
    for i,v in ipairs( players ) do
      buildingList[v.getRace().Buildings[v.getRace().StartingBuilding].new( player )] = {
        x = playerSpawns[i].x,
        y = playerSpawns[i].y
      }
    end
  end

  function spawnTrees()
    local treeObjects = map.getTreeSpawns()
    for i,v in ipairs(treeObjects) do
      treesList[ Tree.new() ] = {
        x = v.x,
        y = v.y
      }
    end
  end

  function Game.getTreesWithin( x, y, ex, ey )
    local trees = {}
    for k,v in pairs( treesList ) do
      if v.x > x and v.y > y and v.x < ex and v.y < ey then
        if k.isPendingDelete() then
          table.remove( treesList, k )
        else
          trees[k] = v
        end
      end
    end
    return trees
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

  return Game
end

return GameLib
