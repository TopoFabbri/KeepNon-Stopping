local player = {}
local avoidables = {}

function love.load()
    avoidables.speed = 30

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

    createAvoidable()

    if love.keyboard.isDown('right') then
        player.pos.x = player.pos.x + player.speed * dt
    end
    if love.keyboard.isDown('left') then
        player.pos.x = player.pos.x - player.speed * dt
    end
    updateVertices()
end

function love.draw()
    love.graphics.setColor(.1, .5, .6, 1)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.polygon("fill", player.tri)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.circle("fill", avoidables.pos.x, avoidables.pos.y, avoidables.size)

end

function updateVertices()
    player.tri = {player.pos.x, player.pos.y - player.size / 2, player.pos.x - player.size / 2,
                  player.pos.y + player.size / 2, player.pos.x + player.size / 2, player.pos.y + player.size / 2}

end

function createAvoidable()
    local randomNumber
    local randomNumberSize

    randomNumber = love.math.random(20)
    
    randomNumberSize = love.math.random(10, 60)

    avoidables.pos = {
        x = love.graphics.getWidth() * (randomNumber / 20) ,
        y = love.graphics.getHeight() * 0
    }
    avoidables.size = randomNumberSize
end