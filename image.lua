image = {}
local i = image


function addImage(name)
  table.insert(i, name, love.graphics.newImage("media/"..name..".png"))
end

addImage("sun")
addImage("planet_1")