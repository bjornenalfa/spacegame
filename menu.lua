menu = {}
local m = menu

function m.draw()
  colorInside = {0, 255, 255}
  colorOutside = {0, 0, 255}
  m.drawOutlinedText("Space Battle Supreme", -300, 64, 3, colorInside, colorOutside)
  msgList = {"-- Player One --", "W - Fire", "A and D - Aim", "", "-- Player Two --", ""}
end

function m.drawOutlinedText(text, y, fontSize, lineWidth, colorInside, colorOutside)
  love.graphics.setFont(love.graphics.newFont(fontSize))
  love.graphics.setColor(colorOutside)
  for dx = -lineWidth, lineWidth, lineWidth do
    for dy = -lineWidth, lineWidth, lineWidth do
      love.graphics.printf(text, -400 + dx, y + dy, 800, "center")
    end
  end
  love.graphics.setColor(colorInside)
  love.graphics.printf(text, -400, y, 800, "center")
end