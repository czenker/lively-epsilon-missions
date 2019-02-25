local f = string.format

local showOnFirstMoneyEarned = true
local showOnLaserRefitReward = true
local showOnPowerPresetsReward = true
local showOnAttackersSpawn = true
local showOnAttackersDetection = false
local showOnClosingInToFortress = false

My.EventHandler:register("onFirstMoneyEarned", function()
    showOnFirstMoneyEarned = false
end)
My.EventHandler:register("onLaserRefitReward", function()
    showOnLaserRefitReward = false
end)
My.EventHandler:register("onPowerPresetsReward", function()
    showOnPowerPresetsReward = false
end)
My.EventHandler:register("onAttackersSpawn", function()
    showOnAttackersSpawn = false
    showOnAttackersDetection = true
end)
My.EventHandler:register("onAttackersDetection", function()
    showOnAttackersDetection = false
    showOnClosingInToFortress = true
end)
My.EventHandler:register("onClosingInToFortress", function()
    showOnClosingInToFortress = false
end)

local mainMenu

mainMenu = function()
    local menu = Menu:new()
    if showOnFirstMoneyEarned then
        menu:addItem(Menu:newItem("onFirstMoneyEarned", function()
            My.EventHandler:fire("onFirstMoneyEarned")
            return mainMenu()
        end, 0))
    end
    if showOnLaserRefitReward then
        menu:addItem(Menu:newItem("onLaserRefitReward", function()
            My.EventHandler:fire("onLaserRefitReward")
            return mainMenu()
        end, 1))
    end
    if showOnPowerPresetsReward then
        menu:addItem(Menu:newItem("onPowerPresetsReward", function()
            My.EventHandler:fire("onPowerPresetsReward")
            return mainMenu()
        end, 2))
    end
    if showOnAttackersSpawn then
        menu:addItem(Menu:newItem("onAttackersSpawn", function()
            My.EventHandler:fire("onAttackersSpawn")
            return mainMenu()
        end, 3))
    end
    if showOnAttackersDetection then
        menu:addItem(Menu:newItem("onAttackersDetection", function()
            My.EventHandler:fire("onAttackersDetection")
            return mainMenu()
        end, 4))
    end
    if showOnClosingInToFortress then
        menu:addItem(Menu:newItem("onClosingInToFortress", function()
            My.EventHandler:fire("onClosingInToFortress")
            return mainMenu()
        end, 5))
    end

    return menu
end

My.EventHandler:register("onWorldCreation", function()
    Menu:addGmMenuItem(Menu:newItem("Story", mainMenu))
end)