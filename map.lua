map = {}
local m = map

--m.maps = {}

function m.load(i)
  events.stopAll()
  asteroid.asteroids = {}
  projectile.projectiles = {}
  planet.planets = {}
  planet.suns = {}
  events.showtext = false
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
    planet2:addMoon(moon2)
    player1.planet = planet1
    player2.planet = planet2
    player1.towerAngle = -math.pi/2
    player2.towerAngle = math.pi/2
    camera.scale = 5
    camera.mapScale = 0.65
  elseif i == 2 then
    p1sun = planet.newSun(2e7, -300, 0, 75, {255, 255, 255}, image.sun)
    p2sun = planet.newSun(2e7, 300, 0, 75, {255, 255, 255}, image.sun)
    sun = planet.newSun(3e7, 0, 0, 100, {255, 255, 255}, image.sun)
    p1p = planet.new(       2e7,   110,  40,     0,    1.0,   1.0, 100,    {255, 255, 255},  image.planet_2)
    p1sun:addMoon(p1p)
    p2p = planet.new(       2e7,   110,  40,     180,  1.0,   1.0, 100,    {255, 255, 255},  image.planet_1)
    p2sun:addMoon(p2p)
    planet5 = planet.new(       12e6,   150,  35,     135, -1.5,   0.5, 70,     {100, 255, 100},  image.planet_2)
    sun:addMoon(planet5)
    player1.planet = p1p
    player2.planet = p2p
    player1.towerAngle = -math.pi/2
    player2.towerAngle = math.pi/2
    camera.scale = 0.1
    camera.mapScale = 0.75
    -- mass, distance, radius, startAngle, speed, selfRotate, health, color, image
  elseif i == 3 then
    p1sun = planet.newSun(2e7, -300, 200, 75, {255, 255, 255}, image.sun)
    p2sun = planet.newSun(2e7, 300, -200, 75, {255, 255, 255}, image.sun)
    p1p = planet.new(       2e7,   110,  40,     0,    1.0,   1.0, 100,    {255, 255, 255},  image.planet_5)
    p1sun:addMoon(p1p)
    p2p = planet.new(       2e7,   110,  40,     180,  1.0,   1.0, 100,    {255, 255, 255},  image.planet_3)
    p2sun:addMoon(p2p)
    planet5 = planet.new(       12e6,   350,  60,     135, -1.5,   0.5, 70,     {100, 255, 100},  image.planet_1)
    planet6 = planet.new(       12e6,   350,  60,     135, -1.5,   0.5, 70,     {100, 255, 100},  image.planet_3)
    p1sun:addMoon(planet5)
    p2sun:addMoon(planet6)
    player1.planet = p1p
    player2.planet = p2p
    player1.towerAngle = -math.pi/2
    player2.towerAngle = math.pi/2
    camera.scale = 2
    camera.mapScale = 0.6
    -- mass, distance, radius, startAngle, speed, selfRotate, health, color, image
  elseif i == 4 then
    p1sun = planet.newSun(2e7, -420, 0, 75, {255, 255, 255}, image.sun)
    p2sun = planet.newSun(2e7, 420, 0, 75, {255, 255, 255}, image.sun)
    in1 = planet.newSun(-2e6, 0, -400, 75, {255, 255, 255}, image.inverter)
    in1 = planet.newSun(-2e6, 0, 400, 75, {255, 255, 255}, image.inverter)
    sun = planet.newSun(6e7, 0, 0, 100, {255, 255, 255}, image.sun)
    p1p = planet.new(       2e7,   170,  40,     0,    0.5,   0.5, 100,    {255, 255, 255},  image.planet_2)
    p1sun:addMoon(p1p)
    p2p = planet.new(       2e7,   170,  40,     180,  0.5,   0.5, 100,    {255, 255, 255},  image.planet_1)
    p2sun:addMoon(p2p)
    planet5 = planet.new(       12e6,   150,  35,     135, -1.5,   0.5, 70,     {100, 255, 100},  image.planet_2)
    sun:addMoon(planet5)
    player1.planet = p1p
    player2.planet = p2p
    player1.towerAngle = -math.pi/2
    player2.towerAngle = math.pi/2
    camera.scale = 0.1
    camera.mapScale = 0.6
  elseif i == 5 then
    sun = planet.newSun(6e7, 0, 0, 150, {255, 255, 255}, image.sun)
    p1p = planet.new(       2e7,   300,  40,     0,    1.0,   1.5, 100,    {255, 255, 255},  image.planet_5)
    sun:addMoon(p1p)
    p2p = planet.new(       2e7,   300,  40,     180,  1.0,   1.5, 100,    {255, 255, 255},  image.planet_3)
    sun:addMoon(p2p)
    planet5 = planet.new(       12e6,   400,  60,     100, -0.5,   0.5, 70,     {100, 255, 100},  image.planet_1)
    planet6 = planet.new(       2e6,   500,  40,     130, 0.7,   0.5, 70,     {100, 255, 100},  image.planet_3)
    planet7 = planet.new(       2e6,   200,  30,     130, 0.8,   0.5, 70,     {100, 255, 100},  image.planet_5)
    sun:addMoon(planet5)
    sun:addMoon(planet6)
    sun:addMoon(planet7)
    player1.planet = p1p
    player2.planet = p2p
    player1.towerAngle = math.pi
    player2.towerAngle = 0
    camera.scale = 2
    camera.mapScale = 0.6
  elseif i == 6 then
    p1sun = planet.newSun(4e7, -300, 200, 100, {255, 255, 255}, image.sun)
    p2sun = planet.newSun(4e7, 300, -200, 100, {255, 255, 255}, image.sun)
    insun1 = planet.newSun(-3e7, -350, -250, 75, {255, 255, 255}, image.inverter)
    insun2 = planet.newSun(-3e7, 350, 250, 75, {255, 255, 255}, image.inverter)
    p1p = planet.new(       2e7,   200,  40,     0,    1.0,   1.0, 100,    {255, 255, 255},  image.planet_2)
    p1sun:addMoon(p1p)
    p2p = planet.new(       2e7,   200,  40,     180,  1.0,   1.0, 100,    {255, 255, 255},  image.planet_2)
    p2sun:addMoon(p2p)
    planet5 = planet.new(       12e6,   350,  40,     135, -1.5,   0.5, 70,     {255, 255, 255},  image.planet_1)
    planet6 = planet.new(       12e6,   350,  40,     135, -1.5,   0.5, 70,     {255, 255, 255},  image.planet_1)
    p1sun:addMoon(planet5)
    p2sun:addMoon(planet6)
    player1.planet = p1p
    player2.planet = p2p
    player1.towerAngle = -math.pi/2
    player2.towerAngle = math.pi/2
    camera.scale = 2
    camera.mapScale = 0.6
  elseif i == 7 then
    sun = planet.newSun(4e7, 0, 0, 125, {255, 255, 255}, image.sun)
    insun1 = planet.newSun(-8e7, -500, -400, 75, {255, 255, 255}, image.inverter)
    insun2 = planet.newSun(-8e7, 500, 400, 75, {255, 255, 255}, image.inverter)
    insun3 = planet.newSun(-8e7, -500, 400, 75, {255, 255, 255}, image.inverter)
    insun4 = planet.newSun(-8e7, 500, -400, 75, {255, 255, 255}, image.inverter)
    insun5 = planet.newSun(-8e7, 0, -600, 75, {255, 255, 255}, image.inverter)
    insun6 = planet.newSun(-8e7, 0, 600, 75, {255, 255, 255}, image.inverter)
    insun7 = planet.newSun(-8e7, 750, 0, 75, {255, 255, 255}, image.inverter)
    insun8 = planet.newSun(-8e7, -750, 0, 75, {255, 255, 255}, image.inverter)
    p1p = planet.new(       2e7,   300,  40,     0,    1.0,   1.5, 100,    {255, 255, 255},  image.planet_1)
    sun:addMoon(p1p)
    p2p = planet.new(       2e7,   300,  40,     180,  1.0,   1.5, 100,    {255, 255, 255},  image.planet_2)
    sun:addMoon(p2p)
    planet5 = planet.new(       2e7,   400,  75,     100, -0.7,   0.5, 70,     {100, 255, 100},  image.planet_1)
    planet6 = planet.new(       2e6,   500,  40,     130, 0.7,   0.5, 70,     {100, 255, 100},  image.planet_3)
    planet7 = planet.new(       -5e6,   200,  35,     130, 1.5,   0.5, 70,     {255, 255, 255},  image.inverter)
    sun:addMoon(planet5)
    sun:addMoon(planet6)
    sun:addMoon(planet7)
    player1.planet = p1p
    player2.planet = p2p
    player1.towerAngle = math.pi
    player2.towerAngle = 0
    camera.scale = 2
    camera.mapScale = 0.5
  else error("Invalid level ID")
  end
end