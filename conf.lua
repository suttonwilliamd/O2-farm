-- conf.lua
function love.conf(t)
    t.window.width = 1280
    t.window.height = 720
    t.window.resizable = false  -- Disable resizing
    t.window.vsync = 1

    -- Mobile orientation locks
    t.modules.joystick = false  -- Optional mobile optimizations
    t.modules.physics = false
    
    if t.android then
        t.android.orientation = "landscape"
    end
    
    if t.ios then
        t.ios.orientation = "landscape"
    end
end