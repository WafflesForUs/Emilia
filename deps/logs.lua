local reasons = {}
function reasons:New(message, action, upon,colour)
    ::back::
    local code = ""
    for i = 1, 6 do
        local h = math.random(97, 122)
            code = code .. string.char(h)
    end
    if self[code] then
        goto back
    end
    local channel = message.client:getChannel("855773180312420372")
    local newmessage =
        channel:send {
            content=message.author.mentionString,
        embed = {
            title = action .. "| case " .. code,
            fields = {
                {name = "user", value = upon.tag .. string.format("(%s)", upon.id)},
                {name = "moderator", value = message.author.tag},
                {name = "reason", value = "Moderator: please do e!reason " .. code .. " [reason]"}
            },
            color=colour or 0
        }
    }
    self[code] = {data = {message = newmessage, upon = upon, moderator = message.author.id}}
    return code
end
function reasons:Reason(msg,case, reason)
    local client = msg.client
    if reasons[case] and client then
        if reasons[case]["data"]["moderator"]~=msg.author.id then 
            return
        end
        self[case]["reason"] = reason
        local message = client:getChannel("855773180312420372"):getMessage(reasons[case]["data"]["message"])
        if not message then
            return
        end
        local h = {}
        local oldembed = message.embed
        for i, v in pairs(oldembed) do
            if i ~= "fields" then
                h[i] = v
            else
                for n, field in pairs(oldembed[i]) do
                    if field["name"] == "reason" then
                        h[i][n] = {name = "reason", value = reason}
                    else
                        h[i] = v
                    end
                end
            end
        end
        message:setEmbed(h)
        message:setContent("")
        msg:delete()
    end
end
return reasons
