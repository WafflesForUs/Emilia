local pp = require("deps.pretty-print")
spawn=require("deps.coro-spawn")

function codeblock(code, lang)
    local lang = lang or ""
    return string.format("```" .. lang .. "\n%s```", code)
end

local function lineprint(...)
    local ret = {}
    for i = 1, select("#", ...) do
        local arg = tostring(select(i, ...))
        table.insert(ret, arg)
    end
    return table.concat(ret, "\t")
end

local function prettyprint(...)
    local ret = {}
    for i = 1, select("#", ...) do
        local arg = pp.strip(pp.dump(select(i, ...)))
        table.insert(ret, arg)
    end
    return table.concat(ret, "\t")
end

function eval(code, message)
    if
        not code or
            not message.client:getGuild("738517191644807250"):getMember(message.author.id):hasRole("852971883720343602")
     then
        return
    end
    code = code:match("```l?u?a?(.+)```") or code
    local global = setmetatable({}, {__index = _G})
    local lines = {}
    global.p = function(...)
        table.insert(lines, prettyprint(...))
    end
    global.print = function(...)
        table.insert(lines, lineprint(...))
    end
    global.message = message

    local exec, syntax = load(code, "emilia", "t", global)
    if not exec then
        return message:reply{embed={title="syntax error",description=codeblock(syntax),color=math.random(255,99999)}}
    end
    local success, error = pcall(exec)
    if not success then
        return message:reply{embed={title="error",description=codeblock(error),color=math.random(255,99999)}}
    end
    if #table.concat(lines, "\n") == 0 then
        return
    end
    local output=string.sub(table.concat(lines, "\n"),1,1991)
    message:reply{embed={title="output",description=codeblock(output, "lua"),color=math.random(255,99999)}}
end

return {function(...)
    message, client, data = ...
    pcall(eval,message.content:sub(#(data.prefix .. "eval") + 2), message)
end,{
    description = "executes a lua code",
    example = "{prefix}eval ```lua\nprint('init is gay')```",
    slowdown = 5
}
}