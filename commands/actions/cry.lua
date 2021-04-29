local spawn = require("deps.coro-spawn")
local json = require("deps.json")

return function(...)
    local message, client = ...
    local user = client:getUser(message.content:match("(%d+)"))
    local kiss =
        json.parse(spawn("curl", {args = {"http://api.nekos.fun:8080/api/cry"}, stdio = {nil, true, 1}}).stdout.read())
    local responses = {}
    function with()
        local them = (((message.mentionedUsers.first or {}).name or (user or {}).name or "") or "")
        if them ~= "" then
            responses={" is crying at ", " is sad because of ", " is sobbing at "}
            return  responses[math.random(#responses)]..them
        end
        responses={" is crying ", " is sad ", " is sobbing "}

        return responses[math.random(#responses)]
    end
    message:reply {
        embed = {
            title = message.author.name  .. with(),
            image = {url = kiss.image},
            color = 16777214
        }
    }
end
