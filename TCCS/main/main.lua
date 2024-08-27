-- TCCS/main/main.lua
local basalt = require("/lib/basalt")

local args = {...}
local loggedInUser = args[1]

local function createMainGUI()
    local main = basalt.createFrame()
    local monitor = peripheral.find("monitor")
    
    if monitor then
        basalt.setMonitor(monitor)
    end

    main:setBackground(colors.lightGray)

    local titleLabel = main:addLabel()
    titleLabel:setText("CC:Tweaked TCCS [" .. loggedInUser .. "]")
    titleLabel:setPosition(1, 1)
    titleLabel:setSize("parent.w", 1)
    titleLabel:setBackground(colors.gray)
    titleLabel:setForeground(colors.white)
    titleLabel:setTextAlign("center")

    -- ここにメイン画面の他の要素を追加

    local logoutButton = main:addButton()
    logoutButton:setText("Logout")
    logoutButton:setPosition(1, "parent.h")
    logoutButton:setSize(6, 1)
    logoutButton:setBackground(colors.red)
    logoutButton:setForeground(colors.white)
    logoutButton:onClick(function()
        basalt.stopUpdate()
        shell.run("login/login.lua")
    end)
end

createMainGUI()
basalt.autoUpdate()