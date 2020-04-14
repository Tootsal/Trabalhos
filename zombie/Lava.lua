Lava = class{}


function Lava:init(x, y, speed, dead)


  self.sprite_dead = lava_die
  self.grid_walk = anim8.newGrid(248,376,4960,376)
  self.grid_dead = anim8.newGrid(248,376,1240,376)
  self.animation_walk = anim8.newAnimation(self.grid_walk('1-20',1),0.05)
  self.animation_die = anim8.newAnimation(self.grid_dead('1-5',1),0.025,"pauseAtEnd")
  self.width = 248
  self.height = 376
  self.x = x
  self.y = y
  self.speed = speed
  self.dead = false


  local s = math.random(6)
  if s == 1 then
    self.size = 1.5
    self.life = 4
  else
    self.size = 1
    self.life = 1
  end

  if math.random(2) == 1 then self.sprite_walk = lava_walk else self.sprite_walk = lava_walk2 end

end

function Lava:update(dt)

  if fr == false and self.dead == false then
    self.animation_walk:update(dt)
    self.x = self.x + math.cos(self:DirectionToPlayer(self)) * self.speed * dt
    self.y = self.y + math.sin(self:DirectionToPlayer(self)) * self.speed * dt

  elseif self.dead == true then
    self.animation_die:update(dt)

  end

end

function Lava:render()
  if self.dead == false then
      self.animation_walk:draw(self.sprite_walk, self.x, self.y,Lava:DirectionToPlayer(self)+math.pi/2, 0.2*self.size, 0.2*self.size, self.width/2, self.height/2)
  else
      self.animation_die:draw(self.sprite_dead, self.x,self.y, self.d, 0.2*self.size, 0.2*self.size,self.width/2, self.height/2)
  end

end

function Lava:DirectionToPlayer(self)
    return math.atan2(player.y - self.y, player.x - self.x)
end
