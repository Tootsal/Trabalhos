Explosion = class{}

function Explosion:init(x, y)
  self.sprite = love.graphics.newImage("sprites/explosion.png")
  self.x = x
  self.y = y
  self.grid = anim8.newGrid(64,64,256,256)
  self.animation = anim8.newAnimation(self.grid('1-4',1,'1-4',2,'1-4',3,'1-4',4),0.1, "pauseAtEnd")
  self.over = false

end

function Explosion:update(dt)
  self.animation:update(dt)
end


function Explosion:render()
  self.animation:draw(self.sprite, self.x, self.y, nil, 6, 6, 32, 32)
end
