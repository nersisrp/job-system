function kamyonParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 1950)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan TL1950 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("kamyonParaVer", true)
addEventHandler("kamyonParaVer", getRootElement(), kamyonParaVer)

function kamyonBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2215.3779296875, -2656.1875, 13.546875)
	setElementRotation(thePlayer, 0, 0, 270.43533325195)
end
addEvent("kamyonBitir", true)
addEventHandler("kamyonBitir", getRootElement(), kamyonBitir)