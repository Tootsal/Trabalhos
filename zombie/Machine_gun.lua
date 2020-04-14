Machine_gun = class{}


-- Machine_gun state
mgo = false

function Machine_gun:init(x, y)
  self.sprite = love.graphics.newQuad(40, 120, 40, 40, 400, 400)
  self.x = math.random(10, WORLD_WIDTH-10)
  self.y = math.random(10, WORLD_HEIGHT-10)
  self.remove = false
end

function Machine_gun:update(dt)
    if distance(self.x, self.y, player.x, player.y) < 30 then
      mgo = true
      startMg = love.timer.getTime()
      --table.insert(explosions, Explosion(self.x, self.y))
      self.remove = true
  end
end

function Machine_gun:render()
  love.graphics.draw(powerups_img, self.sprite, self.x, self.y)
end

function machine_gun_timer()
  if love.timer.getTime() - startMg > 10 then
    mgo = false
  end
end
