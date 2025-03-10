-- Script para convertir al personaje en un payaso flotante con un martillo gigante y pinchos rojos

-- Obtén el jugador local
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Crear el martillo gigante
local hammer = Instance.new("Part")
hammer.Name = "GiantHammer"
hammer.Size = Vector3.new(5, 10, 5)
hammer.Position = rootPart.Position + Vector3.new(0, 10, 0)
hammer.Anchored = true
hammer.CanCollide = false
hammer.Parent = character

local hammerMesh = Instance.new("SpecialMesh", hammer)
hammerMesh.MeshType = Enum.MeshType.FileMesh
hammerMesh.MeshId = "rbxassetid://9419831" -- ID de un martillo (puedes cambiarlo)
hammerMesh.TextureId = "rbxassetid://9419826" -- Textura del martillo
hammerMesh.Scale = Vector3.new(5, 5, 5)

-- Crear los pinchos rojos alrededor del personaje
local spikes = {}
for i = 1, 8 do
    local spike = Instance.new("Part")
    spike.Name = "Spike"
    spike.Size = Vector3.new(2, 5, 2)
    spike.Color = Color3.new(1, 0, 0) -- Rojo
    spike.Anchored = true
    spike.CanCollide = false
    spike.Parent = character

    local spikeMesh = Instance.new("SpecialMesh", spike)
    spikeMesh.MeshType = Enum.MeshType.FileMesh
    spikeMesh.MeshId = "rbxassetid://1033714" -- ID de un pincho (puedes cambiarlo)
    spikeMesh.Scale = Vector3.new(1, 2, 1)

    table.insert(spikes, spike)
end

-- Animación de rodeo para los pinchos
local function spinSpikes()
    while true do
        for i, spike in ipairs(spikes) do
            local angle = math.rad((i / #spikes) * 360 + tick() * 100) -- Rota los pinchos
            local offset = Vector3.new(math.cos(angle) * 10, 0, math.sin(angle) * 10)
            spike.Position = rootPart.Position + offset
        end
        wait(0.01)
    end
end

-- Hacer flotar al personaje
humanoid:ChangeState(Enum.HumanoidStateType.Flying)
rootPart.Anchored = true

-- Emote de golpe al hacer clic
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local hitSound = Instance.new("Sound")
hitSound.SoundId = "rbxassetid://130976108" -- ID de un sonido de golpe (puedes cambiarlo)
hitSound.Parent = rootPart

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
        -- Emote de golpe
        humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = "rbxassetid://35654637"})):Play() -- ID de animación de golpe (puedes cambiarlo)
        hitSound:Play()
    end
end)

-- Iniciar animación de pinchos
spinSpikes()
