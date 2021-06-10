function encrypt(a, b)
    if not a then return end
    return a:gsub(
        ".",
        function(v)
            h = tonumber(b)
            if not h then
                local c = 0
                for i = 1, #b do
                    c = c + b:sub(i, i):byte()
                end
                return c + v:byte() .. " "
            end
            return v:byte()+math.abs(h).." "
        end
    )
end

return {function(...)
    local message,client,data=...
    local args=message.content:split(" ")
    if args[3] then
        local k=message.content:find(args[3])
        message:reply(encrypt(message.content:sub(k),args[2]))
    elseif args[2] then
        local randkey=(function()local h="" for i=1,12 do h=h..string.char(math.random(47,120)) end print(h) return h end)()
        local k=message.content:find(args[2])
        message:reply("your randomly generated key: `"..randkey.."`\n"..encrypt(message.content:sub(k),randkey))
    else
        message:reply("wrong arguments! try "..data.prefix.."`encrypt {key} {value}` instead ")
    end
end,
{
    description = "encrypts a word",
    example = "{prefix}encrypt amogus sussy baka",
    slowdown = 10
}}