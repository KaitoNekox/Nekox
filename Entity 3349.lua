local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Crear el botón de inicio
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(0.5, -50, 0.5, -25)
button.Text = "Start"
button.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

-- Transformar al personaje en una entidad aterradora
button.MouseButton1Click:Connect(function()
    button.Visible = false

    character.Head.MeshId = "rbxassetid://123456789"
    character.Head.TextureId = "rbxassetid://987654321"
    character.Torso.BrickColor= BrickColor.new("Really black")
    character["Left Arm"].BrickColor= BrickColor.new("Really black")
    character["Right Arm"].BrickColor= BrickColor.new("Really black")
    character...["Left Leg"].BrickColor= BrickColor.new("Really black")
character["Right Leg"].BrickColor= BrickColor.new("Really black")

local humanoid=character:FindFirstChildOfClass("Humanoid")
humanoid.WalkSpeed=16
humanoid.JumpPower=50

-- Añadir animaciones y sonidos
local animations={
walk=Instance.new("Animation"),
run=Instance.new("Animation"),
grab=Instance.new("Animation"),
kill=Instance.new("Animation"),
equip=Instance.new("Animation"),
aim=Instance.new("Animation")
}

animations.walk.AnimationId="rbxassetid://123456789"
animations.run.AnimationId="rbxassetid://987654321"
animations.grab.AnimationId="rbxassetid://1122334455"
animations.kill.AnimationId="rbxassetid://5566778899"
animations.equip.AnimationId="rbxassetid://9988776655"
animations.aim.AnimationId="rbxassetid://5544332211"

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

-- Equipar el ojo en un bastón al presionar la tecla E
userInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end

if input.KeyCode==Enum.KeyCode.E then
humanoid:LoadAnimation(animations.equip):Play()
end
end)

-- Apuntar y disparar un rayo al hacer click en la pantalla con el ojo equipado
userInputService.InputBegan:Connect(function(input, gameProcessed)
if gameProcessed then return end

if input.UserInputType==Enum.UserInputType.MouseButton1 and humanoid:GetPlayingAnimationTracks()[1]==animations.equip then
humanoid:LoadAnimation(animations.aim):Play()
wait(1)

local rayOrigin=character.HumanoidRootPart.Position+Vector3.new(0, 5, 0)
local rayDirection=(mouse.Hit.p-rayOrigin).unit*1000

local raycastParams=RaycastParams.new()
raycastParams.FilterDescendantsInstances={character}
={character}
raycastParams.FilterType=Enum.RaycastFilterType.Blacklist

local raycastResult=workspace:Raycast(rayOrigin, rayDirection, raycastParams)

if raycastResult and raycastResult.Instance:IsA('BasePart') and raycastResult.Instance.Parent:IsA('Model') and raycastResult.Instance.Parent~=character then
raycastResult.Instance.Parent.Humanoid.Health-=10000000000000000000000 -- Reiniciar al usuario alcanzado por el rayo

-- Crear efectos visuales y sonoros para el rayo y el cielo rojo con círculos blancos cada vez que se haga click con el ojo equipado (opcional)
end
