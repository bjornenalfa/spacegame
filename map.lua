map = {}
local m = map

--m.maps = {}

function m.load(i)
  events.stopAll()
  planet.planets = {}
  planet.suns = {}
  player1.planet = {}
  player2.planet = {}
  if i == 1 then
    -- mass, x, y, radius, color, image
    sun = planet.newSun(1e8, 0, 0, 150, {255, 255, 255}, image.sun)
    -- mass, distance, radius, startAngle, speed, selfRotate, health, color, image
    planetDuoBase = planet.new( 1,      200,  0,      270, -0.5,   0,   100000, {0, 0, 0},  image.planet_3)
    planetDuo1 = planet.new(    4e6,    30,   20,     180,  1,     2,   100,    {255, 100, 200},  image.planet_5)
    planetDuo2 = planet.new(    4e6,    30,   20,     0,    1,     3,   100,    {100, 100, 255},  image.planet_1)
    planet1 = planet.new(       20e6,   350,  50,     0,    0.5,   1.0, 100,    {255, 255, 255},  image.planet_2)
    planet2 = planet.new(       20e6,   350,  50,     180,  0.5,   1.0, 100,    {255, 255, 255},  image.planet_1)
    planet3 = planet.new(       8e6,    1200, 20,     90,   0.01,  0.1, 50,     {255, 0, 250},    image.planet_3)
    planet4 = planet.new(       15e6,   800,  40,     180,  0.05,  0.2, 50,     {100, 100, 100},  image.planet_4)
    planet5 = planet.new(       12e6,   200,  35,     135, -0.5,   0.5, 70,     {100, 255, 100},  image.planet_2)
    planet6 = planet.new(       15e6,   600,  47,     45,  -0.1,   1.5, 120,    {100, 255, 180},  image.planet_4)
    moon1 = planet.new(         1e6,    100,  10,     0,    1.5,   0,   100,    {255, 255, 255},  image.planet_3)
    moon2 = planet.new(         1e6,    100,  12,     90,   1.5,   0,   100,    {200, 0, 200},    image.planet_1)
    sun:addMoons(planet1, planet2, planet3, planet4, planet5, planet6, planetDuoBase)
    planetDuoBase:addMoons(planetDuo1, planetDuo2)
    planet1:addMoon(moon1)
    planet1:addMoon(moon2)
    player1.planet = planet1
    player2.planet = planet2
  elseif i == 2 then
    p1sun = planet.newSun()
  end
end