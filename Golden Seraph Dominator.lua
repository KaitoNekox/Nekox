local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Transformar al personaje en un ángel
character.Head.MeshId = "rbxassetid://123456789"
character.Head.TextureId = "rbxassetid://987654321"
character.Torso.BrickColor= BrickColor.new("Bright yellow")
character["Left Arm"].BrickColor= BrickColor.new("Bright yellow")
character["Right Arm"].BrickColor= BrickColor.new("Bright yellow")
character["Left Leg"].BrickColor= BrickColor.new("Bright yellow")
character["Right Leg"].BrickColor= BrickColor.new("Bright yellow")

local humanoid=character:FindFirstChildOfClass("Humanoid")
humanoid.WalkSpeed=16
humanoid.JumpPower=50

-- Añadir animaciones y sonidos
local animations={
fly=Instance.new("Animation"),
aim=Instance.new("Animation"),
shoot=Instance.new("Animation")
}

animations.fly.AnimationId="rbxassetid://123456789"
animations.aim.AnimationId="rbxassetid://987654321"
animations.shoot.AnimationId="rbxassetid://1122334455"

for _, animation in pairs(animations) do
animation.Parent=character.HumanoidRootPart
end

-- Ejecutar animaciones al hacer click en la pantalla
local userInputService=game:GetService('UserInputService')

userInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end

if input.UserInputType==Enum.UserInputType.MouseButton1 then
humanoid:LoadAnimation(animations.aim):Play()
wait(1)
humanoid:LoadAnimation(animations.shoot):Play()

local rayOrigin=character.HumanoidRootPart.Position+Vector3.new(0, 5, 0)
local rayDirection=(mouse.Hit.p-rayOrigin).unit*1000

local raycastParams=RaycastParams.new()
raycastParams.FilterDescendantsInstances={character}
raycastParams.FilterType=Enum.RaycastFilterType.Blacklist

local raycastResult=workspace:Raycast(rayOrigin, rayDirection, raycastParams)

if raycastResult and raycastResult.Instance:IsA('BasePart') and raycastResult.Instance.Parent:IsA('Model') and raycastResult.Instance.Parent~=character then
raycastResult.Instance.Parent.Humanoid.Health-=10000000000000000000000 -- Reiniciar al usuario alcanzado por el rayo

-- Crear efectos visuales y sonoros para el rayo (opcional)
end```

Puedes ejecutarlo en Delta Executor para Roblox.
