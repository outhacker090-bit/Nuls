--// WAITING FOR GAME LOAD
repeat task.wait() until game:IsLoaded()

--// 1. SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local VercelUrl = "https://webhook-rose-nu.vercel.app/api/forward.js"

--// 2. CONFIG & LIBRARY
local Library = require(ReplicatedStorage:WaitForChild("Library"))
local Config = {
    Enabled = false,
    Webhook = "",
    MaxGems = {
        Exclusive = 25000,
        ExclusiveLevel = 50000,
        Huge = 2500000,
        Titanic = 100000000,
        Event = 100000
    }
}

--// 3. FORMATTING TOOLS
local function toSuffix(n)
    if n >= 1e9 then return string.format("%.1fB", n / 1e9):gsub("%.0", "")
    elseif n >= 1e6 then return string.format("%.1fM", n / 1e6):gsub("%.0", "")
    elseif n >= 1e3 then return string.format("%.1fK", n / 1e3):gsub("%.0", "")
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

--// 4. NEW & IMPROVED SNIPER LOGIC
local function TryBuy(listingId, price, itemData, sellerId)
    if not Config.Enabled then return end
    
    local itemId = itemData.id
    local petData = Library.Directory.Pets[itemId]
    if not petData then return end

    local buy = false
    local category = "Other"

    if petData.titanic and price <= Config.MaxGems.Titanic then buy = true category = "Titanic"
    elseif petData.huge and price <= Config.MaxGems.Huge then buy = true category = "Huge"
    elseif petData.exclusiveLevel and price <= Config.MaxGems.ExclusiveLevel then buy = true category = "Exclusive Lvl"
    elseif string.find(itemId, "Exclusive") and price <= Config.MaxGems.Exclusive then buy = true category = "Exclusive"
    elseif itemId == "Titanic Christmas Present" and price <= Config.MaxGems.Event then buy = true category = "Event"
    end

    if buy then
        -- Updated Remote Call
        local success = ReplicatedStorage.Network.Booths_RequestPurchase:InvokeServer(sellerId, listingId)
        if success then
            print("✅ PURCHASED: " .. itemId .. " for " .. toSuffix(price))
            -- Send Webhook
            pcall(function()
                local data = {
                    ["url"] = Config.Webhook,
                    ["content"] = "@everyone",
                    ["embeds"] = {{
                        ["title"] = "🚀 NulsHub Snipe!",
                        ["color"] = 65420,
                        ["fields"] = {
                            {["name"] = "Item", ["value"] = itemId, ["inline"] = true},
                            {["name"] = "Price", ["value"] = toSuffix(price), ["inline"] = true},
                            {["name"] = "Type", ["value"] = category, ["inline"] = true}
                        }
                    }}
                }
                HttpService:PostAsync(VercelUrl, HttpService:JSONEncode(data))
            end)
        end
    end
end

-- Monitor Booths
ReplicatedStorage.Network:WaitForChild("Booths_Broadcast").OnClientEvent:Connect(function(_, data)
    if not Config.Enabled or type(data) ~= "table" or not data.Listings then return end
    for listingId, info in pairs(data.Listings) do
        if info.ItemData and info.ItemData.data then
            TryBuy(listingId, info.DiamondCost, info.ItemData.data, data.PlayerID)
        end
    end
end)

--// 5. GUI CONSTRUCTION
if CoreGui:FindFirstChild("NulsHubV4") then CoreGui.NulsHubV4:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "NulsHubV4"

-- Smooth Draggable Function
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

-- Main Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 280); Main.Position = UDim2.new(0.5, -210, 0.5, -140); Main.BackgroundColor3 = Color3.fromRGB(15,15,15); Main.BorderSizePixel = 0; Main.Visible = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
SmoothDrag(Main)

-- Glowing Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45); Title.Text = "NulsHub"; Title.TextColor3 = Color3.fromRGB(0, 255, 140); Title.Font = Enum.Font.GothamBlack; Title.TextSize = 22; Title.BackgroundTransparency = 1
local Glow = Instance.new("UIStroke", Title); Glow.Thickness = 2; Glow.Transparency = 0.4; Glow.Color = Title.TextColor3

-- Sidebar
local Side = Instance.new("Frame", Main); Side.Size = UDim2.new(0, 100, 1, -45); Side.Position = UDim2.new(0,0,0,45); Side.BackgroundColor3 = Color3.fromRGB(20,20,20); Side.BorderSizePixel = 0
Instance.new("UIListLayout", Side)

-- Content Area
local Container = Instance.new("Frame", Main); Container.Size = UDim2.new(1, -110, 1, -55); Container.Position = UDim2.new(0, 105, 0, 50); Container.BackgroundTransparency = 1

local Pages = {}
local function CreateTab(name)
    local b = Instance.new("TextButton", Side); b.Size = UDim2.new(1, 0, 0, 40); b.BackgroundTransparency = 1; b.Text = name; b.Font = Enum.Font.GothamBold; b.TextColor3 = Color3.fromRGB(150,150,150); b.TextSize = 13
    local p = Instance.new("ScrollingFrame", Container); p.Size = UDim2.new(1,0,1,0); p.Visible = false; p.BackgroundTransparency = 1; p.ScrollBarThickness = 0
    b.MouseButton1Click:Connect(function() 
        for _, v in pairs(Pages) do v.Visible = false end 
        p.Visible = true 
    end)
    Pages[name] = p
    return p
end

local Home = CreateTab("Home")
local Settings = CreateTab("Settings")

-- Home: Sniper Toggle
local Tgl = Instance.new("TextButton", Home); Tgl.Size = UDim2.new(1, 0, 0, 60); Tgl.BackgroundColor3 = Color3.fromRGB(30,30,30); Tgl.Text = "SNIPER: OFF"; Tgl.Font = Enum.Font.GothamBlack; Tgl.TextColor3 = Color3.fromRGB(255,80,80); Tgl.TextSize = 18; Instance.new("UICorner", Tgl)
Tgl.MouseButton1Click:Connect(function()
    Config.Enabled = not Config.Enabled
    Tgl.Text = Config.Enabled and "SNIPER: ON" or "SNIPER: OFF"
    Tgl.TextColor3 = Config.Enabled and Color3.fromRGB(0,255,140) or Color3.fromRGB(255,80,80)
end)

-- Settings: Grid Inputs
local Grid = Instance.new("UIGridLayout", Settings); Grid.CellSize = UDim2.new(0, 150, 0, 55); Grid.CellPadding = UDim2.new(0,10,0,10)
local function AddInp(txt, key)
    local f = Instance.new("Frame", Settings); f.BackgroundColor3 = Color3.fromRGB(25,25,25); Instance.new("UICorner", f)
    local l = Instance.new("TextLabel", f); l.Text = txt; l.Size = UDim2.new(1,0,0,20); l.TextColor3 = Color3.fromRGB(0,255,140); l.Font = Enum.Font.GothamBold; l.TextSize = 10; l.BackgroundTransparency = 1
    local i = Instance.new("TextBox", f); i.Size = UDim2.new(1,-20,0,25); i.Position = UDim2.new(0,10,0,22); i.Text = toSuffix(Config.MaxGems[key]); i.BackgroundColor3 = Color3.fromRGB(35,35,35); i.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", i)
    i.FocusLost:Connect(function() 
        local val = parseNumber(i.Text)
        Config.MaxGems[key] = val
        i.Text = toSuffix(val)
    end)
end
AddInp("Huge Max", "Huge"); AddInp("Titanic Max", "Titanic"); AddInp("Excl Max", "Exclusive"); AddInp("Event Max", "Event")

--// 6. FLOATING BUTTON (FIXED)
local Float = Instance.new("TextButton", ScreenGui)
Float.Size = UDim2.new(0, 65, 0, 65)
Float.Position = UDim2.new(0.9, 0, 0.1, 0)
Float.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Float.Text = "NULS"
Float.TextColor3 = Color3.fromRGB(0, 255, 140)
Float.Font = Enum.Font.GothamBlack
Float.TextScaled = true -- FIXED: No more pixelated/tiny text
Instance.new("UICorner", Float).CornerRadius = UDim.new(1, 0)
local FloatStroke = Instance.new("UIStroke", Float); FloatStroke.Color = Float.TextColor3; FloatStroke.Thickness = 2

-- Padding for text so it doesn't touch the circle edges
local Padding = Instance.new("UIPadding", Float)
Padding.PaddingBottom = UDim.new(0, 15); Padding.PaddingTop = UDim.new(0, 15); Padding.PaddingLeft = UDim.new(0, 10); Padding.PaddingRight = UDim.new(0, 10)

SmoothDrag(Float)
Float.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

Home.Visible = true
print("NulsHub v4 Loaded - Everything Fixed.")
