local logs=require("deps.logs")
return function(...)
    local message,client=...
    local args=string.split(message.content," ")
    logs:Reason(message,args[2] or "",string.sub(message.content,#args[2]+#args[1]+3) or "")
end