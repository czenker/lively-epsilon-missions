local endsWith = function(s, suffix)
    s = s:lower()
    suffix = suffix:lower()
    return s:sub(-suffix:len()) == suffix
end

local guessVariableByName = function(variableName)
    if endsWith(variableName, "Person") then
        local person = Person:byName("John Doe")
        Generic:withTags(person)
        return person
    elseif endsWith(variableName, "Name") or endsWith(variableName, "CallSign") then
        return "Random Name"
    elseif endsWith(variableName, "Names") or endsWith(variableName, "CallSigns") then
        return {"Foo", "Bar", "Baz"}
    elseif endsWith(variableName, "Product") then
        local product = Product:new("McGuffin")
        Generic:withTags(product)
        return product
    else
        -- everything else is probably just a number
        return 42
    end
end

insulate("01 Krepios", function()

    require "lively_epsilon.init"
    require "lively_epsilon.spec.mocks"
    require "01_krepios.init"
    require "lively_epsilon.spec.asserts"

    for locale, dictonary in pairs(My.Translator:getDictionaries()) do
        insulate("translation " .. locale, function()

            -- here happens black magic: We hook into the lua engine, stop when a translation function is called
            -- and try to guess some parameter values by their name.
            debug.sethook(function()
                local info = debug.getinfo(2)
                if info.source:find("01_krepios") ~= nil then
                    for i=1,100 do
                        local name, value = debug.getlocal(2, i)
                        if name == nil then
                            break
                        elseif value == nil and name:sub(1,1) ~= "(" then
                            debug.setlocal(2, i, guessVariableByName(name))
                        end
                    end
                end
            end, "c")

            for key, value in pairs(dictonary) do
                it(key .. " is a string and does not error", function()
                    if isFunction(value) then
                        local ret = value()
                        assert.is_same("string", type(ret))
                    else
                        assert.is_same("string", type(value))
                    end
                end)
            end
        end)
    end
end)