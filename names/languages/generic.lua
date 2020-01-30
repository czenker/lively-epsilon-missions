Names = Names or {}

Names.possessive = function(name)
    if string.sub(name, -1) == "s" then
        return name .. "'"
    else
        return name .. "'s"
    end
end

local leetify = function(letter)
    if letter == "A" then return "4"
    elseif letter == "B" then return "8"
    elseif letter == "E" then return "3"
    elseif letter == "F" then return "PH"
    elseif letter == "G" then return Util.random({"6", "9"})
    elseif letter == "I" then return "1"
    elseif letter == "O" then return "0"
    elseif letter == "S" then return Util.random({"5", "$"})
    elseif letter == "T" then return "7"
    elseif letter == "Z" then return "2"
    else return letter
    end
end

Names.leetify = function(name)
    name = string.upper(name)
    local ret = ""
    for i=1,string.len(name) do
        ret = ret .. leetify(name:sub(i, i))
    end
    return ret
end