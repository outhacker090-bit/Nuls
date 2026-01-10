--// WAITING FOR GAME LOAD
repeat task.wait() until game:IsLoaded()

--// 1. SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local VercelUrl = "https://webhook-rose-nu.vercel.app/api/forward.js"
local Library = require(ReplicatedStorage:WaitForChild("Library"))

--// 2. EXECUTOR REQUEST FINDER
local function getRequest()
    return request 
        or (syn and syn.request) 
        or http_request 
        or (http and http.request) 
        or (fluxus and fluxus.request) 
        or (httpx and httpx.request) 
        or nil
end

--// 3. CONFIG
local Config = {
    Enabled = false,
    Webhook = "", 
    MaxGems = {
        Huge = 2500000,
        Titanic = 100000000,
        Exclusive = 25000,
        ExclusiveLevel = 50000,
        Event = 100000
    }
}

--// 4. UTILITIES
local function toSuffix(n)
    if n >= 1e9 then return string.format("%.2fB", n / 1e9)
    elseif n >= 1e6 then return string.format("%.2fM", n / 1e6)
    elseif n >= 1e3 then return string.format("%.1fK", n / 1e3)
    end
    return tostring(n)
end

local function parseNumber(text)
    text = string.lower(text):gsub(",", ""):gsub(" ", "")
    local num = tonumber(text:match("[%d%.]+"))
    if not num then return 0 end
    if text:find("k") then num *= 1e3
    elseif text:find("m") then num *= 1e6
    elseif text:find("b") then num *= 1e9 end
    return math.floor(num)
end

--// 5. IMPROVED WEBHOOK SENDER
local function SendWebhook(title, item, price, cat)
    if Config.Webhook == "" then return end
    
    local execRequest = getRequest()
    local payload = HttpService:JSONEncode({
        ["webhook"] = Config.Webhook, -- Vercel proxy requirement
        ["content"] = "@everyone",
        ["embeds"] = {{
            ["title"] = title,
            ["color"] = 65420,
            ["fields"] = {
                {["name"] = "Item", ["value"] = item, ["inline"] = true},
                {["name"] = "Price", ["value"] = toSuffix(price), ["inline"] = true},
                {["name"] = "Type", ["value"] = cat, ["inline"] = true},
                {["name"] = "User", ["value"] = LocalPlayer.Name, ["inline"] = false}
            },
            ["footer"] = {["text"] = "NulsHub Sniper | V9"}
        }}
    })

    if execRequest then
        -- Use Executor's special request function
        task.spawn(function()
            execRequest({
                Url = VercelUrl,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = payload
            })
        end)
    else
        -- Fallback to standard HttpService (Only works if HttpEnabled is ON)
        pcall(function()
            HttpService:PostAsync(VercelUrl, payload)
        end)
    end
end

--// 6. SNIPER LOGIC
local function TryBuy(listingUID, price, itemData, sellerId)
    if not Config.Enabled then return end
    local itemId = itemData.id
    local petData = Library.Directory.Pets[itemId]
    if not petData then return end

    local buy = false
    local cat = "Other"

    if petData.titanic and price <= Config.MaxGems.Titanic then buy = true cat = "Titanic"
    elseif petData.huge and price <= Config.MaxGems.Huge then buy = true cat = "Huge"
    elseif petData.exclusiveLevel and price <= Config.MaxGems.ExclusiveLevel then buy = true cat = "Excl Lvl"
    elseif string.find(itemId, "Exclusive") and price <= Config.MaxGems.Exclusive then buy = true cat = "Exclusive"
    end

    if buy then
        task.spawn(function()
            local success = ReplicatedStorage.Network.Booths_RequestPurchase:InvokeServer(tostring(sellerId), listingUID)
            if success then
                SendWebhook("🚀 Successful Snipe!", itemId, price, cat)
            end
        end)
    end
end

ReplicatedStorage.Network.Booths_Broadcast.OnClientEvent:Connect(function(sellerId, data)
    if not Config.Enabled or type(data) ~= "table" or not data.Listings then return end
    for uid, info in pairs(data.Listings) do
        if info.ItemData and info.ItemData.data then
            TryBuy(uid, info.DiamondCost, info.ItemData.data, sellerId)
        end
    end
end)

--// 7. UI CONSTRUCTION
if CoreGui:FindFirstChild("NulsHubV9") then CoreGui.NulsHubV9:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "NulsHubV9"

local function SmoothDrag(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = obj.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    obj.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 280); Main.Position = UDim2.new(0.5, -210, 0.5, -140); Main.BackgroundColor3 = Color3.fromRGB(15,15,15); Main.BorderSizePixel = 0; Main.Visible = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
SmoothDrag(Main)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45); Title.Text = "NulsHub"; Title.TextColor3 = Color3.fromRGB(0, 255, 140); Title.Font = Enum.Font.GothamBlack; Title.TextSize = 22; Title.BackgroundTransparency = 1

local Side = Instance.new("Frame", Main); Side.Size = UDim2.new(0, 100, 1, -45); Side.Position = UDim2.new(0,0,0,45); Side.BackgroundColor3 = Color3.fromRGB(20,20,20); Side.BorderSizePixel = 0
Instance.new("UIListLayout", Side)

local Container = Instance.new("Frame", Main); Container.Size = UDim2.new(1, -110, 1, -55); Container.Position = UDim2.new(0, 105, 0, 50); Container.BackgroundTransparency = 1

local Pages = {}
local function CreateTab(name)
    local b = Instance.new("TextButton", Side); b.Size = UDim2.new(1, 0, 0, 40); b.BackgroundTransparency = 1; b.Text = name; b.Font = Enum.Font.GothamBold; b.TextColor3 = Color3.fromRGB(150,150,150); b.TextSize = 13
    local p = Instance.new("ScrollingFrame", Container); p.Size = UDim2.new(1,0,1,0); p.Visible = false; p.BackgroundTransparency = 1; p.ScrollBarThickness = 0
    b.MouseButton1Click:Connect(function() for _, v in pairs(Pages) do v.Visible = false end p.Visible = true end)
    Pages[name] = p
    return p
end

local Home = CreateTab("Home")
local Settings = CreateTab("Settings")
local Discord = CreateTab("Discord")

-- Home
local Tgl = Instance.new("TextButton", Home); Tgl.Size = UDim2.new(1, 0, 0, 50); Tgl.BackgroundColor3 = Color3.fromRGB(30,30,30); Tgl.Text = "SNIPER: OFF"; Tgl.Font = Enum.Font.GothamBlack; Tgl.TextColor3 = Color3.fromRGB(255,80,80); Tgl.TextSize = 18; Instance.new("UICorner", Tgl)
Tgl.MouseButton1Click:Connect(function()
    Config.Enabled = not Config.Enabled
    Tgl.Text = Config.Enabled and "SNIPER: ON" or "SNIPER: OFF"
    Tgl.TextColor3 = Config.Enabled and Color3.fromRGB(0,255,140) or Color3.fromRGB(255,80,80)
end)

-- Settings
local Grid = Instance.new("UIGridLayout", Settings); Grid.CellSize = UDim2.new(0, 150, 0, 55)
local function AddInp(txt, key)
    local f = Instance.new("Frame", Settings); f.BackgroundColor3 = Color3.fromRGB(25,25,25); Instance.new("UICorner", f)
    local l = Instance.new("TextLabel", f); l.Text = txt; l.Size = UDim2.new(1,0,0,20); l.TextColor3 = Color3.fromRGB(0,255,140); l.Font = Enum.Font.GothamBold; l.TextSize = 10; l.BackgroundTransparency = 1
    local i = Instance.new("TextBox", f); i.Size = UDim2.new(1,-20,0,25); i.Position = UDim2.new(0,10,0,22); i.Text = toSuffix(Config.MaxGems[key]); i.BackgroundColor3 = Color3.fromRGB(35,35,35); i.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", i)
    i.FocusLost:Connect(function() local val = parseNumber(i.Text) Config.MaxGems[key] = val i.Text = toSuffix(val) end)
end
AddInp("Huge Max", "Huge"); AddInp("Titanic Max", "Titanic"); AddInp("Excl Max", "Exclusive")

-- Discord
local DiscI = Instance.new("TextBox", Discord); DiscI.Size = UDim2.new(1, 0, 0, 40); DiscI.PlaceholderText = "Paste Webhook URL Here"; DiscI.Text = ""; DiscI.BackgroundColor3 = Color3.fromRGB(25,25,25); DiscI.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", DiscI)
DiscI.FocusLost:Connect(function() Config.Webhook = DiscI.Text end)

local TestBtn = Instance.new("TextButton", Discord); TestBtn.Size = UDim2.new(1,0,0,40); TestBtn.Position = UDim2.new(0,0,0,50); TestBtn.BackgroundColor3 = Color3.fromRGB(0,120,200); TestBtn.Text = "TEST WEBHOOK"; TestBtn.Font = Enum.Font.GothamBold; TestBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", TestBtn)
TestBtn.MouseButton1Click:Connect(function() SendWebhook("✅ Test Message", "NulsHub Connection Check", 0, "Test") end)

-- Floating Button
local Float = Instance.new("TextButton", ScreenGui); Float.Size = UDim2.new(0, 60, 0, 60); Float.Position = UDim2.new(0.9, 0, 0.1, 0); Float.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Float.Text = "NULS"; Float.TextColor3 = Color3.fromRGB(0, 255, 140); Float.Font = Enum.Font.GothamBlack; Float.TextScaled = true; Instance.new("UICorner", Float).CornerRadius = UDim.new(1,0)
Instance.new("UIPadding", Float).PaddingTop = UDim.new(0,18)
SmoothDrag(Float)
Float.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

Home.Visible = true
