local PlayerConstructor = {}

function PlayerConstructor.new( race, name, color )
  local Player = {}

  function Player.getRace()
    return race
  end
  return Player
end

return PlayerConstructor
