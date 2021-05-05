local json=require("deps.json")
local spawn=require("deps.coro-spawn")

return function(...) 
    local message,client=...
    if not message.channel.nsfw then message:reply("use this command in a nsfw channel") return end

    local req = json.parse(spawn("curl", {args = {"https://api.waifu.pics/nsfw/neko"}, stdio = {nil, true, 1}}).stdout.read())
    message:reply {
        embed = {
            title ="\"nya\"",
            image = {url = req.url},
            color=16777214
        }
    }

end