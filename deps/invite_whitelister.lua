--[[

please delete this if you're using this for your personal purposes as it requires you to make another bot and run a web server 
to put the list of invites of every guild that bot is in to use as a whitelist  


]]


local spawn = require "deps.coro-spawn"
local json = require "json"

function IsInvite(str)
    return (str:match("discord%.gg/([--z]+)") or str:match("discord%.com/invite/([--z]+)"))
    end

return function(...)
    local invites=json.parse(spawn("curl", {args = {"127.0.0.1:80/whitelist"}, stdio = {nil, true, 1}}).stdout.read() or '{"discord-developers":"613425648685547541","dbl":"264445053596991498"}')
    local message, client=...
    if IsInvite(message.content) and not invites[IsInvite(message.content)] then
        message:delete()
        message:reply("your invite link wasn't whitelisted therefore deleted if <@837143242713726996> was in that server and you think there's a problem you can contact <@411887008160415766>")
    end
end