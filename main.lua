local player = {}
local avoidables = {}
local avoidableCounter = 0
local max = 100

for i = 1, 100 do
    avoidables[i] = {}
end

function love.load()

    createAvoidables()

    player.pos = {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() * (7 / 8)
    }

    player.size = 30
    player.speed = 600
    updateVertices()

    player.collider = {
        center = player.pos,
        size = player.size
    }
end

function love.update(dt)

    if love.keyboard.isDown('right') then
        player.pos.x = player.pos.x + player.speed * dt
    end
    if love.keyboard.isDown('left') then
        player.pos.x = player.pos.x - player.speed * dt
    end
    updateVertices()
    updateAvoidables(dt)
end

function love.draw()

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.polygon("line", player.tri)

    for i = 1, max do
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.circle("fill", avoidables[i].pos.x, avoidables[i].pos.y, avoidables[i].size)
    end
end

function updateVertices()
    player.tri = {player.pos.x, player.pos.y - player.size / 2, player.pos.x - player.size / 2,
                  player.pos.y + player.size / 2, player.pos.x + player.size / 2, player.pos.y + player.size / 2}

end

function createAvoidables()
    local randomNumber
    local randomNumberSize

    for i = 1, max do
        createAvoidable(i)
    end
end

function createAvoidable(i)
    avoidables[i].isActive = false
    avoidables[i].counter = .1 * i

    randomNumber = love.math.random(20)
    randomNumberSize = love.math.random(10, 60)

    avoidables[i].speed = 300
    avoidables[i].size = randomNumberSize

    avoidables[i].pos = {
        x = love.graphics.getWidth() * (randomNumber / 20),
        y = love.graphics.getHeight() * 0 - randomNumberSize / 2
    }

end

function updateAvoidables(dt)
    for i = 1, max do
        if avoidables[i].counter > 0 then
            avoidables[i].counter = avoidables[i].counter - dt
        else
            avoidables[i].isActive = true
            avoidableCounter = avoidableCounter + 1
        end
        fall(dt, i)
    end
end

function fall(dt, i)
    if avoidables[i].isActive then
        avoidables[i].pos.y = avoidables[i].pos.y + avoidables[i].speed * dt
    end
end