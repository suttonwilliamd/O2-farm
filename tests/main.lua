-- Run from the repository: love tests <absolute-path-to-repository>
function love.load(args)
    local ok, message = xpcall(function()
        local root = assert(args[1], "Pass the absolute repository path after 'tests'.")
        package.path = root .. "/?.lua;" .. package.path
        assert(loadfile(root .. "/main.lua"))()
        love.load()

        local Scaling = require("systems.scaling")
        local Earth = require("objects.earth")
        local Mars = require("objects.mars")
        local function near(actual, expected)
            assert(math.abs(actual - expected) < 0.000001,
                tostring(actual) .. " != " .. tostring(expected))
        end

        love.focus(true)
        love.update(1)
        near(Earth.rotation, 0.5)
        near(Mars.rotation, 0.2)
        love.keypressed("space", "space", false)
        love.update(1)
        near(Earth.rotation, 0.5)
        love.keypressed("space", "space", true)
        love.update(1)
        near(Earth.rotation, 0.5)
        love.keypressed("space", "space", false)
        love.focus(false)
        love.update(1)
        near(Earth.rotation, 0.5)
        love.focus(true)
        love.update(1)
        near(Earth.rotation, 1)
        print("PASS: pause, key repeat, focus loss and resume")

        local set_mode = love.window.setMode
        love.window.setMode = function()
            error("Resize must not recreate the window")
        end
        love.resize(1000, 1000)
        near(Scaling.scale, 1000 / 1280)
        near(Scaling.offset_x, 0)
        near(Scaling.offset_y, 218.75)
        love.resize(1920, 720)
        near(Scaling.scale, 1)
        near(Scaling.offset_x, 320)
        near(Scaling.offset_y, 0)
        love.resize(854, 480)
        near(Scaling.scale, 480 / 720)
        near(Scaling.offset_x, 1 / 3)
        near(Scaling.offset_y, 0)
        love.window.setMode = set_mode
        print("PASS: square, ultrawide and minimum-size letterboxing; no window recreation")

        local earth_texture, mars_texture = Earth.texture, Mars.texture
        assert(love.window.updateMode(1000, 720))
        love.resize(love.graphics.getDimensions())
        assert(Earth.texture == earth_texture and Mars.texture == mars_texture)
        local function alpha_at_center(texture)
            local width, height = texture:getDimensions()
            local target = love.graphics.newCanvas(width, height)
            love.graphics.setCanvas(target)
            love.graphics.clear(0, 0, 0, 0)
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(texture)
            love.graphics.setCanvas()
            local _, _, _, alpha = target:newImageData():getPixel(width / 2, height / 2)
            return alpha
        end
        assert(alpha_at_center(Earth.texture) > 0 and alpha_at_center(Mars.texture) > 0,
            "Planet textures lost during resize")
        love.draw()
        love.keypressed("h", "h", false)
        love.draw()
        love.keypressed("h", "h", false)
        print("PASS: real window resize retains planet textures and renders help on/off")
    end, debug.traceback)
    if not ok then
        print(message)
    end
    love.event.quit(ok and 0 or 1)
end
