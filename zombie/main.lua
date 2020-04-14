WORLD_WIDTH = 3000
WORLD_HEIGHT = 1500
class = require 'class'
anim8 = require 'anim8'
require 'Lava'
require 'fly'
require 'Beetle'
require 'Cockroach'
require 'Scorpion'
require 'Player'
require 'Bullet'
require 'Explosion'
require 'utils'
require 'Machine_gun'
require 'Freeze'
require 'Speed_boost'
require 'Shield'
require 'Bomb'
cameraFile = require 'camera'


function love.load()

    love.window.setMode(1280, 720)
    math.randomseed(os.time())

    loadImages()
    background = sky
    WORLD_WIDTH = background:getWidth()
    WORLD_HEIGHT = background:getHeight()


    player = Player()
    cam = cameraFile()

    bugs = {}
    bullets = {}
    explosions = {}
    powerups = {}
    gamestate = 0
    maxTime = 5
    timer = maxTime
    levelTime = 100
    level = 1
    score = 0
    mgRate = 5

    myFont = love.graphics.newFont(40)

    crosshair = love.mouse.getSystemCursor("crosshair")
    love.mouse.setCursor(crosshair)

end

function love.update(dt)

    for i,p in ipairs(powerups) do
      p:update(dt)
    end

    levelTimer(dt)

    player:update(dt)

    for i,b in ipairs(bugs) do
      b:update(dt)
    end

    -- Bullets move
    for i,b in ipairs(bullets) do
      b:update(dt)
    end

    powerupsTimer(dt)

    spawnPowerups(dt)
    killBugs()
    bulletRemove()
    explosionsRemove()
    --removeZombies()
    removePowerups()
    camUpdate()
    timePass(dt)

    for i,e in ipairs(explosions) do
      e:update(dt)
    end

    if love.mouse.isDown(1) or love.keyboard.isDown('space') and mgo == true  then
      mgRate = mgRate - 1
      if mgRate == 0 then
        spawnBullet()
        mgRate = 5
    end
  end


end

function love.draw()

    cam:attach()

    love.graphics.draw(background)

    for i,b in ipairs(bugs) do
        b:render()
    end

    for i,b in ipairs(bullets) do
        b:render()
    end

    for i,e in ipairs(explosions) do
      e:render()
    end

    for i,p in ipairs(powerups) do
      p:render()
    end

    player:render()

    cam:detach()

    love.graphics.printf("Score: " .. score, 0, love.graphics.getHeight() - 100, love.graphics.getWidth(), "center")
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.print("Enemies: " .. #bugs, 10, 50)
    love.graphics.print("Next Level: " .. math.floor(levelTime) ,950, 50)


    if gamestate == 0 then
        love.graphics.setFont(myFont)
        love.graphics.printf("Click enter to begin!", 0, 50, love.graphics.getWidth(), "center")
        love.graphics.printf("Level " .. level, 0, 150, love.graphics.getWidth(), "center")
    end

end
