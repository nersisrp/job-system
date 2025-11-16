function paraParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 75)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan 75TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("paraParaVer", true)
addEventHandler("paraParaVer", getRootElement(), paraParaVer)

function paraBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setVehicleLocked(pedVeh, false)
	setElementPosition(thePlayer, 1006.419921875, -1309.1650390625, 13.3828125)
	setElementRotation(thePlayer, 0, 0, 91.338989257813)
end
addEvent("paraBitir", true)
addEventHandler("paraBitir", getRootElement(), paraBitir)