local Input = require("nui.input")
local event = require("nui.utils.autocmd").event
local util = require("jclasses.util")

local M = {}

function M.test()
    local function def_value(package_name)
        if package_name == "" then
            return ""
        else
            return package_name .. "."
        end
    end

    local input = Input({
        position = "50%",
        size = {
            width = 100,
        },
        border = {
            style = "single",
            text = {
                top = "[Enter a class name]",
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }, {
        prompt = "> ",
        default_value = def_value(util.getpackage()),
        on_submit = function(value)
            util.createfile(value)
        end,
    })

    -- mount/open the component
    input:mount()

    -- unmount component when cursor leaves buffer
    input:on(event.BufLeave, function()
        input:unmount()
    end)
end

return M
