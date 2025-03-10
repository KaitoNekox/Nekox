local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Cambiar la apariencia del personaje
character.Head.MeshId = "rbxassetid://123456789"
character.Head.TextureId = "rbxassetid://987654321"
character.Torso.BrickColor = BrickColor.new("Really black")
character["Left Arm"].BrickColor = BrickColor.new("Really black")
character["Right Arm"].BrickColor = BrickColor.new("Really black")
character["Left Leg"].BrickColor = BrickColor.new("Really black")
character...["Right Leg"].BrickColor = BrickColor.new("Really black")

-- Cambiar la postura del personaje
local humanoid = character:FindFirstChildOfClass("Humanoid")
humanoid.WalkSpeed = 16
humanoid.JumpPower = 50

-- Añadir animaciones y sonidos
local animations = {
    walk = Instance.new("Animation"),
    run = Instance.new("Animation"),
    climb = Instance.new("Animation"),
    scream = Instance.new("Animation"),
    kill1 = Instance.new("Animation"),
    kill2 = Instance.new("Animation"),
    kill3 = Instance.new("Animation")
}

animations.walk.AnimationId = "rbxassetid://123456789"
animations.run.AnimationId = "rbxassetid://987654321"
animations.climb.AnimationId = "rbxassetid://1122334455"
animations.scream.AnimationId = "rbxassetid://5566778899"
animations.kill1.AnimationId = "rbxassetid://9988776655"
animations.kill2.AnimationId = "rbxassetid://5544332211"
animations.kill3.AnimationId = "rbxassetid://1100223344"

local sounds = {
    scream1 = Instance.new("Sound"),
    scream2 = Instance.new("Sound"),
    scream3= Instance.new("Sound")
}

sounds.scream1.SoundId= "rbxassetid://123456789"
sounds.scream2.SoundId= "rbxassetid://987654321"
sounds.scream3.SoundId= "rbxassetid://1122334455"

for _, animation in pairs(animations) do
    animation.Parent= character.HumanoidRootPart
end

for _, sound in pairs(sounds) do
    sound.Parent= character.HumanoidRootPart
end

-- Ejecutar animaciones y sonidos al hacer click en la pantalla
local userInputService= game:GetService('UserInputService')

userInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end

if input.UserInputType== Enum.UserInputType.MouseButton1 then
local randomKill= math.random(1, 3)
if randomKill== 1 then
humanoid:LoadAnimation(animations.kill1):Play()
sounds.scream1:Play()
elseif randomKill== 2 then
humanoid:LoadAnimation(animations.kill2):Play()
sounds.scream2:Play()
else
humanoid:LoadAnimation(animations.kill3):Play()
sounds.scream3:Play()
end
end
end)
