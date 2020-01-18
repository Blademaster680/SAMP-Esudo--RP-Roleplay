	#include <a_samp>
	#include <streamer>
	#include <a_mysql>
	
	enum GunInfo
	{
		pGuns[20]
	}
	new gInfo[MAX_PLAYERS][GunInfo];
	
stock Save_Weapons(playerid)
{
	if(GetPVarInt(playerid, "Logged") == 1)
	{
		new Query[1028];
			
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PWeapons` SET `pGun1` = '%d', `pGun2` = '%d', `pGun3` = '%d', `pGun4` = '%d', `pGun5` = '%d', `pGun6` = '%d', `pGun7` = '%d', `pGun8` = '%d', `pGun9` = '%d', `pGun10` = '%d', `pGun11` = '%d', `pGun12` = '%d' WHERE `Username` = '%s'",
		gInfo[playerid][pGuns][0],
		gInfo[playerid][pGuns][1],
		gInfo[playerid][pGuns][2],
		gInfo[playerid][pGuns][3],
		gInfo[playerid][pGuns][4],
		gInfo[playerid][pGuns][5],
		gInfo[playerid][pGuns][6],
		gInfo[playerid][pGuns][7],
		gInfo[playerid][pGuns][8],
		gInfo[playerid][pGuns][9],
		gInfo[playerid][pGuns][10],
		gInfo[playerid][pGuns][11],
		pName(playerid));
		mysql_query(dbHandle,Query,false);
	}
}
	
stock Load_Weapons(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new Query[512], savestr[50], rows, fields;
		mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `PWeapons` WHERE `Username` = '%s'", pName(playerid));
		mysql_query(dbHandle,Query);
	    cache_get_data(rows, fields);
	    if(rows)
	    {
			cache_get_field_content(0, "pGun1", savestr);			gInfo[playerid][pGuns][0] = strval(savestr);
			cache_get_field_content(0, "pGun2", savestr);			gInfo[playerid][pGuns][1] = strval(savestr);
			cache_get_field_content(0, "pGun3", savestr);			gInfo[playerid][pGuns][2] = strval(savestr);
			cache_get_field_content(0, "pGun4", savestr);			gInfo[playerid][pGuns][3] = strval(savestr);
			cache_get_field_content(0, "pGun5", savestr);			gInfo[playerid][pGuns][4] = strval(savestr);
			cache_get_field_content(0, "pGun6", savestr);			gInfo[playerid][pGuns][5] = strval(savestr);
			cache_get_field_content(0, "pGun7", savestr);			gInfo[playerid][pGuns][6] = strval(savestr);
			cache_get_field_content(0, "pGun8", savestr);			gInfo[playerid][pGuns][7] = strval(savestr);
			cache_get_field_content(0, "pGun9", savestr);			gInfo[playerid][pGuns][8] = strval(savestr);
			cache_get_field_content(0, "pGun10", savestr);			gInfo[playerid][pGuns][9] = strval(savestr);
			cache_get_field_content(0, "pGun11", savestr);			gInfo[playerid][pGuns][10] = strval(savestr);
			cache_get_field_content(0, "pGun12", savestr);			gInfo[playerid][pGuns][11] = strval(savestr);
	  	}
		SetPlayerWeapons(playerid);
	}
	return 1;
}

stock SetPlayerWeapons(playerid)
{
	ResetPlayerWeapons(playerid);
	for(new s = 0; s < 12; s++)
	{
		if(gInfo[playerid][pGuns][s] > 0)
		{
		    if(gInfo[playerid][pGuns][s] == 17)
				GivePlayerValidWeapon(playerid, gInfo[playerid][pGuns][s], 5);
			else
				GivePlayerValidWeapon(playerid, gInfo[playerid][pGuns][s], 60000);
		}
	}
	return 1;
}

stock GivePlayerValidWeapon(playerid, WeaponID, Ammo)
{
	switch(WeaponID)
	{
  		case 0, 1:
		{
			gInfo[playerid][pGuns][0] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 2, 3, 4, 5, 6, 7, 8, 9:
		{
			gInfo[playerid][pGuns][1] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 22, 23, 24:
		{
			gInfo[playerid][pGuns][2] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 25, 26, 27:
		{
			gInfo[playerid][pGuns][3] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 28, 29, 32:
		{
			gInfo[playerid][pGuns][4] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 30, 31:
		{
			gInfo[playerid][pGuns][5] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 33, 34:
		{
			gInfo[playerid][pGuns][6] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 35, 36, 37, 38:
		{
			gInfo[playerid][pGuns][7] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 16, 17, 18, 39, 40:
		{
			gInfo[playerid][pGuns][8] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 41, 42, 43:
		{
			gInfo[playerid][pGuns][9] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 10, 11, 12, 13, 14, 15:
		{
			gInfo[playerid][pGuns][10] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
		case 44, 45, 46:
		{
			gInfo[playerid][pGuns][11] = WeaponID;
			GivePlayerWeapon(playerid, WeaponID, Ammo);
		}
	}
	return 1;
}