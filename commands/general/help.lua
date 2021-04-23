function FetchCommands(tbl)

    local h=""
    for i in pairs(tbl) do
        h=h..", "..i
    end
    return h
end

return function(...)
    local message, client, data=...
    local embed={title="commands",fields={}}
        for i,v in pairs(data.commands) do
            
        table.insert(embed.fields,{name=i,value=FetchCommands(v)})
        end
        p(embed)
    message:reply({embed=embed})
end