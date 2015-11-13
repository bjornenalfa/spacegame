require "planet"

camera = {}
local c = camera

c.width = love.window.getWidth()
c.height = love.window.getHeight()
c.x = 0
c.y = 0

function camera.update()
  c.x, c.y = planet.getPlayerOne()
  c.x = c.x + c.width/2
  c.y = c.y + c.height/2
end

function camera.draw()
  love.graphics.translate(c.x, c.y)
end