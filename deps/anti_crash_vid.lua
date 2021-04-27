function IsSketchy(tbl)
    for i in pairs(tbl) do
        for b in pairs(tbl) do
            if i ~= b then
                if i > b then
                    return (i / b) * 100
                else
                    return (b / i) * 100
                end
            end
        end
    end
end --percentage of file resolution difference
function detector(i, message, client)
    local vals = {}
    for i, v in io.popen("ffprobe -v error -show_entries frame=width,height -select_streams v -of csv=p=0 " .. i.url):lines(

    ) do --video/gif resolution per frame
        if not vals[i:match("(%d+)")] then
            vals[i:match("(%d+)")] = true
        end
    end
    if (IsSketchy(vals) or 100) < 70 then
        message:delete()
        message:reply(
            "dont post crash gifs/videos " ..
                message.author.mentionString .. "\n\n||" .. client:getUser("411887008160415766").mentionString .. "||"
        )
    end
end
return function(message, client)
    if message.attachments then
        for _, i in pairs(message.attachments) do
            local extension = i.filename:lower():match(".+%.(.+)")
            if extension == "mp4" or extension == "gif" or extension == "mov" then
                detector(i, message, client)
            end
        end
    end
    if message.content:lower():match("(https?://.+%.-)") then
        detector({url = message.content:lower():match("(https?://.+%.-)")}, message, client)
    end
    if message.content:lower():match(".+gfycat%..+") then
        message:delete()
        message:reply(
            "due to gfycat having many discord crash gifs, and returning a 403 error each time we try to scan the gif, we decided to automatically delete images from there " ..
                message.author.mentionString
        )
    end
end
