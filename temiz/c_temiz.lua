local temizMarker = 0
local temizCreatedMarkers = {}
-- false devam
-- true bekle
-- true, true bitiş
local temizRota = {
	{ 1466.0625, -1742.46484375, 13.540049552917, false },
	{ 1431.677734375, -1722.88671875, 13.3828125, false },
	{ 1431.857421875, -1653.2734375, 13.3828125, false },
	{ 1432.056640625, -1581.4912109375, 13.367107391357, false },
	{ 1449.166015625, -1499.3486328125, 13.377288818359, false },
	{ 1457.599609375, -1450.91015625, 13.369727134705, false },
	{ 1423.2060546875, -1435.2666015625, 13.3828125, false },
	{ 1369.8505859375, -1393.068359375, 13.457413673401, false },

	{ 1344.6220703125, -1419.1328125, 13.3828125, false },

	{ 1326.150390625, -1496.5771484375, 13.3828125, false },
	
	{ 1302.7744140625, -1554.8798828125, 13.3828125, true },
	
	{ 1299.76171875, -1653.4130859375, 13.3828125, false },
	{ 1286.9833984375, -1709.849609375, 13.3828125,	false },
	{ 1224.1279296875, -1709.869140625, 13.3828125, false },
	{ 1172.3828125, -1763.9970703125, 13.060980796814, false },
	{ 1180.46484375, -1854.6484375, 13.3984375, false },
	{ 1286.421875, -1854.8603515625, 13.390604019165, false },
	
	{ 1372.7255859375, -1873.966796875, 13.3828125, false },	
	{ 1391.6591796875, -1842.1162109375, 13.3828125, false },
	{ 1398.328125, -1735.3515625, 13.10783290863, false },
	{ 1454.8984375, -1743.09375, 13.265824317932, false },
	{ 1434.9111328125, -1755.9453125, 13.265182495117, true,true },

}

function temizBasla(cmd)
	if not getElementData(getLocalPlayer(), "temizSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 574
		
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "temizSoforlugu", true)
			updatetemizRota()
			addEventHandler("onClientMarkerHit", resourceRoot, temizRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("temizlikbasla", temizBasla)

function updatetemizRota()
	temizMarker = temizMarker + 1
	for i,v in ipairs(temizRota) do
		if i == temizMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(temizCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(temizCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(temizCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function temizRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 574 then
				for _, marker in ipairs(temizCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatetemizRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							temizMarker = 0
							triggerServerEvent("temizParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeniden temizlemek  için hazırlanıyoruz, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /temizlebitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFHazırız. Hadi gidelim.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatetemizRota()
								end, 5000, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFÇalılar temizleniyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFÇalılar temizlenmiştir, devam edebilirsiniz.", 0, 0, 255, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatetemizRota()
								end, 12000, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function temizBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local temizSoforlugu = getElementData(getLocalPlayer(), "temizSoforlugu")
	if pedVeh then
		if pedVehModel == 574 then
			if temizSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "temizSoforlugu", false)
				for i,v in ipairs(temizCreatedMarkers) do
					destroyElement(v[1])
				end
				temizCreatedMarkers = {}
				temizMarker = 0
				triggerServerEvent("temizBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, temizRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), temizAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("temizlikbitir", temizBitir)

function temizAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 574 and vehicleJob == 17 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 17 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Şehir Temizleyici Şoförlüğü mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		cancelEvent()
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), temizAntiYabanci)

function temizAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			temizBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), temizAntiAracTerketme)