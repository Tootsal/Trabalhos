Bomb = class{}

function Bomb:init()
  self.sprite = bomb
  self.x = player.x
  self.y = player.y
  self.remove = false
  self.timer = love.timer.getTime()
end

function Bomb:update()
  --if love.timer.getTime() - self.timer > 3 then
    --self.remove = true
    --table.insert(explosions, Explosion(self.x, self.y))
    for i,b in ipairs(bugs) do
      if distance(self.x, self.y, b.x, b.y) < 30 then
        self.remove = true
        table.insert(explosions, Explosion(self.x, self.y))
        for i,z in ipairs(bugs) do
          if distance(self.x, self.y, b.x, b.y) < 300 and b.dead == false then
            b.dead = true
            b.d = b:DirectionToPlayer(b)+math.pi/2
            score = score + 1
        end
      end
    end
  end
end

function Bomb:render()
  love.graphics.draw(self.sprite, self.x, self.y, nil ,nil ,nil, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
end
