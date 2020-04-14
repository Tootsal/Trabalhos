-- survive the level
function levelTimer(dt)

  if gamestate ~= 0 then
    --levelTime = levelTime - dt
    if levelTime < 0 then
      levels()
      end
    end
end

function levels()
  for i,b in ipairs(bugs) do
      bugs[i] = nil
  end
  for i,p in ipairs(powerups) do
    powerups[i] = nil
  end
  gamestate = 0
  level = level + 1
  score = 0
  levelTime = 60
  maxTime = 4
  background = runefall
  WORLD_WIDTH = background:getWidth()
  WORLD_HEIGHT = background:getHeight()
  player.x = WORLD_WIDTH/2
  player.y = WORLD_HEIGHT/2

end

function spawnBullet()
    table.insert(bullets, Bullet())
end

side = 1
function spawnBug()

    local bug
    --local side = math.random(1,4)
    if side == 5 then side = 1 end

    if side == 1 then
        bug = Lava(-30, math.random(0, WORLD_HEIGHT), 140)

    elseif side == 2 then
        bug = Beetle(math.random(0, WORLD_WIDTH), -30, 140)

    elseif side == 3 then
        bug = Lava(WORLD_WIDTH + 30, math.random(0, WORLD_HEIGHT), 140)
    else
        bug = Fly(math.random(0, WORLD_WIDTH), WORLD_HEIGHT + 30, 140)
    end
    side = side + 1

    table.insert(bugs, bug)
end

function love.mousepressed(x, y, b, istouch)
    if b == 1 and gamestate ~= 0 then
        spawnBullet()
    end
end


function love.keypressed(key, scancode, isrepeat)
  if key == 'return' then
    if gamestate == 0 then
        gamestate = 1
    end
  elseif key == 'b' then
    table.insert(powerups, Bomb())
  elseif key == 'space' then
    spawnBullet()
  end
end





function Player:mouse()
    x,y = cam:mousePosition()
    return math.atan2(y - self.y, x - self.x)
end

function distance(x1, y1, x2, y2)
    return math.sqrt( (y2 - y1)^2 + (x2 - x1)^2)
end

function camUpdate()

      cam:lookAt(player.x, player.y)

      if player.x < love.graphics.getWidth()/2 then
        cam:lookAt(love.graphics.getWidth()/2, player.y)
      end

      if player.x < love.graphics.getWidth()/2 and player.y < love.graphics.getHeight()/2    then
        cam:lookAt(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
      end

      if player.x < love.graphics.getWidth()/2 and player.y > WORLD_HEIGHT - love.graphics.getHeight()/2  then
        cam:lookAt(love.graphics.getWidth()/2, WORLD_HEIGHT - love.graphics.getHeight()/2)
      end

      if player.x > WORLD_WIDTH - love.graphics.getWidth()/2 then
        cam:lookAt(WORLD_WIDTH - love.graphics.getWidth()/2, player.y)
      end

      if player.x > WORLD_WIDTH - love.graphics.getWidth()/2 and player.y < love.graphics.getHeight()/2  then
        cam:lookAt(WORLD_WIDTH - love.graphics.getWidth()/2, love.graphics.getHeight()/2)
      end

      if player.x > WORLD_WIDTH - love.graphics.getWidth()/2 and player.y > WORLD_HEIGHT - love.graphics.getHeight()/2  then
        cam:lookAt(WORLD_WIDTH - love.graphics.getWidth()/2, WORLD_HEIGHT - love.graphics.getHeight()/2)
      end

      if player.y < love.graphics.getHeight()/2 and player.x > love.graphics.getWidth()/2 and player.x < WORLD_WIDTH - love.graphics.getWidth()/2 then
        cam:lookAt(player.x, love.graphics.getHeight()/2)
      end

      if player.y > WORLD_HEIGHT - love.graphics.getHeight()/2 and player.x > love.graphics.getWidth()/2 and player.x < WORLD_WIDTH - love.graphics.getWidth()/2 then
        cam:lookAt(player.x, WORLD_HEIGHT - love.graphics.getHeight()/2)
      end

end

function bulletRemove()
  -- Remove bullets
  for i=#bullets, 1, -1 do
      local b = bullets[i]
      if b.x < 0 or b.y < 0 or b.x > WORLD_WIDTH or b.y > WORLD_HEIGHT or b.dead == true then
          table.remove(bullets, i)
      end
  end
end

function explosionsRemove()
  -- remove explosions
  for i=#explosions, 1, -1 do
      local e = explosions[i]
      if e.animation.status == "paused" then
        table.remove(explosions, i)
      end
  end
end


function killBugs()
  -- zombies die
  for i,z in ipairs(bugs) do
      for j,b in ipairs(bullets) do
          if distance(z.x, z.y, b.x, b.y) < 20 and z.dead == false then
              z.life = z.life - 1
              b.dead = true
            end
      end

      if z.life <= 0 and z.dead == false then
        z.dead = true
        z.d = z:DirectionToPlayer(z)+math.pi/2
        score = score + 1
      end

      if sho == true then
        if distance(z.x, z.y, player.x, player.y) < 100 and z.dead == false then
          z.dead = true
          z.d = z:DirectionToPlayer(z)+math.pi/2
          score = score + 1
          --table.insert(explosions, Explosion(z.x, z.y))
        end
      end
  end
end

function removeBugs()
  -- remove zombies
  for i=#bugs, 1, -1 do
      local b = bugs[i]
      if b.dead == true then
          table.remove(bugs, i)
      end
  end
end

function timePass(dt)
  if gamestate ~= 0 then
      timer = timer - dt
      if timer <= 0 then
          spawnBug()
          maxTime = maxTime * 0.95
          timer = maxTime
      end
  end
end


function spawnPowerups(dt)
  if gamestate ~= 0 and #powerups <= 8 then
    if math.random(5 / dt) == 1 then
      p = love.math.random(4)
        if p == 1 then
           table.insert(powerups, Machine_gun())
        elseif p == 2 then
            table.insert(powerups, Freeze())
        elseif p == 3 then
            table.insert(powerups, Speed_boost())
        else
            table.insert(powerups, Shield())
        end
    end
  end
end


function removePowerups()
  for i=#powerups, 1, -1 do
      local p = powerups[i]
      if p.remove == true then
          table.remove(powerups, i)
      end
  end
end

function loadImages()

  -- backgrounds
  sky = love.graphics.newImage("sprites/background/jungle2.png")
  runefall = love.graphics.newImage("sprites/background/runefall2.png")
  desert = love.graphics.newImage("sprites/background/desert.png")
  -- cockroach
  cockroach = love.graphics.newImage("sprites/cockroach.png")
  cockroach_dead = love.graphics.newImage("sprites/cockroach_dead.png")
  -- beetles
  black_beetle_walk = love.graphics.newImage("sprites/__black_beetle_walk.png")
  black_beetle_die = love.graphics.newImage("sprites/__black_beetle_dead.png")
  blue_beetle_walk = love.graphics.newImage("sprites/__blue_beetle_walk.png")
  blue_beetle_die = love.graphics.newImage("sprites/__blue_beetle_dead.png")
  green_beetle_walk = love.graphics.newImage("sprites/__dark_green_beetle_walk.png")
  green_beetle_die = love.graphics.newImage("sprites/__dark_green_beetle_dead.png")
  red_beetle_walk = love.graphics.newImage("sprites/__red_beetle_walk.png")
  red_beetle_die = love.graphics.newImage("sprites/__red_beetle_dead.png")
  yellow_beetle_walk = love.graphics.newImage("sprites/__yellow_beetle_walk.png")
  yellow_beetle_die = love.graphics.newImage("sprites/__yellow_beetle_dead.png")
  -- fly_
  fly = love.graphics.newImage("sprites/__fly_flying.png")
  fly_dead = love.graphics.newImage("sprites/__fly_dead.png")
  -- scorpions
  black_scorpion_walk = love.graphics.newImage("sprites/black_scorpion_walk.png")
  black_scorpion_walk2 = love.graphics.newImage("sprites/black_scorpion_walk2.png")
  black_scorpion_die = love.graphics.newImage("sprites/black_scorpion_die.png")
  blue_scorpion_walk = love.graphics.newImage("sprites/blue_scorpion_walk.png")
  blue_scorpion_walk2 = love.graphics.newImage("sprites/blue_scorpion_walk2.png")
  blue_scorpion_die = love.graphics.newImage("sprites/blue_scorpion_die.png")
  red_scorpion_walk = love.graphics.newImage("sprites/red_scorpion_walk.png")
  red_scorpion_walk2 = love.graphics.newImage("sprites/red_scorpion_walk2.png")
  red_scorpion_die = love.graphics.newImage("sprites/red_scorpion_die.png")
  yellow_scorpion_walk = love.graphics.newImage("sprites/yellow_scorpion_walk.png")
  yellow_scorpion_walk2 = love.graphics.newImage("sprites/yellow_scorpion_walk2.png")
  yellow_scorpion_die = love.graphics.newImage("sprites/yellow_scorpion_die.png")
  -- lava

  lava_walk = love.graphics.newImage("sprites/lava_wigle.png")
  lava_walk2 = love.graphics.newImage("sprites/lava_move2.png")
  lava_die = love.graphics.newImage("sprites/lava_die.png")
  -- powerups
  powerups_img = love.graphics.newImage("sprites/powerups.png")
  bomb = love.graphics.newImage("sprites/bomb.png")

end

function powerupsTimer(dt)
  -- timer for the machine_gun
  if mgo == true then
    machine_gun_timer()
  end
  -- timer for freeze
  if fr == true then
    freeze_timer()
  end
  -- timer for Speed_boost
  if sp == true then
    speed_boost_timer()
  end
  --timer for shield
  if sho == true then
    --shield_timer()
    shield_animation:update(dt)
  end

end
