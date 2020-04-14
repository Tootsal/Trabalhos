Player = class{}


function Player:init()
  self.sprite_idle = love.graphics.newImage("sprites/player_idle.png")
  self.sprite_move = love.graphics.newImage("sprites/player_move.png")
  self.sprite_idle_rifle = love.graphics.newImage("sprites/player_idle_rifle.png")
  self.sprite_move_rifle = love.graphics.newImage("sprites/player_move_rifle.png")
  self.grid_idle = anim8.newGrid(76,65,1520,65)
  self.grid_move = anim8.newGrid(76,65,1520,65)
  self.grid_idle_rifle = anim8.newGrid(76,65,1520,65)
  self.grid_move_rifle = anim8.newGrid(76,65,1520,65)
  self.animation_idle = anim8.newAnimation(self.grid_idle('1-20',1),0.05)
  self.animation_move = anim8.newAnimation(self.grid_move('1-20',1),0.05)
  self.animation_idle_rifle = anim8.newAnimation(self.grid_idle_rifle('1-20',1),0.05)
  self.animation_move_rifle = anim8.newAnimation(self.grid_move_rifle('1-20',1),0.05)
  self.width = 76
  self.height = 65
  self.x = WORLD_WIDTH/2
  self.y = WORLD_HEIGHT/2
  self.dead = 0
  self.speed = 180
  self.moving = false

end


function Player:update(dt)


    if gamestate ~= 0 then

    self.animation_idle:update(dt)

    self.moving = false

    if love.keyboard.isDown('a') and self.x > 0 then
        self.x = self.x - self.speed * dt
        self.animation_move:update(dt)
        self.moving = true
    end

    if love.keyboard.isDown('s') and self.y < WORLD_HEIGHT then
        self.y = self.y + self.speed * dt
        self.animation_move:update(dt)
        self.moving = true
    end

    if love.keyboard.isDown('d') and self.x < WORLD_WIDTH then
        self.x = self.x + self.speed * dt
        self.animation_move:update(dt)
        self.moving = true
    end

    if love.keyboard.isDown('w') and self.y > 0 then
        self.y = self.y - self.speed * dt
        self.animation_move:update(dt)
        self.moving = true
    end

    if mgo == true and self.moving == false then
      self.animation_idle_rifle:update(dt)

    elseif mgo == true and self.moving == true then
      self.animation_move_rifle:update(dt)
    end

  end

  -- When you die
  for i,b in ipairs(bugs) do
    if distance(b.x, b.y, player.x, player.y) < 30 and b.dead == false then
          for i,b in ipairs(bugs) do
              bugs[i] = nil
          end
          for i,p in ipairs(powerups) do
            powerups[i] = nil
          end
          gamestate = 0
          level = 1
          love.timer.sleep(2)
          levelTime = 30
          self.x = WORLD_WIDTH/2
          self.y = WORLD_HEIGHT/2
        end
    end

    if sp == true then
      self.speed = 360
    else
      self.speed = 180
    end

end


function Player:render()

    if mgo == true and self.moving == false then
      self.animation_idle_rifle:draw(self.sprite_idle_rifle, self.x, self.y, self:mouse(), nil, nil, self.width/2, self.height/2)

    elseif mgo == true and self.moving == true then
      self.animation_move_rifle:draw(self.sprite_idle_rifle, self.x, self.y, self:mouse(), nil, nil, self.width/2, self.height/2)

    elseif self.moving == false and mgo == false then
      self.animation_idle:draw(self.sprite_idle, self.x, self.y, self:mouse(), nil, nil, self.width/2, self.height/2)

    elseif self.moving == true and mgo == false then
      self.animation_move:draw(self.sprite_move, self.x, self.y, self:mouse(), nil, nil, self.width/2, self.height/2)
    end

    if sho == true then
      shield_animation:draw(shield_sprite, self.x, self.y-20, nil, 2, 2, self.width/2, self.height/2)
    end

end

function Player:mouse()
    x,y = cam:mousePosition()
    return math.atan2(y - self.y, x - self.x)
end
