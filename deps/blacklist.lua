local fs = require("fs")

return function(...)
    local message, client = ...
    if not message.guild or message.author.bot then return end

    for _, file in pairs(fs.readdirSync("./blacklisted_words")) do
        local text = fs.readFileSync("./blacklisted_words/" .. file)

        if text and message.content:match(file:match("(%w+)")) then
            message:delete()
            local punishment = text:match("(%w+):") --matches the punishment `{punishment}: `
            if punishment == "ban" then
                print("c")
                message.guild:banUser(message.author.id, "auto moderation", 7)
            elseif punishment == "kick" then
                print("b")
                message.guild:kickUser(message.author.id, "auto moderation", 7)
            elseif punishment == "mute" then
                print("a")
                --TODO
                local duration = text:match("%w+:%s+%d+") --matches the duration of how long the member will be banned {mute: x}
                local member = message.guild:getMember(message.author.id) -- message.member can return nil which can cause the bot to crash
                member:addRole("778360589369081907")
            end
        end
    end
end
