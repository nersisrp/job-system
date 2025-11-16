-- ROTA --
local denizMarker = 0
local denizCreatedMarkers = {}
local denizRota = {
{ 74.6640625, -1990.8994140625, 0.071220740675926, false },
{ 83.8896484375, -2090.748046875, 0.068022392690182, false },
{ 96.5751953125, -2264.908203125, 0.10961759090424, false },
{ 122.802734375, -2529.083984375, 0.1053591966629, false },
{ 243.6728515625, -2725.2314453125, 0.03300504386425, false },
{ 440.2431640625, -2834.0458984375, 0.10162529349327, false },
{ 659.8212890625, -2884.0419921875, -0.0037453880067915, false },
{ 899.849609375, -2922.697265625, 0.11598802357912, false },
{ 1021.7119140625, -3002.39453125, 0.049229864031076, false },
{ 1191.080078125, -3107.01953125, 0.20249159634113, false },
{ 1383.103515625, -3187.0166015625, 0.13640357553959, false },
{ 1601.2470703125, -3203.072265625, 0.15827921032906, false },
{ 1715.228515625, -3269.7939453125, 0.15504640340805, false },
{ 1827.7421875, -3365.560546875, 0.19564943015575, false },
{ 1944.9521484375, -3446.9951171875, 0.10535853356123, false },
{ 2095.541015625, -3432.736328125, 0.0091792000457644, false },
{ 2244.7998046875, -3334.1806640625, 0.20048294961452, false },
{ 2476.2880859375, -3194.310546875, -0.019190579652786, false },
{ 2656.2275390625, -3087.572265625, 0.09340138733387, false },
{ 2812.9677734375, -2970.8662109375, 0.18485553562641, false },
{ 2895.046875, -2841.234375, -0.022524392232299, false },
{ 2928.087890625, -2720.126953125, 0.12232954055071, false },
{ 2939.0927734375, -2550.5439453125, 0.08140791207552, false },
{ 2933.8095703125, -2403.5205078125, 0.12150110304356, false },
{ 2872.0615234375, -2309.86328125, 0.065187841653824, false },
{ 2767.0751953125, -2311.4443359375, 0.098495155572891, false },
{ 2704.3857421875, -2309.228515625, 0.03345775231719, true }, -- yük indirme 1
{ 2627.900390625, -2305.4365234375, 0.11244720220566, false },
{ 2499.810546875, -2306.357421875, 0.03529404103756, false },
{ 2422.626953125, -2359.091796875, 0.11796125024557, false },
{ 2341.6435546875, -2441.45703125, 0.075040124356747, false },
{ 2325.8837890625, -2536.1201171875, 0.11009792238474, false },
{ 2325.1962890625, -2646.712890625, 0.10651282966137, false },
{ 2327.7294921875, -2712.75, 0.020183317363262, false },
{ 2323.1416015625, -2873.216796875, 0.092823170125484, false },
{ 2238.75, -2989.4072265625, 0.19094170629978, false },
{ 2180.2587890625, -3010.7841796875, 0.035713262856007, false },
{ 2024.16015625, -2980.9072265625, 0.012250322848558, false },
{ 1799.3232421875, -2936.421875, 0.20415237545967, false },
{ 1596.0859375, -2892.6171875, 0.091317743062973, false },
{ 1449.48828125, -2843.0751953125, 0.19221359491348, false },
{ 1264.357421875, -2730.5498046875, 0.066010490059853, false },
{ 1161.744140625, -2642.0029296875, -0.027265384793282, false },
{ 1045.1474609375, -2555.0361328125, 0.21417519450188, false },
{ 895.615234375, -2458.5556640625, 0.011651555076241, false },
{ 760.0595703125, -2369.8583984375, 0.11484099924564, false },
{ 637.3232421875, -2289.6806640625, 0.15393683314323, false },
{ 508.2177734375, -2225.33203125, -0.045578524470329, false },
{ 388.666015625, -2186.0712890625, 0.2017896771431, false },
{ 302.5166015625, -2133.4853515625, 0.087491974234581, false },
{ 226.7255859375, -2068.0927734375, 0.1197826564312, false },
{ 168.005859375, -2025.341796875, 0.10264313966036, false },
{ 133.173828125, -1966.3916015625, 0.094067014753819, false },
{ 2425.171875, -2702.1650390625, -0.33786660432816, true, true },
}

function denizBasla(cmd)
	if not getElementData(getLocalPlayer(), "denizSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 472
		
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "denizSoforlugu", true)
			updateDenizRota()
			addEventHandler("onClientMarkerHit", resourceRoot, denizRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("denizbasla", denizBasla)

local createdBlip
function updateDenizRota()
	if createdBlip then
		destroyElement(createdBlip)
	end
	denizMarker = denizMarker + 1
	for i,v in ipairs(denizRota) do
		if i == denizMarker then
			createdBlip = createBlip(v[1], v[2], v[3])
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "ring", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(denizCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "ring", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(denizCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "ring", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(denizCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function denizRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 472 then
				for _, marker in ipairs(denizCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updateDenizRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							denizMarker = 0
							triggerServerEvent("denizParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFTeknenize yeni mallar yükleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /denizbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFTeknenize yeni mallar yüklenmiştir. Gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateDenizRota()
								end, 5000, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFTeknenizdeki mallar indiriliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFTeknenizdeki mallar indirilmiştir, geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateDenizRota()
								end, 12000, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function denizBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local denizSoforlugu = getElementData(getLocalPlayer(), "denizSoforlugu")
	if pedVeh then
		if pedVehModel == 472 then
			if denizSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "denizSoforlugu", false)
				for i,v in ipairs(denizCreatedMarkers) do
					destroyElement(v[1])
				end
				denizCreatedMarkers = {}
				denizMarker = 0
				triggerServerEvent("denizBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, denizRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), denizAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("denizbitir", denizBitir)

function denizAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 472 and vehicleJob == 15 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 15 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Deniz Taşımacılığı mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), denizAntiYabanci)

function denizAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			denizBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), denizAntiAracTerketme)