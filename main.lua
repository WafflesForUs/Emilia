local discordia = require("discordia")
local client = discordia.Client()
local cmds = require("command_handler")
local prefix = "e!"
local acv = require("anti_crash_vid")
require("reqs.functions")
local iw=require("invite_whitelister")  -- delete this if you're using Emilia for personal uses and the file deps/invite_whitelister.lua as well

client:on("messageCreate",function(message) 
    if message.guild and not message.guild:getMember(message.author.id):hasRole("773838374440009758") then
        iw(message) 
    end 
end)-- ^

client:on(
    "messageCreate",
    function(message) 
        if  message.guild then
            acv(message, client)
        end
    end
)
client:on(
    "messageCreate",
    function(message)
        local arg = string.split(message.content, " ")[1]
        if string.sub(arg, 1, #(prefix)) == prefix and message.guild then
            for _, i in pairs(cmds) do
                if i[string.sub(arg, #(prefix) + 1)] then
                    i[string.sub(arg, #(prefix) + 1)](message, client, {commands = cmds, prefix = prefix})
                end
            end
        end
    end
)

client:run("Bot " .. io.open("token.txt", "r"):read())