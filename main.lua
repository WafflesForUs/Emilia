local discordia = require("discordia")
local client = discordia.Client{cacheAllMembers=true}
local cmds = require("command_handler")
local acv = require("anti_crash_vid")
require("reqs.functions")
local iw=require("invite_whitelister")  -- delete this if you're using Emilia for personal uses and the file deps/invite_whitelister.lua as well
local bl=require("blacklist")
local aer=require("anti_earrape")
local prefix = "e!"
local sub,split=string.sub, string.split

client:on("interactionCreate",function(message,data,member)
    message:reply(data.custom_id)
    message:setContent("h")
end)
--test

client:on("memberJoin",function(member)
    if member.username:lower():match("h0nda") then
        member:ban()
    end
end)
--anti skid

client:on("messageCreate",function(message) 
    pcall(bl,message,client)
end)

client:on("messageCreate",function(message) 
    pcall(aer,message,client)
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