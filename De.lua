-- Roblox FE LocalScript: Giant WINDOW OUTLINE – EVERY LINE SEGMENT AS OWN PART
-- Outer frame split into 8 separate short pieces + full crossbars

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character
local humanoid
local rootPart

local function makeWindowOutlineSegments()
    -- Clean up all previous parts
    for _, name in ipairs({
        "TopCenter", "TopRight",
        "BottomLeft", "BottomCenter",
        "LeftTop", "RightBottom",
        "HorizontalCross", "VerticalCross"
    }) do
        pcall(function() character:FindFirstChild(name):Destroy() end)
    end
    
    -- Hide original body (keeps collision)
    for _, obj in ipairs(character:GetChildren()) do
        if obj:IsA("BasePart") then
            obj.Transparency = 1
        elseif obj:IsA("Accessory") then
            pcall(function() obj:Destroy() end)
        end
    end
    
    local thickness = 1.2
    local depth = 1.5
    local fullWidth = 32
    local fullHeight = 40
    local segLength = fullWidth / 3     -- each horizontal segment ≈1/3 of full width
    local segHeight = fullHeight / 3    -- each vertical segment ≈1/3 of full height
    local neonColor = Color3.fromRGB(0, 255, 255)  -- cyan glow
    
    local center = CFrame.new(0, 0, 0)
    
    -- ────────────────────────────────────────────────
    -- TOP horizontal line – split into 3 segments
    -- 1. Top-left segment
    
    -- 2. Top-center segment
    local topCenter = Instance.new("Part")
    topCenter.Name = "TopCenter"
    topCenter.Parent = character
    topCenter.Anchored = false
    topCenter.CanCollide = false
    topCenter.Size = Vector3.new(segLength, thickness, depth)
    topCenter.Material = Enum.Material.Neon
    topCenter.Color = neonColor
    topCenter.CFrame = rootPart.CFrame * center * CFrame.new(0, fullHeight/2, 0)
    
    local weldTC = Instance.new("WeldConstraint")
    weldTC.Part0 = rootPart
    weldTC.Part1 = topCenter
    weldTC.Parent = topCenter
    
    -- 3. Top-right segment
    local topRight = Instance.new("Part")
    topRight.Name = "TopRight"
    topRight.Parent = character
    topRight.Anchored = false
    topRight.CanCollide = false
    topRight.Size = Vector3.new(segLength, thickness, depth)
    topRight.Material = Enum.Material.Neon
    topRight.Color = neonColor
    topRight.CFrame = rootPart.CFrame * center * CFrame.new(fullWidth/3, fullHeight/2, 0)
    
    local weldTR = Instance.new("WeldConstraint")
    weldTR.Part0 = rootPart
    weldTR.Part1 = topRight
    weldTR.Parent = topRight
    
    -- ────────────────────────────────────────────────
    -- BOTTOM horizontal line – split into 3 segments
    -- 4. Bottom-left segment
    local botLeft = Instance.new("Part")
    botLeft.Name = "BottomLeft"
    botLeft.Parent = character
    botLeft.Anchored = false
    botLeft.CanCollide = false
    botLeft.Size = Vector3.new(segLength, thickness, depth)
    botLeft.Material = Enum.Material.Neon
    botLeft.Color = neonColor
    botLeft.CFrame = rootPart.CFrame * center * CFrame.new(-fullWidth/3, -fullHeight/2, 0)
    
    local weldBL = Instance.new("WeldConstraint")
    weldBL.Part0 = rootPart
    weldBL.Part1 = botLeft
    weldBL.Parent = botLeft
    
    -- 5. Bottom-center segment
    local botCenter = Instance.new("Part")
    botCenter.Name = "BottomCenter"
    botCenter.Parent = character
    botCenter.Anchored = false
    botCenter.CanCollide = false
    botCenter.Size = Vector3.new(segLength, thickness, depth)
    botCenter.Material = Enum.Material.Neon
    botCenter.Color = neonColor
    botCenter.CFrame = rootPart.CFrame * center * CFrame.new(0, -fullHeight/2, 0)
    
    local weldBC = Instance.new("WeldConstraint")
    weldBC.Part0 = rootPart
    weldBC.Part1 = botCenter
    weldBC.Parent = botCenter
    
    -- 6. Bottom-right segment
    
    -- ────────────────────────────────────────────────
    -- LEFT vertical line – split into 2 segments (top & bottom halves)
    -- 7. Left-top segment
    local leftTop = Instance.new("Part")
    leftTop.Name = "LeftTop"
    leftTop.Parent = character
    leftTop.Anchored = false
    leftTop.CanCollide = false
    leftTop.Size = Vector3.new(thickness, segHeight, depth)
    leftTop.Material = Enum.Material.Neon
    leftTop.Color = neonColor
    leftTop.CFrame = rootPart.CFrame * center * CFrame.new(-fullWidth/2, fullHeight/3, 0)
    
    local weldLT = Instance.new("WeldConstraint")
    weldLT.Part0 = rootPart
    weldLT.Part1 = leftTop
    weldLT.Parent = leftTop
    
    -- 8. Left-bottom segment
    
    -- ────────────────────────────────────────────────
    -- RIGHT vertical line – split into 2 segments
    -- 9. Right-top segment
    
    local rightBot = Instance.new("Part")
    rightBot.Name = "RightBottom"
    rightBot.Parent = character
    rightBot.Anchored = false
    rightBot.CanCollide = false
    rightBot.Size = Vector3.new(thickness, segHeight, depth)
    rightBot.Material = Enum.Material.Neon
    rightBot.Color = neonColor
    rightBot.CFrame = rootPart.CFrame * center * CFrame.new(fullWidth/2, -fullHeight/3, 0)
    
    local weldRB = Instance.new("WeldConstraint")
    weldRB.Part0 = rootPart
    weldRB.Part1 = rightBot
    weldRB.Parent = rightBot
    
    -- ────────────────────────────────────────────────
    -- MIDDLE CROSSBARS (kept full-length for clean division)
    
    -- 11. Horizontal cross (full middle horizontal line)
    local hCross = Instance.new("Part")
    hCross.Name = "HorizontalCross"
    hCross.Parent = character
    hCross.Anchored = false
    hCross.CanCollide = false
    hCross.Size = Vector3.new(fullWidth, thickness, depth)
    hCross.Material = Enum.Material.Neon
    hCross.Color = neonColor
    hCross.CFrame = rootPart.CFrame * center
    
    local weldH = Instance.new("WeldConstraint")
    weldH.Part0 = rootPart
    weldH.Part1 = hCross
    weldH.Parent = hCross
    
    -- 12. Vertical cross (full middle vertical line)
    local vCross = Instance.new("Part")
    vCross.Name = "VerticalCross"
    vCross.Parent = character
    vCross.Anchored = false
    vCross.CanCollide = false
    vCross.Size = Vector3.new(thickness, fullHeight, depth)
    vCross.Material = Enum.Material.Neon
    vCross.Color = neonColor
    vCross.CFrame = rootPart.CFrame * center
    
    local weldV = Instance.new("WeldConstraint")
    weldV.Part0 = rootPart
    weldV.Part1 = vCross
    weldV.Parent = vCross
end

local function onCharacterAdded(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")
    spawn(function()
        wait(0.6)
        makeWindowOutlineSegments()
    end)
end

player.CharacterAdded:Connect(onCharacterAdded)

if player.Character then
    onCharacterAdded(player.Character)
end
