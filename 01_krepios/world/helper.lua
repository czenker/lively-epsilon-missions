My.World.Helper = {
    eraseAsteroidsAround = function(x, y, radius, blur)
        radius = radius or 2000
        blur = blur or (radius / 2)
        for _,obj in pairs(getObjectsInRadius(x,y,radius + blur)) do
            if isEeAsteroid(obj) then
                if distance(obj,x,y) <= radius or math.random(0,1) == 0 then obj:destroy() end
            end
        end
    end,

    tryMinDistance = function(generatorFunc, checkFunc, minDistance, retries)
        retries = retries or 10
        local x, y, bestDistance = nil, nil, 0

        for i=1,retries do -- try a few positions to make sure objects don't clutch
            local newX, newY = generatorFunc()
            local closestDistance = 999999999
            for _, thing in pairs(getObjectsInRadius(newX, newY, minDistance)) do
                if checkFunc(thing) then
                    local d = distance(newX, newY, thing:getPosition())
                    if closestDistance == nil or d < closestDistance then
                        closestDistance = d
                    end
                end
            end
            if closestDistance > bestDistance then
                x, y, bestDistance = newX, newY, closestDistance
            end
            if bestDistance >= minDistance then break end
        end

        return x, y
    end
}