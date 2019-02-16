Names = Names or {}

Names.possessive = function(name)
    if string.sub(name, -1) == "s" then
        return name .. "'"
    else
        return name .. "'s"
    end
end