-- TCCS/startup.lua
local github_user = "medakoro"
local repo = "TCCS"
local branch = "main"

local function downloadFile(file)
    local url = string.format(
        "https://raw.githubusercontent.com/medakoro/CC-Tweaked-TCCS/main/TCCS/startup.lua",
        github_user, repo, branch, file
    )
    local response = http.get(url)
    if response then
        local content = response.readAll()
        response.close()
        return content
    end
    return nil
end

local function saveFile(path, content)
    local file = fs.open(path, "w")
    file.write(content)
    file.close()
end

local files = {
    "login/login.lua",
    "login/login_list.json",
    "main/main.lua",
    "lib/basalt.lua"
}

for _, file in ipairs(files) do
    local content = downloadFile(file)
    if content then
        saveFile(file, content)
        print("Downloaded: " .. file)
    else
        print("Failed to download: " .. file)
    end
end

shell.run("login/login.lua")
