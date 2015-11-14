require "planet"
require "projectile"
require "camera"

function love.load()
  love.graphics.setBackgroundColor(0,0,0)
  planet.new(1, 200, 50, 0, 0.5)
  planet.new(1, 300, 20, 2, 0.1)
  planet.new(1, 400, 40, 1, 0.02)
  projectile.new(0.01, 10, 10, 5, 5, 0, 20, 90)
end


time = 0
function love.update(dt)
  time = time + dt
  camera.update()
  planet.update(dt)
  projectile.update(dt)
end

function love.draw()
  camera.draw()
  love.graphics.setColor(255,255,0)
  love.graphics.circle("fill",400,300,100)
  planet.draw()
  projectile.draw()
end