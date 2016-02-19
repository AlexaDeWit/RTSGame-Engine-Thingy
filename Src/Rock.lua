local class = require( "Lib/middleclass" )
local Actor = require( "Src/Actor" )
local Rock = class("Rock")
Rock:include(Actor)


Rock.static.tileset = love.graphics.newImage( "Assets/Neutral/rock.png" )
Rock.static.startingResource = 1500

function Rock:initialize()
  self:setActorData( Rock.tileset, 64, 64 )
  self.remaining = Rock.startingResource
end

function Rock:isPendingDelete()
  return self.remaining <= 0
end

return Rock


