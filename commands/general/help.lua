function FetchCommands(tbl)

    local h={}
    for i in pairs(tbl) do
        table.insert(h,i)
    end
    return table.concat(h,", ")
end

return function(...)
    local message, client, data=...
    local embed={title="commands",fields={}}
        for i,v in pairs(data.commands) do
        table.insert(embed.fields,{name=i,value=FetchCommands(v)})
        end
    message:reply({embed=embed})
end