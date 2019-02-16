My = My or {}

My.metalBandName = function()
    local version = math.random(1,6)
    if version == 1 then
        return Util.random(Names.sinisterAttribute) .. " " .. Util.random(Names.sinisterNouns)
    elseif version == 2 then
        return Util.random(Names.sinisterAttribute) .. Util.random(Names.sinisterNouns)
    elseif version == 3 then
        return Util.random(Names.sinisterAttribute) .. " " .. Util.random(Names.scaryThing)
    elseif version == 4 then
        return Util.random(Names.sinisterAttribute) .. Util.random(Names.scaryThing)
    elseif version == 5 then
        return Util.random(Names.sinisterAttribute) .. " " .. Util.random(Names.sinisterNouns) .. " of " .. Util.random(Names.scaryThing)
    else
        return Util.random(Names.sinisterNouns) .. " of " .. Util.random(Names.scaryThing)
    end
end
