function string.split(str, delim)
    local ret = {}
    if not str then
        return ret
    end
    if not delim or delim == "" then
        for c in string.gmatch(str, ".") do
            table.insert(ret, c)
        end
        return ret
    end
    local n = 1
    while true do
        local i, j = string.find(str, delim, n)
        if not i then
            break
        end
        table.insert(ret, string.sub(str, n, i - 1))
        n = j + 1
    end
    table.insert(ret, string.sub(str, n))
    return ret
end

function switch(check, cases)
    if pcall(cases[check]) then
        return
    end
    if cases["default"] then
        cases["default"]()
    end
end

function string.startsWith(self, str)
    return self:sub(1, #str) == str
end

function ExecuteCommand(message, data)
    local prefix = data.prefix
    local discordia = data.discordia
    local cmds = data.commands
    local client = message.client
    if not message.guild or message.author.bot then
        return
    end
    
    local function startsWithPrefix(tbl,str)
        for _,v in pairs(tbl) do
            if str:startsWith(v) then
               return v
            end
        end
    end 

    local arg = string.split(message.content, " ")[1]
    local prefixes=prefix
    local prefix=startsWithPrefix(prefix,arg)
    if prefix then
        
        for _, i in pairs(cmds) do
            if i[string.sub(arg, #(prefix) + 1)] then
                (function()
                    function SearchForFunction(k)
                        if type(k) == "function" then
                            return k
                        end
                        for _, i in pairs(k) do
                            switch(
                                type(i),
                                {
                                    ["table"] = function()
                                        SearchForFunction(i)
                                    end,
                                    ["function"] = function()
                                        local b, h = pcall(i, message, client, {commands = cmds, prefix = prefix, prefixes = prefixes})
                                        if not b then
                                            message:reply("an unknown issue has occurred, please try again later\n"..h)
                                        end
                                    end
                                }
                            )
                        end
                    end
                    SearchForFunction(i[string.sub(arg, #(prefix) + 1)])
                end)()
            end
        end
    end
end
