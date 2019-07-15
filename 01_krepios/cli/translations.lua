require "lively_epsilon/init"

-- this can be used to run translations through a text correction program, like
--
-- lua 01_krepios/cli/translations.lua "de" | java -jar languagetool-commandline.jar --language de-DE --disable FALSCHE_VERWENDUNG_DES_BINDESTRICHS,TYPOGRAFISCHE_ANFUEHRUNGSZEICHEN,UPPERCASE_SENTENCE_START,WHITESPACE_RULE,AUSLASSUNGSPUNKTE,PUNCTUATION_PARAGRAPH_END,DOPPELTES_AUSRUFEZEICHEN -
-- lua 01_krepios/cli/translations.lua "en" | java -jar languagetool-commandline.jar --language en-US --disable UPPERCASE_SENTENCE_START,WHITESPACE_RULE,PUNCTUATION_PARAGRAPH_END,DASH_RULE,PROFANITY,EN_QUOTES,ENGLISH_WORD_REPEAT_BEGINNING_RULE -

local locale = arg[1]

My = My or {}
My.Translator = Translator:new(locale)
My.Translator:useLocale(locale)

require("01_krepios/lang/" .. locale .. "/init")

math.randomseed(os.time())

local endsWith = function(s, suffix)
    s = s:lower()
    suffix = suffix:lower()
    return s:sub(-suffix:len()) == suffix
end

local guessVariableByName = function(variableName)
    if endsWith(variableName, "Person") then
        local person
        if locale == "de" then
            person = Person:byName("Johannes Reh")
        else
            person = Person:byName("John Doe")
        end
        Generic:withTags(person)
        return person
    elseif endsWith(variableName, "Name") or endsWith(variableName, "CallSign") then
        if locale == "de" then
            return "Platzhalter"
        else
            return "placeholder"
        end
    elseif endsWith(variableName, "Names") or endsWith(variableName, "CallSigns") then
        if locale == "de" then
            return {"Platzhalter", "Unbekannt", "Name"}
        else
            return {"placeholder", "unknown", "name"}
        end
    elseif endsWith(variableName, "Product") then
        local product
        if locale == "de" then
            product = Product:new("Schnitzel")
        else
            product = Product:new("thing")
        end
        Generic:withTags(product)
        return product
    else
        -- everything else is probably just a number
        return 42
    end
end

for _, dictionary in pairs(My.Translator:getDictionaries()) do
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

    for _, value in pairs(dictionary) do
        if isFunction(value) then
            local variations = {}
            for _=1,50 do
                local s = value()
                variations[s] = s
            end
            for _, s in pairs(variations) do
                print(s:gsub("\n+", "\n"), "\n")
            end
        else
            print(value:gsub("\n+", "\n"), "\n")
        end
    end
end