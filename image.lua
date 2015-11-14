image = {}
local i = image

function addImage(name)
  i[name] =  love.graphics.newImage("media/"..name..".png")
end

addImage("sun")
addImage("sun_sunglasses")
addImage("planet_1")
addImage("planet_2")
addImage("planet_3")
addImage("planet_4")
addImage("planet_5")
addImage("missile_atomicbomb")
addImage("missile_atomicbombSmall")
addImage("FireStationBase")
addImage("FireStationBase_cannon")
addImage("cannonSmall")
addImage("cannonBig")

for i = 0,5 do
  addImage("cracks"..i)
end

for i = 1,6 do
  addImage("planetexplosion"..i)
end

for i = 1,5 do
  addImage("planetdebris"..i)
end

addImage("background2")
addImage("stars1")
addImage("stars2")
addImage("stars3")
addImage("stars4")
addImage("star1")
addImage("star2")