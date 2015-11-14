background = {}
local b = background

function b.draw()
  if drunkMode == 1 then
    love.graphics.setColor(255, 255, 255)
    b.draw1()
  end
  starScale = 0.4
  imgList = {image.stars1, image.stars2, image.stars3, image.stars4}
  img = imgList[math.floor(time * 4 % 4 + 1)]
  width = img:getWidth()
  height = img:getHeight()
  for x = -10, 10 do
    for y = -10, 10 do
      if drunkMode == 0 then
        love.graphics.setColor(255, 255, 255, 120)
        love.graphics.draw(img, width * x * starScale, height * y * starScale, 0, starScale)
      elseif drunkMode == 1 then
        dir = 1
        if x % 2 == 1 then dir = -1 end
        diff = dir * (time * 400 % height)
        red = math.floor(time * 120 % 510)
        green = math.floor(time * 300 % 510)
        blue = math.floor(time * 420 % 510)
        if red > 255 then red = 509 - red end
        if green > 255 then green = 509 - green end
        if blue > 255 then blue = 509 - blue end
        love.graphics.setColor(red, green, blue)
        love.graphics.draw(img, width * x * starScale, (height * y + diff) * starScale, 0, starScale)
      end
    end
  end
end

function b.draw1()
  img = image.background2
  width = img:getWidth()
  height = img:getHeight()
  love.graphics.draw(img, - width / 2, - height / 2)
end