local HouseConstructor = {}

HouseConstructor.tileset = love.graphics.newImage( "Assets/BuildingsAndUnits/Human/Buildings/house.png" )
HouseConstructor.width = 32
HouseConstructor.height = 32
HouseConstructor.maxHP = 450
HouseConstructor.healthRegen = 0
HouseConstructor.armor = 1
HouseConstructor.buildTime = 26
HouseConstructor.attack = nil
HouseConstructor.buildCost = {
  wood = 100,
  gold = 0
}
HouseConstructor.visionRange = 8


function HouseConstructor.new()
  local House = {}

  House.hp = HouseConstructor.maxHP

  return House
end

return HouseConstructor
