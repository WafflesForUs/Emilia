return function(...)
    local message, client, data=...
    local mention=message.mentionedUsers or client:getUser(message.content:mtach("(%d)"))
    if mention then
        
    end
end