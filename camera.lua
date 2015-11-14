camera = {}
local c = camera

c.width = love.window.getWidth()
c.height = love.window.getHeight()
c.x = 0
c.y = 0

function camera.update()
  c.x, c.y = planet.getPlayerOne()
  -- bad zoom
  c.x = c.x * 0.3 + c.width/2
  c.y = c.y * 0.3 + c.height/2
end

function camera.draw()
  love.graphics.translate(c.x, c.y)
  love.graphics.scale(0.3)
end