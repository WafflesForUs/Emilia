local json=require("deps.json")
local spawn=require("deps.coro-spawn")

return function(...) 
    local message,client=...
    local req = json.parse(spawn("curl", {args = {"https://shiro.gg/api/images/neko"}, stdio = {nil, true, 1}}).stdout.read())
    message:reply {
        embed = {
            title ="\"nya\"",
            image = {url = req.url},
            color=16777214
        }
    }

end