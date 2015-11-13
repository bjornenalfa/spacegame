require "planet"

camera = {}
local c = camera

c.x = 0
c.y = 0

function camera.update()
  c.x = 0
end

function camera.draw()
  love.graphics.translate(c.x, c.y)
end