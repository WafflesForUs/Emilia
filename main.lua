local discordia = require("discordia")
local client = discordia.Client()
local cmds = require("command_handler")
local prefix = "e!"
local acv = require("anti_crash_vid")
require("reqs.functions")
local iw=require("invite_whitelister")  -- delete this if you're using Emilia for personal uses and the file deps/invite_whitelister.lua as well

client:on("messageCreate",function(message) 
    if not message.guild or message.author.bot then return end
    if message.guild:getMember(message.author.id):hasRole("773838374440009758") then
        pcall(iw,message) 
    end
end)-- ^

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
        if not message.guild or message.author.bot then return end
        local arg = string.split(message.content, " ")[1]
        if string.sub(arg, 1, #(prefix)) == prefix then
            for _, i in pairs(cmds) do
                if i[string.sub(arg, #(prefix) + 1)] then
                    local h,b=pcall(i[string.sub(arg, #(prefix) + 1)],message, client, {commands = cmds, prefix = prefix})
                    if not h then
                        client:getChannel("841854073405702194"):send{embed={color=15158332,title="error",description="```"..b.."```",timestamp = discordia.Date():toISO('T', 'Z')}}
                        message:reply("an unknown issue has occurred, please try again later")
                    end
                end
            end
        end
    end
)

client:run("Bot " .. io.open("token.txt", "r"):read())