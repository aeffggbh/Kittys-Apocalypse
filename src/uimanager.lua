-- the color has to be a table with rgba
function newText(x, y, content, size, fontDir, color)
    local text = {}
    text.content = content
    text.love = love.graphics.newText(love.graphics.setNewFont(fontDir, size), content)
    text.x = x
    text.y = y
    text.size = size
    text.color = color
    return text
end

-- the color has to be a table with rgba
function newButton(content, font, x, y, width, height, buttonColor, buttonHighlight, textColor)
    local button = {}
    button.x = x
    button.y = y
    button.currentColor = buttonColor
    button.highLight = buttonHighlight
    button.default = buttonColor
    button.width = width
    button.height = height
    button.text = newText(x, y, content, height / 2, font, textColor)
    button.text.x = x + width / 2 - button.text.love:getWidth() / 2
    button.text.y = y + height / 2 - button.text.love:getHeight() / 2

    return button
end

function drawText(fontDir, text)

    love.graphics.setColor(text.color.r, text.color.g, text.color.b)
    love.graphics.setNewFont(fontDir, text.size)
    love.graphics.print(text.content, text.x, text.y)

end

function drawButton(textFontDir, button)

    love.graphics.setColor(button.currentColor.r, button.currentColor.g, button.currentColor.b)
    love.graphics.rectangle('fill', button.x, button.y, button.width, button.height)
    drawText(textFontDir, button.text)
end

function isMouseOnButton(button)
    if love.mouse.getX() >= button.x and love.mouse.getX() <= button.x + button.width and love.mouse.getY() >= button.y and
        love.mouse.getY() <= button.y + button.height then
        return true
    end
    return false
end

function checkSceneChange(button, scene)

    if isMouseOnButton(button) then
        button.currentColor = button.highLight
        if love.mouse.isDown(1) then
            if scene == scenes.menuScene then
                restartGame()
            end
            setCurrentScene(scene)
        end
    else
        button.currentColor = button.default
    end

end

function drawBackground(bgDir)

    local myBackground = love.graphics.newImage(bgDir)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(myBackground, 0, 0, 0, 1, 1)

end