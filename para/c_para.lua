local paraMarker = 0
local paraCreatedMarkers = {}
-- false devam
-- true bekle
-- true, true bitiş
local paraRota = {
	{ 1011.6064453125, -1309.7998046875, 13.3828125, false },
	{ 1012.025390625, -1317.275390625, 13.382812, false },
	{ 937.0302734375, -1320.0908203125, 13.390609741211, false },
	{ 876.08984375, -1320.4384765625, 13.56649017334, false },
	{ 807.322265625, -1320.1748046875, 13.492800712585, false },
	{ 725.3203125, -1317.5703125, 13.398408889771, false },
	{ 647.724609375, -1317.33984375, 13.34151268005, false },
	{ 625.5283203125, -1337.4560546875, 13.380571365356, false },

	{ 625.12109375, -1389.6826171875, 13.36554813385, false },

	{ 651.73828125, -1406.658203125, 13.399341583252, false },
	
	{ 736.5849609375, -1406.5439453125, 13.368768692017, true },
	
	{  798.9248046875, -1385.7890625, 13.430834770203, false },
	{ 800.1953125, -1328.6142578125, 13.3828125,	false },
	{ 912.474609375, -1327.3779296875, 13.586393356323, false },
	{ 975.3095703125, -1327.3544921875, 13.368781089783, false },
	{ 991.7978515625, -1327.5947265625, 13.3828125, false },
	{ 1006.58984375, -1325.6103515625, 13.382812, false },
	{ 1010.9677734375, -1310.0732421875, 13.3828125, true,true },

}

function paraBasla(cmd)
	if not getElementData(getLocalPlayer(), "paraSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 609		
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "paraSoforlugu", true)
			updateparaRota()
			addEventHandler("onClientMarkerHit", resourceRoot, paraRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("parabasla", paraBasla)

function updateparaRota()
	paraMarker = paraMarker + 1
	for i,v in ipairs(paraRota) do
		if i == paraMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(paraCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(paraCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(paraCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function paraRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 609 then
				for _, marker in ipairs(paraCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updateparaRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							paraMarker = 0
							triggerServerEvent("paraParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeniden sürmek  için hazırlanıyoruz, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /paralebitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFHazırız. Hadi gidelim.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateparaRota()
								end, 5000, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFParalar Bırakılıyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFParalar Bırakılmıştır, devam edebilirsiniz.", 0, 0, 255, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateparaRota()
								end, 12000, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function paraBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local paraSoforlugu = getElementData(getLocalPlayer(), "paraSoforlugu")
	if pedVeh then
		if pedVehModel == 609 then
			if paraSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "paraSoforlugu", false)
				for i,v in ipairs(paraCreatedMarkers) do
					destroyElement(v[1])
				end
				paraCreatedMarkers = {}
				paraMarker = 0
				triggerServerEvent("paraBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, motoRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), paraAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("paralebitir", paraBitir)

function paraAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 609 and vehicleJob == 17 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 17 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Şehir paracu Şoförlüğü mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		cancelEvent()
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), paraAntiYabanci)

function paraAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			paraBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), paraAntiAracTerketme)