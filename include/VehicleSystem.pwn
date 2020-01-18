	#include <a_samp>
	#include <streamer>
	#include <a_mysql>
	#include <SimpleFuel>
	
	#include "../vehicles/SAPDVeh.pwn"
	 
	#define DEALER_VEHICLE 1
	#define MAX_DVEHICLES 2000
	#define MAX_FSTATIONS 200
	#define DEFAULT_VEHICLE_OWNER "Dealership"
	#define DEFAULT_SELL_PRICE 50000
	
	#define FUEL_PRICE 250
	#define FUEL_AREA_RADIUS 3.0
	
	#define	COLOR_YELLOW	0xFFFF00AA
	#define COLOR_GREY		0xAFAFAFAA
	 
	enum vehicleinfo
	{
		vID,
		vDealer,
        vOwner[25],
        vModel,
        vPrice,
        Float: vPos[4],
        vColor1,
        vColor2,
		vFuel,
		vLocked,
        Text3D:Label
	}
	new vInfo[MAX_DVEHICLES][vehicleinfo];
	new VehicleID[MAX_DVEHICLES];
	new DSV[40];
	new vSpawned[MAX_DVEHICLES];
	new currentspeed[MAX_PLAYERS];
	
	enum gauges
	{
		Text: speed,
		Text: fuel,
	}
	new vSpeed[MAX_PLAYERS][gauges];
	
	enum fuelinfo
	{
		fID,
		Float: fPos[4],
		Text3D: Label
	}
	new fInfo[MAX_FSTATIONS][fuelinfo];
	new FuelTimer[MAX_VEHICLES];
	new RefuelTimer[MAX_VEHICLES];
	new RefuelCost[MAX_PLAYERS];
	new FuelPickup[MAX_FSTATIONS];
	new FuelArea[MAX_FSTATIONS] = -1;
	new LoadedDealershipVehicles = 0;
	
	new VehicleNames[][] =
	{
		"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
		"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
		"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
		"Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
		"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
		"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
		"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
		"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
		"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
		"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
		"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
		"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
		"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
		"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
		"Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
		"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
		"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
		"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
		"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
		"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
		"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
		"Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
		"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
		"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
		"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
		"Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
		"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
		"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
		"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
		"Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
		"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
		"Tiller", "Utility Trailer"
	};
	
	forward Speedometer(playerid);
	
Load_SpeedoG()
{
	SetTimer("Speedometer", 100, true);
}
	
Load_SpeedoC(playerid)
{
	vSpeed[playerid][speed] = TextDrawCreate(545.0, 400.0, " ");
	TextDrawShowForPlayer(playerid, vSpeed[playerid][speed]);
	TextDrawUseBox( vSpeed[playerid][speed], 1);
	
	vSpeed[playerid][fuel] = TextDrawCreate(545.0, 415.0, " ");
	TextDrawShowForPlayer(playerid, vSpeed[playerid][fuel]);
	TextDrawUseBox( vSpeed[playerid][fuel], 1);
}

Load_Vehicles()
{
		new vehicleid = 100;
        new Query[512], savestr[25], rows, fields, count = 0;
        for(new i = 0; i < MAX_DVEHICLES; i++)
        {
                mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `Vehicles` WHERE `ID` = '%d'", i);
                mysql_query(dbHandle,Query);
				cache_get_data(rows, fields);
                if(rows)
                {
					cache_get_field_content(0, "ID", savestr);				vInfo[vehicleid][vID] = strval(savestr);
					cache_get_field_content(0, "Dealer", savestr);			vInfo[vehicleid][vDealer] = strval(savestr);
                    cache_get_field_content(0, "Owner", savestr);           vInfo[vehicleid][vOwner] = savestr;
                    cache_get_field_content(0, "Model", savestr);           vInfo[vehicleid][vModel] = strval(savestr);
                    cache_get_field_content(0, "Price", savestr);           vInfo[vehicleid][vPrice] = strval(savestr);
                    cache_get_field_content(0, "PosX", savestr);            vInfo[vehicleid][vPos][0] = floatstr(savestr);
                    cache_get_field_content(0, "PosY", savestr);            vInfo[vehicleid][vPos][1] = floatstr(savestr);
                    cache_get_field_content(0, "PosZ", savestr);            vInfo[vehicleid][vPos][2] = floatstr(savestr);
                    cache_get_field_content(0, "PosA", savestr);            vInfo[vehicleid][vPos][3] = floatstr(savestr);
                    cache_get_field_content(0, "Color1", savestr);          vInfo[vehicleid][vColor1] = strval(savestr);
                    cache_get_field_content(0, "Color2", savestr);          vInfo[vehicleid][vColor2] = strval(savestr);
					cache_get_field_content(0, "Fuel", savestr);			vInfo[vehicleid][vFuel] = strval(savestr);
					cache_get_field_content(0, "Locked", savestr);			vInfo[vehicleid][vLocked] = strval(savestr);
					VehicleID[vehicleid] = AddStaticVehicleEx(vInfo[vehicleid][vModel], vInfo[vehicleid][vPos][0], vInfo[vehicleid][vPos][1], vInfo[vehicleid][vPos][2], vInfo[vehicleid][vPos][3], vInfo[vehicleid][vColor1], vInfo[vehicleid][vColor2], 60000);
					vSpawned[vehicleid] = 1;
					vInfo[vehicleid][vFuel] = 100;
					count++;
					vehicleid++;
                }
        }
		print("----------------------------------");
		printf("Loaded: %i Player Vehicles", count);
		print("----------------------------------");
}

Load_Vehicle(vehicleid)
{
        new Query[512], savestr[25], rows, fields, count = 0;
        mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `Vehicles` WHERE `ID` = '%d'", vehicleid);
        mysql_query(dbHandle,Query);
		cache_get_data(rows, fields);
        if(rows)
        {
			cache_get_field_content(0, "ID", savestr);				vInfo[vehicleid][vID] = strval(savestr);
			cache_get_field_content(0, "Dealer", savestr);			vInfo[vehicleid][vDealer] = strval(savestr);
            cache_get_field_content(0, "Owner", savestr);           vInfo[vehicleid][vOwner] = savestr;
            cache_get_field_content(0, "Model", savestr);           vInfo[vehicleid][vModel] = strval(savestr);
            cache_get_field_content(0, "Price", savestr);           vInfo[vehicleid][vPrice] = strval(savestr);
            cache_get_field_content(0, "PosX", savestr);            vInfo[vehicleid][vPos][0] = floatstr(savestr);
            cache_get_field_content(0, "PosY", savestr);            vInfo[vehicleid][vPos][1] = floatstr(savestr);
            cache_get_field_content(0, "PosZ", savestr);            vInfo[vehicleid][vPos][2] = floatstr(savestr);
            cache_get_field_content(0, "PosA", savestr);            vInfo[vehicleid][vPos][3] = floatstr(savestr);
            cache_get_field_content(0, "Color1", savestr);          vInfo[vehicleid][vColor1] = strval(savestr);
            cache_get_field_content(0, "Color2", savestr);          vInfo[vehicleid][vColor2] = strval(savestr);
			cache_get_field_content(0, "Fuel", savestr);			vInfo[vehicleid][vFuel] = strval(savestr);
			cache_get_field_content(0, "Locked", savestr);			vInfo[vehicleid][vLocked] = strval(savestr);
			VehicleID[vehicleid] = AddStaticVehicleEx(vInfo[vehicleid][vModel], vInfo[vehicleid][vPos][0], vInfo[vehicleid][vPos][1], vInfo[vehicleid][vPos][2], vInfo[vehicleid][vPos][3], vInfo[vehicleid][vColor1], vInfo[vehicleid][vColor2], 60000);
			vSpawned[vehicleid] = 1;
			count++;
        }
}

Load_DealershipVehicles()
{
        new Query[512], savestr[25], rows, fields, count = 0;
        for(new i = 1; i < MAX_DVEHICLES; i++)
        {
                mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `DVehicles` WHERE `ID` = '%d'", i);
                mysql_query(dbHandle,Query);
				cache_get_data(rows, fields);
                if(rows)
                {
					cache_get_field_content(0, "ID", savestr);				vInfo[i][vID] = strval(savestr);
					cache_get_field_content(0, "Dealer", savestr);			vInfo[i][vDealer] = strval(savestr);
                    cache_get_field_content(0, "Owner", savestr);           vInfo[i][vOwner] = savestr;
                    cache_get_field_content(0, "Model", savestr);           vInfo[i][vModel] = strval(savestr);
                    cache_get_field_content(0, "Price", savestr);           vInfo[i][vPrice] = strval(savestr);
                    cache_get_field_content(0, "PosX", savestr);            vInfo[i][vPos][0] = floatstr(savestr);
                    cache_get_field_content(0, "PosY", savestr);            vInfo[i][vPos][1] = floatstr(savestr);
                    cache_get_field_content(0, "PosZ", savestr);            vInfo[i][vPos][2] = floatstr(savestr);
                    cache_get_field_content(0, "PosA", savestr);            vInfo[i][vPos][3] = floatstr(savestr);
                    cache_get_field_content(0, "Color1", savestr);          vInfo[i][vColor1] = strval(savestr);
                    cache_get_field_content(0, "Color2", savestr);          vInfo[i][vColor2] = strval(savestr);
						
					VehicleID[i] = AddStaticVehicleEx(vInfo[i][vModel], vInfo[i][vPos][0], vInfo[i][vPos][1], vInfo[i][vPos][2], vInfo[i][vPos][3], vInfo[i][vColor1], vInfo[i][vColor2], 10);
					new labeltext[128];
					format(labeltext, sizeof(labeltext), "Price: R%d", vInfo[i][vPrice]);
					vInfo[i][Label] = Create3DTextLabel(labeltext, 0xBB7700DD, 0, 0, 0, 10.0, 0, 0);
					Attach3DTextLabelToVehicle(vInfo[i][Label], VehicleID[i], 0, 0, 0);
					count++;
					LoadedDealershipVehicles++;
                }
        }
		print("----------------------------------");
		printf("Loaded: %i Dealership Vehicles", count);
		print("----------------------------------");
}

stock Destroy_DealershipVehicles()
{
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(vInfo[i][vDealer] == 1)
		{
			DestroyVehicle(VehicleID[i]);
			Delete3DTextLabel(vInfo[i][Label]);
		}
	}
	LoadedDealershipVehicles = 0;
}

stock Destroy_Vehicles()
{
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		DestroyVehicle(VehicleID[i]);
	}
}

stock Load_FuelStations()
{
	new Query[512], savestr[25], rows, fields, count = 0;
    for(new i = 1; i < MAX_FSTATIONS; i++)
    {
        mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `Fuelstations` WHERE `ID` = '%d'", i);
        mysql_query(dbHandle,Query);
		cache_get_data(rows, fields);
        if(rows)
        {
			cache_get_field_content(0, "ID", savestr);				fInfo[i][fID] = strval(savestr);
			cache_get_field_content(0, "PosX", savestr);			fInfo[i][fPos][0] = floatstr(savestr);
            cache_get_field_content(0, "PosY", savestr);           	fInfo[i][fPos][1] = floatstr(savestr);
			cache_get_field_content(0, "PosZ", savestr);          	fInfo[i][fPos][2] = floatstr(savestr);
			count++;

			Create_FuelStation(i);
        }
    }
	print("----------------------------------");
	printf("Loaded: %i Fuel Stations", count);
	print("----------------------------------");
}

stock Create_FuelStation(fid)
{
	FuelPickup[fid] = CreateDynamicPickup(1244, 0, fInfo[fid][fPos][0], fInfo[fid][fPos][1], fInfo[fid][fPos][2], 0);
	fInfo[fid][Label] = CreateDynamic3DTextLabel("Fuel Station", COLOR_YELLOW, fInfo[fid][fPos][0], fInfo[fid][fPos][1], fInfo[fid][fPos][2]+0.7,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1);
	FuelArea[fid] = CreateDynamicCircle(fInfo[fid][fPos][0], fInfo[fid][fPos][1], FUEL_AREA_RADIUS);
}

stock Destroy_FuelStation()
{
	for(new i = 1; i < MAX_FSTATIONS; i++)
	{
		DestroyDynamicPickup(FuelPickup[i]);
		DestroyDynamic3DTextLabel(vInfo[i][Label]);
	}
}

Save_Vehicles()
{
	for(new i = 1; i < MAX_DVEHICLES; i++)
	{
		new Query[528];
		
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Vehicles` SET `Color1` = '%d', `Color2` = '%d', `Fuel` = '%d', `Locked` = '%d' WHERE `ID` = '%d'",
		vInfo[i][vColor1],
		vInfo[i][vColor2],
		vInfo[i][vFuel],
		vInfo[i][vLocked],
		i);
		mysql_query(dbHandle,Query,false);
	}
}

Save_Vehicle(vehicleid)
{
	new Query[528];
	
	mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Vehicles` SET `Color1` = '%d', `Color2` = '%d', `Fuel` = '%d', `Locked` = '%d' WHERE `ID` = '%d'",
	vInfo[vehicleid][vColor1],
	vInfo[vehicleid][vColor2],
	vInfo[vehicleid][vFuel],
	vInfo[vehicleid][vLocked],
	vehicleid);
	mysql_query(dbHandle,Query,false);
}

stock IsADSV(carid)
{
	for(new v = 0; v < sizeof(DSV); v++) {
	    if(carid == DSV[v]) return 1;
	}
	return 0;
}
 
GetVehicleID(vehicleid)
{
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(VehicleID[i] == vehicleid) return i;
	}
	return 0;
}

stock Respawn_PlayerVehicle(vehid)
{
	new vid = GetVehicleID(vehid);
	if(vInfo[vid][vOwner] != 0)
	{
		SetVehicleToRespawn(vehid);
	}
	return 1;
}

public Speedometer(playerid)
{
	new vid = GetVehicleID(GetPlayerVehicleID(playerid));
	new variables[7], vehicleid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vehicleid, variables[0], variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
	if(variables[0] == VEHICLE_PARAMS_ON)
	{
		
		if(vInfo[vid][vOwner] != 0)
		{
			new Float: speed_x, Float: speed_y, Float: speed_z, Float: final_speed, speed_string[256], final_speed_int, fuel_string[256];
			if(vehicleid != 0)
			{
				GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
				final_speed = floatsqroot(((speed_x*speed_x) + (speed_y * speed_y)) + (speed_z * speed_z)) * 250.666667;
				final_speed_int = floatround(final_speed, floatround_round);
				format(speed_string, sizeof(speed_string), "Speed: %i", final_speed_int);
				TextDrawSetString(vSpeed[playerid][speed], speed_string);
				currentspeed[playerid] = final_speed_int;
				if(!IsABycicle(GetVehicleModel(vehicleid)))
				{
					format(fuel_string, sizeof(fuel_string), "Fuel: %i", vInfo[vid][vFuel]);
					TextDrawSetString(vSpeed[playerid][fuel], fuel_string);
				}
			}
		}
		else
		{
			new Float: speed_x, Float: speed_y, Float: speed_z, Float: final_speed, speed_string[256], final_speed_int, fuel_string[256];
			if(vehicleid != 0)
			{
				GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
				final_speed = floatsqroot(((speed_x*speed_x) + (speed_y * speed_y)) + (speed_z * speed_z)) * 250.666667;
				final_speed_int = floatround(final_speed, floatround_round);
				format(speed_string, sizeof(speed_string), "Speed: %i", final_speed_int);
				TextDrawSetString(vSpeed[playerid][speed], speed_string);
				currentspeed[playerid] = final_speed_int;
				
				format(fuel_string, sizeof(fuel_string), "Fuel: %d", GetVehicleFuel(vehicleid));
				TextDrawSetString(vSpeed[playerid][fuel], fuel_string);
			}
			return 1;
		}
	}
	else
	{
		TextDrawSetString(vSpeed[playerid][speed], " ");
		TextDrawSetString(vSpeed[playerid][fuel], " ");
	}
	return 1;
}

forward Fuelmeter(playerid);
public Fuelmeter(playerid)
{
	new vehicleid;
	vehicleid = GetPlayerVehicleID(playerid);
	new vid = GetVehicleID(GetPlayerVehicleID(playerid));
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
		
	if(IsABycicle(GetVehicleModel(vehicleid))) return 1;
	if(GetPVarInt(playerid, "InRace") == 1) return 1;
	
	new variables[7];
	GetVehicleParamsEx(vehicleid, variables[0], variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
	if(variables[0] == VEHICLE_PARAMS_ON)
	{
		if(vehicleid != 0)
		{
			if(vInfo[vid][vOwner] != 0)
			{
				if(vInfo[vid][vFuel] > 0)
				{
					if(currentspeed[playerid] == 0)
					{
						if(IsASCar(vehicleid))
						{
							vInfo[vid][vFuel] -= 1;
							return 1;
						}
						else
						{
							vInfo[vid][vFuel] -= 1;
						}
						return 1;
					}
					else
					{
						if(IsASCar(vehicleid))
						{
							vInfo[vid][vFuel] -= 2;
							return 1;
						}
						else
						{
							vInfo[vid][vFuel] -= 1;
						}
					}
					return 1;
				}
				else return KillTimer(FuelTimer[vehicleid]);
			}
			else
			{
				if(GetVehicleFuel(vehicleid) > 0)
				{
					if(currentspeed[playerid] == 0)
					{
						if(IsASCar(vehicleid))
						{
							gVehicleFuel[vehicleid] -= 1;
							return 1;
						}
						else
						{
							gVehicleFuel[vehicleid] -= 1;
						}
						return 1;
					}
					else
					{
						if(IsASCar(vehicleid))
						{
							gVehicleFuel[vehicleid] -= 2;
							return 1;
						}
						else
						{
							gVehicleFuel[vehicleid] -= 1;
						}
					}
					return 1;
				}
				else KillTimer(FuelTimer[vehicleid]);
			}
			if(vInfo[vid][vFuel] <= 0)
			{
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
				KillTimer(FuelTimer[vehicleid]);
				SendClientMessage(playerid, COLOR_GREY, "Vehicle out of fuel.");
				return 1;
			}
			if(GetVehicleFuel(vehicleid) <= 0)
			{
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
				KillTimer(FuelTimer[vehicleid]);
				SendClientMessage(playerid, COLOR_GREY, "Vehicle out of fuel.");
				return 1;
			}		
		}
		else KillTimer(FuelTimer[vehicleid]);
	}
	else KillTimer(FuelTimer[vehicleid]);
	return 1;
}

stock IsATruck(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 403 || 514 || 515)
	{
		return 1;
	}
	return 0;
}

stock IsASCar(vehicleid)
{
	if(GetVehicleModel(vehicleid) == 411)
	{
		return 1;
	}
	return 0;
}

stock IsABycicle(vehicleid)
{
	switch (vehicleid)
    {
        case 481, 509, 510: return 1;
    }
	return 0;
}

stock IsABike(vehicle)
{
    new Motorads[] = { 509, 481, 510, 462, 448, 581, 522, 461, 521, 523, 463, 586, 468, 471 };
    for(new i = 0; i < sizeof(Motorads); i++) {
        if(GetVehicleModel(vehicle) == Motorads[i]) return 1;
    }
    return 0;
}

stock GetVehicleName(vehicleid)
{
	new string[25];
    format(string,sizeof(string),"%s",VehicleNames[GetVehicleModel(vehicleid) - 400]);
    return string;
}

