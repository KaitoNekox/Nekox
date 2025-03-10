local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Crear el botón
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(1, -110, 1, -60)
button.Text = "Transform"
button.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

-- Transformar al personaje en un demonio gigante
button.MouseButton1Click:Connect(function()
    character.Head.MeshId = "rbxassetid://123456789"
    character.Head.TextureId = "rbxassetid://987654321"
    character.Torso.BrickColor = BrickColor.new("Really black")
    character["Left Arm"].BrickColor = BrickColor.new("Really black")
    character["Right Arm"].BrickColor= BrickColor.new("Really black")
    character["Left Leg"].BrickColor= BrickColor.new("Really black")
    character["Right Leg"].BrickColor= BrickColor.new("Really black")

    local humanoid= character:FindFirstChildOfClass("Humanoid")
    humanoid.WalkSpeed= 16
    humanoid.JumpPower= 50

    -- Añadir animaciones y sonidos
    local animations= {
        walk= Instance.new("Animation"),
        run= Instance.new("Animation"),
        grab= Instance.new("Animation"),
        kill= Instance.new("Animation")
    }

    animations.walk.AnimationId= "rbxassetid://123456789"
    animations.run.AnimationId= "rbxassetid://987654321"
    animations.grab.AnimationId= "rbxassetid://1122334455"
animations.kill.AnimationId="rbxassetid://5566778899"

for _, animation in pairs(animations) do
animation.Parent=character.HumanoidRootPart
end

-- Ejecutar animaciones al hacer click en la pantalla
local userInputService=game:GetService('UserInputService')

userInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end

if input.UserInputType==Enum.UserInputType.MouseButton1 then
humanoid:LoadAnimation(animations.grab):Play()
wait(1)
humanoid:LoadAnimation(animations.kill):Play()
end
end)
end)
