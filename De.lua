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

-- Hide original body parts
local function hideCharacter()
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = 1
            part.CanCollide = false
        end
    end
end

-- Morph character into the flag
local function makeFlag()
    hideCharacter()

    local flagWidth = 20 -- bigger than player
    local flagHeight = 14
    local thickness = 0.5
    local armThickness = 1.5
    local armLength = 6

    -- Red flag background
    createPart("RedFlag", Vector3.new(flagWidth, thickness, flagHeight), Vector3.new(0,0,0), Color3.fromRGB(255,0,0))

    -- White circle
    local circle = Instance.new("Part")
    circle.Name = "WhiteCircle"
    circle.Parent = character
    circle.Anchored = false
    circle.CanCollide = false
    circle.Massless = true
    circle.Shape = Enum.PartType.Cylinder
    circle.Size = Vector3.new(8, thickness, 8)
    circle.Material = Enum.Material.SmoothPlastic
    circle.Color = Color3.fromRGB(255,255,255)
    circle.CFrame = rootPart.CFrame * CFrame.Angles(math.rad(90),0,0)
    local weldCircle = Instance.new("WeldConstraint")
    weldCircle.Part0 = rootPart
    weldCircle.Part1 = circle
    weldCircle.Parent = circle

    -- Symbol rotated 45 degrees
    local rotation45 = CFrame.Angles(0, math.rad(45), 0)
    local armData = {
        {offset = Vector3.new(armLength/2,0,armLength/2), size = Vector3.new(armLength, thickness, armThickness)},
        {offset = Vector3.new(-armLength/2,0,-armLength/2), size = Vector3.new(armLength, thickness, armThickness)},
        {offset = Vector3.new(armLength/2,0,-armLength/2), size = Vector3.new(armThickness, thickness, armLength)},
        {offset = Vector3.new(-armLength/2,0,armLength/2), size = Vector3.new(armThickness, thickness, armLength)},
    }

    for i, data in ipairs(armData) do
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
