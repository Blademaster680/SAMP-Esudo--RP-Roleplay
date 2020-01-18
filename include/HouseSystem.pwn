#include <a_samp>
#include <streamer>
#include <a_mysql>

#include "../include/colors.pwn"

#define MAX_HOUSES 3000
#define DEFUALT_HOUSE_OWNER "Server"

enum HouseInfo
{
	hID,
	hOwner[25],
	hSize[25],
	hHouseInt,
	hPrice,
	Float: hPos[4],
	Float: hIPos[4],
	Float: hFacAngle,
	hInt,
	hVW,
	Text3D: hTextID,
	Text3D: hTextExitID,
	hPickup,
	hPlayerHouse
}
new hInfo[MAX_HOUSES][HouseInfo];
new HouseCreated[MAX_HOUSES] = 0;
new HouseBought[MAX_HOUSES] = 0;

stock Load_Houses()
{
	new Query[512], savestr[25], rows, fields, count = 0;
	for(new i = 1; i < MAX_HOUSES; i++)
	{
		mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `Houses` WHERE `ID` = '%d'", i);
        mysql_query(dbHandle,Query);
		cache_get_data(rows, fields);
        if(rows)
		{
			cache_get_field_content(0, "ID", savestr);				hInfo[i][hID] = strval(savestr);
			cache_get_field_content(0, "Owner", savestr);			hInfo[i][hOwner] = savestr;
			cache_get_field_content(0, "Size", savestr);			hInfo[i][hSize] = savestr;
			cache_get_field_content(0, "HouseInt", savestr);		hInfo[i][hHouseInt] = strval(savestr);
			cache_get_field_content(0, "Price", savestr);			hInfo[i][hPrice] = strval(savestr);
			cache_get_field_content(0, "PosX", savestr);			hInfo[i][hPos][0] = floatstr(savestr);
			cache_get_field_content(0, "PosY", savestr);			hInfo[i][hPos][1] = floatstr(savestr);
			cache_get_field_content(0, "PosZ", savestr);			hInfo[i][hPos][2] = strval(savestr);
			cache_get_field_content(0, "FaceAngle", savestr);		hInfo[i][hFacAngle] = floatstr(savestr);
			cache_get_field_content(0, "IPosX", savestr);			hInfo[i][hIPos][0] = floatstr(savestr);
			cache_get_field_content(0, "IPosY", savestr);			hInfo[i][hIPos][1] = floatstr(savestr);
			cache_get_field_content(0, "IPosZ", savestr);			hInfo[i][hIPos][2] = floatstr(savestr);
			cache_get_field_content(0, "Interior", savestr);		hInfo[i][hInt] = strval(savestr);
			cache_get_field_content(0, "VirtualWorld", savestr);	hInfo[i][hVW] = strval(savestr);
			hInfo[i][hPlayerHouse] = 0;
			
			Create_DynamicHouse(i);
			HouseCreated[i] = 1;
			count++;
		}
	}
	print("----------------------------------");
	printf("Loaded: %i Houses", count);
	print("----------------------------------");
}

stock Load_PlayerHouses()
{
	new Query[512], savestr[25], rows, fields, count = 0;
	for(new i = 1; i < MAX_HOUSES; i++)
	{
		mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `PHouses` WHERE `ID` = '%d'", i);
        mysql_query(dbHandle,Query);
		cache_get_data(rows, fields);
        if(rows)
		{
			cache_get_field_content(0, "ID", savestr);				hInfo[i][hID] = strval(savestr);
			cache_get_field_content(0, "Owner", savestr);			hInfo[i][hOwner] = savestr;
			cache_get_field_content(0, "Size", savestr);			hInfo[i][hSize] = savestr;
			cache_get_field_content(0, "HouseInt", savestr);		hInfo[i][hHouseInt] = strval(savestr);
			cache_get_field_content(0, "Price", savestr);			hInfo[i][hPrice] = strval(savestr);
			cache_get_field_content(0, "PosX", savestr);			hInfo[i][hPos][0] = floatstr(savestr);
			cache_get_field_content(0, "PosY", savestr);			hInfo[i][hPos][1] = floatstr(savestr);
			cache_get_field_content(0, "PosZ", savestr);			hInfo[i][hPos][2] = strval(savestr);
			cache_get_field_content(0, "FaceAngle", savestr);		hInfo[i][hFacAngle] = floatstr(savestr);
			cache_get_field_content(0, "IPosX", savestr);			hInfo[i][hIPos][0] = floatstr(savestr);
			cache_get_field_content(0, "IPosY", savestr);			hInfo[i][hIPos][1] = floatstr(savestr);
			cache_get_field_content(0, "IPosZ", savestr);			hInfo[i][hIPos][2] = floatstr(savestr);
			cache_get_field_content(0, "Interior", savestr);		hInfo[i][hInt] = strval(savestr);
			cache_get_field_content(0, "VirtualWorld", savestr);	hInfo[i][hVW] = strval(savestr);
			hInfo[i][hPlayerHouse] = 1;
			
			Create_PlayerDynamicHouse(i);
			HouseCreated[i] = 1;
			count++;
			HouseBought[i] = 1;
		}
	}
	print("----------------------------------");
	printf("Loaded: %i Player Houses", count);
	print("----------------------------------");
}

stock Load_House(houseid)
{
	new Query[512], savestr[25], rows, fields;
	mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `Houses` WHERE `ID` = '%d'", houseid);
    mysql_query(dbHandle,Query);
	cache_get_data(rows, fields);
    if(rows)
	{
		cache_get_field_content(0, "ID", savestr);				hInfo[houseid][hID] = strval(savestr);
		cache_get_field_content(0, "Owner", savestr);			hInfo[houseid][hOwner] = savestr;
		cache_get_field_content(0, "Size", savestr);			hInfo[houseid][hSize] = savestr;
		cache_get_field_content(0, "HouseInt", savestr);		hInfo[houseid][hHouseInt] = strval(savestr);
		cache_get_field_content(0, "Price", savestr);			hInfo[houseid][hPrice] = strval(savestr);
		cache_get_field_content(0, "PosX", savestr);			hInfo[houseid][hPos][0] = floatstr(savestr);
		cache_get_field_content(0, "PosY", savestr);			hInfo[houseid][hPos][1] = floatstr(savestr);
		cache_get_field_content(0, "PosZ", savestr);			hInfo[houseid][hPos][2] = strval(savestr);
		cache_get_field_content(0, "FaceAngle", savestr);		hInfo[houseid][hFacAngle] = floatstr(savestr);
		cache_get_field_content(0, "IPosX", savestr);			hInfo[houseid][hIPos][0] = floatstr(savestr);
		cache_get_field_content(0, "IPosY", savestr);			hInfo[houseid][hIPos][1] = floatstr(savestr);
		cache_get_field_content(0, "IPosZ", savestr);			hInfo[houseid][hIPos][2] = strval(savestr);
		cache_get_field_content(0, "Interior", savestr);		hInfo[houseid][hInt] = strval(savestr);
		cache_get_field_content(0, "VirtualWorld", savestr);	hInfo[houseid][hVW] = strval(savestr);
		hInfo[houseid][hPlayerHouse] = 0;
		
		Create_DynamicHouse(houseid);
		HouseCreated[houseid] = 1;
	}
}

stock Load_PlayerHouse(houseid)
{
	new Query[512], savestr[25], rows, fields;
	mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `PHouses` WHERE `ID` = '%d'", houseid);
    mysql_query(dbHandle,Query);
	cache_get_data(rows, fields);
    if(rows)
	{
		cache_get_field_content(0, "ID", savestr);				hInfo[houseid][hID] = strval(savestr);
		cache_get_field_content(0, "Owner", savestr);			hInfo[houseid][hOwner] = savestr;
		cache_get_field_content(0, "Size", savestr);			hInfo[houseid][hSize] = savestr;
		cache_get_field_content(0, "HouseInt", savestr);		hInfo[houseid][hHouseInt] = strval(savestr);
		cache_get_field_content(0, "Price", savestr);			hInfo[houseid][hPrice] = strval(savestr);
		cache_get_field_content(0, "PosX", savestr);			hInfo[houseid][hPos][0] = floatstr(savestr);
		cache_get_field_content(0, "PosY", savestr);			hInfo[houseid][hPos][1] = floatstr(savestr);
		cache_get_field_content(0, "PosZ", savestr);			hInfo[houseid][hPos][2] = strval(savestr);
		cache_get_field_content(0, "FaceAngle", savestr);		hInfo[houseid][hFacAngle] = floatstr(savestr);
		cache_get_field_content(0, "IPosX", savestr);			hInfo[houseid][hIPos][0] = floatstr(savestr);
		cache_get_field_content(0, "IPosY", savestr);			hInfo[houseid][hIPos][1] = floatstr(savestr);
		cache_get_field_content(0, "IPosZ", savestr);			hInfo[houseid][hIPos][2] = strval(savestr);
		cache_get_field_content(0, "Interior", savestr);		hInfo[houseid][hInt] = strval(savestr);
		cache_get_field_content(0, "VirtualWorld", savestr);	hInfo[houseid][hVW] = strval(savestr);
		hInfo[houseid][hPlayerHouse] = 1;
		
		Create_PlayerDynamicHouse(houseid);
		HouseCreated[houseid] = 1;
		HouseBought[houseid] = 1;
	}
}

stock Save_PlayerHouses()
{
	for(new i = 1; i < MAX_HOUSES; i++)
	{
		new Query[528];
		
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `Owner` = '%s', `HouseInt` = '%d' WHERE `ID` = '%d'",
		hInfo[i][hOwner],
		hInfo[i][hLevel],
		i);
		mysql_query(dbHandle,Query,false);
	}
}

stock Create_DynamicHouse(houseid)
{
	new string[60];
	format(string, sizeof(string), "House ID: %i \nOwner: %s \nPrice: R%i \nSize: %s", hInfo[houseid][hID], hInfo[houseid][hOwner], hInfo[houseid][hPrice], hInfo[houseid][hSize]);
	hInfo[houseid][hTextID] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, hInfo[houseid][hPos][0], hInfo[houseid][hPos][1], hInfo[houseid][hPos][2]+0.78,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	hInfo[houseid][hTextExitID] = CreateDynamic3DTextLabel("Exit", COLOR_YELLOW, hInfo[houseid][hIPos][0], hInfo[houseid][hIPos][1], hInfo[houseid][hIPos][2]+0.78,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	hInfo[houseid][hPickup] = CreateDynamicPickup(1273, 23, hInfo[houseid][hPos][0], hInfo[houseid][hPos][1], hInfo[houseid][hPos][2], 0);
	return 1;
}

stock Create_PlayerDynamicHouse(houseid)
{
	new string[60];
	format(string, sizeof(string), "House ID: %i \nOwner: %s \nSize: %s", hInfo[houseid][hID], hInfo[houseid][hOwner], hInfo[houseid][hSize]);
	hInfo[houseid][hTextID] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, hInfo[houseid][hPos][0], hInfo[houseid][hPos][1], hInfo[houseid][hPos][2]+0.78,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	hInfo[houseid][hTextExitID] = CreateDynamic3DTextLabel("Exit", COLOR_YELLOW, hInfo[houseid][hIPos][0], hInfo[houseid][hIPos][1], hInfo[houseid][hIPos][2]+0.78,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	hInfo[houseid][hPickup] = CreateDynamicPickup(1272, 23, hInfo[houseid][hPos][0], hInfo[houseid][hPos][1], hInfo[houseid][hPos][2], 0);
	return 1;
}

stock Destroy_DynamicHouses()
{
	for(new i = 0; i <= MAX_HOUSES; i++)
	{
		DestroyDynamic3DTextLabel(hInfo[i][hTextID]);
		DestroyDynamicPickup(hInfo[i][hPickup]);
	}
	return 1;
}

stock Destroy_DynamicHouse(houseid)
{
	DestroyDynamic3DTextLabel(hInfo[houseid][hTextID]);
	DestroyDynamicPickup(hInfo[houseid][hPickup]);
	return 1;
}

stock Make_TinyHouse(playerid, cost, int)
{
	new Query[500], rows, fields, houseid = 0, rand, amount, str[150];
	amount = cost;
	new Float: x, Float: y, Float: z;
	new Float: ix, Float: iy, Float: iz, Float: fac;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, fac);
	rand = random(5000)+10;
	ix = 2513.4382; iy = -1729.1031; iz = 778.6371;
	strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
	strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 1, '%i')");
	mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Tiny", int, amount, x, y, z, ix, iy, iz, rand);
	mysql_query(dbHandle, Query, false);
	for(new i = 0; i <= MAX_HOUSES; i++)
	{
		mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
		mysql_query(dbHandle,Query);
		cache_get_data(rows, fields);
		if(rows)
		{
			houseid = i;
		}
	}
	Load_House(houseid);
	format(str, sizeof(str), "Created house ID: %i", houseid);
	SendClientMessage(playerid, COLOR_GREY, str);
	format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f | Interior: %i", x, y, z, int);
	SendClientMessage(playerid, COLOR_GREY, str);
	return 1;
}

stock Make_SmallHouse(playerid, cost, int)
{
	new Query[500], rows, fields, houseid = 0, rand, amount, str[150];
	amount = cost;
	new Float: x, Float: y, Float: z;
	new Float: ix, Float: iy, Float: iz, Float: fac;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, fac);
	rand = random(5000)+10;
	if(int == 1)
	{
		ix = 2259.38; iy = -1135.77; iz = 1050.64;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 10, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Small", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
	
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 2)
	{
		ix = 266.50; iy = 304.90; iz = 999.15;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 2, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Small", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 3)
	{
		ix = 2233.64; iy = -1115.26; iz = 1051.00;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 5, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Small", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 4)
	{
		ix = 223.20; iy = 1287.08; iz = 1082.14;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 1, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Small", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 5)
	{
		ix = 2283.04; iy = -1140.28; iz = 1051.00;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 11, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Small", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	format(str, sizeof(str), "Created house ID: %i", houseid);
	SendClientMessage(playerid, COLOR_GREY, str);
	format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f | Interior: %i", x, y, z, int);
	SendClientMessage(playerid, COLOR_GREY, str);
	return 1;
}

stock Make_MediumHouse(playerid, cost, int)
{
	new Query[500], rows, fields, houseid = 0, rand, amount, str[150];
	amount = cost;
	new Float: x, Float: y, Float: z;
	new Float: ix, Float: iy, Float: iz, Float: fac;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, fac);
	rand = random(5000)+10;
	if(int == 1)
	{
		ix = 2196.85; iy = -1204.25; iz = 1049.02;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 6, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Medium", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
	
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 2)
	{
		ix = 2270.38; iy = -1210.35; iz = 1047.56;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 10, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Medium", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 3)
	{
		ix = 446.99; iy = 1397.07; iz = 1084.30;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 2, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Medium", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 4)
	{
		ix = 22.88; iy = 1403.33; iz = 1084.44;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 5, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Medium", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 5)
	{
		ix = 2237.59; iy = -1081.64; iz = 1049.02;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 2, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Medium", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 6)
	{
		ix = 261.12; iy = 1284.30; iz = 1080.26;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 4, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Medium", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 7)
	{
		ix = 24.04; iy = 1340.17; iz = 1084.38;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 10, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Medium", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 8)
	{
		ix = 83.03; iy = 1322.28; iz = 1084.00;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 9, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Medium", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 9)
	{
		ix = 2495.98; iy = -1692.08; iz = 1014.74;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 3, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Medium", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	format(str, sizeof(str), "Created house ID: %i", houseid);
	SendClientMessage(playerid, COLOR_GREY, str);
	format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f | Interior: %i", x, y, z, int);
	SendClientMessage(playerid, COLOR_GREY, str);
	return 1;
}

stock Make_BigHouse(playerid, cost, int)
{
	new Query[500], rows, fields, houseid = 0, rand, amount, str[150];
	amount = cost;
	new Float: x, Float: y, Float: z;
	new Float: ix, Float: iy, Float: iz, Float: fac;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, fac);
	rand = random(5000)+10;
	if(int == 1)
	{
		ix = 140.17; iy = 1366.07; iz = 1084.00;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 5, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Big", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
	
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 2)
	{
		ix = 2324.53; iy = -1149.54; iz = 1050.71;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 12, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Big", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
	
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 3)
	{
		ix = 225.68; iy = 1021.45; iz = 1084.02;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 7, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Big", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
	
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 4)
	{
		ix = 234.19; iy = 1063.73; iz = 1084.21;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 6, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Big", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
	
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 5)
	{
		ix = 226.3873; iy = 1114.2246; iz = 1080.9934;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 5, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Big", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
	
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	else if(int == 6)
	{
		ix = 1260.7726; iy = -785.3885; iz = 1091.9063;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 5, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, "Big", int, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
	
		for(new i = 0; i <= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
			mysql_query(dbHandle,Query);
			cache_get_data(rows, fields);
			if(rows)
			{
				houseid = i;
			}
		}
		Load_House(houseid);
	}
	format(str, sizeof(str), "Created house ID: %i", houseid);
	SendClientMessage(playerid, COLOR_GREY, str);
	format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f | Interior: %i", x, y, z, int);
	SendClientMessage(playerid, COLOR_GREY, str);
	return 1;
} 

stock Change_Interior(houseid, int)
{
	new Float: ix, Float: iy, Float: iz;
	new Query[500], rows, fields;
	if(strcmp(hInfo[houseid][hSize], "small", true) == 0)
	{
		if(hInfo[houseid][hPlayerHouse] == 0)
		{
			if(int == 1)
			{
				ix = 2259.38; iy = -1135.77; iz = 1050.64;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 10 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 2)
			{
				ix = 266.50; iy = 304.90; iz = 999.15;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 2 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
			
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 3)
			{
				ix = 2233.64; iy = -1115.26; iz = 1051.00;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 5 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
						}
				}
				Load_House(houseid);
			}
			else if(int == 4)
			{
				ix = 223.20; iy = 1287.08; iz = 1082.14;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 1 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 5)
			{
				ix = 2283.04; iy = -1140.28; iz = 1051.00;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 11 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
		}
		else
		{
			if(int == 1)
			{
				ix = 2259.38; iy = -1135.77; iz = 1050.64;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 10 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 2)
			{
				ix = 266.50; iy = 304.90; iz = 999.15;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 2 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
			
				Load_PlayerHouse(houseid);
			}
			else if(int == 3)
			{
				ix = 2233.64; iy = -1115.26; iz = 1051.00;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 5 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 4)
			{
				ix = 223.20; iy = 1287.08; iz = 1082.14;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 1 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 5)
			{
				ix = 2283.04; iy = -1140.28; iz = 1051.00;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 11 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
		}
	}
	if(strcmp(hInfo[houseid][hSize], "medium", true) == 0)
	{
		if(hInfo[houseid][hPlayerHouse] == 0)
		{
			if(int == 1)
			{
				ix = 2196.85; iy = -1204.25; iz = 1049.02;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 6 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 2)
			{
				ix = 2270.38; iy = -1210.35; iz = 1047.56;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 10 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 3)
			{
				ix = 446.99; iy = 1397.07; iz = 1084.30;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 2 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 4)
			{
				ix = 22.88; iy = 1403.33; iz = 1084.44;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 5 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 5)
			{
				ix = 2237.59; iy = -1081.64; iz = 1049.02;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 2 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 6)
			{
				ix = 261.12; iy = 1284.30; iz = 1080.26;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 4 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 7)
			{
				ix = 24.04; iy = 1340.17; iz = 1084.38;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 10 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 8)
			{
				ix = 83.03; iy = 1322.28; iz = 1084.00;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 9 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 9)
			{
				ix = 2495.98; iy = -1692.08; iz = 1014.74;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 3 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
		}
		else
		{
			if(int == 1)
			{
				ix = 2196.85; iy = -1204.25; iz = 1049.02;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 6 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 2)
			{
				ix = 2270.38; iy = -1210.35; iz = 1047.56;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 10 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 3)
			{
				ix = 446.99; iy = 1397.07; iz = 1084.30;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 2 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 4)
			{
				ix = 22.88; iy = 1403.33; iz = 1084.44;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 5 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 5)
			{
				ix = 2237.59; iy = -1081.64; iz = 1049.02;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 2 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_PlayerHouse(houseid);
			}
			else if(int == 6)
			{
				ix = 261.12; iy = 1284.30; iz = 1080.26;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 4 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 7)
			{
				ix = 24.04; iy = 1340.17; iz = 1084.38;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 10 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
					
				Load_PlayerHouse(houseid);
			}
			else if(int == 8)
			{
				ix = 83.03; iy = 1322.28; iz = 1084.00;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 9 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 9)
			{
				ix = 2495.98; iy = -1692.08; iz = 1014.74;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 3 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
		}
	}
	if(strcmp(hInfo[houseid][hSize], "big", true) == 0)
	{
		if(hInfo[houseid][hPlayerHouse] == 0)
		{
			if(int == 1)
			{
				ix = 140.17; iy = 1366.07; iz = 1084.00;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 5 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 2)
			{
				ix = 2324.53; iy = -1149.54; iz = 1050.71;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 12 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 3)
			{
				ix = 225.68; iy = 1021.45; iz = 1084.02;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 7 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 4)
			{
				ix = 234.19; iy = 1063.73; iz = 1084.21;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 6 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 5)
			{
				ix = 226.3873; iy = 1114.2246; iz = 1080.9934;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 5 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
			else if(int == 6)
			{
				ix = 1260.7726; iy = -785.3885; iz = 1091.9063;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 5 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				for(new i = 0; i <= MAX_HOUSES; i++)
				{
					mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `Houses` WHERE `ID` = '%d'", i);
					mysql_query(dbHandle,Query);
					cache_get_data(rows, fields);
					if(rows)
					{
						houseid = i;
					}
				}
				Load_House(houseid);
			}
		}
		else
		{
			if(int == 1)
			{
				ix = 140.17; iy = 1366.07; iz = 1084.00;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 5 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 2)
			{
				ix = 2324.53; iy = -1149.54; iz = 1050.71;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 12 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 3)
			{
				ix = 225.68; iy = 1021.45; iz = 1084.02;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 7 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 4)
			{
				ix = 234.19; iy = 1063.73; iz = 1084.21;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 6 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 5)
			{
				ix = 226.3873; iy = 1114.2246; iz = 1080.9934;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 5 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
			else if(int == 6)
			{
				ix = 1260.7726; iy = -785.3885; iz = 1091.9063;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `HouseInt` = '%d', `IPosX` = '%f', `IPosY` = '%f', `IPosZ` = '%f', `Interior` = 5 WHERE `ID` = '%d'",
				int, ix, iy, iz, houseid);
				mysql_query(dbHandle,Query,false);
				Destroy_DynamicHouse(houseid);
				
				Load_PlayerHouse(houseid);
			}
		}
	}
	return 1;
}

stock Change_Price(houseid, price)
{
	new Query[500];
	mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Houses` SET `Price` = '%d' WHERE `ID` = '%d'",
	price, houseid);
	mysql_query(dbHandle,Query,false);
	Destroy_DynamicHouse(houseid);
	Load_House(houseid);
	return 1;
}