function copParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 975)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan TL975 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("copParaVer", true)
addEventHandler("copParaVer", getRootElement(), copParaVer)

function copBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 1639.8291015625, -1900.17578125, 13.552103996277)
	setElementRotation(thePlayer, 0, 0, 183.71343994141)
end
addEvent("copBitir", true)
addEventHandler("copBitir", getRootElement(), copBitir)