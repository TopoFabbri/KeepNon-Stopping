local player = {}

function love.load()
    player.pos = {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() * (3 / 4)
    }

    player.size = 30

    updateVertices()

    player.collider = {
        center = player.pos,
        size = player.size
    }
end

function love.update(dt)
    if love.keyboard.isDown('right') then
        player.pos.x = player.pos.x + 100 * dt
    end
    if love.keyboard.isDown('left') then
        player.pos.x = player.pos.x - 100 * dt
    end
    updateVertices()
end

function love.draw()
    love.graphics.setColor(.1, .5, .6, 1)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.polygon("fill", player.tri)
end

function updateVertices()
    player.tri = {player.pos.x, player.pos.y - player.size / 2, player.pos.x - player.size / 2,
                  player.pos.y + player.size / 2, player.pos.x + player.size / 2, player.pos.y + player.size / 2}

end
