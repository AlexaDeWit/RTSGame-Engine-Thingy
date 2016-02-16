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
HeadquartersConstructor.quads = {}


function HeadquartersConstructor.new( owner )
  local Headquarters = {}

  Headquarters.hp = HeadquartersConstructor.maxHP

  function Headquarters.getOwner()
    return owner
  end

  function Headquarters.getImage()
    return HeadquartersConstructor.tileset
  end

  function Headquarters.getFrameQuad()
    return HeadquartersConstructor.quads[1]
  end

  return Headquarters
end

function buildQuads()
  local quads = {}
  local i = 1
  local tileH = HeadquartersConstructor.height
  local imageHeight = HeadquartersConstructor.tileset:getHeight()
  local tileW = HeadquartersConstructor.width
  local imageWidth = HeadquartersConstructor.tileset:getWidth()
  for y=0, tileH - tileH, tileH do
    for x=0, tileW - tileW, tileW do
      quads[i] = love.graphics.newQuad(
      x,
      y,
      tileW,
      tileH,
      imageWidth,
      imageHeight
      )
      i = i + 1
    end
  end
  HeadquartersConstructor.quads = quads
end

buildQuads()

return HeadquartersConstructor
