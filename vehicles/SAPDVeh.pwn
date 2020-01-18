#include <a_samp>
#include <SimpleFuel>

new SAPDVeh[41];
new LAFMDVeh[11];

Load_SAPDVehicles()
{
	SAPDVeh[0] = CreateVehicleEx(596, 1602.8655, -1684.0818, 5.5351, 89.8200, -1, -1, 3000);
	SAPDVeh[1] = CreateVehicleEx(596, 1602.8782, -1688.2321, 5.5351, 89.8200, -1, -1, 3000);
	SAPDVeh[2] = CreateVehicleEx(596, 1602.9431, -1691.9994, 5.5351, 89.8200, -1, -1, 3000);
	SAPDVeh[3] = CreateVehicleEx(596, 1602.8256, -1696.1193, 5.5351, 89.8200, -1, -1, 3000);
	SAPDVeh[4] = CreateVehicleEx(596, 1602.8932, -1700.4136, 5.5351, 89.8200, -1, -1, 3000);
	SAPDVeh[5] = CreateVehicleEx(596, 1602.9369, -1704.2742, 5.5351, 89.8200, -1, -1, 3000);
	SAPDVeh[6] = CreateVehicleEx(599, 1595.4606, -1709.1302, 6.0086, 0.0000, -1, -1, 3000);
	SAPDVeh[7] = CreateVehicleEx(599, 1591.3920, -1709.2321, 6.0117, 0.0000, -1, -1, 3000);
//	SAPDVeh[8] = CreateVehicleEx(599, 1587.5900, -1709.2371, 6.0117, 0.0000, -1, -1, 3000);
	SAPDVeh[9] = CreateVehicleEx(599, 1583.6956, -1709.4608, 6.0117, 0.0000, -1, -1, 3000);
	SAPDVeh[10] = CreateVehicleEx(599, 1578.5642, -1709.1691, 6.0117, 0.0000, -1, -1, 3000);
	SAPDVeh[11] = CreateVehicleEx(599, 1574.3569, -1709.4406, 6.0117, 0.0000, -1, -1, 3000);
	SAPDVeh[12] = CreateVehicleEx(599, 1570.3618, -1709.6201, 6.0117, 0.0000, -1, -1, 3000);
	SAPDVeh[13] = CreateVehicleEx(599, 1559.0073, -1709.2556, 6.0117, 0.0000, -1, -1, 3000);
	SAPDVeh[14] = CreateVehicleEx(601, 1531.2284, -1647.0277, 5.7960, -180.6600, -1, -1, 3000);
	SAPDVeh[15] = CreateVehicleEx(601, 1527.0643, -1646.7473, 5.7960, -180.6600, -1, -1, 3000);
	SAPDVeh[16] = CreateVehicleEx(528, 1534.8807, -1646.4390, 6.0678, -179.5200, -1, -1, 3000);
	SAPDVeh[17] = CreateVehicleEx(528, 1538.6096, -1646.3053, 6.0678, -179.5200, -1, -1, 3000);
	SAPDVeh[18] = CreateVehicleEx(432, 1564.6068, -1712.5907, 6.1774, 0.0000, -1, -1, 3000);
	SAPDVeh[19] = CreateVehicleEx(599, 1587.5900, -1709.2371, 6.0117, 0.0000, -1, -1, 3000);
	SAPDVeh[20] = CreateVehicleEx(599, 1586.1104, -1667.8644, 6.0537, -90.3600, -1, -1, 3000);
	SAPDVeh[21] = CreateVehicleEx(599, 1586.2621, -1671.8003, 6.0537, -90.3600, -1, -1, 3000);
	SAPDVeh[22] = CreateVehicleEx(523, 1587.5552, -1675.6658, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[23] = CreateVehicleEx(523, 1587.4854, -1674.5126, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[24] = CreateVehicleEx(523, 1587.4641, -1677.8076, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[25] = CreateVehicleEx(523, 1587.4321, -1676.7764, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[26] = CreateVehicleEx(523, 1587.3647, -1681.2448, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[27] = CreateVehicleEx(523, 1587.4521, -1678.9174, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[28] = CreateVehicleEx(523, 1587.5791, -1680.0322, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[29] = CreateVehicleEx(523, 1583.7408, -1681.1982, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[30] = CreateVehicleEx(523, 1583.7565, -1679.9834, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[31] = CreateVehicleEx(523, 1583.7708, -1678.8705, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[32] = CreateVehicleEx(523, 1583.7850, -1677.7606, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[33] = CreateVehicleEx(523, 1583.7097, -1676.7289, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[34] = CreateVehicleEx(523, 1583.4678, -1675.6136, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[35] = CreateVehicleEx(523, 1583.4354, -1674.4609, 5.4204, -90.7800, -1, -1, 3000);
	SAPDVeh[36] = CreateVehicleEx(490, 1544.2365, -1668.2870, 5.7522, 90.7200, -1, -1, 3000);
	SAPDVeh[37] = CreateVehicleEx(490, 1544.5907, -1684.2299, 5.7522, 90.7200, -1, -1, 3000);
	SAPDVeh[38] = CreateVehicleEx(490, 1544.1021, -1680.2092, 5.7522, 90.7200, -1, -1, 3000);
	SAPDVeh[39] = CreateVehicleEx(490, 1544.3326, -1676.2732, 5.7522, 90.7200, -1, -1, 3000);
	SAPDVeh[40] = CreateVehicleEx(490, 1544.3116, -1672.2198, 5.7522, 90.7200, -1, -1, 3000);
}

Load_LAFMDVehicles()
{
	LAFMDVeh[0] = CreateVehicleEx(416, 1808.1235, -1764.1086, 14.3937, -90.0000, -1, -1, 3000);
	LAFMDVeh[1] = CreateVehicleEx(416, 1807.9542, -1746.5803, 14.3937, -90.0000, -1, -1, 3000);
	LAFMDVeh[2] = CreateVehicleEx(417, 1775.0276, -1809.6287, 14.5655, -137.9400, -1, -1, 3000);
	LAFMDVeh[3] = CreateVehicleEx(417, 1759.3711, -1803.9785, 14.5655, -67.6201, -1, -1, 3000);
	LAFMDVeh[4] = CreateVehicleEx(407, 1808.6919, -1755.4065, 14.8585, -90.0000, -1, -1, 3000);
	LAFMDVeh[5] = CreateVehicleEx(544, 1755.1294, -1772.9003, 13.6003, 180.0000, -1, -1, 3000);
	LAFMDVeh[6] = CreateVehicleEx(407, 1758.3527, -1760.8984, 13.6003, 180.0000, -1, -1, 3000);
	LAFMDVeh[7] = CreateVehicleEx(416, 1750.6572, -1775.3926, 14.3176, 180.0000, -1, -1, 3000);
	LAFMDVeh[8] = CreateVehicleEx(416, 1747.4774, -1766.1439, 14.3176, 180.0000, -1, -1, 3000);
	LAFMDVeh[9] = CreateVehicleEx(416, 1750.6012, -1755.5383, 14.3176, 180.0000, -1, -1, 3000);
	
}

stock IsSAPDVeh(vehicleid)
{
	for(new i = 0; i < sizeof(SAPDVeh); ++i)
	{
		if(vehicleid == SAPDVeh[i]) return 1;
	}
	return 0;
}

stock IsACopCar(carid)
{
	switch (carid)
    {
        case 490, 523, 528, 601, 599, 596: return 1;
    }
	return 0;
}

stock IsAAmbulance(carid)
{
	switch (carid)
	{
		case 416, 417, 407, 544: return 1;
	}
	return 0;
}

stock IsLAFMDVeh(vehicleid)
{
	for(new i = 0; i < sizeof(LAFMDVeh) ; ++i)
	{
		if(vehicleid == LAFMDVeh[i]) return 1;
	}
	return 0;
}