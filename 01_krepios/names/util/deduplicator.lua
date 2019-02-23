My = My or {}

My.deduplicateName = function(func)
    local knownNames = {}

    return function()
        for _=1,100 do
            local thing = func()
            local name
            if Person:isPerson(thing) then
                name = thing:getFormalName()
            else
                name = thing
            end
            if knownNames[name] == nil then
                knownNames[name] = 1
                return thing
            end
        end
        error("Could not find a non-duplicate name")
    end
end