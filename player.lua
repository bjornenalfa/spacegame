player = {}
local p = player

p.players = {}

function p.newPlayer(name, planet)
  newPlayer = {
    name = name,
    planet = planet
  }
  table.insert(p.players, newPlayer)
  return newPlayer
end