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

insulate("01 Krepios Translations", function()

    require "lively_epsilon.init"
    require "lively_epsilon.spec.mocks"
    require "names.init"
    require "01_krepios.init"
    require "lively_epsilon.spec.asserts"

    setup(function()
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
    end)
    teardown(function()
        debug.sethook()
    end)

    local dictionaries = My.Translator:getDictionaries()
    local locales = {}
    for locale, _ in pairs(dictionaries) do
        table.insert(locales, locale)
    end
    local defaultLocale = My.Translator:getDefaultLocale()

    for _, locale in pairs({"de", "en"}) do
        it("should support locale " .. locale, function()
            assert.contains_value(locale, locales)
        end)
    end

    for locale, dictionary in pairs(dictionaries) do
        describe("translation " .. locale, function()
            for key, value in pairs(dictionary) do
                describe(key, function()
                    local s
                    if isFunction(value) then
                        it("does not error when called", function()
                            s = value()
                        end)
                    else
                        s = value
                    end
                    it("is a string", function()
                        assert.is_same("string", type(s))
                    end)
                    it("should not contain TODOs", function()
                        assert.is_nil(s:find("TODO"))
                    end)
                end)
            end
        end)
    end
    for locale, dictionary in pairs(dictionaries) do
        for key, _ in pairs(dictionary) do
            if locale == defaultLocale then
                for _, locale in pairs(locales) do
                    if locale ~= defaultLocale then
                        local label = key .. " should have a translation in " .. locale
                        it(label, function()
                            -- test should not fail, but make it transparent something should be fixed. so no assert here
                            if dictionaries[locale][key] == nil then
                                pending(label)
                            end
                        end)
                    end
                end
            else
                local label = key .. " used in " .. locale .. " should have a base translation"
                it(label, function()
                    -- test should not fail, but make it transparent something should be fixed. so no assert here
                    if dictionaries[defaultLocale][key] == nil then
                        pending(label)
                    end
                end)
            end
        end
    end
end)