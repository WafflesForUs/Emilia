function to255s(number)
    number = tonumber(number)
    if number > 255 then
        number = number - 255
        if number > 255 then
            number = to255s(number)
        end
    end
    if number < 0 then
        number = number + 255
        if number < 0 then
            number = to255s(number)
        end
    end
    return number
end

function decrypt(a, b)
    if not a then
        return
    end
    local data = ""
    local h = tonumber(b)
    for i in string.gmatch(a, "%d+") do
        local bt = tonumber(i)
        if bt then
            if not h then
                local c = 0
                for i = 1, #b do
                    c = c + b:sub(i, i):byte()
                end
                data = data .. string.char(to255s(bt - c))
            else
                data = data .. string.char(to255s(h - bt))
            end
        end
    end
    return data
end

return {
    function(...)
        local message, client, data = ...
        local args = message.content:split(" ")
        if args[3] then
            print(message.content:sub(message.content:find(args[3])))
            local k = message.content:find(args[3])
            message:reply(decrypt(message.content:sub(k), args[2]))
        else
            message:reply("wrong arguments! try " .. data.prefix .. "`encrypt {key} {value}` instead ")
        end
    end,
    {
        description = "decrypts a word",
        example = "{prefix}decrypt amogus 767 769 767 767 773 684 750 749 759 749",
        slowdown = 7
    }
}
