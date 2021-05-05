local spawn = require("deps.coro-spawn")
local json = require("deps.json")

return function(...)
    local message, client = ...
    local user = client:getUser(message.content:match("(%d+)"))
    local req =
        json.parse(spawn("curl", {args = {"https://api.waifu.pics/sfw/wink"}, stdio = {nil, true, 1}}).stdout.read())
    local responses = {" is winking "}
    function with()
        local them = (((message.mentionedUsers.first or {}).name or (user or {}).name or "") or "")
        if them ~= "" then
            return "at " .. them
        end
        return ""
    end
    message:reply {
        embed = {
            title = message.author.name .. responses[math.random(#responses)] .. with(),
            image = {url = req.url},
            color = 16777214
        }
    }
end
