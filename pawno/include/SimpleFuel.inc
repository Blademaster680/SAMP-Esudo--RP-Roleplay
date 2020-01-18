

new
	gVehicleFuel[MAX_VEHICLES];

stock CreateVehicleEx(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay)
{
	new
		vehicleid = AddStaticVehicleEx(vehicletype, x, y, z, rotation, color1, color2, respawn_delay);

	gVehicleFuel[vehicleid] = 100;
}

stock SetVehicleFuel(vehicleid, VehFuel)
{
	gVehicleFuel[vehicleid] = VehFuel;
}

stock GetVehicleFuel(vehicleid)
{
	return gVehicleFuel[vehicleid];
}