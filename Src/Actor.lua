local Actor = {
  setActorData = function( self, tileset, width, height )
    self.tileset = tileset
    self.tileWidth = width
    self.tileHeight = height
    self:buildQuads()
  end,

  buildQuads = function( self )
    local quads = {}
    local i = 1
    local tileH = self.tileHeight
    local imageHeight = self.tileset:getHeight()
    local tileW = self.tileWidth
    local imageWidth = self.tileset:getWidth()
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
    self.quads = quads
  end,

  getImage = function( self )
    return self.tileset
  end,

  getFrameQuad = function( self )
    return self.quads[1]
  end
}

return Actor
