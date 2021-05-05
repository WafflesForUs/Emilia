local spawn = require("deps.coro-spawn")
local json = require("deps.json")

return function(...)
    local message, client = ...
    local user = client:getUser(message.content:match("(%d+)"))
    local req =
        json.parse(spawn("curl", {args = {"http://api.nekos.fun:8080/api/laugh"}, stdio = {nil, true, 1}}).stdout.read())
    local responses = {" is laughing ", " is releasing depomine ", " is happy "}
    function with()
        local them = (((message.mentionedUsers.first or {}).name or (user or {}).name or "") or "")
        if them ~= "" then
            return "with " .. them
        end
        return ""
    end
    message:reply {
        embed = {
            title = message.author.name .. responses[math.random(#responses)] .. with(),
            image = {url = req.image},
            color = 16777214
        }
    }
end
