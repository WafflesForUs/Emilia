local spawn = require("deps.coro-spawn")
local json = require("deps.json")

return function(...)
    local message, client = ...
    local user = client:getUser(message.content:match("(%d+)"))
    local req =
        json.parse(spawn("curl", {args = {"https://shiro.gg/api/images/sleep"}, stdio = {nil, true, 1}}).stdout.read())
    local responses
    function with()
        local them = (((message.mentionedUsers.first or {}).name or (user or {}).name or "") or "")
        if them ~= "" then
            responses={" is saying goodnight to "}
            return responses[math.random(#responses)]..them
            else
                responses={" is sleepy "," is saying goodnight "," is feeling sleepy "}
            return responses[math.random(#responses)]
        end
     end
    message:reply {
        embed = {
            title = message.author.name .. with(),
            image = {url = req.url},
            color = 16777214
        }
    }
end

