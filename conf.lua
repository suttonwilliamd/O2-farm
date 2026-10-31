local config = require("config")

function love.conf(t)
    t.window.title = "O2-farm"
    t.window.width = config.BASE_W
    t.window.height = config.BASE_H
    t.window.resizable = true
    t.window.minwidth = config.MIN_WIDTH
    t.window.minheight = config.MIN_HEIGHT
    t.window.vsync = 1

    t.modules.joystick = false
    t.modules.physics = false
    
    if t.android then
        t.android.orientation = "landscape"
    end
    
    if t.ios then
        t.ios.orientation = "landscape"
    end
end