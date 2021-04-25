function FetchCommands(tbl)

    local h={}
    for i in pairs(tbl) do
        table.insert(h,i)
    end
    return table.concat(h,", ")
end

return function(...)
    local message, client, data=...
    local embed={title="commands",fields={},color=16777214 }
        for i,v in pairs(data.commands) do
        table.insert(embed.fields,{name=i,value=FetchCommands(v)})
        end
        p(embed)
    message:reply({embed=embed})
end