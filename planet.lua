planet = {}
local p = planet

p.planets = {}

function planet.new(mass, distance, radius, angle, speed)
  table.insert(p.planets, {
      m = mass, 
      d = distance, 
      r = radius, 
      x = 0, 
      y = 0,
      angle = 0,
      speed = speed
  })
end

function planet.update(dt)
  for _,v in pairs(p.planets) do
    v.angle = v.angle + dt*v.speed
    v.x = 400+math.cos(v.angle)*v.d
    v.y = 300+math.sin(v.angle)*v.d
  end
end

function planet.draw()
  love.graphics.setColor(50,50,230)
  for _,v in pairs(p.planets) do
    love.graphics.circle("fill", v.x, v.y, v.r)
  end
end