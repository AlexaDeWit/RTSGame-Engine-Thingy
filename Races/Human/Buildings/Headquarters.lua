local HeadquartersConstructor = {}

HeadquartersConstructor.tileset = love.graphics.newImage( "Assets/BuildingsAndUnits/Human/Buildings/hq2.png" )
HeadquartersConstructor.width = 96
HeadquartersConstructor.height = 96
HeadquartersConstructor.maxHP = 1250
HeadquartersConstructor.healthRegen = 0
HeadquartersConstructor.armor = 2
HeadquartersConstructor.buildTime = 60
HeadquartersConstructor.attack = nil
HeadquartersConstructor.buildCost = {
  wood = 500,
  gold = 0
}
HeadquartersConstructor.visionRange = 8


function HeadquartersConstructor.new()
  local Headquarters = {}

  Headquarters.hp = HeadquartersConstructor.maxHP

  return Headquarters
end

return HeadquartersConstructor
