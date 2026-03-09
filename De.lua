local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character
local rootPart

local function createPart(name,size,offset,color)

    local p = Instance.new("Part")
    p.Name = name
    p.Parent = character
    p.Anchored = false
    p.CanCollide = false
    p.Massless = true
    p.Size = size
    p.Material = Enum.Material.SmoothPlastic
    p.Color = color or Color3.fromRGB(0,0,0)
    p.CFrame = rootPart.CFrame * CFrame.new(offset)

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = rootPart
    weld.Part1 = p
    weld.Parent = p

end

local function createCircle(radius,segments,thickness)

    for i = 1, segments do

        local angle = math.rad((360/segments)*i)

        local x = math.cos(angle) * radius
        local y = math.sin(angle) * radius

        local part = Instance.new("Part")
        part.Name = "CirclePart"
        part.Parent = character
        part.Anchored = false
        part.CanCollide = false
        part.Massless = true
        part.Size = Vector3.new(thickness, thickness, 1.6)
        part.Material = Enum.Material.SmoothPlastic
        part.Color = Color3.fromRGB(255,255,255)

        part.CFrame =
            rootPart.CFrame *
            CFrame.new(x,y,0) *
            CFrame.Angles(0,0,angle)

        local weld = Instance.new("WeldConstraint")
        weld.Part0 = rootPart
        weld.Part1 = part
        weld.Parent = part

    end

end

local function makeShape()

    for _,v in pairs(character:GetChildren()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
        elseif v:IsA("Accessory") then
            v:Destroy()
        end
    end

    local thickness = 1.2
    local depth = 1.5

    local size = 36
    local seg = size/3
    local half = size/2

    -- TOP
    createPart("TopCenter",Vector3.new(seg,thickness,depth),Vector3.new(0,half,0))
    createPart("TopRight",Vector3.new(seg,thickness,depth),Vector3.new(seg,half,0))

    -- BOTTOM
    createPart("BottomLeft",Vector3.new(seg,thickness,depth),Vector3.new(-seg,-half,0))
    createPart("BottomCenter",Vector3.new(seg,thickness,depth),Vector3.new(0,-half,0))

    -- LEFT
    createPart("LeftTop",Vector3.new(thickness,seg,depth),Vector3.new(-half,seg,0))

    -- RIGHT
    createPart("RightBottom",Vector3.new(thickness,seg,depth),Vector3.new(half,-seg,0))

    -- CROSS
    createPart("HorizontalCross",Vector3.new(size,thickness,depth),Vector3.new(0,0,0))
    createPart("VerticalCross",Vector3.new(thickness,size,depth),Vector3.new(0,0,0))

    -- RED STRIPE
    createPart(
        "RedStripe",
        Vector3.new(size*2,0.35,depth+0.2),
        Vector3.new(0,0,0),
        Color3.fromRGB(255,0,0)
    )

    -- WHITE CIRCLE
    createCircle(size*0.75,40,0.8)

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
