return function(...)
    local message, client = ...
    function shuffle(tbl)
        if type(tbl) ~= "table" then
            return
        end
        local check = {}
        for i, v in pairs(tbl) do
            ::bacc::
            local rand = math.random(#tbl)
            if check[rand] then
                goto bacc
            end
            check[rand] = v
        end
        return check
    end

    function shuffleMembers(g)
        local t = {}
        for i in g:iter() do
            table.insert(t, i)
        end
        return shuffle(t)
    end
    p(#client:getRole("773838374440009758").members)
    for _, i in pairs(shuffleMembers(client:getRole("773838374440009758").members)) do
        print(i)
        if i.status == "dnd" or i.status == "online" then
            return message:reply(i.mentionString)
        end
    end
    message:reply("there are no online mods, please try again later")
end
