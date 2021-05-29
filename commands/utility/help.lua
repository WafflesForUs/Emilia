function FetchCommands(tbl)
    local h = {}
    for i in pairs(tbl) do
        table.insert(h, i)
    end
    return table.concat(h, ", ")
end
local split = string.split

return {
    function(...)
        local message, _, data = ...
        local cmnd = message.content:split(" ")[2]
        if cmnd then
            for i, v in pairs(data.commands) do
                for i, v in pairs(v) do
                    if i == cmnd then
                        v = v[1]
                        if type(v) == "function" or not v[2] then
                            message:reply("this command doesn't have any description or an example")
                        else
                            local embed = {title = cmnd .. " help", fields = {}}
                            for i, v in pairs(v[2]) do
                                table.insert(
                                    embed.fields,
                                    {name = i, value = tostring(v):gsub("{prefix}", data.prefix)}
                                )
                            end
                            p(embed)
                            message:reply {embed = embed}
                        end

                        return
                    end
                end
            end
        end
        local embed = {title = "commands", fields = {}, color = 16777214}
        for i, v in pairs(data.commands) do
            table.insert(embed.fields, {name = i, value = FetchCommands(v)})
        end

        message:reply({embed = embed})
    end,
    {
        description = "shows the commands list",
        example = "{prefix}help",
        slowdown = 10
    }
}
