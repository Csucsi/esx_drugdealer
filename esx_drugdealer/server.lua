ESX = nil;
local price = 1000; -- Price of goods, it can be changed. 
local quantity = 5; -- quantity of goods 
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end);

RegisterNetEvent('esx_drugdealer:buyspeed')
AddEventHandler('esx_drugdealer:buyspeed', function()
local xPlayer = ESX.GetPlayerFromId(source);
local xPlayer_job = xPlayer.getJob();
	if xPlayer.canCarryItem('speed', quantity) then
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price);
			xPlayer.addInventoryItem('speed', quantity);
			TriggerClientEvent('esx_drugdealer:limiter', source);
			xPlayer.showNotification("~g~You~w~ received the ~g~goods~w~!");
		else
			xPlayer.showNotification("~r~You do not have enough money!");
		end
	else
		xPlayer.showNotification("Your inventory is full");
	end
end)
RegisterNetEvent('esx_drugdealer:buylsd')
AddEventHandler('esx_drugdealer:buylsd', function()
local xPlayer = ESX.GetPlayerFromId(source);
local xPlayer_job = xPlayer.getJob();
	if xPlayer.canCarryItem('lsd', quantity) then
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price);
			xPlayer.addInventoryItem('lsd', quantity);
			TriggerClientEvent('esx_drugdealer:limiter', source);
			xPlayer.showNotification("~g~You~w~ received the ~g~goods~w~!");
		else
			xPlayer.showNotification("~r~You do not have enough money!");
		end
	else
		xPlayer.showNotification("Your inventory is full");
	end
end)
RegisterNetEvent('esx_drugdealer:buyecstasy')
AddEventHandler('esx_drugdealer:buyecstasy', function()
local xPlayer = ESX.GetPlayerFromId(source);
	if xPlayer.canCarryItem('ecstasy', quantity) then
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price);
			xPlayer.addInventoryItem('ecstasy', quantity);
			TriggerClientEvent('esx_drugdealer:limiter', source);
			xPlayer.showNotification("~g~You~w~ received the ~g~goods~w~!");
		else
			xPlayer.showNotification("~r~You do not have enough money!");
		end
	else
		xPlayer.showNotification("Your inventory is full");
	end
end)
--Checking the job on server-side, it can be checked on client-side too. 
RegisterNetEvent('esx_drugdealer:checkjob')
AddEventHandler('esx_drugdealer:checkjob', function()
	local xPlayer = ESX.GetPlayerFromId(source);
	if xPlayer.getJob().name == "kind" then
		TriggerClientEvent('esx_drugdealer:kindjob', source);
	else
		TriggerClientEvent('esx_drugdealer:notkindjob', source);
	end
end)