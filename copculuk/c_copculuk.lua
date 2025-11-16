-- ROTA --
local copMarker = 0
local copCreatedMarkers = {}
local copRota = {
	--{ 2227.8173828125, -2626.603515625, 13.87215423584, false },
{ 1653.3837890625, -1874.7451171875, 13.934601783752, false }, -- start
{ 2508.2119140625, -1734.517578125, 13.3828125 , false },
{ 2525.5068359375, -1734.4140625, 13.3828125, false },
{ 2562.4228515625, -1734.1123046875, 13.001593589783, false },
{ 2644.1591796875, -1726.3359375, 10.340007781982, false },
{ 2645.0859375, -1682.7080078125, 10.377652168274, false },
{ 2677.0185546875, -1659.47265625, 10.522150993347, false },
{ 2715.8330078125, -1659.5703125, 12.776346206665, false },
{ 2739.8916015625, -1640.69921875, 12.570874214172, false },
{ 2740.412109375, -1602.9306640625, 12.46280002594, false },
{ 2740.3544921875, -1566.390625, 19.911066055298, true },
{ 2739.7958984375, -1516.0302734375, 29.907081604004, true },
{ 2739.4677734375, -1466.0986328125, 29.888214111328, true },
{ 2739.3828125, -1410.1865234375, 33.574596405029, true },
{ 2739.2861328125, -1350.31640625, 44.377559661865, true },
{ 2739.2177734375, -1302.103515625, 53.091171264648, true },
{ 2740.1201171875, -1276.2548828125, 57.738945007324, true },
{ 2739.9306640625, -1238.34375, 60.869567871094, true },
{ 2740.310546875, -1222.3662109375, 63.721347808838, true },
{ 2740.685546875, -1205.943359375, 66.684440612793, true },
{ 2739.8291015625, -1181.4326171875, 68.850891113281, false },
{ 2739.7763671875, -1151.3955078125, 69.035575866699, false },
{ 2740.0634765625, -1109.7314453125, 69.154876708984, false },
{ 2704.0322265625, -1069.8544921875, 68.826652526855, false },
{ 2656.2724609375, -1068.43359375, 69.008796691895, false },
{ 2626.267578125, -1045.234375, 69.022178649902, false },
{ 2579.888671875, -1045.646484375, 69.018371582031, true },
{ 2546.9130859375, -1045.123046875, 69.048789978027, true },
{ 2526.3515625, -1044.734375, 69.021911621094, true },
{ 2503.6171875, -1044.0078125, 68.492492675781, true },
{ 2474.837890625, -1034.7314453125, 63.663188934326, true },
{ 2453.099609375, -1031.7763671875, 58.456615447998, true },
{ 2430.5556640625, -1032.6748046875, 53.343257904053, true },
{ 2396.359375, -1049.943359375, 52.111053466797, true },
{ 2257.767578125, -1050.2177734375, 50.761936187744, true },
{ 2200.0234375, -1010.826171875, 61.469383239746, true },
{ 2121.9189453125, -991.171875, 57.185947418213, true },
{ 2090.3525390625, -983.3134765625, 51.61051940918, true },
{ 2052.7861328125, -976.830078125, 44.760459899902, true },
{ 2023.6044921875, -983.125, 37.166679382324, true },
{ 2006.5751953125, -995.8701171875, 31.316246032715, true },
{ 1985.9228515625, -1033.384765625, 24.098550796509, false },
{ 2030.0966796875, -1073.9609375, 24.237573623657, true },
{ 2049.6796875, -1081.748046875, 24.295209884644, true },
{ 2084.1982421875, -1098.521484375, 24.477828979492, false },
{ 2109.341796875, -1108.353515625, 24.682308197021, false },
{ 2146.9404296875, -1117.787109375, 24.909076690674, false },
{ 2173.3681640625, -1143.185546875, 24.563274383545, false },
{ 2173.2490234375, -1168.04296875, 24.129976272583, false },
{ 2173.0830078125, -1200.69140625, 23.578351974487, false },
{ 2194.54296875, -1222.9931640625, 23.41961479187, true },
{ 2215.3515625, -1223.27734375, 23.420175552368, true },
{ 2231.162109375, -1223.1748046875, 23.41081237793, true },
{ 2251.3701171875, -1223.189453125, 23.419273376465, true },
{ 2268.640625, -1243.0400390625, 23.411394119263, false },
{ 2268.6416015625, -1267.70703125, 23.434381484985, false },
{ 2268.681640625, -1312.02734375, 23.436773300171, false },
{ 2268.681640625, -1342.6162109375, 23.43763923645, false },
{ 2268.6806640625, -1376.466796875, 23.434879302979, false },
{ 2286.4091796875, -1386.044921875, 23.713195800781, false },
{ 2321.1328125, -1386.4970703125, 23.47027015686, false },
{ 2340.1044921875, -1404.419921875, 23.421737670898, false },
{ 2340.8759765625, -1445.064453125, 23.436340332031, false },
{ 2340.8095703125, -1492.2861328125, 23.433668136597, false },
{ 2340.1572265625, -1534.6923828125, 23.455020904541, false },
{ 2341.0712890625, -1590.8369140625, 23.257818222046, false },
{ 2340.759765625, -1655.361328125, 12.981450080872, false },
{ 2340.3310546875, -1698.2158203125, 12.971076965332, false },
{ 2361.357421875, -1734.7109375, 12.998873710632, false },
{ 2395.9140625, -1734.78515625, 12.990892410278, false },
{ 2467.90234375, -1740.2392578125, 13.164016723633, true, true }, -- bitiş
	
}
-- tek true yük indir, iki true bitiş.

function copBasla(cmd)
	outputChatBox("[!] #FFFFFFa mesleğe başladınız!", 255, 0, 0, true)
	if not getElementData(getLocalPlayer(), "copSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 408
		
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "copSoforlugu", true)
			updatecopRota()
			addEventHandler("onClientMarkerHit", resourceRoot, copRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("copbasla", copBasla)

function updatecopRota()
	copMarker = copMarker + 1
	for i,v in ipairs(copRota) do
		if i == copMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(copCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(copCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(copCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function copRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 408 then
				for _, marker in ipairs(copCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatecopRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							copMarker = 0
							triggerServerEvent("copParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFAracınıza yeni mallar yükleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /copbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFAracınıza yeni mallar yüklenmiştir. Gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatecopRota()
								end, 5000, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFAracınızdaki mallar indiriliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFAracınızdaki mallar indirilmiştir, geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatecopRota()
								end, 12000, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function copBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local copSoforlugu = getElementData(getLocalPlayer(), "copSoforlugu")
	if pedVeh then
		if pedVehModel == 408 then
			if copSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "copSoforlugu", false)
				for i,v in ipairs(copCreatedMarkers) do
					destroyElement(v[1])
				end
				copCreatedMarkers = {}
				copMarker = 0
				triggerServerEvent("copBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, copRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), copAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("copbitir", copBitir)

function copAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 408 and vehicleJob == 16 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 16 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Çöpçülük Şoförlüğü mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), copAntiYabanci)

function copAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			copBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), copAntiAracTerketme)

function copBlip()
	blip = createBlip(1615.986328125, -1897.5830078125, 13.5491771698, 0, 4, 255, 255, 0)  --0 0 1787.1259765625 -1903.591796875 13.394536972046
	exports.hud:sendBottomNotification(localPlayer, "Çöpçülük Şoförü", "Haritadaki sarı işarete giderek cop Taşımacılığı şoförlüğü mesleğinize başlayabilirsiniz.")
end