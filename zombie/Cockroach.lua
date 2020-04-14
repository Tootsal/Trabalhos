Cockroach = class{}

function Cockroach:init(x, y, speed)

    self.sprite_dead = cockroach_dead
    self.sprite = cockroach
    self.grid = anim8.newGrid(726,1084,3630,2168)
    self.animation = anim8.newAnimation(self.grid('1-5',1,'1-5',2),0.05)
    self.width = 726
    self.height = 1084
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

function Cockroach:update(dt)

  if fr == false and self.dead == false then
    self.animation:update(dt)
    self.x = self.x + math.cos(self:DirectionToPlayer(self)) * self.speed * dt
    self.y = self.y + math.sin(self:DirectionToPlayer(self)) * self.speed * dt
  end

end

function Cockroach:render()
  if self.dead == false then
      self.animation:draw(self.sprite, self.x, self.y,Cockroach:DirectionToPlayer(self)+math.pi/2, 0.08333*self.size, 0.08333*self.size, self.width/2, self.height/2)
  else
      love.graphics.draw(self.sprite_dead, self.x,self.y, self.d, 0.08333*self.size, 0.08333*self.size, self.width/2, self.height/2)
  end

end

function Cockroach:DirectionToPlayer(self)
    return math.atan2(player.y - self.y, player.x - self.x)
end
