function postaParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 950)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan TL950 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("postaParaVer", true)
addEventHandler("postaParaVer", getRootElement(), postaParaVer)

function postaBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2496.7802734375, -1742.662109375, 13.546875)
	setElementRotation(thePlayer, 0, 0, 177.84118652344)
end
addEvent("postaBitir", true)
addEventHandler("postaBitir", getRootElement(), postaBitir)