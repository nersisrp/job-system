function sigaraParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 2000)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan TL2000 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("sigaraParaVer", true)
addEventHandler("sigaraParaVer", getRootElement(), sigaraParaVer)

function sigaraBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setVehicleLocked(pedVeh, false)
	setElementPosition(thePlayer, 2456.1162109375, -2650.6630859375, 13.660751342773)
	setElementRotation(thePlayer, 0, 0, 91.338989257813)
end
addEvent("sigaraBitir", true)
addEventHandler("sigaraBitir", getRootElement(), sigaraBitir)