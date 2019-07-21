local myPackages = {
    "names/util/deduplicator.lua",

    "names/languages/esperantish.lua",
    "names/languages/english.lua",
    "names/languages/generic.lua",
    "names/languages/greek.lua",
    "names/languages/human.lua",

    "names/band.lua",
    "names/person.lua",
    "names/places.lua",
    "names/ships.lua",
}

if package ~= nil and package.path ~= nil then
    local basePath = debug.getinfo(1).source
    if basePath:sub(1,1) == "@" then basePath = basePath:sub(2) end
    if basePath:sub(-8) == "init.lua" then basePath = basePath:sub(1, -9) end
    basePath = "./" .. basePath .. "/.."

    package.path = package.path .. ";" .. basePath .. "?.lua"


    for _, package in pairs(myPackages) do
        local name = package:match("^(.+).lua$")
        require(name)
    end
else
    -- within empty epsilon

    for _, package in pairs(myPackages) do
        require(package)
    end
end


