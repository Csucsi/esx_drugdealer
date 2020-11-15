ESX = nil;
local price = 1000; -- Price of goods, it can be changed. 
local quantity = 5; -- quantity of goods 
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end);

RegisterNetEvent('rl-drugdealer:buyspeed')
AddEventHandler('rl-drugdealer:buyspeed', function()
local xPlayer = ESX.GetPlayerFromId(source);
local xPlayer_job = xPlayer.getJob();
	if xPlayer.canCarryItem('speed', quantity) then
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price);
			xPlayer.addInventoryItem('speed', quantity);
			TriggerClientEvent('rl-drugdealer:limiter', source);
			xPlayer.showNotification("~g~You~w~ received the ~g~goods~w~!");
		else
			xPlayer.showNotification("~r~You do not have enough money!");
		end
	else
		xPlayer.showNotification("Your inventory is full");
	end
end)
RegisterNetEvent('rl-drugdealer:buylsd')
AddEventHandler('rl-drugdealer:buylsd', function()
local xPlayer = ESX.GetPlayerFromId(source);
local xPlayer_job = xPlayer.getJob();
	if xPlayer.canCarryItem('lsd', quantity) then
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price);
			xPlayer.addInventoryItem('lsd', quantity);
			TriggerClientEvent('rl-drugdealer:limiter', source);
			xPlayer.showNotification("~g~You~w~ received the ~g~goods~w~!");
		else
			xPlayer.showNotification("~r~You do not have enough money!");
		end
	else
		xPlayer.showNotification("Your inventory is full");
	end
end)
RegisterNetEvent('rl-drugdealer:buyecstasy')
AddEventHandler('rl-drugdealer:buyecstasy', function()
local xPlayer = ESX.GetPlayerFromId(source);
	if xPlayer.canCarryItem('ecstasy', quantity) then
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price);
			xPlayer.addInventoryItem('ecstasy', quantity);
			TriggerClientEvent('rl-drugdealer:limiter', source);
			xPlayer.showNotification("~g~You~w~ received the ~g~goods~w~!");
		else
			xPlayer.showNotification("~r~You do not have enough money!");
		end
	else
		xPlayer.showNotification("Your inventory is full");
	end
end)
--Checking the job on server-side, it can be checked on client-side too. 
RegisterNetEvent('rl-drugdealer:checkjob')
AddEventHandler('rl-drugdealer:checkjob', function()
	local xPlayer = ESX.GetPlayerFromId(source);
	if xPlayer.getJob().name == "kind" then
		TriggerClientEvent('rl-drugdealer:kindjob', source);
	else
		TriggerClientEvent('rl-drugdealer:notkindjob', source);
	end
end)