require "planet"

function love.load()
  love.graphics.setBackgroundColor(0,0,0)
end

planet.new(1, 200, 50, 0, 0.1)
planet.new(1, 300, 20, 2, 0.5)

time = 0
function love.update(dt)
  time = time + dt
  planet.update(dt)
end

function love.draw()
  love.graphics.setColor(255,255,0)
  love.graphics.circle("fill",400,300,100)
  planet.draw()
end