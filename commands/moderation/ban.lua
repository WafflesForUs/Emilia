local logs=require("deps.logs")
return {function(...)
    local message, client, data=...
    local mention=(message.mentionedUsers.first or client:getUser(message.content:match("(%d+)")))
    if mention then
        if message.guild:getMember(message.author.id):hasPermission(4) then
            if not message.guild:getMember(mention.id) or not message.guild:getMember(mention.id):hasPermission(4) then
                if not message.guild:banUser(mention.id,"user banned by "..message.author.username) then
                    return message:reply("unable to ban user")
                end
                logs:New(message,"ban",mention,15158332)
            else 
                message:reply("this user is a mod, you can't ban mods") 
            end
        else
            message:reply("you don't have permission to use this command")
        end
    else
        message:reply("mention someone to use this command")
    end
end,
{
    description = "bans a user from the guild",
    example = "{prefix}help ban @init",
    slowdown = 10
}
}
