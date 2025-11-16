function betonParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 1775)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan TL1775 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("betonParaVer", true)
addEventHandler("betonParaVer", getRootElement(), betonParaVer)

function betonBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2338.080078125, -2056.8310546875, 13.548931121826)
	setElementRotation(thePlayer, 0, 0, 91.822357177734)
end
addEvent("betonBitir", true)
addEventHandler("betonBitir", getRootElement(), betonBitir)