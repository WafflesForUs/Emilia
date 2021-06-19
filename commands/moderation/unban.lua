local logs=require("deps.logs")
return function(...)
    local message, client, data=...
    local mention=(message.mentionedUsers.first or client:getUser(message.content:match("(%d+)")))
    if mention then
        if message.guild:getMember(message.author.id):hasPermission(2) then
                if not message.guild:unbanUser(mention.id,"user unbanned by "..message.author.username) then
                    return message:reply("unable to unban user")
                end
                logs:New(message,"unban",mention,3066993)
        else
            message:reply("you don't have permission to use this command")
        end
    else
        message:reply("mention someone to use this command")
    end
end
