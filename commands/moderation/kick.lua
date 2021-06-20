local logs = require("deps.logs")
return {
    function(...)
        local message, client, data = ...
        local mention = (message.mentionedUsers.first or client:getUser(message.content:match("(%d+)")))
        if mention then
            if message.guild:getMember(message.author.id):hasPermission(2) then
                if not message.guild:getMember(mention.id) or not message.guild:getMember(mention.id):hasPermission(4) then
                    if not message.guild:kickUser(mention.id, "user kicked by " .. message.author.username) then
                        return message:reply("unable to kick user")
                    end
                    logs:New(message, "kick", mention, 15158332)
                else
                    message:reply("this user is a mod, you can't kick mods")
                end
            else
                message:reply("you don't have permission to use this command")
            end
        else
            message:reply("mention someone to use this command")
        end
    end,
    {
        description = "kicks a user from the guild",
        example = "{prefix}kick @init",
        slowdown = 5
    }
}
