function trashParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 500)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan TL500 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("trashParaVer", true)
addEventHandler("trashParaVer", getRootElement(), trashParaVer)

function trashBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setVehicleLocked(pedVeh, false)
	setElementPosition(thePlayer, 1661.994140625, -1882.75, 13.546875)
	setElementRotation(thePlayer, 0, 0, 270.43533325195)
end
addEvent("trashBitir", true)
addEventHandler("trashBitir", getRootElement(), trashBitir)