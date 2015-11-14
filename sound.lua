sound = {}
local s = sound

-- for long sound tracks
function addSound(name, ext)
  s[name] = love.audio.newSource("media/audio/"..name..ext)
end

-- for short sound tracks
function addStaticSound(name, ext)
  s[name] = love.audio.newSource("media/audio/"..name..ext, "static")
end

addSound("battle1", ".ogg")
addSound("sandstorm", ".mp3")