local json=require("deps.json")
local spawn=require("deps.coro-spawn")

return {function(...) 
    local message,client=...
    local req = json.parse(spawn("curl", {args = {"https://shiro.gg/api/images/trap"}, stdio = {nil, true, 1}}).stdout.read())
    message:reply {
        embed = {
            title ="if there's a hole there's a way",
            image = {url = req.url},
            color=16777214
        }
    }

end,
{
    description = "posts a fucking trap",
    example = "{prefix}trap",
    slowdown = 5
}
}