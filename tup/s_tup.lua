--[[
    
--]]

--[[ 
BİLGİ: 
	MESLEK ID = 16 / ARAÇ MESLEK ID = 16
]]

function tupParaVer(thePlayer)
	local money = 150
	--[[local realTime = getRealTime()
	local weekDay = realTime["weekday"]
	if weekDay == 6 or weekDay == 7 then
		money = 190
	end]]
	exports.global:giveMoney(thePlayer, money)
end
addEvent("tup:tupParaVer", true)
addEventHandler("tup:tupParaVer", getRootElement(), tupParaVer)

function tupBitir(thePlayer)
	local theVehicle = getPedOccupiedVehicle(thePlayer)
	respawnVehicle(theVehicle)
	removePedFromVehicle(thePlayer)
	setElementPosition(thePlayer, 2340.8818359375, -2075.5537109375, 13.553783416748)
	setElementRotation(thePlayer, 0, 0, 90)
end
addEvent("tup:tupBitir", true)
addEventHandler("tup:tupBitir", getRootElement(), tupBitir)