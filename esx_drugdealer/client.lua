ESX = nil;
local ped = nil;
local isNear = false;
local resource_name = "esx_drugdealer";
local isPurchased = false;

-- Threads

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end);
		Wait(5000);
	end
end)

-- Creating ped
CreateThread(function()
	local ped_hash = GetHashKey('s_m_y_dealer_01'); -- Ped Type
	
	RequestModel(ped_hash);
	while not HasModelLoaded(ped_hash) do
		Wait(100);
	end
	ped = CreatePed(4,ped_hash,-1464.01,-639.06,28.58 ,223.46, false, true); --Creating the ped with fixed coords
	SetEntityAsMissionEntity(ped, false, false);
	FreezeEntityPosition(ped, true);
	SetBlockingOfNonTemporaryEvents(ped, true);
	SetEntityInvincible(ped, true);
	SetPedCanRagdoll(ped, false);
	SetEntityVisible(ped, true);
	SetEntityCollision(ped, true);
end)
--Checking the distance between the player and the ped
CreateThread(function()
	while true do
		Wait(1000);
		local player_ped = PlayerPedId();
		if GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(player_ped), true) < 2.5 then
			if not isNear then
				isNear = true;
			end
		else
			if isNear then
				isNear = false;
			end
		end
	end
end)

CreateThread(function()
	while true do
		if isNear then
			DrawText3Ds(-1464.01,-639.06,30.58, "~r~NPC");
			DrawText3Ds(-1464.01,-639.06,29.58, "Press ~g~[E]~s~ to buy goods");
			if IsControlJustReleased(0, 38) then
				if not isPurchased then 
					TriggerServerEvent('esx_drugdealer:checkjob')
				else
					exports.pNotify:SendNotification({layout = "topCenter", text = "You have to wait to buy again..", type = "error", timeout = 5000})
				end
			end
			Wait(5);
		else
			Wait(1000);
		end
	end
end)

--Functions

function buySpeed()
	TriggerServerEvent('esx_drugdealer:buyspeed')
end

function buyLSD()
	TriggerServerEvent('esx_drugdealer:buylsd')
end

function buyEcstasy()
	TriggerServerEvent('esx_drugdealer:buyecstasy')
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z);
	if onScreen then
		SetTextScale(0.35, 0.35);
		SetTextFont(4);
		SetTextProportional(1);
		SetTextColour(255, 255, 255, 215);
		SetTextEntry("STRING");
		SetTextCentre(1);
		AddTextComponentString(text);
		DrawText(_x,_y);
	end
end

function MenuDrugs()
	local elements = {}
		table.insert(elements, {label = '5 Speed', value = '1'})
		table.insert(elements, {label = '5 LSD', value = '2'})
		table.insert(elements, {label = '5 Ecstasy', value = '3'})
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'drugmenu',
		{
			title    = "Drugdealer",
			elements = elements
		},
		function(data, menu)	
			if data.current.value == '1' then 
				buySpeed();
			elseif data.current.value == '2' then 
				buyLSD();
			elseif data.current.value == '3' then 
				buyEcstasy();
			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
	end)
end

function Limiter()
	isPurchased = true;
	SetTimeout(600000,function()
		isPurchased = false;
	end)
end

-- Events
AddEventHandler('onResourceStop', function(resource_name)
	if GetCurrentResourceName() ~= resource_name then
		return 
	else
		ESX.UI.Menu.CloseAll();
		print("Stucking in the menus has been prevented.")
	end
end)
RegisterNetEvent('esx_drugdealer:kindjob')
AddEventHandler('esx_drugdealer:kindjob', function()
	MenuDrugs();
end)
RegisterNetEvent('esx_drugdealer:notkindjob')
AddEventHandler('esx_drugdealer:notkindjob', function()
	ESX.ShowNotification("~r~You are not in right faction!")
end)
RegisterNetEvent('esx_drugdealer:limiter')
AddEventHandler('esx_drugdealer:limiter', function()
	Limiter();
end)