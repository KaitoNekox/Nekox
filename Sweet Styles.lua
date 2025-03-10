-- Crear la ventana inicial
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.Parent = screenGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.Text = "Powered By KaitoNeko"
label.TextColor3 = Color3.new(1, 1, 1)
label.Font = Enum.Font.SourceSansBold
label.TextScaled = true
label.Parent = frame

local kaitoText = Instance.new("TextLabel")
kaitoText.Size = UDim2.new(1, 0, 0.5, 0)
kaitoText.Position = UDim2.new(0, 0, 0.5, 0)
kaitoText.Text = "KaitoNeko"
kaitoText.TextColor3 = Color3.new(1, 0, 0)
kaitoText.Font = Enum.Font.SourceSansBold
kaitoText.TextScaled = true
kaitoText.Parent = frame

-- Esperar 4 segundos y luego eliminar la ventana
wait(4)
frame:Destroy()

-- Crear el menú flotante
local sphere = Instance.new("Part")
sphere.Shape = Enum.PartType.Ball
sphere.Size = Vector3.new(2, 2, 2)
sphere.Position = Vector3.new(0, 5, 0)
sphere.Anchored = true
sphere.CanCollide = false
sphere.BrickColor = BrickColor.new("Bright blue")
sphere.Parent = workspace

local clickDetector = Instance.new("ClickDetector")
clickDetector.Parent = sphere

-- Función para cambiar el color de la esfera
local function changeColor()
    while true do
        sphere.BrickColor = BrickColor.new(math.random(), math.random(), math.random())
        wait(1)
    end
end

-- Iniciar el cambio de color
spawn(changeColor)

-- Función para mostrar el menú
local function showMenu()
    local menuFrame = Instance.new("Frame")
    menuFrame.Size = UDim2.new(0, 200, 0, 200)
    menuFrame.Position = UDim2.new(0.5, -100, 0.5, -100)
    menuFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    menuFrame.Parent = screenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Text = "Sweet Styles"
    title.TextColor3 = Color3.new(1, 0, 0)
    title.Font = Enum.Font.SourceSansBold
    title.TextScaled = true
    title.Parent = menuFrame

    local danceButton = Instance.new("TextButton")
    danceButton.Size = UDim2.new(1, 0, 0.2, 0)
    danceButton.Position = UDim2.new(0, 0, 0.2, 0)
    danceButton.Text = "Dance coolkidd"
    danceButton.TextColor3 = Color3.new(1, 1, 1)
    danceButton.BackgroundColor3 = Color3.new(0, 0, 1)
    danceButton.Parent = menuFrame

    local sitButton = Instance.new("TextButton")
    sitButton.Size = UDim2.new(1, 0, 0.2, 0)
    sitButton.Position = UDim2.new(0, 0, 0.4, 0)
    sitButton.Text = "Sit Aleatory"
    sitButton.TextColor3 = Color3.new(1, 1, 1)
    sitButton.BackgroundColor3 = Color3.new(0, 0, 1)
    sitButton.Parent = menuFrame

    local swordButton = Instance.new("TextButton")
    swordButton.Size = UDim2.new(1, 0, 0.2, 0)
    swordButton.Position = UDim2.new(0, 0, 0.6, 0)
    swordButton.Text = "Sword"
    swordButton.TextColor3 = Color3.new(1, 1, 1)
    swordButton.BackgroundColor3 = Color3.new(0, 0, 1)
    swordButton.Parent = menuFrame

    local hammerButton = Instance.new("TextButton")
    hammerButton.Size = UDim2.new(1, 0, 0.2, 0)
    hammerButton.Position = UDim2.new(0, 0, 0.8, 0)
    hammerButton.Text = "Hammer"
    hammerButton.TextColor3 = Color3.new(1, 1, 1)
    hammerButton.BackgroundColor3 = Color3.new(0, 0, 1)
    hammerButton.Parent = menuFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
    closeButton.Position = UDim2.new(0.9, 0, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
    closeButton.Parent = menuFrame

    -- Funcionalidad de los botones
    danceButton.MouseButton1Click:Connect(function()
        if danceButton.BackgroundColor3 == Color3.new(0, 0, 1) then
            danceButton.BackgroundColor3 = Color3.new(0, 1, 0)
            -- Aquí iría la lógica para activar la animación de baile
        else
            danceButton.BackgroundColor3 = Color3.new(0, 0, 1)
            -- Aquí iría la lógica para desactivar la animación de baile
        end
    end)

    sitButton.MouseButton1Click:Connect(function()
        -- Aquí iría la lógica para sentarse en la cabeza de un usuario aleatorio
    end)

    swordButton.MouseButton1Click:Connect(function()
        -- Aquí iría la lógica para dar una espada al usuario
    end)

    hammerButton.MouseButton1Click:Connect(function()
        -- Aquí iría la lógica para dar un martillo al usuario
    end)

    closeButton.MouseButton1Click:Connect(function()
        menuFrame:Destroy()
    end)
end

-- Mostrar el menú al hacer clic en la esfera
clickDetector.MouseClick:Connect(showMenu)
