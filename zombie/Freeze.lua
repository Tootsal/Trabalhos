Freeze = class{}


fr = false

function Freeze:init()
  self.sprite = love.graphics.newQuad(80, 120, 40, 40, 400, 400)
  self.x = math.random(10, WORLD_WIDTH-10)
  self.y = math.random(10, WORLD_HEIGHT-10)
  self.remove = false
end

function Freeze:update(dt)
    if distance(self.x, self.y, player.x, player.y) < 30 then
      fr = true
      startFr = love.timer.getTime()
      --table.insert(explosions, Explosion(self.x, self.y))
      self.remove = true
  end
end

function Freeze:render()
  love.graphics.draw(powerups_img, self.sprite, self.x, self.y)
end

function freeze_timer()
  if love.timer.getTime() - startFr > 4 then
    fr = false
  end
end
