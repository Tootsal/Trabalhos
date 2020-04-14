Shield = class{}

sho = false
shield_sprite = love.graphics.newImage("sprites/shield.png")
shield_grid = anim8.newGrid(80, 80, 320, 161)
shield_animation = anim8.newAnimation(shield_grid('1-4', 1, '1-4', 2), 0.1)


function Shield:init()
  self.sprite = love.graphics.newQuad(160, 120, 40, 40, 400, 400)
  self.x = math.random(10, WORLD_WIDTH-10)
  self.y = math.random(10, WORLD_HEIGHT-10)
  self.remove = false
end

function Shield:update()
    if distance(self.x, self.y, player.x, player.y) < 30 then
      sho = true
      startSh = love.timer.getTime()
      self.remove = true
  end
end

function Shield:render()
  love.graphics.draw(powerups_img, self.sprite, self.x, self.y)
end

function shield_timer()
  if love.timer.getTime() - startSh > 7 then
    sho = false
  end
end
