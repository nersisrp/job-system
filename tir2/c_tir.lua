local tirModelID = 514

-- ROTA --

local tirPed = createPed(16, -1550.771484375,-2737.873046875,48.743457794189, 232 ,true)
setElementData(tirPed, "talk", 1)
setElementData(tirPed, "name", "Abdullah Kara")
setElementFrozen(tirPed, true)

function tirJobDisplayGUI()
	local carlicense = getElementData(getLocalPlayer(), "license.car")
	
	if (carlicense==1) then
		triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), "Abdullah Kara diyor ki: Merhaba dostum.", 255, 255, 255, 3, {}, true)
		tirAcceptGUI(getLocalPlayer())
	else
		triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), "Abdullah Kara diyor ki: La senin daha ehliyetin yok? Alıverip öyle gel hadi bakayım.", 255, 255, 255, 10, {}, true)
		return
	end
end
addEvent("tir:displayJob", true)
addEventHandler("tir:displayJob", getRootElement(), tirJobDisplayGUI)

function tirAcceptGUI(thePlayer)
	local screenW, screenH = guiGetScreenSize()
	local jobWindow = guiCreateWindow((screenW - 308) / 2, (screenH - 102) / 2, 308, 102, "Meslek Görüntüle: Tır Şöförlüğü", false)
	guiWindowSetSizable(jobWindow, false)

	if getElementData(localPlayer,"job")==10 then 
		local label = guiCreateLabel(9, 26, 289, 19, "İşten çıkmak istiyor musun?", false, jobWindow)
		guiLabelSetHorizontalAlign(label, "center", false)
		guiLabelSetVerticalAlign(label, "center")		

		local acceptBtn = guiCreateButton(9, 55, 142, 33, "Ayrıl", false, jobWindow)
		addEventHandler("onClientGUIClick", acceptBtn, 
			function()
				destroyElement(jobWindow)
				setElementData(localPlayer, "job", -1)
				triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), "Abdullah Kara diyor ki: İşten ayrılman bizim için büyük kayıp, Hakkında hayırlısı olsun.", 255, 255, 255, 3, {}, true)
				triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), getPlayerName(localPlayer).." diyor ki: Eyvallah.", 255, 255, 255, 3, {}, true)
				return	
			end
		)
		
		local line = guiCreateLabel(9, 32, 289, 19, "____________________________________________________", false, jobWindow)
		guiLabelSetHorizontalAlign(line, "center", false)
		guiLabelSetVerticalAlign(line, "center")
		local cancelBtn = guiCreateButton(159, 55, 139, 33, "İptal Et", false, jobWindow)
		addEventHandler("onClientGUIClick", cancelBtn, 
			function()
				destroyElement(jobWindow)
				triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), "Abdullah Kara diyor ki: İşe devam edecek olmana sevindim. İyi yolculuklar", 255, 255, 255, 3, {}, true)
				triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), getPlayerName(localPlayer).." diyor ki: Eyvallah.", 255, 255, 255, 3, {}, true)
				
				return	
			end
		)
	
	else
		local label = guiCreateLabel(9, 26, 289, 19, "İşi kabul ediyor musun?", false, jobWindow)
		guiLabelSetHorizontalAlign(label, "center", false)
		guiLabelSetVerticalAlign(label, "center")

		

		local acceptBtn = guiCreateButton(9, 55, 142, 33, "Kabul Et", false, jobWindow)
		addEventHandler("onClientGUIClick", acceptBtn, 
			function()
				destroyElement(jobWindow)
				setElementData(localPlayer, "job", 10)
				triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), "Abdullah Kara diyor ki: Yandaki tırlardan birini alıp işe başla, dikkatli olmayı unutma.", 255, 255, 255, 3, {}, true)
				
				return	
			end
		)
		
		local line = guiCreateLabel(9, 32, 289, 19, "____________________________________________________", false, jobWindow)
		guiLabelSetHorizontalAlign(line, "center", false)
		guiLabelSetVerticalAlign(line, "center")
		local cancelBtn = guiCreateButton(159, 55, 139, 33, "İptal Et", false, jobWindow)
		addEventHandler("onClientGUIClick", cancelBtn, 
			function()
				destroyElement(jobWindow)
				triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), "Abdullah Kara diyor ki: O zaman beni ne uğraştırıyorsun, hadi işine bak.", 255, 255, 255, 3, {}, true)
				triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), getPlayerName(localPlayer).." diyor ki: olur.", 255, 255, 255, 3, {}, true)
				
				return	
			end
		)
	end
end



--createObject ( 577, -1540.4072265625, -2750.1904296875, 48.534427642822, 0, 0, 0 )
local tirMarker = 0
local tirCreatedMarkers = {}

local tirRota2={}

local cikisRotaBaslangic={
	--{ -1546.38671875, -2758.365234375, 48.2448387146, 2 },
	{-1569.158203125,-2744.44921875,48.5390625, false},	
	{ -1607.0615234375,-2713.453125,48.533473968506, 1,1 },	
	
	{ -1639.365234375,-2711.7451171875,48.942993164062, false },
	{ -1668.4814453125, -2685.8466796875, 49.193748474121, false },
	{ -1730.146484375, -2610.2314453125, 49.168754577637, false },
	{ -1800.693359375, -2546.1943359375, 55.244041442871, false },
	{ -1897.2412109375, -2532.3291015625, 41.567859649658, false },
	{ -1911.0068359375, -2536.1357421875,40.125846862793, false },
	{ -1964.87890625,-2549.88671875,38.913970947266, false },
	{-2026.3310546875,-2502.9521484375,32.642219543457, false },
	{ -2097.6259765625,-2446.44140625,30.993553161621, false },
	{ -2152.1865234375,-2402.375,30.99178314209, false },
	{ -2188.482421875,-2372.8291015625,30.990810394287, false },
	{-2165.912109375,-2335.826171875,31.009607315063, false },
	{-2159.9306640625,-2309.3447265625,30.996732711792, false },
	{-2212.8232421875,-2264.49609375,30.987174987793, false },
	{ -2256.705078125,-2227.966796875,30.654357910156, false },
	{-2293.3671875,-2222.2392578125,26.969223022461, false },
	{ -2345.4658203125,-2239.451171875,19.272996902466, false },
	{ -2342.1748046875,-2193.2490234375,34.184516906738, false },
	{-2292.97265625,-2158.6484375,47.507423400879, false },
	{ -2249.1865234375,-2129.673828125,63.145854949951, false },
	{ -2158.7431640625,-2036.8427734375,93.162872314453, false },
	{-2103.10546875,-1910.5693359375,106.39519500732, false },
	{ -2142.78515625,-1948.5009765625,118.37550354004, false },
	{ -2194.8525390625,-2014.15234375,120.09524536133, false },
	{ -2279.4765625,-2080.732421875,118.99201202393, false },
	{ -2397.75,-2097.1494140625,119.24432373047, false },




}
local cikisRotaOrta1={
	{ -2463.9638671875,-2080.2998046875,125.50453948975, false },	
	{ -2538.275390625,-2070.24609375,128.78845214844, false },
	{-2605.625,-2081.9931640625,132.73976135254, false },
	{-2671.009765625,-1897.9326171875,134.96589660645, false },
	{ -2774.755859375,-1767.9345703125,142.35676574707, false },
	{ -2765.6162109375,-1612.4638671875,141.96199035645, false },
	{ -2754.546875,-1446.009765625,140.56420898438, false },
	{ -2651.50390625,-1187.2978515625,165.84127807617, false },
	{-2534.61328125,-1117.609375,177.2904510498, false },
	{-2599.146484375,-1172.7958984375,193.12982177734, false },
	{ -2655.0234375,-1319.5576171875,241.80024719238, false },
	{ -2564.95703125,-1353.4599609375,266.33822631836, false },
	{ -2429.64453125,-1274.5732421875,292.4704284668, false },
	{ -2337.2197265625,-1296.3359375,310.12942504883, false },
	{ -2411.50390625,-1347.1376953125,336.80053710938, false },
	{ -2579.4423828125,-1474.419921875,359.60940551758, false },
	{-2475.279296875,-1435.87890625,363.19281005859, false },
	{ -2311.02734375,-1413.7021484375,359.22833251953, false },
	{ -2215.7578125,-1508.5439453125,360.34313964844, false },
	{ -2189.9423828125,-1701.482421875,375.53033447266, false },
	{-2225.9951171875,-1548.8681640625,379.96685791016, false },
	{ -2244.265625,-1492.291015625,379.70468139648, false },
	{-2340.142578125,-1445.84375,383.43276977539, false },
	{-2477.1123046875,-1472.478515625,391.56518554688, false },	
	{-2524.91796875,-1605.7724609375,398.95794677734, false },
}
local cikisRotaOrta2={
	{ -2464.1787109375,-2071.3408203125,131.6897277832, false },	
	{ -2494.3564453125,-2027.634765625,154.16192626953, false },
	{-2555.783203125,-1922.6025390625,189.58923339844, false },
	{-2625.15625,-1839.3173828125,216.80828857422, false },
	{ -2651.4384765625,-1730.9716796875,257.98007202148, false },
	{ -2605.6474609375,-1789.4501953125,262.01943969727, false },
	{ -2553.18359375,-1865.5244140625,286.08480834961, false },
	{ -2518.4658203125,-1889.5576171875,296.27905273438, false },
	{-2545.9296875,-1838.076171875,311.46875, false },
	{-2598.126953125,-1759.3212890625,320.46301269531, false },
	{ -2591.8896484375,-1625.33984375,344.29666137695, false },
	{ -2585.900390625,-1677.521484375,352.33987426758, false },
	{ -2573.6220703125,-1762.8583984375,354.54232788086, false },
	{ -2540.83984375,-1802.4580078125,374.64730834961, false },
	{ -2556.025390625,-1756.1669921875,384.14926147461, false },
	{ -2558.5244140625,-1679.7421875,396.80892944336, false },
	{-2535.4013671875,-1690.287109375,401.44512939453, false },
}
local cikisRotaSon={
	{-2516.0263671875,-1751.73828125,402.48751831055, false },
	{-2448.859375,-1813.5166015625,410.83401489258, false },
	{-2449.7822265625,-1721.7294921875,431.93505859375, false },
	{ -2361.97265625,-1816.3564453125,433.06213378906, false },
	{ -2278.822265625,-1733.865234375,468.36849975586, false },
	{ -2306.4599609375,-1577.9638671875,480.70935058594, false },
	{ -2325.873046875,-1574.3349609375,482.96325683594, false },
	{ -2338.68359375,-1584.82421875,484.15582275391, false },
	{ -2338.953125,-1614.5341796875,484.29489135742, false },
	{ -2338.953125,-1614.5341796875,484.29489135742, true },	
}

local inisRotaBaslangic={	
	{ -2330.4169921875,-1647.6591796875,483.703125, 2 },

	{-2310.0703125,-1685.685546875,482.63809204102, false },
	{ -2282.7197265625,-1739.01171875,465.66842651367, false },
	{ -2329.203125,-1812.265625,436.55184936523, false },
	{ -2433.470703125,-1723.9736328125,434.57015991211, false },
	{ -2437.1298828125,-1804.8203125,411.30374145508, false },
	{ -2516.9345703125,-1740.2607421875,402.61682128906, false },
}
local inisRotaOrta2={
	{-2540.0556640625,-1676.1064453125,401.02813720703, false }, 
	{-2548.5576171875,-1662.017578125,400.26177978516, false },
	{-2561.31640625,-1740.01171875,386.37893676758, false },
	{-2527.474609375,-1803.00390625,376.6091003418, false },
	{-2584.400390625,-1723.0888671875,350.47515869141, false },
	{-2597.5537109375,-1617.6259765625,343.10641479492, false },
	{-2668.5263671875,-1558.365234375,307.03088378906, false },
	{-2708.8515625,-1512.9462890625,299.79956054688, false },
	{-2674.822265625,-1384.7958984375,254.15313720703 , false },
}
local inisRotaOrta1={
	{-2524.04296875,-1669.5947265625,402.45086669922, false }, 	
	{-2494.0478515625,-1553.337890625,395.45977783203, false },
	{ -2475.0546875,-1476.05859375,391.31323242188, false },
	{-2333.7783203125,-1451.2861328125,383.1091003418, false },
	{-2253.6181640625,-1492.53125,379.44784545898, false },
	{ -2206.5234375,-1720.7177734375,377.32278442383, false },
	{-2194.85546875,-1560.3828125,362.34460449219, false },
	{-2223.27734375,-1483.365234375,358.83685302734, false },
	{ -2262.58203125,-1429.2255859375,356.26498413086, false },
	{ -2416.3583984375,-1390.8701171875,359.7600402832, false },
	{ -2548.4541015625,-1495.8759765625,359.6650390625, false },
	{-2569.80078125,-1463.5595703125,359.03707885742, false },
	{-2415.095703125,-1352.0703125,337.22668457031, false },
	{-2334.154296875,-1295.3994140625,310.13323974609, false },
	{ -2509.1435546875,-1270.5400390625,273.39309692383, false },
	{ -2624.8837890625,-1362.345703125,262.92672729492, false },
}
local inisRotaOrtaDevam={
	{ -2669.669921875,-1371.83984375,252.85862731934, false },
	{ -2608.30078125,-1281.85546875,220.53396606445, false },
	{ -2610.486328125,-1188.7763671875,197.64692687988, false },
	{ -2551.4267578125,-1132.15234375,175.16915893555, false },
	{ -2631.91796875,-1163.923828125,169.03698730469, false },
	{ -2726.3603515625,-1288.6455078125,153.31872558594, false },
	{ -2757.3291015625,-1438.7509765625,140.77252197266, false },
	{ -2769.4169921875,-1606.1162109375,141.92724609375, false },
	{ -2784.7392578125,-1736.3544921875,142.31185913086, false },
	{ -2766.0185546875,-1847.0048828125,142.47947692871, false },
	{ -2698.1767578125,-1878.287109375,138.26725769043, false },
	{ -2655.919921875,-1954.603515625,128.23176574707, false },
	{ -2625.0224609375,-2062.8984375,130.62017822266, false },
	{ -2583.123046875,-2082.0498046875,132.00834655762, false },
	{ -2486.951171875,-2078.259765625,125.62312316895, false },
	{ -2362.7705078125,-2105.6142578125,114.48916625977, false },
	{ -2258.310546875,-2076.400390625,120.69970703125, false },
	{ -2199.9931640625,-2026.3662109375,120.20796203613, false },
	{ -2143.64453125,-1960.0390625,118.75916290283, false },
	{ -2114.8046875,-1889.978515625,112.14151000977, false },
	{ -2101.955078125,-1895.0791015625,110.10572814941, false },
	{ -2131.185546875,-1980.8544921875,98.153060913086, false },
	{ -2161.375,-2035.8857421875,93.121391296387, false },
	{ -2219.2919921875,-2100.8330078125,74.64998626709, false },
	{ -2261.8046875,-2138.4326171875,58.821960449219, false },
	{ -2310.3681640625,-2164.9609375,41.926010131836, false },
	{ -2347.14453125,-2195.037109375,33.640453338623, false },
	{ -2347.4697265625,-2240.2197265625,19.208047866821, false },
	{ -2335.8544921875,-2267.046875,19.477848052979, false },
	{ -2315.4189453125,-2291.802734375,22.85719871521, false },
	{ -2251.806640625,-2328.931640625,30.024919509888, false },	
	{ -2206.494140625,-2358.3046875,31.21021270752, false },		
	{ -2159.7197265625,-2403.4033203125,31.053598403931, false },	
	{ -2089.357421875,-2459.3564453125,31.051103591919, false },
}
local inisRotaSon1={
	{ -1996.3515625,-2531.470703125,35.814502716064, false },
	{ -1942.095703125,-2584.5400390625,40.655086517334, false },
	{ -1901.7626953125,-2677.09375,53.401950836182, false },
	{ -1877.275390625,-2696.5517578125,54.676586151123, false },
	{ -1794.626953125,-2678.0849609375,53.949863433838, false },
	{ -1716.6650390625,-2694.7880859375,47.759952545166, false },
	{ -1669.541015625,-2721.6015625,47.507675170898, false },
	{ -1628.25390625,-2754.0849609375,47.504806518555, false },
	{ -1579.0595703125,-2797.2705078125,47.508377075195, false },
	{ -1527.177734375,-2847.19921875,47.508575439453, false },
	{ -1486.9404296875,-2870.994140625,47.669040679932, false },
}
local inisRotaSon2={
	{-2016.109375,-2498.7421875,32.452754974365,false},
	{-1918.5263671875,-2440.6357421875,30.330183029175,false},
	{-1829.5009765625,-2349.76171875,32.234424591064,false},
	{-1769.2958984375,-2317.615234375,41.85343170166,false},
	{-1710.4453125,-2298.5859375,44.803512573242,false},
	{-1672.7626953125,-2209.625,34.170555114746,false},
	{-1607.3076171875,-2158.662109375,21.701471328735,false},
	{-1471.7822265625,-2155.96484375,2.4297981262207,false},
	{-1390.50390625,-2170.6435546875,20.124383926392,false},
	{-1304.3125,-2206.5009765625,22.200008392334,false},
	{-1247.396484375,-2305.1845703125,19.699695587158,false},
	{-1164.1044921875,-2364.7041015625,21.624576568604,false},
	{-1039.91015625,-2377.61328125,53.196918487549,false},
	{-987.0791015625,-2366.7890625,65.377960205078,false},
	{-898.4443359375,-2386.26953125,52.58207321167,false},
	{-801.107421875,-2467.3837890625,77.586837768555,false},
	{-757.265625,-2431.697265625,66.07926940918,false},
	{-708.6572265625,-2351.8359375,40.534526824951,false},
	{-590.103515625,-2379.802734375,27.462697982788,false},
	{-658.1259765625,-2477.23828125,34.083080291748,false},
	{-689.4326171875,-2566.9150390625,57.432117462158,false},
	{-719.4501953125,-2623.146484375,76.615585327148,false},
	{-766.970703125,-2683.095703125,83.899261474609,false},
	{-844.0419921875,-2679.2470703125,96.886566162109,false},
	{-902.76953125,-2666.857421875,90.183570861816,false},
	{-1016.6240234375,-2683.05078125,52.462749481201,false},
	{-1121.6328125,-2659.1103515625,16.333745956421,false},
	{-1227.8369140625,-2636.24609375,9.1158494949341,false},
	{-1374.7939453125,-2631.0966796875,28.907989501953,false},
	{-1441.0390625,-2629.7978515625,34.794597625732,false},
	{-1474.0859375,-2645.2744140625,43.863876342773,false},
	{-1445.2587890625,-2707.6552734375,59.074153900146,false},
	{-1444.392578125,-2776.484375,61.329669952393,false},
	{-1439.6318359375,-2843.4130859375,48.174922943115,false},
}
local inisRotaFinal={
	{ -1471.4326171875,-2854.306640625,48.200572967529, false },
	{ -1482,-2821.4013671875,48.434745788574, false },
	{ -1508.5244140625,-2762.2265625,49.126731872559, false },
	{ -1544.14453125,-2720.2783203125,49.122200012207, false },
	{ -1565.37890625,-2708.3935546875,49.123584747314, false },
	{ -1591.3115234375,-2716.9169921875,49.122539520264, true, true },
	
}

function rotaOlustur()
	local cikisRotaOrta=cikisRotaOrta1
	local sans = math.random(1,5)
	if sans==2 then 
		cikisRotaOrta=cikisRotaOrta2
	end

	local inisRotaOrta=inisRotaOrta1
	sans = math.random(1,3)
	if sans==2 then 
		inisRotaOrta=inisRotaOrta2
	end

	local inisRotaSon=inisRotaSon2
	sans = math.random(1,5)
	if sans==2 then 
		inisRotaSon=inisRotaSon1
	end


	tirRota2 = {}
	for _, adim in ipairs(cikisRotaBaslangic) do
		table.insert(tirRota2, adim)
	end
	for _, adim in ipairs(cikisRotaOrta) do
		table.insert(tirRota2, adim)
	end
	for _, adim in ipairs(cikisRotaSon) do
		table.insert(tirRota2, adim)
	end	
	for _, adim in ipairs(inisRotaBaslangic) do
		table.insert(tirRota2, adim)
	end
	for _, adim in ipairs(inisRotaOrta) do
		table.insert(tirRota2, adim)
	end
	for _, adim in ipairs(inisRotaOrtaDevam) do
		table.insert(tirRota2, adim)
	end
	for _, adim in ipairs(inisRotaSon) do
		table.insert(tirRota2, adim)
	end
	for _, adim in ipairs(inisRotaFinal) do
		table.insert(tirRota2, adim)
	end
end


function onPlayerEnterTruck(thePlayer, seat)
	if thePlayer ~= getLocalPlayer() then return end
	if seat ~= 0 then return end
	if getElementData(localPlayer, "job") ~= 10 then return end
	if getElementData(localPlayer, "tirSoforlugu") then return end
	local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
	
	local oyuncuAracModel = getElementModel(oyuncuArac)
	if oyuncuAracModel == tirModelID then		
		if getElementData(oyuncuArac, "job")~= 10 then 
			outputChatBox("[!] #FFFFFFÖzel araç ile tır mesleği yapabilmek için meslek bölgesinde /tirbasla yazmanız gerekmektedir!", 255, 0, 0, true)
		return end
		rotaOlustur()
		outputChatBox("[!] #FFFFFFDorsenizi alıp yola koyulabilirsiniz, Yolunuz açık olsun!", 255, 0, 0, true)
		setElementData(localPlayer, "tirSoforlugu", true)
		updateTirRota2()
		addEventHandler("onClientMarkerHit", resourceRoot, tirRotaMarkerHit2)
	end
end
addEventHandler("onClientVehicleEnter", root, onPlayerEnterTruck)

function tirBasla(cmd)
	
	local seat = getPedOccupiedVehicleSeat(localPlayer)	
    if seat ~= 0 then return end
	
    if getElementData(localPlayer, "job") ~= 10 then return end
	if getElementData(localPlayer, "tirSoforlugu") then return end
	
    local px, py, pz = getElementPosition(localPlayer)
    local dist = getDistanceBetweenPoints3D(px, py, pz, -1536, -2762, 49)
    if dist > 40 then
        outputChatBox("[!] #FFFFFFBu işlem için meslek bölgesine gidin!", 255, 0, 0, true)
        return
    end
    if getElementData(localPlayer, "tirSoforlugu") then return end
    local oyuncuArac = getPedOccupiedVehicle(localPlayer)
    if not oyuncuArac then return end
    local oyuncuAracModel = getElementModel(oyuncuArac)
    if oyuncuAracModel == tirModelID then
        rotaOlustur()
        outputChatBox("[!] #FFFFFFDorsenizi alıp yola koyulabilirsiniz, Herhangi bir anda /tirbitir yazarak mesleği bitirebilirsiniz!", 255, 0, 0, true)
        setElementData(localPlayer, "tirSoforlugu", true)
        updateTirRota2()
        addEventHandler("onClientMarkerHit", resourceRoot, tirRotaMarkerHit2)
    end
end
addCommandHandler("tirbasla", tirBasla)


function onTirTrailerAttach(trailer, couplingIndex)
	local veh=getPedOccupiedVehicle(localPlayer)
	if not isElement(veh) then return end
	if trailer ~= veh then return end
    if getElementModel(veh) ~= tirModelID then return end
	
    if getElementData(localPlayer, "job") ~= 10 then return end
	triggerServerEvent("tirDepozitoParaVer", localPlayer, localPlayer)
    outputChatBox("[!] #00FF00Dorse başarıyla takıldı, rotanı takip etmeye başlayabilirsin!", 255,255,255, true)

end
addEventHandler("onClientTrailerAttach", root, onTirTrailerAttach)


function updateTirRota2()
	tirMarker = tirMarker + 1
	for i,v in ipairs(tirRota2) do
		if i == tirMarker then
			if v[4] == 2 then
				local theMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255)
				table.insert(tirCreatedMarkers, { theMarker, 2 })
			elseif v[4] == 1 and v[5] == 0 then
				local dorseMarker1 = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255)
				table.insert(tirCreatedMarkers, { dorseMarker1, 1, 0 })
			elseif v[4] == 1 and v[5] == 1 then
				local dorseMarker2 = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255)
				table.insert(tirCreatedMarkers, { dorseMarker2, 1, 1 })
			elseif not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255)
				table.insert(tirCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255)
				table.insert(tirCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255)
				table.insert(tirCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

warned=false
function tirRotaMarkerHit2(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == tirModelID then
				for _, marker in ipairs(tirCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == 2 then
							destroyElement(source)
							updateTirRota2()
						elseif marker[2] == 1  and marker[3] == 1 then
							triggerServerEvent("tirBenzinParaVer", hitPlayer, hitPlayer)
							destroyElement(source)
							updateTirRota2()
						elseif marker[2] == false then
							if getVehicleTowedByVehicle(hitVehicle) then					
								destroyElement(source)
								updateTirRota2()
							end
						elseif marker[2] == true and marker[3] == true then
							if getVehicleTowedByVehicle(hitVehicle) then
								local hitVehicle = getPedOccupiedVehicle(hitPlayer)
								tirMarker = 0
								triggerServerEvent("tirDepozitoIade", hitPlayer, hitPlayer)
								triggerServerEvent("tirParaVer2", hitPlayer, hitPlayer)
								detachTrailerFromVehicle(hitVehicle)
								destroyElement(source)
								tirBitir2()
							end
						elseif marker[2] == true and marker[3] == false then
							if getVehicleTowedByVehicle(hitVehicle) then
								local hitVehicle = getPedOccupiedVehicle(hitPlayer)
								setElementFrozen(hitPlayer, true)
								setElementFrozen(hitVehicle, true)
								toggleAllControls(false, true, false)
								outputChatBox("[!] #FFFFFFAracınızın dorsesi indiriliyor, lütfen bekleyiniz.", 0, 0, 255, true)
								setTimer(
									function(thePlayer, hitVehicle, hitMarker)
										destroyElement(hitMarker)
										local trailer = getVehicleTowedByVehicle(hitVehicle)
										detachTrailerFromVehicle(hitVehicle)
										triggerServerEvent("tirDepozitoIade", hitPlayer, hitPlayer)
										outputChatBox("[!] #FFFFFFDorseniz indirilmiştir, İşi tamamlamak için dorse alıp geri dönebilirsiniz.", 0, 255, 0, true)
										setElementFrozen(hitVehicle, false)
										setElementFrozen(thePlayer, false)
										toggleAllControls(true)
										updateTirRota2()
									end, 12000, 1, hitPlayer, hitVehicle, source
								)	
							end
						end
					end
				end
			end
		end
	end
end


function tirBitir2()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local tirSoforlugu = getElementData(getLocalPlayer(), "tirSoforlugu")
	if pedVeh then
		if pedVehModel == tirModelID then
			if tirSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "tirSoforlugu", false)
				for i,v in ipairs(tirCreatedMarkers) do
					destroyElement(v[1])
				end
				tirCreatedMarkers = {}
				tirMarker = 0
				triggerServerEvent("tirBitir2", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, tirRotaMarkerHit2)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), tirAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("tirbitir", tirBitir2)

function tirAntiYabanci2(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == tirModelID and vehicleJob == 10 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 10 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Tır Şoförlüğü mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		cancelEvent()
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), tirAntiYabanci2)

function tirAntiAracTerketme2(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if getElementData(theVehicle, "job")~= 10 then return end
		if seat == 0 then
			tirBitir2()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), tirAntiAracTerketme2)

function tirBlip()
	blip = createBlip(-1548.6728515625, -2737.4638671875, 48.539730072021, 0, 4, 255, 255, 0)  --0 0 1787.1259765625 -1903.591796875 13.394536972046
	exports.hud:sendBottomNotification(localPlayer, "Tır Şoförü", "Haritadaki sarı işarete giderek tir şoförlüğü mesleğinize başlayabilirsiniz.")
end