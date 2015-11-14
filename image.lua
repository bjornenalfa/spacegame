image = {}
local i = image



function addImage(name)
  i[name] =  love.graphics.newImage("media/"..name..".png")
end

addImage("sun")
addImage("planet_1")
addImage("media/missile_atomicbomb.png")
