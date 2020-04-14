Speed_boost = class{}


sp = false

function Speed_boost:init()
  self.sprite = love.graphics.newQuad(0, 160, 40, 40, 400, 400)
  self.x = math.random(10, WORLD_WIDTH-10)
  self.y = math.random(10, WORLD_HEIGHT-10)
  self.remove = false
end

function Speed_boost:update()
    if distance(self.x, self.y, player.x, player.y) < 30 then
      sp = true
      startSp = love.timer.getTime()
      self.remove = true
  end
end

function Speed_boost:render()
  love.graphics.draw(powerups_img, self.sprite, self.x, self.y)
end


function speed_boost_timer()
  if love.timer.getTime() - startSp > 7 then
    sp = false
  end
end
