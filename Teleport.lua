local placeId = 1818 -- El ID del lugar al que quieres telenstransportarte
local game = "https://www.roblox.com/share?code=89a619bad542104e9fd4aa3ccb2f1819&type=ExperienceDetails&stamp=1743204692831"..placeId.."/Game-Name-Here" -- El enlace al juego

local players = game:GetService("Players"):GetPlayers()

for _, player in ipairs(players) do
    game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, player.UserId)
end
