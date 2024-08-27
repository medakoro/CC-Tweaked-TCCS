-- TCCS/login/login.lua
local basalt = require("/lib/basalt")

local function loadLoginList()
    local file = fs.open("login/login_list.json", "r")
    local content = file.readAll()
    file.close()
    return textutils.unserializeJSON(content)
end

local loginList = loadLoginList()

local function createGUI()
    local main = basalt.createFrame()
    local monitor = peripheral.find("monitor")
    
    if monitor then
        basalt.setMonitor(monitor)
    end

    main:setBackground(colors.lightGray)

    local titleLabel = main:addLabel()
    titleLabel:setText("CC:Tweaked Train Computer Control System")
    titleLabel:setPosition(1, 1)
    titleLabel:setSize("parent.w", 1)
    titleLabel:setBackground(colors.gray)
    titleLabel:setForeground(colors.white)
    titleLabel:setTextAlign("center")

    local instructionLabel = main:addLabel()
    instructionLabel:setText("Please input Login name and password")
    instructionLabel:setPosition(1, 3)
    instructionLabel:setSize("parent.w", 1)
    instructionLabel:setForeground(colors.black)
    instructionLabel:setTextAlign("center")

    local usernameInput = main:addInput()
    usernameInput:setPosition("parent.w / 2 - 10", 6)
    usernameInput:setSize(20, 1)
    usernameInput:setBackground(colors.white)
    usernameInput:setForeground(colors.black)

    local passwordInput = main:addInput()
    passwordInput:setPosition("parent.w / 2 - 10", 8)
    passwordInput:setSize(20, 1)
    passwordInput:setBackground(colors.white)
    passwordInput:setForeground(colors.black)
    passwordInput:setInputType("password")

    local nextButton = main:addButton()
    nextButton:setText("Next")
    nextButton:setPosition("parent.w - 5", "parent.h")
    nextButton:setSize(6, 1)
    nextButton:setBackground(colors.green)
    nextButton:setForeground(colors.white)
    nextButton:onClick(function()
        local username = usernameInput:getValue()
        local password = passwordInput:getValue()
        
        if loginList[username] == password then
            basalt.stopUpdate()
            shell.run("main/main.lua", username)
        else
            basalt.debug("Invalid login credentials")
        end
    end)

    local restartButton = main:addButton()
    restartButton:setText("Restart")
    restartButton:setPosition(1, "parent.h")
    restartButton:setSize(6, 1)
    restartButton:setBackground(colors.red)
    restartButton:setForeground(colors.white)
    restartButton:onClick(function()
        basalt.stopUpdate()
        createGUI()
        basalt.autoUpdate()
    end)
end

createGUI()
basalt.autoUpdate()