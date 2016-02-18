local TreeConstructor = {}

TreeConstructor.tileset = love.graphics.newImage( "Assets/Neutral/tree.png" )
TreeConstructor.width = 32
TreeConstructor.height = 32
TreeConstructor.startingResource = 500
TreeConstructor.quads = {}

function TreeConstructor.new()
  local Tree = {}

  Tree.remaining = TreeConstructor.startingResource

  function Tree.getImage( )
    return TreeConstructor.tileset
  end

  function Tree.getFrameQuad()
    return TreeConstructor.quads[1]
  end

  function Tree.isPendingDelete()
    return Tree.remaining <= 0
  end

  return Tree

end

function buildQuads()
  local quads = {}
  local i = 1
  local tileH = TreeConstructor.height
  local imageHeight = TreeConstructor.tileset:getHeight()
  local tileW = TreeConstructor.width
  local imageWidth = TreeConstructor.tileset:getWidth()
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
  TreeConstructor.quads = quads
end

buildQuads()

return TreeConstructor
