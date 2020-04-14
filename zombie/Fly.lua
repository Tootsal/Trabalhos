Fly = class{}


function Fly:init(x, y, speed, dead)

  self.sprite_dead = fly_dead
  self.sprite = fly
  self.grid_walk = anim8.newGrid(819,668,3276,3340)
  self.animation_walk = anim8.newAnimation(self.grid_walk('1-4',1, '1-4',2, '1-4',3, '1-4',4, '1-4',5),0.1)
  self.width = 819
  self.height = 668
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

end

function Fly:update(dt)

  if fr == false and self.dead == false then
    self.animation_walk:update(dt)
    self.x = self.x + math.cos(self:DirectionToPlayer(self)) * self.speed * dt
    self.y = self.y + math.sin(self:DirectionToPlayer(self)) * self.speed * dt
  end

end

function Fly:render()
  if self.dead == false then
      self.animation_walk:draw(self.sprite, self.x, self.y,Fly:DirectionToPlayer(self)+math.pi/2, 0.08333*self.size, 0.08333*self.size, self.width/2, self.height/2)
  else
      love.graphics.draw(self.sprite_dead, self.x,self.y, self.d, 0.08333*self.size, 0.08333*self.size,self.width/2, self.height/2)
  end

end

function Fly:DirectionToPlayer(self)
    return math.atan2(player.y - self.y, player.x - self.x)
end
