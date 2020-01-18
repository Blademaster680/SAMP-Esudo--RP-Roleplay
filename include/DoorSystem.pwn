	#include <a_samp>
	#include <streamer>
	#include <a_mysql>
	
	#define MAX_DOORS 2000
	
	#define	COLOR_YELLOW 0xFFFF00AA

	enum doorinfo
	{
		dID,
		dName[32],
		dPickupID,
		Float: dEPos[3],
		Float: dIPos[3],
		Float: dFacAng,
		Float: dIFacAng,
		dInt,
		dEInt,
		dVW,
		dEVW,
		dLocked,
		Text3D: dTextID,
	}
	new dInfo[MAX_DOORS][doorinfo];
	new DoorCreate[MAX_DOORS];
	new DoorPickupE[MAX_DOORS];
	new DoorPickupI[MAX_DOORS];
	new Text3D: DoorLabelI[MAX_DOORS];
	
stock Load_DynamicDoors()
{
	    new Query[512], savestr[25], savestr2[32], rows, fields, count;
        for(new i = 1; i < MAX_DOORS; i++)
        {
                mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `Doors` WHERE `ID` = '%d'", i);
                mysql_query(dbHandle,Query);
				cache_get_data(rows, fields);
                if(rows)
                {
					cache_get_field_content(0, "ID", savestr);				dInfo[i][dID] = strval(savestr);
					cache_get_field_content(0, "Name", savestr2);			dInfo[i][dName] = savestr2;
					cache_get_field_content(0, "PickupID", savestr);		dInfo[i][dPickupID] = strval(savestr);
                    cache_get_field_content(0, "ExtX", savestr);            dInfo[i][dEPos][0] = floatstr(savestr);
                    cache_get_field_content(0, "ExtY", savestr);            dInfo[i][dEPos][1] = floatstr(savestr);
                    cache_get_field_content(0, "ExtZ", savestr);            dInfo[i][dEPos][2] = floatstr(savestr);
                    cache_get_field_content(0, "IntX", savestr);            dInfo[i][dIPos][0] = floatstr(savestr);
                    cache_get_field_content(0, "IntY", savestr);            dInfo[i][dIPos][1] = floatstr(savestr);
                    cache_get_field_content(0, "IntZ", savestr);            dInfo[i][dIPos][2] = floatstr(savestr);
					cache_get_field_content(0, "FacingAngle", savestr);     dInfo[i][dFacAng] = floatstr(savestr);
					cache_get_field_content(0, "IFacingAngle", savestr);    dInfo[i][dIFacAng] = floatstr(savestr);
                    cache_get_field_content(0, "Interior", savestr);        dInfo[i][dInt] = strval(savestr);
					cache_get_field_content(0, "EInterior", savestr);       dInfo[i][dEInt] = strval(savestr);
                    cache_get_field_content(0, "VW", savestr);          	dInfo[i][dVW] = strval(savestr);
					cache_get_field_content(0, "EVW", savestr);          	dInfo[i][dEVW] = strval(savestr);
                    cache_get_field_content(0, "Locked", savestr);          dInfo[i][dLocked] = strval(savestr);
					if(DoorCreate[i] == 0)
					{
						Create_DynamicDoors(i);
						DoorCreate[i] = 1;
						count++;
					}
				}
        }
		print("----------------------------------");
		printf("Loaded: %i Dynamic Doors", count);
		print("----------------------------------");				
		return 1;
}

stock Load_DynamicDoor(doorid)
{
	new Query[512], savestr[25], savestr2[32], rows, fields;
    mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `Doors` WHERE `ID` = '%d'", doorid);
    mysql_query(dbHandle,Query);
	cache_get_data(rows, fields);
    if(rows)
    {
		cache_get_field_content(0, "ID", savestr);				dInfo[doorid][dID] = strval(savestr);
		cache_get_field_content(0, "Name", savestr2);			dInfo[doorid][dName] = savestr2;
		cache_get_field_content(0, "PickupID", savestr);		dInfo[doorid][dPickupID] = strval(savestr);
		cache_get_field_content(0, "ExtX", savestr);            dInfo[doorid][dEPos][0] = floatstr(savestr);
		cache_get_field_content(0, "ExtY", savestr);            dInfo[doorid][dEPos][1] = floatstr(savestr);
		cache_get_field_content(0, "ExtZ", savestr);            dInfo[doorid][dEPos][2] = floatstr(savestr);
		cache_get_field_content(0, "IntX", savestr);            dInfo[doorid][dIPos][0] = floatstr(savestr);
		cache_get_field_content(0, "IntY", savestr);            dInfo[doorid][dIPos][1] = floatstr(savestr);
		cache_get_field_content(0, "IntZ", savestr);            dInfo[doorid][dIPos][2] = floatstr(savestr);
		cache_get_field_content(0, "FacingAngle", savestr);     dInfo[doorid][dFacAng] = floatstr(savestr);
		cache_get_field_content(0, "IFacingAngle", savestr);    dInfo[doorid][dIFacAng] = floatstr(savestr);
		cache_get_field_content(0, "Interior", savestr);        dInfo[doorid][dInt] = strval(savestr);
		cache_get_field_content(0, "EInterior", savestr);       dInfo[doorid][dEInt] = strval(savestr);
		cache_get_field_content(0, "VW", savestr);          	dInfo[doorid][dVW] = strval(savestr);
		cache_get_field_content(0, "EVW", savestr);          	dInfo[doorid][dEVW] = strval(savestr);
		cache_get_field_content(0, "Locked", savestr);          dInfo[doorid][dLocked] = strval(savestr);
		Create_DynamicDoors(doorid);
		DoorCreate[doorid] = 1;
	}
	return 1;
}

stock Create_DynamicDoors(doorid)
{
	new string[128];
	format(string, sizeof(string), "%s", dInfo[doorid][dName]);	
	dInfo[doorid][dTextID] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, dInfo[doorid][dEPos][0], dInfo[doorid][dEPos][1], dInfo[doorid][dEPos][2]+0.7,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, dInfo[doorid][dEVW], dInfo[doorid][dEInt], -1);	
	DoorPickupE[doorid] = CreateDynamicPickup(dInfo[doorid][dPickupID], 23, dInfo[doorid][dEPos][0], dInfo[doorid][dEPos][1], dInfo[doorid][dEPos][2], 0);
	DoorLabelI[doorid] = CreateDynamic3DTextLabel("Exit", COLOR_YELLOW, dInfo[doorid][dIPos][0], dInfo[doorid][dIPos][1], dInfo[doorid][dIPos][2]+0.7,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, dInfo[doorid][dVW], dInfo[doorid][dInt], -1);
	DoorPickupI[doorid] = CreateDynamicPickup(1318, 23, dInfo[doorid][dIPos][0], dInfo[doorid][dIPos][1], dInfo[doorid][dIPos][2], dInfo[doorid][dVW]);	
	return 1;
}

stock Destroy_DynamicDoor(doorid)
{
	DestroyDynamicPickup(DoorPickupE[doorid]);
	DestroyDynamic3DTextLabel(dInfo[doorid][dTextID]);
	DestroyDynamic3DTextLabel(DoorLabelI[doorid]);
	DestroyDynamicPickup(DoorPickupI[doorid]);
	return 1;
}