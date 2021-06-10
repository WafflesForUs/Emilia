local fs = require("fs")
local timer=require("timer")
local dir="./blacklisted_words"

function DelUnwantedCharacters(str)
    return str:gsub("%d", ""):gsub("%W", ""):gsub(" ", "")
end

return function(...)
    local message, client = ...
    if not message.guild or message.author.bot then
        return
    end

    for _, file in pairs(fs.readdirSync(dir)) do
        local text = fs.readFileSync(dir .."/".. file)
        if text and DelUnwantedCharacters(message.content:lower()):match(file:match("(%w+)")) then

            message:delete()             
            --matches the punishment `{punishment}: `
            local punishment = text:match("(%w+):")
            
            if punishment == "ban" or punishment == "kick" then
                message.guild[punishment.."User"](message.guild, message.author.id, "auto moderation: said "..file, 7)
            elseif punishment=="mute" then
                
                --local duration = text:match("%w+:%s+%d+")    (matches the duration of how long the member will be banned {mute: x})

                local member = message.guild:getMember(message.author.id) 
                member:addRole("778360589369081907")
                --TODO
            end
            local a=message:reply(
                message.author.name .. " received a " .. punishment .. " for saying the " .. file:match("%w") .. " word"
            )
            timer.sleep(5000)
            a:delete()
        end
    end
end
