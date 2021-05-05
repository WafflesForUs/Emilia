local spawn = require("deps.coro-spawn")
local json = require("deps.json")

return function(...)
    local message, client = ...
    local user = client:getUser(message.content:match("(%d+)"))
    if message.mentionedUsers.first or user then
        local req = json.parse(spawn("curl", {args = {"http://api.nekos.fun:8080/api/slap"}, stdio = {nil, true, 1}}).stdout.read())
        local responses={" is slapping "," is hurting "," landed a hit on "}
        message:reply {
            embed = {
                title =message.author.name .. responses[math.random(#responses)] .. (user.name or message.mentionedUsers.first.name),
                image = {url = req.image},
                color=16777214
            }
        }
    else
        message:reply("mention someone to use this command")
    end
end
