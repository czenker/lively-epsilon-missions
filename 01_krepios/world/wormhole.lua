-- the WormHole that connects Krepios to the other systems

local angle

My.EventHandler:register("onWorldCreation", function()
    local avgAngle = My.Config.avgAngle
    local distancePerGrad = 180000 / 360

    angle = avgAngle + math.random(240, 300)
    local originX, originY = My.World.planet:getPosition()
    local holeX, holeY = vectorFromAngle(angle, distancePerGrad*120)
    local targetX, targetY = vectorFromAngle(angle, distancePerGrad*150)

    My.Wormhole = WormHole():setPosition(originX + holeX, originY + holeY):setTargetPosition(originX + targetX, originY + targetY)
end)

local openWormHole = function()
    local dx, dy = Util.vectorFromAngle(angle, -1000)
    local x, y = My.World.colonel:getPosition()

    My.Wormhole:setTargetPosition(x + dx, y + dy)
end

My.EventHandler:register("onClosingInToFortress", function()
    openWormHole()
end)
My.EventHandler:register("onCommanderDead", function()
    openWormHole()
end)
My.EventHandler:register("onEnemiesDestroyed", function()
    openWormHole()
end)
