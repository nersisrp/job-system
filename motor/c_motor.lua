local motorMarker = 0
local motorCreatedMarkers = {}
-- false devam
-- true bekle
-- true, true bitiş
local motorRota = {
	{ 789.33984375, -1596.61328125, 13.3828125, false },
	{ 785.099609375, -1588.5205078125, 13.390348434448, false },
	{ 761.1318359375, -1588.6875, 13.406144142151, false },
	{ 749.515625, -1601.4794921875, 13.478230476379, false },
	{ 749.6259765625, -1626.990234375, 9.062237739563, false },
	{ 749.7294921875, -1645.8203125, 5.363543510437, false },
	{ 751.2158203125, -1670.1025390625, 3.9809002876282, false },
	{ 752.0947265625, -1689.1884765625, 4.202579498291, false },

	{ 752.4921875, -1714.474609375, 6.8545565605164, false },

	{ 752.5390625, -1754.982421875, 12.826830863953, false },
	
	{ 770.6953125, -1769.6171875, 12.859689712524, true },
	
	{  800.39453125, -1771.2734375, 13.458010673523, false },
	{ 812.4013671875, -1757.583984375, 13.392844200134,	false },
	{ 812.5947265625, -1739.7314453125, 13.3828125, false },
	{ 812.74609375, -1717.35546875, 13.3828125, false },
	{ 812.85546875, -1700.9521484375, 13.3828125, false },
	{ 812.900390625, -1685.5966796875, 13.3828125, false },
	
	{ 813.140625, -1664.3115234375, 13.3828125, false },	
	{ 838.2158203125, -1615.78125, 13.3828125, false },
	{ 815.6044921875, -1592.5380859375, 13.3828125, false },
	{ 788.748046875, -1590.3818359375, 13.3828125, false },
	{ 788.0478515625, -1596.4501953125, 13.3828125, true,true },

}

function motorBasla(cmd)
	if not getElementData(getLocalPlayer(), "motorSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 448
		
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "motorSoforlugu", true)
			updatemotorRota()
			addEventHandler("onClientMarkerHit", resourceRoot, motorRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("motorbasla", motorBasla)

function updatemotorRota()
	motorMarker = motorMarker + 1
	for i,v in ipairs(motorRota) do
		if i == motorMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(motorCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(motorCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(motorCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function motorRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 448 then
				for _, marker in ipairs(motorCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatemotorRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							motorMarker = 0
							triggerServerEvent("motorParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeniden sürmek  için hazırlanıyoruz, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /motorlebitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFHazırız. Hadi gidelim.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatemotorRota()
								end, 5000, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFPizzalar Bırakılıyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFPizzalar Bırakılmıştır, devam edebilirsiniz. @Delete", 0, 0, 255, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatemotorRota()
								end, 12000, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function motorBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local motorSoforlugu = getElementData(getLocalPlayer(), "motorSoforlugu")
	if pedVeh then
		if pedVehModel == 448 then
			if motorSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "motorSoforlugu", false)
				for i,v in ipairs(motorCreatedMarkers) do
					destroyElement(v[1])
				end
				motorCreatedMarkers = {}
				motorMarker = 0
				triggerServerEvent("motorBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, motoRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), motorAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("motorlebitir", motorBitir)

function motorAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 448 and vehicleJob == 17 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 17 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Şehir Motorcu Şoförlüğü mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		cancelEvent()
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), motorAntiYabanci)

function motorAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			motorBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), motorAntiAracTerketme)