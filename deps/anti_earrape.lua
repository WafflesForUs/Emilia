local spawn = require("coro-spawn")
local fs = require("fs")
return function(...)
    local message, client = ...
    local supported = {"mp4", "mp3", "wav", "webm"}
    for _, attachment in pairs(message.attachments) do
        for i, v in pairs(supported) do
            if v == attachment.filename:match(".+%.(%w+)") then
                break
            end
            if i == #supported then
                return
            end
        end

        spawn(
            "ffmpeg",
            {
                args = {
                    "-i",
                    attachment.url,
                    "-af",
                    "astats=metadata=1:reset=1,ametadata=print:key=lavfi.astats.Overall.RMS_level:file=log.txt",
                    "-f",
                    "null",
                    "-"
                },
                stdio = {nil, true, 1}
            }
        ):waitExit()

        local file = io.open("log.txt", "r")
        for i in file:lines() do
            if tonumber(i:match("RMS_level=(.?%d+%.?%d+)")) and (tonumber(i:match("RMS_level=(.?%d+%.?%d+)"))) > -4 then
                message:addReaction("🔊")
                message.channel:send {
                    content = "contains loud audio^",
                    reference = {message = message, mention = true},
                }
                break
            end
        end
    end
    file:close()
end
