local f = string.format

My.Translator:register("en", {

    research_station_description = function(nebulaName)
        return Util.random({
            "A small science station in ".. nebulaName .. ".",
        }) .. " " .. Util.random({
            "The database does not hold entries on any significant scientific discoveries made here.",
            "It is unimportant for the science world.",
        })
    end,
})