image = {}
local i = image

i.sun = love.graphics.newImage("media/sun.png")


i.planet = {}
function addPlanetImage(name)
  table.insert(i.planet, love.graphics.newImage("media/"..name..".png"))
end

addPlanetImage("planet_1")