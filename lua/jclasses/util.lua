local M = {}

local function find_package_name(lines)
    for _, line in ipairs(lines) do
        local trimmed_line = line:match("^%s*(.-)%s*$")

        if trimmed_line:sub(1, 7) == "package" then
            local package_part = trimmed_line:sub(8)

            if package_part:sub(-1) == ";" then
                package_part = package_part:sub(1, -2)

                package_part = package_part:match("^%s*(.-)%s*$")

                return package_part
            end
        end
    end

    return ""
end

local function get_dir(class_name)
    local package_name = class_name:match("^(.-)%.%w+$")

    if package_name then
        local folder_path = package_name:gsub("%.", "/")
        return folder_path -- src/main/java is added later
    else
        return ""
    end
end

local function get_class_name(class_name)
    return class_name:match("([^%.]+)$")
end

local function gen_text(pkg, class_name)
    if pkg == "" then
        return string.format("public class %s {\n\n}", class_name)
    end

    return string.format("package %s;\n\npublic class %s {\n\n}", pkg:gsub("/", "."), class_name)
end

local function write(filename, content)
    local file = io.open(filename, "r")

    if file then
        file:close()
        print("ERROR: File already exists.")
        return
    else
        local file, err = io.open(filename, "w")

        if not file then
            print("Error creating file: " .. err)
            return
        end

        file:write(content)
        file:close()

        print("File created successfully.")
    end
end

function M.createfile(str)
    local dir = get_dir(str)
    local pkg = dir:gsub("/", ".")

    if dir ~= "" then
        dir = "app/src/main/java/" .. dir
    end

    os.execute("mkdir -p " .. dir)

    local class_name = get_class_name(str)
    local filename = ""

    if dir ~= "" then
        filename = dir .. "/" .. class_name .. ".java"
    else
        filename = class_name .. ".java"
    end

    write(filename, gen_text(pkg, class_name))

    vim.api.nvim_command("edit " .. filename)
end

function M.getpackage()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local package_name = find_package_name(lines)

    if package_name then
        return package_name
    else
        return ""
    end
end

return M
