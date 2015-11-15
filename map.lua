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
    planet1 = planet.new(       2e7,   350,  50,     0,    0.5,   1.0, 100,    {255, 255, 255},  image.planet_2)
    planet2 = planet.new(       2e7,   350,  50,     180,  0.5,   1.0, 100,    {255, 255, 255},  image.planet_1)
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
    camera.scale = 5
    camera.mapScale = 0.65
  elseif i == 4 then
    p1sun = planet.newSun(2e7, -420, 0, 75, {255, 255, 255}, image.sun)
    p2sun = planet.newSun(2e7, 420, 0, 75, {255, 255, 255}, image.sun)
    sun = planet.newSun(6e7, 0, 0, 100, {255, 255, 255}, image.sun)
    p1p = planet.new(       2e7,   170,  40,     0,    1.0,   1.0, 100,    {255, 255, 255},  image.planet_2)
    p1sun:addMoon(p1p)
    p2p = planet.new(       2e7,   170,  40,     180,  1.0,   1.0, 100,    {255, 255, 255},  image.planet_1)
    p2sun:addMoon(p2p)
    planet5 = planet.new(       12e6,   150,  35,     135, -1.5,   0.5, 70,     {100, 255, 100},  image.planet_2)
    sun:addMoon(planet5)
    player1.planet = p1p
    player2.planet = p2p
    camera.scale = 0.1
    camera.mapScale = 0.6
  elseif i == 2 then
    p1sun = planet.newSun(2e7, -300, 0, 75, {255, 255, 255}, image.sun)
    p2sun = planet.newSun(2e7, 300, 0, 75, {255, 255, 255}, image.sun)
    sun = planet.newSun(6e7, 0, 0, 100, {255, 255, 255}, image.sun)
    p1p = planet.new(       2e7,   110,  40,     0,    1.0,   1.0, 100,    {255, 255, 255},  image.planet_2)
    p1sun:addMoon(p1p)
    p2p = planet.new(       2e7,   110,  40,     180,  1.0,   1.0, 100,    {255, 255, 255},  image.planet_1)
    p2sun:addMoon(p2p)
    planet5 = planet.new(       12e6,   150,  35,     135, -1.5,   0.5, 70,     {100, 255, 100},  image.planet_2)
    sun:addMoon(planet5)
    player1.planet = p1p
    player2.planet = p2p
    camera.scale = 0.1
    camera.mapScale = 0.75
  end
end