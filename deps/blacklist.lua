local fs = require("fs")

return function(...)
    local message, client = ...
    if not message.guild or message.author.bot then
        return
    end

    for _, file in pairs(fs.readdirSync("./blacklisted_words")) do
        local text = fs.readFileSync("./blacklisted_words/" .. file)

        if text and message.content:gsub("%d", ""):gsub("%W", ""):gsub(" ", ""):lower():match(file:match("(%w+)")) then
            message:delete()
            local punishment = text:match("(%w+):") --matches the punishment `{punishment}: `
            if punishment == "ban" or punishment == "kick" then
                message.guild["banUser"](message.guild, message.author.id, "auto moderation", 7)
            elseif punishment=="mute" then
                --TODO
                local duration = text:match("%w+:%s+%d+") --matches the duration of how long the member will be banned {mute: x}
                local member = message.guild:getMember(message.author.id) -- message.member can return nil which can cause the bot to crash
                member:addRole("778360589369081907")
            end
            message:reply(
                message.author.name .. " received a " .. punishment .. " for saying the " .. file:match("%w") .. " word"
            )
        end
    end
end
