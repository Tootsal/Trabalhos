Beetle = class{}

function Beetle:init(x, y, speed, dead)

  self.grid_walk = anim8.newGrid(961,1007,4805,3021)
  self.grid_dead = anim8.newGrid(1157,1076,11570,1076)
  self.animation_walk = anim8.newAnimation(self.grid_walk('1-5',1, '1-5',2, '1-5',3),0.05)
  self.animation_die = anim8.newAnimation(self.grid_dead('1-10',1),0.025,"pauseAtEnd")
  self.width = 961
  self.height = 1007
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

  local r = math.random(5)

  if r == 1 then

    self.sprite_dead = black_beetle_die
    self.sprite_walk = black_beetle_walk

  elseif r == 2 then
    self.sprite_dead = blue_beetle_die
    self.sprite_walk = blue_beetle_walk

  elseif r == 3 then
    self.sprite_dead = red_beetle_die
    self.sprite_walk = red_beetle_walk

  elseif r == 4 then
    self.sprite_dead = yellow_beetle_die
    self.sprite_walk = yellow_beetle_walk

  else
    self.sprite_dead = green_beetle_die
    self.sprite_walk = green_beetle_walk
  end

end

function Beetle:update(dt)

  if fr == false and self.dead == false then
    self.animation_walk:update(dt)
    self.x = self.x + math.cos(self:DirectionToPlayer(self)) * self.speed * dt
    self.y = self.y + math.sin(self:DirectionToPlayer(self)) * self.speed * dt

  elseif self.dead == true then
    self.animation_die:update(dt)
  end

end

function Beetle:render()
  if self.dead == false then
      self.animation_walk:draw(self.sprite_walk, self.x, self.y,Beetle:DirectionToPlayer(self)+math.pi/2, 0.07*self.size, 0.07*self.size, self.width/2, self.height/2)
  else
      self.animation_die:draw(self.sprite_dead, self.x,self.y, self.d - math.pi/2, 0.07*self.size, 0.07*self.size,self.width/2, self.height/2)
  end

end

function Beetle:DirectionToPlayer(self)
    return math.atan2(player.y - self.y, player.x - self.x)
end
