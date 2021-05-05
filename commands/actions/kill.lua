local spawn = require("deps.coro-spawn")
local json = require("deps.json")

return function(...)
    local message, client = ...
    local user = (client:getUser(message.content:match("(%d+)")) or message.mentionedUsers.first)
    if user and user.id~=message.author.id then
        local req = json.parse(spawn("curl", {args = {"https://api.waifu.pics/sfw/kill"}, stdio = {nil, true, 1}}).stdout.read())
        local responses={" is killing "," is slaughtering "," is destroying "}
        message:reply {
            embed = {
                title =message.author.name .. responses[math.random(#responses)] .. (user.name or message.mentionedUsers.first.name),
                image = {url = req.url},
                color=16777214
            }
        }
    elseif user.id==message.author.id then
        message:reply("please don't ):")
    else
        message:reply("mention someone to use this commmand")
    end
end
