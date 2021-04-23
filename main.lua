local discordia=require("discordia")
local client=discordia.Client()
local cmds=require("command_handler")
local prefix="s!"

local token=""

client:on("messageCreate", 
    function(message)
        --[[
        if string.sub(message.content,1,#(prefix))==prefix then
            for _,i in pairs(cmds) do
                if i[string.sub(message.content,#(prefix)+1)] then
                    i[string.sub(message.content,#(prefix)+1)](message,client)
                end
            end
        end
]]
    end)
 --still working on this part lmao 


client:run("Bot "..token)
