local myPackages = {
    "01_krepios/names/util/deduplicator.lua",

    "01_krepios/names/languages/esperantish.lua",
    "01_krepios/names/languages/english.lua",
    "01_krepios/names/languages/generic.lua",
    "01_krepios/names/languages/greek.lua",
    "01_krepios/names/languages/human.lua",

    "01_krepios/names/band.lua",
    "01_krepios/names/person.lua",
    "01_krepios/names/places.lua",
    "01_krepios/names/ships.lua",
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


