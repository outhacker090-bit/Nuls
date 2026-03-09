local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character
local rootPart

-- Helper to create a part welded to HumanoidRootPart
local function createPart(name, size, offset, color, material, rotation)
    local p = Instance.new("Part")
    p.Name = name
    p.Parent = character
    p.Anchored = false
    p.CanCollide = false
    p.Massless = true
    p.Size = size
    p.Material = material or Enum.Material.SmoothPlastic
    p.Color = color or Color3.fromRGB(0,0,0)

    if rotation then
        p.CFrame = rootPart.CFrame * CFrame.new(offset) * rotation
    else
        p.CFrame = rootPart.CFrame * CFrame.new(offset)
    end

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = rootPart
    weld.Part1 = p
    weld.Parent = p
    return p
end

-- Create flag with connected 45° symbol
local function makeFlag()
    -- Clear previous parts
    for _, v in pairs(character:GetChildren()) do
        if v:IsA("BasePart") or v:IsA("Accessory") then
            v:Destroy()
        end
    end

    local flagWidth = 12
    local flagHeight = 8
    local thickness = 0.3
    local armThickness = 1
    local armLength = 3.5 -- length of each arm from center

    -- Red flag
    createPart("RedFlag", Vector3.new(flagWidth, thickness, flagHeight), Vector3.new(0,0,0), Color3.fromRGB(255,0,0))

    -- White circle
    local circle = Instance.new("Part")
    circle.Name = "WhiteCircle"
    circle.Parent = character
    circle.Anchored = false
    circle.CanCollide = false
    circle.Massless = true
    circle.Shape = Enum.PartType.Cylinder
    circle.Size = Vector3.new(4.5, thickness, 4.5)
    circle.Material = Enum.Material.SmoothPlastic
    circle.Color = Color3.fromRGB(255,255,255)
    circle.CFrame = rootPart.CFrame * CFrame.Angles(math.rad(90),0,0)
    local weldCircle = Instance.new("WeldConstraint")
    weldCircle.Part0 = rootPart
    weldCircle.Part1 = circle
    weldCircle.Parent = circle

    -- Symbol center rotation
    local rotation45 = CFrame.Angles(0, math.rad(45), 0)
    
    -- Define arm positions relative to center BEFORE rotation
    local armData = {
        -- Horizontal arms
        {offset = Vector3.new(armLength/2, 0, armLength/2), size = Vector3.new(armLength, thickness, armThickness)}, -- top right
        {offset = Vector3.new(-armLength/2, 0, -armLength/2), size = Vector3.new(armLength, thickness, armThickness)}, -- bottom left
        -- Vertical arms
        {offset = Vector3.new(armLength/2, 0, -armLength/2), size = Vector3.new(armThickness, thickness, armLength)}, -- bottom right
        {offset = Vector3.new(-armLength/2, 0, armLength/2), size = Vector3.new(armThickness, thickness, armLength)}, -- top left
    }

    -- Create arms fully connected
    for i, data in ipairs(armData) do
        -- Apply rotation around the center of the symbol
        local rotatedOffset = rotation45:VectorToWorldSpace(data.offset)
        createPart("Arm"..i, data.size, rotatedOffset, Color3.fromRGB(0,0,0), nil, rotation45)
    end
end

-- Setup character
local function onCharacterAdded(char)
    character = char
    rootPart = char:WaitForChild("HumanoidRootPart")
    task.wait(0.2)
    makeFlag()
end

player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
    onCharacterAdded(player.Character)
end
