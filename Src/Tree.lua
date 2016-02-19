local class = require( "Lib/middleclass" )
local Actor = require( "Src/Actor" )
local Tree = class("Tree")
Tree:include(Actor)

Tree.static.tileset = love.graphics.newImage( "Assets/Neutral/tree.png" )
Tree.static.startingResource = 500

function Tree:initialize()
  self:setActorData( Tree.tileset, 32, 32 )
  self.remaining = Tree.startingResource
end

function Tree:isPendingDelete()
  return self.remaining <= 0
end

return Tree
