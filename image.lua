image = {}
local i = image



function addImage(name)
  i[name] =  love.graphics.newImage("media/"..name..".png")
end

addImage("sun")
addImage("planet_1")
addImage("missile_atomicbomb")
addImage("FireStationBase")
addImage("background2")