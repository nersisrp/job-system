--[[
    @بسم الله الرحمن الرحيم
    @Script: Temizcilik Sistemi
    @Version: v1.4
    @Scripter: Leoncio
    @Server: Nersis Roleplay    
--]]

--[[ 
BİLGİ: 
	MESLEK ID = 11 / ARAÇ MESLEK ID = 11
]]

----------------------------------------------------------------------------
-- DEĞİŞKENLER
----------------------------------------------------------------------------
local jobID = 11

-- GLOBAL
--local ucretRate = 0.12
local kamyonMarker = 0
local kamyonBlip = 0
local kamyonCreatedMarkers = {}
local kamyonCreatedBlips = {}

----------------------------------------------------------------------------
--- ROTA
----------------------------------------------------------------------------
local kamyonRota = {
	-- X, Y, Z, Marker Türü [0 = Başlangıç (Mal Yükleme), 1 = Normal, 2 = Mal İndirme, 3 = Bitiş]
	{ 2624.5673828125, -2208.9580078125, 13.256106376648, 0 },

	{ 2614.228515625, -2224.2705078125, 13.078134536743, 1 },
	{ 2563.234375, -2223.986328125, 13.08030128479, 1 },
	{ 2465.326171875, -2223.7470703125, 13.041860580444, 1 },
	{ 2412.0478515625, -2244.9951171875, 13.089684486389, 1 },
	{ 2370.2451171875, -2286.6943359375, 13.103886604309, 1 },
	{ 2332.052734375, -2324.955078125, 13.098116874695, 1 },
	{ 2287.181640625, -2299.359375, 13.09202671051, 1 },
	{ 2292.611328125, -2285.6474609375, 13.089079856873, 1 },
	{ 2283.5537109375, -2266.384765625, 13.084852218628, 1 },
	{ 2223.0185546875, -2327.6669921875, 13.084526062012, 1 },
	{ 2191.9794921875, -2358.9130859375, 13.085609436035, 1 },
	{ 2170.6826171875, -2393.642578125, 13.084468841553, 1 },
	{ 2158.6376953125, -2440.5791015625, 13.085118293762, 1 },
	{ 2157.5634765625, -2504.6318359375, 13.084478378296, 1 },
	{ 2154.2216796875, -2593.390625, 13.086261749268, 1 },
	{ 2107.33984375, -2655.31640625, 13.084224700928, 1 },
	{ 2038.1435546875, -2667.6591796875, 11.76575756073, 1 },
	{ 1895.5771484375, -2667.6669921875, 5.598813533783, 1 },
	{ 1765.119140625, -2667.78515625, 5.598828792572, 1 },
	{ 1646.1943359375, -2667.5361328125, 5.5766582489014, 1 },
	{ 1517.40234375, -2667.623046875, 8.9609355926514, 1 },
	{ 1419.5703125, -2663.1298828125, 13.085380554199, 1 },
	{ 1361.767578125, -2617.283203125, 13.086873054504, 1 }, --
	{ 1358.453125, -2520.0673828125, 13.08696269989, 1 },
	{ 1341.6328125, -2446.6484375, 7.3660230636597, 1 },
	{ 1277.60546875, -2445.4208984375, 7.9361047744751, 1 },
	{ 1175.9482421875, -2410.6455078125, 10.073055267334, 1 },
	{ 1114.4482421875, -2360.685546875, 11.565880775452, 1 },
	{ 1065.38671875, -2293.8505859375, 12.631350517273, 1 },
	{ 1034.4853515625, -2178.822265625, 12.6707239151, 1 },
	{ 1059.7392578125, -2025.345703125, 12.663001060486, 1 },
	{ 1064.73828125, -1901.07421875, 12.805470466614, 1 },
	{ 1058.4169921875, -1828.90625, 13.279728889465, 1 },
	{ 983.1689453125, -1782.8251953125, 13.789549827576, 1 },
	{ 862.9287109375, -1767.8828125, 13.092288970947, 1 },
	{ 751.1708984375, -1761.50390625, 12.54887008667, 1 },
	{ 584.4541015625, -1720.49609375, 13.215152740479, 1 },
	{ 451.91015625, -1703.3603515625, 10.350499153137, 1 },
	{ 349.50390625, -1698.7216796875, 6.3572764396667, 1 },
	{ 231.87890625, -1650.7333984375, 11.878342628479, 1 },
	{ 152.6015625, -1559.00390625, 10.61257648468, 1 },
	{ 81.8486328125, -1525.6318359375, 4.7616467475891, 1 },
	{ 7.9033203125, -1517.1279296875, 3.1041815280914, 1 },
	{ -83.7158203125, -1500.0673828125, 2.4096529483795, 1 },
	{ -145.71484375, -1303.552734375, 2.4047775268555, 1 },
	{ -124.619140625, -1197.857421875, 2.4048089981079, 1 },
	{ -86.8515625, -1114.7958984375, 1.1052490472794, 1 },
	{ -266.83203125, -884.3076171875, 44.918121337891, 1 },
	{ -422.69921875, -827.69140625, 48.27059173584, 1 },
	{ -509.25, -879.458984375, 53.391979217529, 1 },
	{ -655.6044921875, -997.1455078125, 68.757797241211, 1 },
	{ -767.76953125, -1001.3896484375, 77.934951782227, 1 },
	{ -850.87109375, -1031.9921875, 87.67724609375, 1 },
	{ -889.2265625, -1113.884765625, 98.662620544434, 1 },
	{ -973.482421875, -1028.037109375, 95.399787902832, 1 },
	{ -1100.5087890625, -896.638671875, 75.869728088379, 1 },
	{ -1243.73046875, -775.8515625, 64.86385345459, 1 },
	{ -1366.287109375, -813.166015625, 79.211654663086, 1 },
	{ -1524.01171875, -814.0390625, 56.93383026123, 1 },
	{ -1674.52734375, -764.0419921875, 41.39098739624, 1 },
	{ -1755.1416015625, -694.7001953125, 25.856147766113, 1 },
	{ -1759.794921875, -596.814453125, 16.010055541992, 1 },
	{ -1805.1806640625, -575.0654296875, 15.793820381165, 1 },
	{ -1872.4013671875, -574.6015625, 23.919469833374, 1 },
	{ -1950.373046875, -574.7109375, 24.154804229736, 1 },
	{ -2103.3955078125, -537.4482421875, 33.265533447266, 1 },
	{ -2224.1201171875, -418.3193359375, 50.576560974121, 1 },
	{ -2251.96484375, -335.0361328125, 50.576866149902, 1 },
	{ -2251.822265625, -247.46484375, 38.723690032959, 1 },
	{ -2251.708984375, -169.84765625, 34.882305145264, 1 },
	{ -2251.203125, -90.4423828125, 34.88134765625, 1 },
	{ -2227.513671875, -73.07421875, 34.880783081055, 1 },
	{ -2180.1884765625, -73.041015625, 34.881649017334, 1 },
	{ -2135.998046875, -73.0693359375, 34.886566162109, 1 },
	{ -2131.5869140625, -96.482421875, 35.03067779541, 1 },

	{ -2103.41015625, -101.8447265625, 35.028522491455, 2 },

	{ -2111.67578125, -87.681640625, 35.033798217773, 1 },
	{ -2134.1064453125, -67.869140625, 34.881687164307, 1 },
	{ -2196.4375, -67.8994140625, 34.881355285645, 1 },
	{ -2239.1201171875, -67.919921875, 34.882236480713, 1 },
	{ -2260.2255859375, -98.33984375, 34.881042480469, 1 },
	{ -2261.0419921875, -157.240234375, 34.881343841553, 1 },
	{ -2262.19140625, -275.1533203125, 44.067649841309, 1 },
	{ -2256.912109375, -377.748046875, 50.576648712158, 1 },
	{ -2212.498046875, -443.2783203125, 50.444931030273, 1 },
	{ -2144.6494140625, -512.359375, 38.358463287354, 1 },
	{ -2023.236328125, -583.7421875, 26.539348602295, 1 },
	{ -1936.5380859375, -583.962890625, 24.15424156189, 1 },
	{ -1896.4736328125, -584.6025390625, 24.15372467041, 1 },
	{ -1831.3046875, -585.662109375, 16.367210388184, 1 },
	{ -1771.1240234375, -586.646484375, 16.046691894531, 1 },
	{ -1761.7421875, -691.734375, 25.137302398682, 1 },
	{ -1703.76171875, -755.0576171875, 38.43957901001, 1 },
	{ -1617.390625, -795.79296875, 46.738414764404, 1 },
	{ -1516.638671875, -821.6484375, 58.389545440674, 1 },
	{ -1388.87109375, -819.32421875, 81.112937927246, 1 },
	{ -1316.0576171875, -815.8818359375, 73.584197998047, 1 },
	{ -1264.263671875, -795.27734375, 67.850318908691, 1 },
	{ -1231.96875, -775.263671875, 63.733924865723, 1 },
	{ -1178.7705078125, -824.5654296875, 65.451759338379, 1 },
	{ -1052.87890625, -953.8515625, 85.021476745605, 1 },
	{ -976.3681640625, -1032.4560546875, 95.427024841309, 1 },
	{ -878.9609375, -1119.94921875, 98.460403442383, 1 },
	{ -854.494140625, -1048.4384765625, 89.649642944336, 1 },
	{ -750.24609375, -1009.1083984375, 76.488876342773, 1 },
	{ -602.857421875, -978.0966796875, 63.797477722168, 1 },
	{ -514.587890625, -892.662109375, 54.108108520508, 1 },
	{ -377.0478515625, -842.4228515625, 46.953701019287, 1 },
	{ -240.9169921875, -904.6865234375, 42.581836700439, 1 },
	{ -146.521484375, -971.19921875, 26.85493850708, 1 },
	{ -83, -1063.12109375, 16.293573379517, 1 },
	{ -91.8046875, -1111.4794921875, 1.4393863677979, 1 },
	{ -139.4541015625, -1227.2421875, 2.2622458934784, 1 },
	{ -148.6875, -1420.7890625, 2.2602949142456, 1 },
	{ -67.4833984375, -1512.708984375, 1.7116763591766, 1 },
	{ 25.900390625, -1536.2177734375, 4.2354907989502, 1 },
	{ 92.998046875, -1547.0712890625, 5.6440501213074, 1 },
	{ 163.955078125, -1599.0810546875, 13.030728340149, 1 },
	{ 255.048828125, -1695.28125, 8.3405838012695, 1 },
	{ 378.876953125, -1719.388671875, 7.002724647522, 1 },
	{ 479.9736328125, -1726.9072265625, 10.526201248169, 1 },
	{ 627.017578125, -1747.8056640625, 12.826986312866, 1 },
	{ 809.5478515625, -1786.6904296875, 13.044312477112, 1 },
	{ 944.46484375, -1794.7041015625, 13.456622123718, 1 },
	{ 1041.73046875, -1836.767578125, 13.048175811768, 1 },
	{ 1045.0478515625, -1943.4697265625, 12.520994186401, 1 },
	{ 1026.6181640625, -2098.3427734375, 12.527070999146, 1 },
	{ 1024.173828125, -2251.0712890625, 12.519849777222, 1 },
	{ 1099.2880859375, -2373.1845703125, 11.450329780579, 1 },
	{ 1225.2548828125, -2455.5146484375, 8.8049077987671, 1 },
	{ 1304.3291015625, -2466.2626953125, 7.2349343299866, 1 },
	{ 1319.4091796875, -2520.361328125, 12.94113445282, 1 },
	{ 1334.6220703125, -2603.8017578125, 12.941701889038, 1 },
	{ 1415.54296875, -2682.9716796875, 12.941559791565, 1 },
	{ 1581.4853515625, -2686.802734375, 5.5176138877869, 1 },
	{ 1744.716796875, -2687.3056640625, 5.4676685333252, 1 },
	{ 1871.486328125, -2686.9716796875, 5.4339985847473, 1 },
	{ 2011.7958984375, -2687.873046875, 10.099326133728, 1 },
	{ 2117.4375, -2672.58203125, 12.941318511963, 1 },
	{ 2173.71484375, -2599.966796875, 12.956903457642, 1 },
	{ 2177.1298828125, -2516.626953125, 12.94226360321, 1 },
	{ 2217, -2498.517578125, 12.961111068726, 1 },
	{ 2227.8291015625, -2452.9443359375, 12.921530723572, 1 },
	{ 2276.80859375, -2389.447265625, 12.974740982056, 1 },
	{ 2335.8369140625, -2329.8984375, 12.961941719055, 1 },
	{ 2411.298828125, -2255.7490234375, 12.941967964172, 1 },
	{ 2495.60546875, -2229.4375, 12.91582775116, 1 },
	{ 2554.796875, -2230.0126953125, 12.899655342102, 1 },

	{ 2603.1591796875, -2204.705078125, 13.117364883423, 3 },
}

function iKamyonBasla(cmd)
	local theVehicle = getPedOccupiedVehicle(getLocalPlayer())
	if not theVehicle or getElementData(theVehicle, "job") ~= jobID then
		exports["Nersisroleplay-bildirim"]:addNotification("Göreve başlamak için bir meslek kamyonunda olmanız gerekmektedir!", "error")
		return
	end
	
	if not getElementData(getLocalPlayer(), "meslek:ikamyon") then
		setElementData(getLocalPlayer(), "meslek:ikamyon", true)
		
		updateKamyonRota()
		addEventHandler("onClientMarkerHit", resourceRoot, kamyonRotaMarkerHit)
		exports["Nersisroleplay-bildirim"]:addNotification("Mesleğe başladınız sarı işarete gidip malları yükletin.", "info")
	else
		exports["Nersisroleplay-bildirim"]:addNotification("Mesleğe zaten başladınız!", "error")
	end
end
addCommandHandler("ikamyonbasla", iKamyonBasla)
addCommandHandler("illegalkamyonbasla", iKamyonBasla)

function updateKamyonRota()
	kamyonMarker = kamyonMarker + 1
	kamyonBlip = kamyonBlip + 1
	for i, v in ipairs(kamyonRota) do
		if i == kamyonMarker then
			if v[4] == 0 then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255)
				local rotaBlip = createBlip(v[1], v[2], v[3], 0, 2, 255, 255, 0, 255)
				table.insert(kamyonCreatedMarkers, { rotaMarker, 0 })
				table.insert(kamyonCreatedBlips, { rotaBlip })
			elseif v[4] == 1 then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255)
				local rotaBlip = createBlip(v[1], v[2], v[3], 0, 2, 255, 0, 0)
				table.insert(kamyonCreatedMarkers, { malMarker, 1 })			
				table.insert(kamyonCreatedBlips, { rotaBlip })
			elseif v[4] == 2 then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255)
				local rotaBlip = createBlip(v[1], v[2], v[3], 0, 2, 255, 0, 0)
				table.insert(kamyonCreatedMarkers, { malMarker, 2 })			
				table.insert(kamyonCreatedBlips, { rotaBlip })
			elseif v[4] == 3 then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255)
				local rotaBlip = createBlip(v[1], v[2], v[3], 0, 2, 255, 0, 0)
				table.insert(kamyonCreatedMarkers, { malMarker, 3 })			
				table.insert(kamyonCreatedBlips, { rotaBlip })
			end
		end
	end
end

function kamyonRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if not hitVehicle or getElementData(hitVehicle, "job") ~= jobID then
			exports["Nersisroleplay-bildirim"]:addNotification("Bu alandan bir kamyonla geçmeniz gerekmektedir.", "error")
			return
		end
	
		for _, marker in ipairs(kamyonCreatedMarkers) do
			if source == marker[1] and matchingDimension then
				if marker[2] == 0 then
					local hitVehicle = getPedOccupiedVehicle(hitPlayer)
					setElementFrozen(hitPlayer, true)
					setElementFrozen(hitVehicle, true)
					toggleAllControls(false, true, false)
					
					exports["Nersisroleplay-bildirim"]:addNotification("Aracınıza mallar yükleniyor. Lütfen bekleyin.", "info")
					setTimer(
						function(theMarker)
							setElementFrozen(hitVehicle, false)
							setElementFrozen(hitPlayer, false)
							toggleAllControls(true)
							
							destroyElement(theMarker)
							destroyElement(kamyonCreatedBlips[kamyonBlip][1])
							
							updateKamyonRota()
							exports["Nersisroleplay-bildirim"]:addNotification("Aracınıza mallar yüklenmiştir. Lütfen kırmızı işaretleri takip ederek malları teslim edin ve polislere dikkat edin!", "info")
						end, 5000, 1, source)
				elseif marker[2] == 1 then
					destroyElement(source)
					destroyElement(kamyonCreatedBlips[kamyonBlip][1])
					
					updateKamyonRota()
				elseif marker[2] == 2 then
					local hitVehicle = getPedOccupiedVehicle(hitPlayer)
					setElementFrozen(hitPlayer, true)
					setElementFrozen(hitVehicle, true)
					toggleAllControls(false, true, false)
					
					exports["Nersisroleplay-bildirim"]:addNotification("Aracınızdaki mallar indiriliyor. Lütfen bekleyin.", "info")
					setTimer(
						function( theMarker )
							setElementFrozen(hitVehicle, false)
							setElementFrozen(hitPlayer, false)
							toggleAllControls(true)
							
							destroyElement(theMarker)
							destroyElement(kamyonCreatedBlips[kamyonBlip][1])
							
							updateKamyonRota()
							exports["Nersisroleplay-bildirim"]:addNotification("Aracınızdan mallar indirilmiştir. Lütfen kırmızı işaretleri takip ederek aracı geri teslim edin!", "info")
						end, 5000, 1, source)
				elseif marker[2] == 3 then
					exports["Nersisroleplay-bildirim"]:addNotification("Aracı teslim ettiniz ve bu turu başarıyla bitirdiniz!", "info")
					triggerServerEvent("ikamyon:paraVer", getLocalPlayer(), getLocalPlayer())
					kamyonBitir()
				end
			end
		end
	end
end

function kamyonBitir()
	local playerVehicle = getPedOccupiedVehicle(getLocalPlayer())
	if playerVehicle then
		local vehicleJob = getElementData(playerVehicle, "job")
		local meslekDurumu = getElementData(getLocalPlayer(), "meslek:ikamyon")
		if vehicleJob == jobID then
			exports.global:fadeToBlack()
			---------------------------- MESLEK BAŞLAMIŞSA ----------------------------
			if meslekDurumu then
				-- MARKER VE BLİPLERİ TEMİZLE
				for _, marker in ipairs(kamyonCreatedMarkers) do
					if isElement(marker[1]) then
						destroyElement(marker[1])
					end
				end
				for _, blip in ipairs(kamyonCreatedBlips) do
					if isElement(blip[1]) then
						destroyElement(blip[1])
					end
				end
				----------------------------------
				kamyonCreatedMarkers = {}
				kamyonCreatedBlips = {}
				kamyonMarker = 0
				kamyonBlip = 0
			end
			---------------------------------------------------------------------------
			triggerServerEvent("ikamyon:kamyonBitir", getLocalPlayer(), getLocalPlayer())
			removeEventHandler("onClientMarkerHit", resourceRoot, kamyonRotaMarkerHit)
			setTimer(function() exports.global:fadeFromBlack() end, 1000, 1)
		end
	end
end
addCommandHandler("kacakkamyonbitir", kamyonBitir)

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--function showTemizlikBlip()
--	blip = createBlip(1664.09375, -1718.5400390625, 15.609375, 0, 4, 255, 255, 0)
--	exports.hud:sendBottomNotification(localPlayer, "Sokak Temizlikçisi", "Haritadaki sarı işarete giderek temizlikçilik mesleğine başlayabilirsiniz.")
--end