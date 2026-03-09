local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character
local rootPart

-- Helper to create a part welded to HumanoidRootPart
local function createPart(name, size, offset, color, material)
    local p = Instance.new("Part")
    p.Name = name
    p.Parent = character
    p.Anchored = false
    p.CanCollide = false
    p.Massless = true
    p.Size = size
    p.Material = material or Enum.Material.SmoothPlastic
    p.Color = color or Color3.fromRGB(0,0,0)
    p.CFrame = rootPart.CFrame * CFrame.new(offset)

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = rootPart
    weld.Part1 = p
    weld.Parent = p
    return p
end

local function makeShape()
    -- Clean previous parts
    for _, v in pairs(character:GetChildren()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
        elseif v:IsA("Accessory") then
            v:Destroy()
        end
    end

    local thickness = 1.2
    local depth = 1.5
    local size = 36 -- the "square" size
    local seg = size / 3
    local half = size / 2

    -- ===== RED FLAG BACKGROUND =====
    createPart("RedFlag", Vector3.new(size*2, thickness, depth+0.2), Vector3.new(0,0,-0.5), Color3.fromRGB(255,0,0))

    -- ===== BLACK SQUARE WITH MISSING SEGMENTS =====
    -- top
    createPart("TopCenter", Vector3.new(seg, thickness, depth), Vector3.new(0, half, 0))
    createPart("TopRight", Vector3.new(seg, thickness, depth), Vector3.new(seg, half, 0))

    -- bottom
    createPart("BottomLeft", Vector3.new(seg, thickness, depth), Vector3.new(-seg, -half, 0))
    createPart("BottomCenter", Vector3.new(seg, thickness, depth), Vector3.new(0, -half, 0))

    -- left & right
    createPart("LeftTop", Vector3.new(thickness, seg, depth), Vector3.new(-half, seg, 0))
    createPart("RightBottom", Vector3.new(thickness, seg, depth), Vector3.new(half, -seg, 0))

    -- cross
    createPart("HorizontalCross", Vector3.new(size, thickness, depth), Vector3.new(0, 0, 0))
    createPart("VerticalCross", Vector3.new(thickness, size, depth), Vector3.new(0, 0, 0))

    -- ===== WHITE FILLED CIRCLE =====
    local circle = Instance.new("Part")
    circle.Name = "WhiteCircle"
    circle.Parent = character
    circle.Anchored = false
    circle.CanCollide = false
    circle.Massless = true
    circle.Shape = Enum.PartType.Cylinder
    circle.Size = Vector3.new(size*2.2, 1.5, size*2.2) -- X/Z = diameter, Y = thickness
    circle.Material = Enum.Material.SmoothPlastic
    circle.Color = Color3.fromRGB(255,255,255)
    circle.CFrame = rootPart.CFrame * CFrame.new(0,0,-1) * CFrame.Angles(0,0,math.rad(90))

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = rootPart
    weld.Part1 = circle
    weld.Parent = circle
end

local function onCharacterAdded(char)
    character = char
    rootPart = char:WaitForChild("HumanoidRootPart")
    task.wait(0.5)
    makeShape()
end

player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
    onCharacterAdded(player.Character)
end
