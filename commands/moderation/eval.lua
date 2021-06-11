local pp = require("deps.pretty-print")

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
    local functions = setmetatable({}, {__index = _G})
    local lines = {}
    functions.p = function(...)
        table.insert(lines, prettyprint(...))
    end
    functions.print = function(...)
        table.insert(lines, lineprint(...))
    end
    functions.message = message

    local exec, syntax = load(code, "emilia", "t", functions)
    if not exec then
        return message:reply(codeblock(syntax))
    end
    local success, error = pcall(exec)
    if not success then
        return message:reply(codeblock(error))
    end
    if #table.concat(lines, "\n") == 0 then
        return
    end
    message:reply(codeblock(table.concat(lines, "\n"), "lua"))
end

return function(...)
    local message, client, data = ...
    eval(message.content:sub(#(data.prefix .. "eval") + 2), message)
end
