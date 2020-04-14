Bullet = class{}

function Bullet:init()
  if mgo == false then
    self.sprite = love.graphics.newImage("sprites/bullet2.png")
  else
    self.sprite = love.graphics.newImage("sprites/bullet1.png")
  end
  self.x = player.x
  self.y = player.y
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  self.speed = 500
  self.direction = player:mouse()
  self.dead = false
end

function Bullet:update(dt)
  self.x = self.x + math.cos(self.direction) * self.speed * dt
  self.y = self.y + math.sin(self.direction) * self.speed * dt
end

function Bullet:render()
    love.graphics.draw(self.sprite, self.x, self.y, self.direction, 0.5, 0.5)
end
