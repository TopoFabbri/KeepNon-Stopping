local player = {}
local avoidables = {}
local avoidableCounter = 0
local max = 100
local score = 0
local highscore = 0

for i = 1, 100 do
    avoidables[i] = {}
end

function love.load()

    createAvoidables()

    player.pos = {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() * (7 / 8)
    }

    player.size = 15
    player.speed = 600
    updateVertices()
end

function love.update(dt)

    score = score + dt
    input(dt)
    updateVertices()
    updateAvoidables(dt)

    if player.pos.x <= 0 then
        player.pos.x = love.graphics.getWidth();
    elseif player.pos.x >= love.graphics.getWidth() then
        player.pos.x = 0
    end
end

function love.draw()

    love.graphics.setBackgroundColor(0, 0, 1, 1)
    love.graphics.setColor(0, 0, 0, .95)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.polygon("line", player.tri)

    for i = 1, max do
        if avoidables[i].isActive then

            love.graphics.setColor(avoidables[i].color)
            love.graphics.circle("fill", avoidables[i].pos.x, avoidables[i].pos.y, avoidables[i].size)
        end
    end

    love.graphics.setColor(1, 1, 0, 1)

    score = math.floor(score * 100) / 100
    highscore = math.floor(highscore * 100) / 100
    
    love.graphics.print(score, 5, 5, 0, 1.5, 1.5)
    love.graphics.print(highscore, 5, 30, 0, 1.5, 1.5)
end

function updateVertices()
    player.tri = {player.pos.x, player.pos.y - player.size, player.pos.x - player.size,
                  player.pos.y + player.size, player.pos.x + player.size, player.pos.y + player.size}

end

function createAvoidables()
    local randomNumber
    local randomNumberSize

    for i = 1, max do
        setAvoidable(i)
    end
end

function setAvoidable(i)
    avoidables[i].isActive = false
    avoidables[i].counter = .1 * i

    randomNumber = love.math.random(20)
    randomNumberSize = love.math.random(10, 45)

    avoidables[i].speed = 300
    avoidables[i].size = randomNumberSize

    avoidables[i].color = {1, 1, 1, 1}

    avoidables[i].pos = {
        x = love.graphics.getWidth() * (randomNumber / 20),
        y = love.graphics.getHeight() * 0 - randomNumberSize
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

        if avoidables[i].pos.y - avoidables[i].size > love.graphics.getHeight() then
            setAvoidable(i)
        end

        if (circlesCollide(player.pos, player.size, avoidables[i].pos, avoidables[i].size)) then
            if score > highscore then
                highscore = score
            end
            score = 0
            createAvoidables()
        end

        fall(dt, i)
    end
end

function fall(dt, i)
    if avoidables[i].isActive then
        avoidables[i].pos.y = avoidables[i].pos.y + avoidables[i].speed * dt
    end
end

function circlesCollide(center1, size1, center2, size2)
    return getDistance(center1, center2) <= size1 + size2
end

function getDistance(center1, center2)

    local value = math.pow(math.abs(center2.x - center1.x), 2) + math.pow(math.abs(center2.y - center1.y), 2)

    value = math.sqrt(value)

    return value
end

function input(dt)
    if love.keyboard.isDown('right') then
        player.pos.x = player.pos.x + player.speed * dt
    end
    if love.keyboard.isDown('left') then
        player.pos.x = player.pos.x - player.speed * dt
    end
end