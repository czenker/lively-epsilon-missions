Person = Person or {}
Person.newHuman = My.deduplicateName(function()
    local gender = Util.random({"male", "female"})
    local firstName
    if gender == "male" then
        firstName = Util.random(Names.humanMaleFirstNames)
    else
        firstName = Util.random(Names.humanFemaleFirstNames)
    end
    local lastName = Util.random(Names.humanLastNames)

    local person = Person:byName(firstName .. " " .. lastName, firstName)
    Person:withTags(person, gender)

    return person
end)

Person.newHumanScientist = My.deduplicateName(function()
    local gender = Util.random({"male", "female"})
    local firstName
    if gender == "male" then
        firstName = Util.random(Names.humanMaleFirstNames)
    else
        firstName = Util.random(Names.humanFemaleFirstNames)
    end
    local lastName = Util.random(Names.humanLastNamesScientific)

    local person = Person:byName(firstName .. " " .. lastName, firstName)
    Person:withTags(person, gender)

    return person
end)
