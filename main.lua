local discordia=require("discordia")
local client=discordia.Client()
local cmds=require("command_handler")
local prefix="s!"
require("reqs.functions")
local token=""

p(cmds)
client:on("messageCreate", 
    function(message)
        
    local arg=string.split(message.content," ")[1]
        if string.sub(arg,1,#(prefix))==prefix then
            for _,i in pairs(cmds) do
                if i[string.sub(arg,#(prefix)+1)] then
                    i[string.sub(arg,#(prefix)+1)](message,client,{commands=cmds,prefix=prefix})
                end
            end
        end

    end)

client:run("Bot "..token)
