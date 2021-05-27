function RandomFromarray(tbl)
    return tbl[math.random(#tbl)]
end
function RandomDndOrOnlineMember(g)
    local t = {}
    for i in g:iter() do
        if i.status == "dnd" or i.status == "online" then
            table.insert(t, i)
        end
    end
    return RandomFromarray(t)
end

return function(...)
    local message, client = ...
    local mod=RandomDndOrOnlineMember(client:getRole("773838374440009758").members)
    if mod then 
        message:reply(mod.mentionString)
    else
        message:reply("no mods are online")
    end
end
