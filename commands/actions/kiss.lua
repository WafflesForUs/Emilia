local spawn = require("deps.coro-spawn")
local json = require("deps.json")

return function(...)
    local kiss =
        json.parse(spawn("curl", {args = {"http://api.nekos.fun:8080/api/kiss"}, stdio = {nil, true, 1}}).stdout.read())
    local message, client = ...
    local user = client:getUser(message.content:match("(%d+)"))
    if message.mentionedUsers.first or user then
        local responses={" is embarrassing "," is showing love to "," is doing stuff to "}
        message:reply {
            embed = {
                title =message.author.name .. responses[math.random(#responses)] .. (user.name or message.mentionedUsers.first.name),
                image = {url = kiss.image},
                color=16777214
            }
        }
    end
end
