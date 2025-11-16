--[[
    @بسم الله الرحمن الرحيم
    @Script: İllegal Kamyon Şoförü Sistemi
    @Version: v1.4
    @Scripter: Leoncio
    @Server: Nersis Roleplay    
--]]

--[[ 
BİLGİ: 
	MESLEK ID = 11 / ARAÇ MESLEK ID = 11
]]

local respawnX, respawnY, respawnZ, respawnRot = 2594.076171875, -2201.97265625, 13.546875, 276
local turSonuMaas = 500

function iKamyonBitir(thePlayer)
	local theVehicle = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(theVehicle)
	setElementPosition(thePlayer, respawnX, respawnY, respawnZ)
	setElementRotation(thePlayer, 0, 0, respawnRot)
	
	if getElementData(thePlayer, "meslek:ikamyon") then
		setElementData(thePlayer, "meslek:ikamyon", false)
	end
end
addEvent("ikamyon:kamyonBitir", true)
addEventHandler("ikamyon:kamyonBitir", getRootElement(), iKamyonBitir)

function iKamyonParaVer(thePlayer)		
	exports.global:giveMoney(thePlayer, turSonuMaas)	
end
addEvent("ikamyon:paraVer", true)
addEventHandler("ikamyon:paraVer", getRootElement(), iKamyonParaVer)