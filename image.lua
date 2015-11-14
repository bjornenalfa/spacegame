image = {}
local i = image



function addImage(name)
  i[name] =  love.graphics.newImage("media/"..name..".png")
end

addImage("sun")
addImage("sun_sunglasses")
addImage("planet_1")
addImage("missile_atomicbomb")
addImage("FireStationBase")

for i = 0,5 do
  addImage("cracks"..i)
end

addImage("background2")
addImage("stars1")
addImage("stars2")
addImage("stars3")
addImage("stars4")