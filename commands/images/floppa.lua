local json=require("deps.json")
local spawn =require("deps.coro-spawn")
return function(...)
    local message=... 
    local floppa=json.parse(spawn("curl", {args = {"http://ycode.xyz/random.json"}, stdio = {nil, true, 1}}).stdout.read())
    message:reply{
        embed={
            image={url=floppa.file}
            ,color=math.random(255,9999999)
    }
    }
end