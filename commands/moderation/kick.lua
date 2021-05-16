return function(...)
    local message, client, data=...
    local mention=(message.mentionedUsers.first or client:getUser(message.content:match("(%d+)")))
    if mention then
        if message.guild:getMember(message.author.id):hasPermission(2) then
            if not message.guild:getMember(mention.id):hasPermission(2) then
                if not message.guild:kickUser(mention.id,"user kicked by "..message.author.username) then
                    message:reply("unable to kick user")
                end
            else 
                message:reply("this user is a mod, you can't kick mods") 
            end
        else
            message:reply("you don't have permission to use this command")
        end
    else
        message:reply("mention someone to use this command")
    end
end
