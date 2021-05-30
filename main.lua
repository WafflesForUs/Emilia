local discordia = require("discordia")
local client = discordia.Client{cacheAllMembers=true}
local cmds = require("command_handler")
local acv = require("anti_crash_vid")
require("reqs.functions")
local iw=require("invite_whitelister")  -- delete this if you're using Emilia for personal uses and the file deps/invite_whitelister.lua as well
local bl=require("blacklist")

local prefix = "e!"
local sub,split=string.sub, string.split


client:on(
    "messageCreate",
    function(message) 
  --[===========================================================[
    try{
        if
        (
⠀⠀⠀     ⣠⣾⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣷⣄⠀
⠀⠀⠀     ⣿⣿⡇⠀⠀⢸⣿⢰⣿⡆⠀⣾⣿⡆⠀⣾⣷⠀⣿⣿⡇⠀⠀⢸⣿⣿⠀
⠀⠀⠀     ⣿⣿⡇⠀⠀⢸⣿⠘⣿⣿⣤⣿⣿⣿⣤⣿⡇⠀⢻⣿⡇⠀⠀⢸⣿⣿⠀
⠀⠀⠀     ⣿⣿⡇⠀⠀⢸⡿⠀⢹⣿⣿⣿⣿⣿⣿⣿⠁⠀⢸⣿⣇⠀⠀⢸⣿⣿⠀
⠀⠀⠀     ⠙⢿⣷⣶⣶⡿⠁⠀⠈⣿⣿⠟⠀⣿⣿⠇⠀⠀⠈⠻⣿⣿⣿⣿⡿⠋
        )
        {
            dont bawn me pwease owo i bewg you >.<
        }
    }catch(owo){
        console.log(owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo+owo)
    }
    ]===========================================================]
    end
)
-- this fixes the bug where emilia bans all of the members remove with your own responsibility.


client:on("messageCreate",function(message) 
    pcall(bl,message,client)
end)

client:on("messageUpdate",function(message) 
    pcall(bl,message,client)
end)

client:on("messageCreate",function(message) 
    if not message.guild or message.author.bot then return end
    if message.guild:getMember(message.author.id):hasRole("773838374440009758") then
        pcall(iw,message) 
    end
end)

client:on(
    "messageCreate",
    function(message) 
        if  message.guild then
            pcall(acv,message, client)
        end
    end
)
client:on(
    "messageCreate",
    function(message)
        ExecuteCommand(message,{commands=cmds,prefix=prefix,discordia=discordia})
    end
)

client:run("Bot " .. io.open("token.txt", "r"):read())