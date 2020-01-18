#include <a_samp>
#include <SimpleFuel>

new SAPDGate[2];
new SAPDGStatus = 0;
new SAPDBarrier;
new SAPDBStatus = 0;

Load_SAPD()
{
	SAPDBarrier = CreateDynamicObject(968, 1544.68750, -1630.70203, 13.26834,   0.30006, 91.98026, 89.76016);
	SAPDGate[0] = CreateDynamicObject(971, 1588.62109, -1637.92908, 14.94298, 0.00000, 0.00000, 0.00000);
	SAPDGate[1] = CreateDynamicObject(971, 1579.91394, -1637.92480, 14.94298, 0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, 1544.67676, -1620.65332, 13.05628,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, 1544.62109, -1635.96265, 13.05628,   0.00000, 0.00000, 0.00000);
	
	CreateDynamicPickup(1239, 1, 1526, -1676, 5.89, 0);
	Create3DTextLabel("Arrest - /arrest", 0x008080FF, 1526, -1676, 6.89, 40.0, 0, 1);
}
