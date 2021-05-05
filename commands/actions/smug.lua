local spawn = require("deps.coro-spawn")
local json = require("deps.json")

return function(...)
    local message, client = ...
    local user = client:getUser(message.content:match("(%d+)"))
    local req =
        json.parse(spawn("curl", {args = {"http://api.nekos.fun:8080/api/smug"}, stdio = {nil, true, 1}}).stdout.read())
    local responses
    function with()
        local them = (((message.mentionedUsers.first or {}).name or (user or {}).name or "") or "")
        if them ~= "" then
            responses={" is smirking at "," is lewding "," is smugging at "}
            return responses[math.random(#responses)]..them
            else
                responses={" is smugging "," is smirking "," is thinking lewd "}
            return responses[math.random(#responses)]
        end
     end
    message:reply {
        embed = {
            title = message.author.name .. with(),
            image = {url = req.image},
            color = 16777214
        }
    }
end

