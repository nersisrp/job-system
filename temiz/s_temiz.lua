function temizParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 500)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan TL500 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("temizParaVer", true)
addEventHandler("temizParaVer", getRootElement(), temizParaVer)

function temizBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setVehicleLocked(pedVeh, false)
	setElementPosition(thePlayer, 1467.36328125, -1745.1640625, 13.540049552917)
	setElementRotation(thePlayer, 0, 0, 91.338989257813)
end
addEvent("temizBitir", true)
addEventHandler("temizBitir", getRootElement(), temizBitir)