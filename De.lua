local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character
local humanoid
local rootPart

local function makeWindowOutlineSegments()

    for _, name in ipairs({
        "TopCenter","TopRight",
        "BottomLeft","BottomCenter",
        "LeftTop","RightBottom",
        "HorizontalCross","VerticalCross"
    }) do
        pcall(function() character:FindFirstChild(name):Destroy() end)
    end

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

    local segLength = fullWidth/3
    local segHeight = fullHeight/3

    local color = Color3.fromRGB(0,0,0)

    local function makePart(name,size,offset)
        local p = Instance.new("Part")
        p.Name = name
        p.Parent = character
        p.Anchored = false
        p.CanCollide = false
        p.Size = size
        p.Material = Enum.Material.SmoothPlastic
        p.Color = color
        p.CFrame = rootPart.CFrame * CFrame.new(offset)

        local weld = Instance.new("WeldConstraint")
        weld.Part0 = rootPart
        weld.Part1 = p
        weld.Parent = p
    end

    -- Top center
    makePart(
        "TopCenter",
        Vector3.new(segLength, thickness, depth),
        Vector3.new(0, fullHeight/2, 0)
    )

    -- Top right
    makePart(
        "TopRight",
        Vector3.new(segLength, thickness, depth),
        Vector3.new(segLength, fullHeight/2, 0)
    )

    -- Bottom left
    makePart(
        "BottomLeft",
        Vector3.new(segLength, thickness, depth),
        Vector3.new(-segLength, -fullHeight/2, 0)
    )

    -- Bottom center
    makePart(
        "BottomCenter",
        Vector3.new(segLength, thickness, depth),
        Vector3.new(0, -fullHeight/2, 0)
    )

    -- Left top
    makePart(
        "LeftTop",
        Vector3.new(thickness, segHeight, depth),
        Vector3.new(-fullWidth/2, segHeight, 0)
    )

    -- Right bottom
    makePart(
        "RightBottom",
        Vector3.new(thickness, segHeight, depth),
        Vector3.new(fullWidth/2, -segHeight, 0)
    )

    -- Horizontal cross
    makePart(
        "HorizontalCross",
        Vector3.new(fullWidth, thickness, depth),
        Vector3.new(0,0,0)
    )

    -- Vertical cross
    makePart(
        "VerticalCross",
        Vector3.new(thickness, fullHeight, depth),
        Vector3.new(0,0,0)
    )

end

local function onCharacterAdded(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")

    task.wait(0.6)
    makeWindowOutlineSegments()
end

player.CharacterAdded:Connect(onCharacterAdded)

if player.Character then
    onCharacterAdded(player.Character)
end
