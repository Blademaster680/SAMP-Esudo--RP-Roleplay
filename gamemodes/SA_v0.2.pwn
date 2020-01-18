//////////////////////////////////////////////////////////////////////////////////////////
//==================================== CREDITS =========================================//
//================================= Blademaster680 =====================================//
//////////////////////////////////////////////////////////////////////////////////////////

#include <a_samp>
#include <a_mysql>
#include <sscanf2>
#include <zcmd>
#include <foreach>
#include <YSI\y_timers>
#include <streamer>
#include <a_players>
#include <SimpleFuel>

#include "../include/news.pwn"
#include "../include/VehicleSystem.pwn"
#include "../include/DoorSystem.pwn"
#include "../include/HouseSystem.pwn"
#include "../include/WeaponSystem.pwn"
#include "../include/EventSystem.pwn"

#include "../include/antispam.pwn"

#include "../maps/MapZone.pwn"
#include "../maps/CityHall.pwn"
#include "../maps/CarLot.pwn"
#include "../maps/Truck.pwn"
#include "../maps/Prison.pwn"
#include "../maps/FactionHQ.pwn"
#include "../maps/Fedex.pwn"
#include "../maps/officemaps.pwn"
#include "../maps/Interiors.pwn"

#include "../vehicles/JobVeh.pwn"


//////////////////////////////////////////////////////////////////////////////////////////
//============================== DEFINES ===============================================//
//////////////////////////////////////////////////////////////////////////////////////////

#define FILTERSCRIPT
#define SQL_HOST 							"localhost" // the ip of your mysql server
#define SQL_USER  							"root"		// the username of your mysql account
#define SQL_PASS 							"password"   	// the password of your mysql account
#define SQL_DB  							"egrp"			// the database name

// DIALOGS ===============================================================================

#define DIALOG_LOGIN       					0
#define DIALOG_REGISTER                     1
#define DIALOG_REGISTEREMAIL1				2
#define DIALOG_REGISTEREMAIL2				3
#define DIALOG_REGISTERSEX					4
#define DIALOG_REGISTERAGE					5
#define DIALOG_KICKED						6
#define DIALOG_STATISTIC                    7
#define DIALOG_HELP							8
#define DIALOG_BANNED						9
#define DIALOG_NAME							10
#define DIALOG_CHANGENAME					11
#define DIALOG_CHANGEPASS					12

#define DIALOG_VBUY							13
#define DIALOG_VSELL						14
#define DIALOG_VEDIT						15
#define DIALOG_VEDITO						16
#define DIALOG_VEDITM						17
#define DIALOG_VEDITP						18
#define DIALOG_VDELETE						19
#define DIALOG_Vs							20

#define DIALOG_HOUSESELL					21

#define DIALOG_BUYSKIN						30
#define DIALOG_247							31

#define DIALOG_FEDEXCOLLECT					50
#define DIALOG_WEPSELL						55
#define DIALOG_CDLFUEL						60

#define DIALOG_BANK 						70
#define DIALOG_DEPOSIT 						71
#define DIALOG_WITHDRAW 					72
#define DIALOG_TRANSFER1 					73
#define DIALOG_TRANSFER2 					74
#define DIALOG_BALANCE 						75

#define DIALOG_RADIO						100

#define DIALOG_JOBHELP						110
#define DIALOG_FEDEXHELP1					111
#define DIALOG_FEDEXHELP2					112
#define DIALOG_ADHELP1						113
#define DIALOG_ADHELP2						114
#define DIALOG_PIZZAHELP1					115
#define DIALOG_PIZZAHELP2					116
#define DIALOG_DRUGSHELP1					117
#define DIALOG_DRUGSHELP2					118
#define DIALOG_TAXIHELP1					119
#define DIALOG_TAXIHELP2					120
#define DIALOG_WAREHHELP1					121
#define DIALOG_WAREHHELP2					122

#define DIALOG_SAPD							130
#define DIALOG_SAPD2						131
#define DIALOG_SAPD3						132
#define DIALOG_LAFMD						133
#define DIALOG_LAFMD2						134
#define DIALOG_LAFMD3						135
#define DIALOG_UNINVITESKIN					136

#define DIALOG_TAXI 						150
#define DIALOG_INVITE						160

// COLORS ================================================================================

#define GREY  								0xAFAFAFAA
#define GREEN  								0x9FFF00FF
#define RED  								0xE60000FF
#define YELLOW   							0xFFFF00AA
#define WHITE  								0xFFFFFFAA
#define red 								0xFF0000AA
#define yellow								0xFFFF00FF
#define black 								0x00000000
#define blue 								0x1229FAFF
#define orange 								0xF97804FF
#define grey 								0xCECECEFF
#define white 								0xFFFFFFAA
#define COL_WHITE       					"{FFFFFF}"
#define COL_BLACK       					"{0E0101}"
#define COL_GREY        					"{C3C3C3}"
#define COL_RED         					"{F81414}"
#define COL_YELLOW      					"{F3FF02}"
#define COL_ORANGE      					"{FFAF00}"
#define COL_LIME        					"{B7FF00}"
#define COL_CYAN        					"{00FFEE}"
#define COL_MAGENTA     					"{F300FF}"
#define COL_VIOLET      					"{B700FF}"
#define COL_PINK        					"{FF00EA}"
#define COL_MARONE      					"{A90202}"
#define COLOR_RED 							0xFF0000FF
#define COLOR_ONE 							0xFF444499
#define COLOR_TWO 							0xFFFF22AA
#define COLOR_THREE 						0xFFCC2299
#define COLOR_GREY 							0xAFAFAFAA
#define COLOR_GREEN 						0x33AA33AA
#define COLOR_BRIGHTRED 					0xFF0000AA
#define COLOR_YELLOW 						0xFFFF00AA
#define COLOR_PINK 							0xFF66FFAA
#define COLOR_BLUE 							0x3A47DEFF
#define COLOR_TAN 							0xBDB76BAA
#define COLOR_PURPLE 						0xC2A2DAAA
#define COLOR_WHITE 						0xFFFFFFAA
#define COLOR_LIGHTBLUE 					0x33CCFFAA
#define COLOR_ORANGE 						0xFF9900AA
#define COLOR_INDIGO 						0x4B00B0AA
#define COLOR_BLACK							0x00000000
#define COLOR_DARKGREY 						0x696969FF
#define COLOR_GRAD1 						0xB4B5B7FF
#define COLOR_GRAD2 						0xBFC0C2FF
#define COLOR_GRAD3 						0xCBCCCEFF
#define COLOR_GRAD4 						0xD8D8D8FF
#define COLOR_GRAD5 						0xE3E3E3FF
#define COLOR_GRAD6 						0xF0F0F0FF
#define COLOR_RED 							0xFF0000FF
#define COLOR_FADE1 						0xE6E6E6E6
#define COLOR_FADE2 						0xC8C8C8C8
#define COLOR_FADE3 						0xAAAAAAAA
#define COLOR_FADE4 						0x8C8C8C8C
#define COLOR_FADE5 						0x6E6E6E6E
#define COLOR_DARKBLUE 						0x2641FEAA
#define COLOR_ALLDEPT 						0xFF8282AA
#define COLOR_GREY 							0xAFAFAFAA
#define C_GREEN 							0x33AA33AA
#define C_RED 								0xAA3333AA
#define COLOR_YELLOW 						0xFFFF00AA
#define COLOR_WHITE 						0xFFFFFFAA
#define COLOR_ONE 							0xFF444499
#define COLOR_TWO 							0xFFFF22AA
#define COLOR_THREE 						0xFFCC2299
#define COLOR_GREY 							0xAFAFAFAA
#define COLOR_GREEN 						0x33AA33AA
#define COLOR_BRIGHTRED 					0xFF0000AA
#define COLOR_YELLOW 						0xFFFF00AA
#define COLOR_PINK 							0xFF66FFAA
#define COLOR_BLUE 							0x3A47DEFF
#define COLOR_TAN 							0xBDB76BAA
#define COLOR_WHITE 						0xFFFFFFAA
#define COLOR_LIGHTBLUE 					0x33CCFFAA
#define COLOR_ORANGE 						0xFF9900AA
#define COLOR_INDIGO 						0x4B00B0AA
#define COLOR_BLACK 						0x00000000
#define COLOR_DARKGREY 						0x696969FF
#define COLOR_GRAD1 						0xB4B5B7FF
#define COLOR_GRAD2 						0xBFC0C2FF
#define COLOR_GRAD3 						0xCBCCCEFF
#define COLOR_GRAD4 						0xD8D8D8FF
#define COLOR_GRAD5 						0xE3E3E3FF
#define COLOR_GRAD6 						0xF0F0F0FF
#define COLOR_RED2 							0xAA3333AA
#define COLOR_FADE1 						0xE6E6E6E6
#define COLOR_FADE2 						0xC8C8C8C8
#define COLOR_FADE3 						0xAAAAAAAA
#define COLOR_FADE4 						0x8C8C8C8C
#define COLOR_FADE5 						0x6E6E6E6E
#define COLOR_DARKBLUE 						0x2641FEAA
#define COLOR_ALLDEPT 						0xFF8282AA
#define COLOR_LIGHTGREEN 					0x7FFF00
#define COLOR_DARKGREEN 					0x006400
#define COL_WHITE 							"{FFFFFF}"
#define COL_RED 							"{F81414}"
#define COL_GREEN 							"{00FF22}"
#define COL_LIGHTBLUE 						"{00CED1}"
#define COL_BLUE                            "{1229FA}"
#define COLOR_GROUPTALK 					0x87CEEBAA
#define COLOR_MENU 							0xFFFFFFAA
#define COLOR_SYSTEM_PM 					0x66CC00AA
#define COLOR_SYSTEM_PW 					0xFFFF33AA
#define ADMINFS_MESSAGE_COLOR 				0xFF444499
#define PM_INCOMING_COLOR     				0xFFFF22AA
#define PM_OUTGOING_COLOR     				0xFFCC2299
#define COLOR_MESS    						0xFFFFFFFF
#define COLOR_Label 						0xFFFFFFFF
#define COLOR_LabelOut 						0x00000040
#define COLOR_ValueOut 						0xFFFFFF40
#define COLOR_Value 						0x000000FF
#define	COLOR_LIGHTRED						0xFF6347AA
#define	COLOR_CYAN 							0x40FFFFFF
#define	COLOR_NEWBIE						0x7DAEFFFF
#define RADIO								0xFFBDFAAA
#define	COLOR_TWBLUE 						0x0000FFAA

#define Light_Blue 							0x00CCFF
#define White 								0xFFFFFF
#define Gray 								0x222222BB
#define COLOR_YELLOW2 						0xF5DEB3AA

// PLAYER ================================================================================

#define MAX_FLOODLINES						5
#define MAX_FLOOD_RATE_SECS					5000
#define AFTERLIFE_SECONDS           		20 // 20 seconds
#define AUTODEATH_SECONDS           		60 // 60 seconds

#define MAX_CONES							500
#define MAX_BARRICADES 						500

#define MAX_ADMIN_CARS						20

//////////////////////////////////////////////////////////////////////////////////////////
//============================== ENUMS =================================================//
//////////////////////////////////////////////////////////////////////////////////////////

enum playerinfo
{
	pUsername[24],
	pPassword[64],
	pEmail[64],
	pIP[16],
	pBanned,
	pCash,
	pBank,
	pAdminLevel,
	pModerator,
	pVipLevel,
	pSkin,
	pLogged,
	pLevel,
	pGender,
	pAge,
	pHours,
	pFaction,
	pFacRank,
	pWanted,
	pCrimes,
	pArrests,
	pJail,
	pBail,
	pJob1,
	pNewbMute,
	pAMMute,
	Float:pPosX,
	Float:pPosY,
	Float:pPosZ,
	pInt,
	pVW,
	pHRs,
	pPhone,
	pHouses,
	pWepSold,
	pWepLevel,
	pMats,
	pSpraycans,
	pRope,
	pBandage,
	pMorphine
};

enum cInfo
{
	sCreated,
	Float:sX,
    Float:sY,
    Float:sZ,
    sObject,
};
	
enum bInfo
{
	sCreated,
    Float:sX,
    Float:sY,
    Float:sZ,
    sObject,
};

//////////////////////////////////////////////////////////////////////////////////////////
//============================== NEWS ==================================================//
//////////////////////////////////////////////////////////////////////////////////////////


	new Invalid[MAX_PLAYERS];
	new pInfo[MAX_PLAYERS][playerinfo];

	new OnCall[MAX_PLAYERS] = -1;
	new Call911[MAX_PLAYERS] = -1;
	new AdminCars[MAX_ADMIN_CARS][2], carcount;
	new spec[MAX_PLAYERS] = -1;
		
	new Float:rrP[MAX_PLAYERS][3];
	
	new FloodByPlayer[MAX_PLAYERS];
	new FloodTimer[MAX_PLAYERS];
	new ChatMute[MAX_PLAYERS] = 0;
	
	new Float:DeathPosX [MAX_PLAYERS];
	new Float:DeathPosY [MAX_PLAYERS];
	new Float:DeathPosZ [MAX_PLAYERS];
	new IsDead [MAX_PLAYERS];
	new SecsToGo [MAX_PLAYERS];
	new IsAfterLifing [MAX_PLAYERS];
	new AfterLifeTimer;
	new LoseHPTimer[MAX_PLAYERS] = 0;
	new tognewbie[MAX_PLAYERS] = 0;
	new NoNewb[MAX_PLAYERS] = 0;
	new waitcheck[MAX_PLAYERS] = 0;
	new tazer[MAX_PLAYERS] = 0;
	new tazerreplace[MAX_PLAYERS] = 0;
	new beingdragged[MAX_PLAYERS] = -1;
	new cardetain[MAX_PLAYERS] = -1;
	new OnDuty[MAX_PLAYERS] = 0;
	new CDuty[MAX_PLAYERS] = 0;
	new Float: HRPos[MAX_PLAYERS][3];
	new chosenpid;
	new invitedby[MAX_PLAYERS];
	new invitedto[MAX_PLAYERS];
	
	new ConeInfo[MAX_CONES][cInfo];
	new CadeInfo[MAX_BARRICADES][bInfo];
	
	new rtimer[MAX_PLAYERS];
	
	new JobCPT[MAX_PLAYERS] = 0;
	new FedexCPT[MAX_PLAYERS] = 0;
	new CDLCPT[MAX_PLAYERS] = 0;
	new PizzaDeliveryCPT[MAX_PLAYERS] = 0;
	new DrugSCPT[MAX_PLAYERS] = 0;
	new WareHouseCPT[MAX_PLAYERS] = 0;
	
	new PlayerOnMission[MAX_PLAYERS];
	new TaxiCall = 999;
	new TransportDuty[MAX_PLAYERS];
	new TaxiCallTime[MAX_PLAYERS];
	new TaxiAccepted[MAX_PLAYERS];
	new TransportValue[MAX_PLAYERS];
	new TransportMoney[MAX_PLAYERS];
	new TransportTime[MAX_PLAYERS];
	new TransportCost[MAX_PLAYERS];
	new TransportDriver[MAX_PLAYERS];
	new ConsumingMoney[MAX_PLAYERS];
	new TaxiDestTimer[MAX_PLAYERS];
	new TaxiDriver[MAX_PLAYERS] = -1;
	new paydaycount;
	new Text: ServerLogo;
	new Text: Clock;
	new Tie[MAX_PLAYERS];
	new OOCChannel = 1;
	new OOCEnabled[MAX_PLAYERS] = 1;
	new AES[MAX_PLAYERS] = 0;
	new AntiEMSTimer[MAX_PLAYERS];
	new DeliverdTo[MAX_PLAYERS] = 0;
	new HospitalTimer[MAX_PLAYERS];
	new HospitalCount[MAX_PLAYERS] = 0;
	new AdminAntiSpam[MAX_PLAYERS] = 0;
	new Seatbelt[MAX_PLAYERS] = 0;
	new CountDown = 0;
	new NewbTimer[MAX_PLAYERS] = 0;
	new NPCVeh;
	new Refueled[MAX_VEHICLES] = 0;
	new RefuelSpamTimer[MAX_PLAYERS] = 0;
	new Explotions = 0;
	new ExplotionTimer;
	
	new Materials = 1000;
	
	new FlasherState[MAX_VEHICLES];
	new Flasher[MAX_VEHICLES] = 0;
	new obj3[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
	new obj4[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
	new obj5[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
	new LightPwr[MAX_VEHICLES];
	new FlashTimer;
	new obj[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
	new obj2[MAX_VEHICLES] = { INVALID_OBJECT_ID, ... };
	
	new Text:Rand;
	
	new Float:DealershipSpawn[3][3] =
	{
		{ 1656.3328, -1136.0929, 24.3675 },
		{ 1610.5627, -1060.3586, 25.5966 },
		{ 1674.8198, -1078.8434, 25.2936 }
	};
	
	new Float:FuelDepot[6][3] =
	{
		{ -166.6990, -276.1116, 3.1207 }, //CDL HQ
		{ -66.4684,- 1123.0426, 0.8052 }, //RS Haul
		{ 16.9021, -2648.6677, 40.4763 }, //24/7
		{ 988.1370, -913.9357, 41.7431 }, //Broadway
		{ 1925.5553, -1791.7350, 12.9546 }, //Idlewood Gas Station
		{ -1708.3915, 393.3517, 6.7286 } //Xoomer San Fransisco
	};
	
	new Float:PizzaDelivery[5][3] =
	{
		{ 2376.6804, -1726.1909, 12.8306 },
		{ 2486.2451, -2018.0354, 12.8310 },
		{ 2442.5657, -1357.1765, 23.2839 },
		{ 2150.1946, -1292.3408, 23.2613 },
		{ 1972.4944, -1636.0623, 15.2525 }
	};
	
	new Text:ServerMSG;

	new RMessages[][] =
	{
		"~y~Random News: ~w~ Use /update to see latest updates",
		"~y~Random News: ~w~ Use /rules to see basic rules",
		"~y~Random News: ~w~ Please register at forums.Escudo-gaming.com",
		"~y~Random News: ~w~ New update is under development",
		"~y~Random News: ~w~ Use /report if you see a hacker",
		"~y~Random News: ~w~ Use /newb to ask a question"
	};
	

//////////////////////////////////////////////////////////////////////////////////////////
//============================== STOCKS ================================================//
//////////////////////////////////////////////////////////////////////////////////////////

stock pName(playerid)
{
    new gName[MAX_PLAYER_NAME];
	GetPlayerName( playerid, gName, sizeof gName );
	return gName;
}

stock MySQL_Register(playerid, passwordstring[])
{
    new Query[512], IP[16];
    GetPlayerIp(playerid, IP, sizeof(IP));

	strcat(Query, "INSERT INTO `PlayerData`(`Username`,`Password`,`pCash`,`pAdminLevel`,`pVipLevel`, `pModerator`,`pSkin`,`pIP`,`pLevel`,`pAge`,`pGender`,`pPlayingTime`,`pJob1`,`pPosX`,`pPosY`,`pPosZ`, `pBanned`, `pNewbMute`)");
	strcat(Query, " VALUES ('%s', SHA1('%s'), 10000, 0, 0, 0, 0, '%s', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)");
	mysql_format(dbHandle, Query,sizeof(Query), Query, pName(playerid), passwordstring, IP);
	mysql_query(dbHandle, Query,false);
	
	format(Query, sizeof(Query), "INSERT INTO `PWeapons`(`Username`) VALUES ('%s')", pName(playerid));
	mysql_query(dbHandle, Query, false);
	
   // pInfo[playerid][pLogged] = 1;
	
	pInfo[playerid][pCash] = 10000;
	pInfo[playerid][pBank] = 25000;
	pInfo[playerid][pAdminLevel] = 0;
	pInfo[playerid][pVipLevel] = 0;
	pInfo[playerid][pLevel] = 1;
	pInfo[playerid][pBanned] = 0;
	
	SetPlayerScore(playerid, pInfo[playerid][pLevel]);
	
	SetTimerEx("PlayerTime", 1000, true, "i", playerid);
	SetTimerEx("WepHack", 5000, true, "i", playerid);
	
	SetPlayerColor(playerid, GetPlayerColor(playerid) & 0xFFFFFF00);
	
	return 1;
}

stock MySQL_Login(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new Query[512], savestr[64], rows, fields;
		mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `PlayerData` WHERE `Username` = '%s'", pName(playerid));
		mysql_query(dbHandle,Query);
	    cache_get_data(rows, fields);
	    if(rows)
	    {
			cache_get_field_content(0, "Email", savestr);           pInfo[playerid][pEmail] = savestr;
			cache_get_field_content(0, "pBanned", savestr);			pInfo[playerid][pBanned] = strval(savestr);
	        cache_get_field_content(0, "pCash", savestr);   		pInfo[playerid][pCash] = strval(savestr);
			cache_get_field_content(0, "pBank", savestr);   		pInfo[playerid][pBank] = strval(savestr);
	        cache_get_field_content(0, "pAdminLevel", savestr);  	pInfo[playerid][pAdminLevel] = strval(savestr);
			cache_get_field_content(0, "pModerator", savestr);  	pInfo[playerid][pModerator] = strval(savestr);
	        cache_get_field_content(0, "pVipLevel", savestr);    	pInfo[playerid][pVipLevel] = strval(savestr);
			cache_get_field_content(0, "pSkin", savestr);   		pInfo[playerid][pSkin] = strval(savestr);
			cache_get_field_content(0, "pLevel", savestr); 			pInfo[playerid][pLevel] = strval(savestr);
			cache_get_field_content(0, "pGender", savestr); 		pInfo[playerid][pGender] = strval(savestr);
			cache_get_field_content(0, "pAge", savestr); 			pInfo[playerid][pAge] = strval(savestr);
			cache_get_field_content(0, "pPlayingTime", savestr); 	pInfo[playerid][pHours] = strval(savestr);
			cache_get_field_content(0, "pFaction", savestr);		pInfo[playerid][pFaction] = strval(savestr);
			cache_get_field_content(0, "pFacRank", savestr);		pInfo[playerid][pFacRank] = strval(savestr);
			cache_get_field_content(0, "pWanted", savestr);			pInfo[playerid][pWanted] = strval(savestr);
			cache_get_field_content(0, "pCrimes", savestr);			pInfo[playerid][pCrimes] = strval(savestr);
			cache_get_field_content(0, "pArrests", savestr);		pInfo[playerid][pArrests] = strval(savestr);
			cache_get_field_content(0, "pJail", savestr);			pInfo[playerid][pJail] = strval(savestr);
			cache_get_field_content(0, "pBail", savestr);			pInfo[playerid][pBail] = strval(savestr);
			cache_get_field_content(0, "pPhone", savestr);			pInfo[playerid][pPhone] = strval(savestr);
			cache_get_field_content(0, "pJob1", savestr);			pInfo[playerid][pJob1] = strval(savestr);
			cache_get_field_content(0, "pPosX", savestr);			pInfo[playerid][pPosX] = strval(savestr);
			cache_get_field_content(0, "pPosY", savestr);			pInfo[playerid][pPosY] = strval(savestr);
			cache_get_field_content(0, "pPosZ", savestr);			pInfo[playerid][pPosZ] = strval(savestr);
			cache_get_field_content(0, "pNewbMute", savestr);		pInfo[playerid][pNewbMute] = strval(savestr);
			cache_get_field_content(0, "pAMMute", savestr);			pInfo[playerid][pAMMute] = strval(savestr);
			cache_get_field_content(0, "pInt", savestr);			pInfo[playerid][pInt] = strval(savestr);
			cache_get_field_content(0, "pVW", savestr);				pInfo[playerid][pVW] = strval(savestr);
			cache_get_field_content(0, "pHouses", savestr);			pInfo[playerid][pHouses] = strval(savestr);
			cache_get_field_content(0, "pWeaponSold", savestr);		pInfo[playerid][pWepSold] = strval(savestr);
			cache_get_field_content(0, "pWLevel", savestr);			pInfo[playerid][pWepLevel] = strval(savestr);
			cache_get_field_content(0, "pMats", savestr);			pInfo[playerid][pMats] = strval(savestr);
			cache_get_field_content(0, "pSpraycan", savestr);		pInfo[playerid][pSpraycans] = strval(savestr);
			cache_get_field_content(0, "pRope", savestr);			pInfo[playerid][pRope] = strval(savestr);
			cache_get_field_content(0, "pBandage", savestr);		pInfo[playerid][pBandage] = strval(savestr);
			cache_get_field_content(0, "pMorphine", savestr);		pInfo[playerid][pMorphine] = strval(savestr);

			SetPlayerScore(playerid, pInfo[playerid][pLevel]);
		    pInfo[playerid][pLogged] = 1;
	  	}
		new str1[300];
		format(str1,sizeof(str1),"User Name: %s\n Banned: %i\nMoney: %i\nAdmin Level: %i\nVip Level: %i\nSkin: %i",
		pName(playerid), pInfo[playerid][pBanned],pInfo[playerid][pCash],pInfo[playerid][pAdminLevel],pInfo[playerid][pVipLevel],pInfo[playerid][pSkin]);
		pInfo[playerid][pLogged] = 1;
		
		if(pInfo[playerid][pPosX] == 0 && pInfo[playerid][pPosY] == 0 && pInfo[playerid][pPosZ] == 0)
		{
			pInfo[playerid][pPosX] = 1780.1759;
			pInfo[playerid][pPosY] = -1933.6698;
			pInfo[playerid][pPosZ] = 13.3859;
			SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ], 5, 0, 0, 0, 0, 0, 0);
			SpawnPlayer(playerid);
			SetPlayerHealth(playerid, 100);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid, pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ]);
			SendClientMessage(playerid, COLOR_ORANGE, "You're last location did not save successfully. We are sorry for the inconvenience.");
			SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
			
		}
		if(pInfo[playerid][pJail] >= 1)
		{
			new rand = random(sizeof(CellDestinations));
			SetPVarInt(playerid, "Dragged", 0);
			SetPVarInt(playerid, "Cuffed", 0);
			TogglePlayerControllable(playerid, 1);
			ResetPlayerWeapons(playerid);
			FreezePlayer(playerid, 3);
			SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], CellDestinations[rand][0], CellDestinations[rand][1], CellDestinations[rand][2], 5, 0, 0, 0, 0, 0, 0);
			SetPlayerInterior(playerid, pInfo[playerid][pInt]);
			SendClientMessage(playerid, COLOR_LIGHTRED, "You are still in jail.");
			rtimer[playerid] = SetTimerEx("arrestrelease", 60000, true, "i", playerid);
		}
		else
		{
			if(pInfo[playerid][pSkin] == 0)
			{
				new skin = random(299)+1;
				pInfo[playerid][pSkin] = skin;
				SetPlayerSkin(playerid, skin);
				SendClientMessage(playerid, COLOR_ORANGE, "We have spawned you with a new skin. We are sorry for the inconvenience.");
				return 1;
			}
			SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], pInfo[playerid][pPosX], pInfo[playerid][pPosY], pInfo[playerid][pPosZ], 5, 0, 0, 0, 0, 0, 0);
			SetPlayerInterior(playerid, pInfo[playerid][pInt]);
			SetPlayerVirtualWorld(playerid, pInfo[playerid][pVW]);
			SpawnPlayer(playerid);
			SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
		}
		if(pInfo[playerid][pModerator] >= 1)
		{
			SendClientMessage(playerid, COLOR_CYAN, "Welcome Moderators. Please use /cduty to go on duty and answer /newb.");
		}
		
		ResetVars(playerid);
		TogglePlayerSpectating(playerid, 0);
		SetPVarInt(playerid, "Logged", 1);
		SetPlayerWantedLevel(playerid, pInfo[playerid][pWanted]);
		SetPlayerScore(playerid, pInfo[playerid][pLevel]);
		SetPlayerColor(playerid, GetPlayerColor(playerid) & 0xFFFFFF00);
	}
	Load_Weapons(playerid);
	SetTimerEx("PlayerTime", 1000, true, "i", playerid);
	SetTimerEx("WepHack", 5000, true, "i", playerid);
	CleanPlayerChat(playerid);
	KillTimer(LoseHPTimer[playerid]);
	ResetVars(playerid);
	return 1;
}

stock SaveStats(playerid)
{
	if(GetPVarInt(playerid, "Logged") == 1)
	{
		new Query[1028];
		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		pInfo[playerid][pSkin] = GetPlayerSkin(playerid);
		
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PlayerData` SET `pCash` = '%d', `pBank` = '%d', `pAdminLevel` = '%d', `pModerator` = '%d', `pVipLevel` = '%d' WHERE `Username` = '%s'",
		pInfo[playerid][pCash],
		pInfo[playerid][pBank],
		pInfo[playerid][pAdminLevel],
		pInfo[playerid][pModerator],
		pInfo[playerid][pVipLevel],
		pName(playerid));
		mysql_query(dbHandle,Query,false); 
		
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PlayerData` SET `pSkin` = '%d', `pLevel` = '%d', `pFaction` = '%d', `pFacRank` = '%d' WHERE `Username` = '%s'",
		pInfo[playerid][pSkin],
		pInfo[playerid][pLevel],
		pInfo[playerid][pFaction],
		pInfo[playerid][pFacRank],
		pName(playerid));
		mysql_query(dbHandle,Query,false); 
		
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PlayerData` SET `pPlayingTime` = '%d', `pWanted` = '%d', `pCrimes` = '%d', `pArrests` = '%d' WHERE `Username` = '%s'",
		pInfo[playerid][pHours],
		pInfo[playerid][pWanted],
		pInfo[playerid][pCrimes],
		pInfo[playerid][pArrests],
		pName(playerid));
		mysql_query(dbHandle,Query,false); 
		
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PlayerData` SET `pJail` = '%d', `pBail` = '%d', `pPhone` = '%d', `pJob1` = '%d' WHERE `Username` = '%s'",
		pInfo[playerid][pJail],
		pInfo[playerid][pBail],
		pInfo[playerid][pPhone],
		pInfo[playerid][pJob1],
		pName(playerid));
		mysql_query(dbHandle,Query,false); 
		
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PlayerData` SET `pPosX` = '%f', `pPosY` = '%f', `pPosZ` = '%f', `pNewbMute` = '%d', `pAMMute` = '%d', `pInt` = '%d', `pVW` = '%d', `pHouses` = '%d', `pWeaponSold` = %d, `pWLevel` = %d, `pMats` = %d WHERE `Username` = '%s'",
		X,
		Y,
		Z,
		pInfo[playerid][pNewbMute],
		pInfo[playerid][pAMMute],
		pInfo[playerid][pInt],
		pInfo[playerid][pVW],
		pInfo[playerid][pHouses],
		pInfo[playerid][pWepSold],
		pInfo[playerid][pWepLevel],
		pInfo[playerid][pMats],
		pName(playerid));
		mysql_query(dbHandle,Query,false); 
		
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PlayerData` SET `pHRs` = '%d', `pSpraycan` = '%d', `pRope` = '%d', `pBandage` = '%d', `pMorphine` = '%d' WHERE `Username` = '%s'",
		pInfo[playerid][pHRs],
		pInfo[playerid][pSpraycans],
		pInfo[playerid][pRope],
		pInfo[playerid][pBandage],
		pInfo[playerid][pMorphine],
		pName(playerid));
		mysql_query(dbHandle,Query,false);
		
		Save_Weapons(playerid);
		
	}
	return 1;
}

stock ResetVars(playerid)
{
	ResetPlayerMoney(playerid);
	SetPlayerScore(playerid, 0);
	
	SetPVarInt(playerid, "ReportPending", 0);
	SetPVarString(playerid, "ReportText", "zero");
	SetPVarInt(playerid, "ReportTime", 0);
	SetPVarInt(playerid, "Injured", 0);
	SetPVarInt(playerid, "Recovering", 0);
	SetPVarInt(playerid, "HRPending", 0);
	SetPVarInt(playerid, "OnHR", 0);
	
	SetPVarInt(playerid, "Dragged", 0);
	SetPVarInt(playerid, "PickupRefuel", 0);
	SetPVarInt(playerid, "AdminDuty", 0);
	
	IsDead [playerid] = 0;
	SecsToGo [playerid] = 0;
	IsAfterLifing [playerid] = 0;
	tognewbie[playerid] = 0;
	
	waitcheck[playerid] = 0;
	tazer[playerid] = 0;
	tazerreplace[playerid] = 0;
	beingdragged[playerid] = 0;
	cardetain[playerid] = 0;
	Call911[playerid] = 0;
	OnCall[playerid] = -1;
	
	KillTimer(LoseHPTimer[playerid]);
	
	return 1;
}

stock SetPlayerMoney(playerid, cash)
{
	if(GetPlayerMoney(playerid) != pInfo[playerid][pCash])
	{
		ResetPlayerMoney(playerid);
		return GivePlayerMoney(playerid, cash);
	}
	else return 0;
}

stock ProxDetector(Float:radi, playerid, string[],color)
{
    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid,x,y,z);
    foreach(Player,i)
    {
        if(IsPlayerInRangeOfPoint(i,radi,x,y,z))
        {
            SendClientMessage(i,color,string);
        }
    }
    return 1;
}

stock Log(FileName[], Input[]) {

	new string[156], date[2][3], File: fileHandle = fopen(FileName, io_append);
	gettime(date[0][0], date[0][1], date[0][2]);
	getdate(date[1][0], date[1][1], date[1][2]);
	format(string, sizeof(string), "[%i/%i/%i - %i:%i:%i] %s\r\n", date[1][2], date[1][1], date[1][0], date[0][0], date[0][1], date[0][2], Input);
	fwrite(fileHandle, string);
	return fclose(fileHandle);
}

stock GetName(playerid)
{
    new
        name[24];
    GetPlayerName(playerid, name, sizeof(name));
    strreplace(name, '_', ' ');
    return name;
}

stock GetNameEx(playerid)
{
    new
        name[24];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

stock strreplace(string[], find, replace)
{
    for(new i=0; string[i]; i++)
    {
        if(string[i] == find)
        {
            string[i] = replace;
        }
    }
}

stock ShowStats(playerid, targetid)
{
	new Stats[1028];
	new string[128];
	new hTime = pInfo[targetid][pHours]/60/60;

	format(string, sizeof(string), " Name: %s | Gender: %s | Age: %i | Playing Hours: %i | Level: %i\n", GetName(targetid), GetGender(targetid), pInfo[targetid][pAge], hTime, pInfo[targetid][pLevel]);
	strcat(Stats, string, sizeof(Stats));
	format(string, sizeof(string), " Cash: R%i | Bank: R%i | Wealth: R%i \n", pInfo[targetid][pCash], pInfo[targetid][pBank], pInfo[targetid][pCash] + pInfo[targetid][pBank]);
	strcat(Stats, string, sizeof(Stats));
	format(string, sizeof(string), " Job: %s | Materials: %i \n", GetJobName1(targetid), pInfo[targetid][pMats]);
	strcat(Stats, string, sizeof(Stats));
	format(string, sizeof(string), " Phone Number: %i | Spray Cans: %i | Rope: %i \n", pInfo[targetid][pPhone], pInfo[targetid][pSpraycans], pInfo[targetid][pRope]);
	strcat(Stats, string, sizeof(Stats));
	
	if(pInfo[targetid][pFaction] >= 1)
	{
		format(string, sizeof(string), " Faction: %s | Rank: %s \n", GetFactionName(targetid), GetRankName(targetid));
		strcat(Stats, string, sizeof(Stats));
	}
	if(pInfo[targetid][pModerator] >= 1)
	{
		format(string, sizeof(string), " Moderator: %s \n", GetModName(targetid));
		strcat(Stats, string, sizeof(Stats));
	}
	if(pInfo[targetid][pAdminLevel] >= 1)
	{
		format(string, sizeof(string), " Admin: %s \n", GetAdminName(targetid));
		strcat(Stats, string, sizeof(Stats));
	}
	format(string, sizeof(string), " \nRegistered Email: %s\n", pInfo[targetid][pEmail]);
	strcat(Stats, string, sizeof(Stats));
	
	ShowPlayerDialog(playerid, DIALOG_STATISTIC, DIALOG_STYLE_MSGBOX, "Stats", Stats, "Ok", "");
}

stock GetGender(targetid)
{
	new string[24];
	if(pInfo[targetid][pGender] == 1)
	{
		string = "Male";
	}
	if(pInfo[targetid][pGender] == 2)
	{
		string = "Female";
	}
	return string;
}

stock SendClientMessageToAdmins(color,string[],level)
{
	foreach(Player, i)
	{
	    if(!IsPlayerConnected(i)) return 1;
		if(pInfo[i][pAdminLevel] >= level)
		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock SendClientMessageToAdminsOnDuty(color,string[],level)
{
	foreach(Player, i)
	{
		if(AdminDuty[i] != 1)
		{		
			if(!IsPlayerConnected(i)) return 1;
			if(pInfo[i][pAdminLevel] >= level)
			{
				SendClientMessage(i, color, string);
				//printf("%s", string);
			}
		}
	}
	return 1;
}

stock SendClientMessageToMods(color,string[],level)
{
	foreach(Player, i)
	{
	    if(!IsPlayerConnected(i)) return 1;
		if(pInfo[i][pModerator] >= level || pInfo[i][pAdminLevel] >= level)
		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock SendClientMessageToModsOnDuty(color,string[],level)
{
	foreach(Player, i)
	{
	    if(!IsPlayerConnected(i)) return 1;
		if(pInfo[i][pModerator] >= level)
		{
			if(CDuty[i] == 1)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

stock GetModName(playerid)
{
	new string[56];
	switch(pInfo[playerid][pModerator])
	{
		case 1: string = "Junior Moderator";
		case 2: string = "Moderator";
		case 3: string = "Senior Moderator";
		case 4: string = "Cheif Moderator";
	}
	return string;
}

stock GetAdminName(playerid)
{
	new string[56];
	switch(pInfo[playerid][pAdminLevel])
	{
		case 1: string = "Junior Staff";
		case 2: string = "Staff";
		case 3: string = "General Staff";
		case 4: string = "Senior Staff";
		case 5: string = "Supervisor";
		case 6: string = "Shift Manager";
		case 7: string = "Operations Manager";
		case 8: string = "Server Director";
	}
	return string;
}

stock GetFactionName(playerid)
{
	new string[128];
	switch(pInfo[playerid][pFaction])
	{
		case 1: string = "South African Police Department";
		case 2: string = "South African Fire Medic Department";
	}
	return string;
}

stock GetFacName(playerid)
{
	new string[128];
	switch(pInfo[playerid][pFaction])
	{
		case 1: string = "SAPD";
		case 2: string = "SAFMD";
	}
	return string;
}

stock GetRankName(playerid)
{
	new string[128];
	if(pInfo[playerid][pFaction] == 1)
	{
		switch(pInfo[playerid][pFacRank])
		{
			case 1: string = "Police Officer I";
			case 2: string = "Police Officer II";
			case 3: string = "Police Officer III";
			case 4: string = "Police Detective I";
			case 5: string = "Police Detective II";
			case 6: string = "Police Sergeant I";
			case 7: string = "Police Sergeant II";
			case 8: string = "Police Lieutenant";
			case 9: string = "Police Captain";
			case 10: string = "Police Commander";
			case 11: string = "Police Deputy Chief";
			case 12: string = "Assistant Chief";
			case 13: string = "Chief of Police";
		}
	}
	if(pInfo[playerid][pFaction] == 2)
	{
		switch(pInfo[playerid][pFacRank])
		{
			case 1: string = "Junior Firefighter";
			case 2: string = "Probationary";
			case 3: string = "Rookie Firefighter";
			case 4: string = "Firefighter EMT";
			case 5: string = "Firefighter Paramedic";
			case 6: string = "Engineer";
			case 7: string = "Aerial Operator";
			case 8: string = "Captain I";
			case 9: string = "Caption II";
			case 10: string = "Battalion Cheif";
			case 11: string = "Assistan Cheif";
			case 12: string = "Deputy Cheif";
			case 13: string = "Chief Of Department";
		}
	}
	return string;
}

stock GetJobName1(playerid)
{
	new string[56];
	switch(pInfo[playerid][pJob1])
	{
		case 0: string = "Unemployed";
		case 1: string = "Fedex Driver";
		case 2: string = "Arms Dealer";
		case 3: string = "Pizza Delivery";
		case 4: string = "Drug Smuggler";
		case 5: string = "Taxi Driver";
		case 6: string = "Warehouse Worker";
	}
	return string;
}

stock Checkban(playerid)
{
	new Query[215], rows, fields, pIP2[215];
	new bReason[215], bannedBy[215], savestr[215];
	GetPlayerIp(playerid, pIP2, sizeof(pIP2));
	mysql_format(dbHandle, Query, sizeof(Query), "SELECT * FROM `Bans` WHERE `Name` = '%e'", pName(playerid));
	mysql_query(dbHandle,Query);
	cache_get_data(rows, fields);
	if(rows)
	{
		cache_get_field_content(0, "Reason", savestr);			bReason = savestr;
		cache_get_field_content(0, "BannedBy", savestr);		bannedBy = savestr;
		
		new string[256], IP[24], dialogText[500];
		
		GetPlayerIp(playerid, IP, sizeof(IP));
        format(string, sizeof(string), "%s Banned - %s", COL_ORANGE, GetName(playerid));		
		format(dialogText, sizeof(dialogText), "You are banned from this server \n\nReason: %s\n\nBanned By: %s", bReason, bannedBy);
		pInfo[playerid][pBanned] = 1;
	    ShowPlayerDialog(playerid, DIALOG_BANNED, DIALOG_STYLE_MSGBOX, string, dialogText, "Ok", "");
	}
	return 0;
}

stock CleanPlayerChat(playerid)
{
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
    SendClientMessage(playerid,WHITE," ");
}

stock Newbie(string[])
{
	foreach(Player, i)
	{
	    if(!IsPlayerConnected(i)) return 1;
	    if(tognewbie[i] == 0)
	    {
	        SendClientMessage(i, COLOR_NEWBIE, string);
		}
	}
	return 1;
}

stock Float:GetDistance(Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2)
{
	new Float:d;
	d += floatpower(x1-x2, 2.0);
	d += floatpower(y1-y2, 2.0);
	d += floatpower(z1-z2, 2.0);
	d = floatsqroot(d);
	return d;
}

stock SendClientMessageToSAPD(color,string[])
{
	foreach(Player, i)
	{
	    if(!IsPlayerConnected(i)) return 1;
		if(pInfo[i][pFaction] == 1 && GetPVarInt(i, "Logged") == 1)
		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock SendClientMessageToSAPDOnDuty(color,string[])
{
	foreach(Player, i)
	{
	    if(!IsPlayerConnected(i)) return 1;
		if(pInfo[i][pFaction] == 1 && GetPVarInt(i, "Logged") == 1)
		{
			if(OnDuty[i] == 1)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

stock SendClientMessageToLAFMD(color,string[])
{
	foreach(Player, i)
	{
	    if(!IsPlayerConnected(i)) return 1;
		if(pInfo[i][pFaction] == 2 && GetPVarInt(i, "Logged") == 1)
		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock SendClientMessageToLAFMDOnDuty(color,string[])
{
	foreach(Player, i)
	{
	    if(!IsPlayerConnected(i)) return 1;
		if(pInfo[i][pFaction] == 2 && GetPVarInt(i, "Logged") == 1)
		{
			if(OnDuty[i] == 1)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

stock SendClientMessageToDepartments(color,string[])
{
	foreach(Player, i)
	{
	    if(!IsPlayerConnected(i)) return 1;
		if(pInfo[i][pFaction] == 1 || pInfo[i][pFaction] == 2 || pInfo[i][pFaction] == 3 && GetPVarInt(i, "Logged") == 1)
		{
			SendClientMessage(i, color, string);
		}
		if(!IsPlayerConnected(i)) return 1;
	}
	return 1;
}

stock RemovePlayerWeapon(playerid, weaponid)
{
    new
        plyWeapons[ 12 ], plyAmmo[ 12 ];

    for( new slot = 0; slot != 12; slot ++ )
    {
        new
            weap, ammo;
            
        GetPlayerWeaponData( playerid, slot, weap, ammo );
        if( weap != weaponid )
        {
            GetPlayerWeaponData( playerid, slot, plyWeapons[ slot ], plyAmmo[ slot ] );
        }
    }
    ResetPlayerWeapons( playerid );
    for( new slot = 0; slot != 12; slot ++ )
    {
        GivePlayerWeapon( playerid, plyWeapons[ slot ], plyAmmo[ slot ] );
    }
}

stock RemovePlayerWeapons(playerid)
{
    for(new i = 0; i <= 11; i++)
	{
		gInfo[playerid][pGuns][i] = 0;
	}
	ResetPlayerWeapons(playerid);
}

stock IsPlayerNearVehicle(playerid, vehicleid, Float:range)
{
    if(!GetVehicleModel(vehicleid)) return 0;
    new Float:x, Float:y, Float:z;
    GetVehiclePos(vehicleid, x, y, z);
    return IsPlayerInRangeOfPoint(playerid, range, x, y, z);
}

forward Unfreeze(playerid);
public Unfreeze(playerid)
{
    TogglePlayerControllable(playerid, 1);
    return 1;
}

stock FreezePlayer(playerid, time)
{
    SetTimerEx("Unfreeze", time*1000, false, "u", playerid);
    TogglePlayerControllable(playerid, 0);
    return 1;
}

stock LoadMapIcons(playerid)
{
	for(new i = 1; i < MAX_FSTATIONS; i++)
	{
		CreateDynamicMapIcon(fInfo[i][fPos][0], fInfo[i][fPos][1], fInfo[i][fPos][2], 56, 0, -1, -1, playerid, 200.0);
	}
}

stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock CreateCone(Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(ConeInfo); i++)
  	{
  	    if(ConeInfo[i][sCreated] == 0)
  	    {
            ConeInfo[i][sCreated]=1;
            ConeInfo[i][sX]=x;
            ConeInfo[i][sY]=y;
            ConeInfo[i][sZ]=z-1;
            ConeInfo[i][sObject] = CreateDynamicObject(1238, x, y, z-0.7, 0, 0, Angle);
	        return 1;
  	    }
  	}
  	return 0;
}

stock DeleteAllCone()
{
    for(new i = 0; i < sizeof(ConeInfo); i++)
  	{
  	    if(ConeInfo[i][sCreated] == 1)
  	    {
  	        ConeInfo[i][sCreated]=0;
            ConeInfo[i][sX]=0.0;
            ConeInfo[i][sY]=0.0;
            ConeInfo[i][sZ]=0.0;
            DestroyDynamicObject(ConeInfo[i][sObject]);
  	    }
	}
    return 0;
}

stock CreateCade(Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(CadeInfo); i++)
  	{
  	    if(CadeInfo[i][sCreated] == 0)
  	    {
            CadeInfo[i][sCreated]=1;
            CadeInfo[i][sX]=x;
            CadeInfo[i][sY]=y;
            CadeInfo[i][sZ]=z;
            CadeInfo[i][sObject] = CreateDynamicObject(978, x, y, z, 0, 0, Angle);
	        return 1;
  	    }
  	}
  	return 0;
}

stock DeleteClosestCade(playerid)
{
    for(new i = 0; i < sizeof(CadeInfo); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 4.0, CadeInfo[i][sX], CadeInfo[i][sY], CadeInfo[i][sZ]))
        {
  	        if(CadeInfo[i][sCreated] == 1)
            {
                CadeInfo[i][sCreated]=0;
                CadeInfo[i][sX]=0.0;
                CadeInfo[i][sY]=0.0;
                CadeInfo[i][sZ]=0.0;
                DestroyDynamicObject(CadeInfo[i][sObject]);
                new str[176], zone[64];
               	GetPlayer3DZone(playerid);
				format(str, sizeof(str), "* %s %s has picked up a barricade at %s", GetRankName(playerid), GetName(playerid), zone);
				SendClientMessageToSAPD(RADIO, str);
                return 1;
  	        }
  	    }
  	}
    return 0;
}

stock DeleteAllCade()
{
    for(new i = 0; i < sizeof(CadeInfo); i++)
  	{
  	    if(CadeInfo[i][sCreated] == 1)
  	    {
  	        CadeInfo[i][sCreated]=0;
            CadeInfo[i][sX]=0.0;
            CadeInfo[i][sY]=0.0;
            CadeInfo[i][sZ]=0.0;
            DestroyDynamicObject(CadeInfo[i][sObject]);
  	    }
	}
    return 0;
}

stock IsNearLoadingPoint(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 20, 1141.23, -1326.42, 13.65)) return 1;
	if(IsPlayerInRangeOfPoint(playerid, 20, 2017.17, -1413.84, 16.99)) return 1;
	return 0;
}

stock doesAccountExist(account_name[])
{
	new Query[300], rows, fields;
	mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `PlayerData` WHERE `Username` = '%e'", account_name);
	mysql_query(dbHandle,Query);
	cache_get_data(rows, fields);
	if(rows)
	{		
		return 1;
	}
	return 0;
}

stock GetClosestVehicle(playerid, Float:range)
{
    new     Float:p_X;
    new     Float:p_Y;
    new     Float:p_Z;

    new     Float:Distance;
    new     Float:PretendentDistance = range +1;
    new     Pretendent;

    GetPlayerPos(playerid, p_X, p_Y, p_Z);

    for(new vehicleid=1; vehicleid < MAX_VEHICLES; vehicleid++)
    {
        Distance = GetVehicleDistanceFromPoint(vehicleid, p_X, p_Y, p_Z);

        if(Distance <= range && Distance <= PretendentDistance)
        {
            Pretendent = vehicleid;
            PretendentDistance = Distance;
        }
    }

    return Pretendent;
}

//////////////////////////////////////////////////////////////////////////////////////////
//============================== PUBLICS ===============================================//
//////////////////////////////////////////////////////////////////////////////////////////

main()
{
	print("\n----------------------------------");
	print("Escudo-Gaming by BladeMaster680");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	ConnectNPC("Crazy_Train_Driver","Train");
	NPCVeh = AddStaticVehicle(538, -1943.0624, 158.9263, 25.7186, 358.2109, 3, 252);
	settime();
	SetGameModeText("Escudo:RP V0.2");
	DisableInteriorEnterExits();
	LimitGlobalChatRadius(0);
	EnableStuntBonusForAll(0);
	ManualVehicleEngineAndLights();
    mysql_log(LOG_ERROR | LOG_WARNING);
    dbHandle = mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS);
	if(!mysql_errno())
	{
	    print("[SERVER SUCCESS]: Connection to database succcessfully establishied.");
	}
	else
	{
		print("[CRITICAL SERVER ERROR]: Connection to database could not pass. Gamemode wont work.");
		SendRconCommand("exit");
	}
	AddPlayerClass(0 ,1757.4214, -1866.6447, 13.5712, 358.6700, 0, 0, 0, 0, 0, 0);
	
	SetTimer("MSG", 8000, true);
	ServerMSG = TextDrawCreate(5.000000, 428.000000, " ");
	TextDrawColor(ServerMSG, Light_Blue);
	TextDrawFont(ServerMSG, 1);
	TextDrawLetterSize(ServerMSG, 0.400000, 0.800000);
	
	ServerLogo = TextDrawCreate(545 , 2, "Escudo-Gaming");
	TextDrawFont(ServerLogo , 3);
	TextDrawLetterSize(ServerLogo , 0.3, 1.5);
	TextDrawColor(ServerLogo , 0xff8400FF);
	TextDrawSetOutline(ServerLogo , false);
	TextDrawSetProportional(ServerLogo , true);
	TextDrawSetShadow(ServerLogo , 1);
	
	Clock = TextDrawCreate(547.0, 24.0, "--:--");
	TextDrawLetterSize(Clock, 0.6, 1.8);
	TextDrawFont(Clock, 3);
	TextDrawSetOutline(Clock, 2);
	SetTimer("settime", 10000, true);
	
	Rand = TextDrawCreate(499.000000, 78.000000, "~g~R");
    TextDrawBackgroundColor(Rand, 255);
    TextDrawFont(Rand, 3);
    TextDrawLetterSize(Rand, 0.539999, 2.000000);
    TextDrawColor(Rand, 945269247);
    TextDrawSetOutline(Rand, 0);
    TextDrawSetProportional(Rand, 1);
    TextDrawSetShadow(Rand, 1);
	
	FlashTimer = SetTimer("FlasherFunc",200,1);
    Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 900);
	
	SetTimer("AdminAntiSpamTimer", 3000, 1);
	SetTimer("WepCheck", 10000, 1);
	
	Load_CityHall();
	Load_Carlot();
	Load_Truck();
	LoadPrison();
	Load_FactionHQ();
	Load_OfficeMaps();
	Load_Interiors();
	
	Load_SAPDVehicles();
	Load_LAFMDVehicles();
	
	Load_SpeedoG();
	Load_FuelStations();
	Load_DynamicDoors();
	
	Load_Houses();
	Load_PlayerHouses();
	
	Load_DealershipVehicles();
	Load_Vehicles();
	Load_JobVehicles();
	
	carcount = 0;
    for(new i = 0; i < MAX_ADMIN_CARS; i++)
    {
        AdminCars[i][0] = INVALID_VEHICLE_ID;
        AdminCars[i][1] = INVALID_PLAYER_ID;
    }
	
	CreateDynamic3DTextLabel("Binco - /buyskin", 0x0008080FF, 207.2720, -101.7905, 1005.2578, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	
	CreatePickup(1239, 1, 207.2720, -101.7905, 1005.2578, -1); // Binco /buyskin
	
	/*======== Job Pickups and 3DText ========*/
	
	//Fedex Driver
	CreatePickup(1239, 1, -2170.8921, -216.0832, 35.3203, -1); 
	CreateDynamic3DTextLabel("Fedex Driver - /join", 0x0008080FF, -2170.8921, -216.0832, 35.3203, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	
	//Arms Dealer
	CreatePickup(1239, 1, 1365.5328, -1275.6300 ,13.5469, -1); 
	CreateDynamic3DTextLabel("Arms Dealer - /join", 0x0008080FF, 1365.5328, -1275.6300 ,13.5469, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	
	//Pizza Delivery
	CreatePickup(1239, 1, 2106.3145, -1788.5518, 13.5608, -1);
	CreateDynamic3DTextLabel("Pizza Delivery - /join", 0x0008080FF, 2106.3145, -1788.5518, 13.5608, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	
	//Drug Smuggler
	CreatePickup(1239, 1, 1151.0225, -1203.6011, 19.4515, -1);
	CreateDynamic3DTextLabel("Drug Smuggler - /join", 0x0008080FF, 1151.0225, -1203.6011, 19.4515, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	
	//Taxi Driver
	CreatePickup(1239, 1, 1743.5931, -1861.5200, 13.5774, -1);
	CreateDynamic3DTextLabel("Taxi Driver - /join", 0x0008080FF, 1743.5931, -1861.5200, 13.5774, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	
	//Warehouse Worker
	CreatePickup(1239, 1, 2180.1250, -2256.1853, 14.7734, -1);
	CreateDynamic3DTextLabel("Warehouse Worker - /join", 0x0008080FF, 2180.1250, -2256.1853, 14.7734, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	
	//Materials Pickup
	CreatePickup(1239, 1, 2116.1904, -1887.2052, 13.5391, -1);
	
	//Delivery Pickups LAFMD
	CreatePickup(1239, 1, 2016.95, -1413.74, 16.99);
	CreateDynamic3DTextLabel("Delivery Point - /deliver", 0x0008080FF, 2016.95, -1413.74, 16.99, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	CreatePickup(1239, 1, 1140.90, -1326, 13.64);
	CreateDynamic3DTextLabel("Delivery Point - /deliver", 0x0008080FF, 1140.90, -1326, 13.64, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	
	//Lockers
	CreatePickup(1239, 1, 264.73, 77.07, 1003.64);
	CreateDynamic3DTextLabel("SAPD Locker - /lockers", 0x0008080FF, 264.73, 77.07, 1003.64, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	CreatePickup(1239, 1, 489.0727, 1421.5646, 1084.3738);
	CreateDynamic3DTextLabel("LAFMD Locker - /lockers", 0x0008080FF, 489.0727, 1421.5646, 1084.3738, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1);
	
	
	return 1;
}

public OnGameModeExit()
{
	Save_Vehicles();
    mysql_close();
	KillTimer(FlashTimer);
	return 1;
}

SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerNPC(playerid))
	{
		SetupPlayerForClassSelection(playerid);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	settime();
	Checkban(playerid);
	if(IsPlayerNPC(playerid))
	{
	//	SetPlayerColor(playerid, 0xFFFFFFFF);
	//	SetPlayerVirtualWorld(playerid, 2);
		return 1;
	}
	if(pInfo[playerid][pBanned] == 0)
	{
		SetPlayerColor(playerid, 0xFFFFFFFF);
		ResetVars(playerid);
		TogglePlayerSpectating(playerid, 1);
		SetPlayerCameraPos(playerid, 1479.7424, -1040.2688, 32.1116);
		SetPlayerCameraLookAt(playerid, 1479.1152, -1039.4833, 31.9165);
		SetPlayerCameraPos(playerid, 1479.7424, -1040.2688, 32.1116);
		
		FloodByPlayer[playerid] = 0;
		FloodTimer[playerid] = SetTimerEx("FloodCheck",MAX_FLOOD_RATE_SECS,true,"i",playerid);
		
		Remove_CityHall(playerid);
		Remove_CarLot(playerid);
		Remove_Fedex(playerid);
		Remove_FactionBuildings(playerid);
		
		Load_SpeedoC(playerid);
		Load_LapCounter(playerid);
				
		new Query[300], rows, fields;
		mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `PlayerData` WHERE `Username` = '%e'", pName(playerid));
		mysql_query(dbHandle,Query);
		cache_get_data(rows, fields);
		if(rows)
		{		
			new str[128], string[256], IP[24];
			
			GetPlayerIp(playerid, IP, sizeof(IP));
			format(str, sizeof(str), "%s Login - %s", COL_ORANGE, GetName(playerid));		
			format(string, sizeof(string), "Welcome to Escudo-Gaming, %s \n\n IP Address: %s \n\n That name you are using is registered, please login below.", GetName(playerid), IP);
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, str, string, "Login", "Cancel");
		}
		else if(!rows)
		{
			new PlayerName2[MAX_PLAYER_NAME], Length;
			GetPlayerName(playerid, PlayerName2, sizeof(PlayerName2));
			Length = strlen(PlayerName2);
			if(PlayerName2[Length - 1] == '_' || PlayerName2[0] == '_' || strfind(PlayerName2, "_", false) == -1)
			{
				SendClientMessage(playerid, COLOR_CYAN, "You have failed to connect with a role play name \nplease select another name. \nFirstname_Lastname");
				ShowPlayerDialog(playerid, DIALOG_NAME, DIALOG_STYLE_INPUT,""COL_WHITE"Name Change",""COL_WHITE"Type in another name to play with. \nFirstname_Lastname","Change","No!");
				return 1;
			}
			new str[128], string[164], IP[24];
			
			GetPlayerIp(playerid, IP, sizeof(IP));
			format(str, sizeof(str), "%sRegister - %s", COL_ORANGE, GetName(playerid));
			format(string, sizeof(string), "Welcome to Escudo-Gaming, %s \n\n IP Address: %s \n\n You may register an account by entering a desired password here:", GetName(playerid), IP);
			ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, str, string, "Register", "Cancel");
		}
	}
	
	LoadMapIcons(playerid);
	SetPlayerSkillLevel(playerid, 0, 1);
	SetPlayerSkillLevel(playerid, 1, 1);
	SetPlayerSkillLevel(playerid, 2, 1);
	SetPlayerSkillLevel(playerid, 3, 1);
	SetPlayerSkillLevel(playerid, 4, 1);
	SetPlayerSkillLevel(playerid, 5, 1);
	SetPlayerSkillLevel(playerid, 6, 1);
	SetPlayerSkillLevel(playerid, 7, 1);
	SetPlayerSkillLevel(playerid, 8, 1);
	SetPlayerSkillLevel(playerid, 9, 1);
	SetPlayerSkillLevel(playerid, 10, 1);
	
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new l[56];
	if(reason == 0) { l = "Timed out"; }
	if(reason == 1) { l = "Leaving"; }
	if(reason == 2) { l = "kicked / banned"; }
	if(GetPVarInt(playerid, "Cuffed") == 1 && reason != 2)
	{
	    new brcst[126];
	    format(brcst, sizeof(brcst), "AdmCmd: %s has been automatically prisoned for logging while cuffed. (%s)", GetName(playerid), l);
	    SendClientMessageToAll(COLOR_LIGHTRED, brcst);
		pInfo[playerid][pJail] = 15;
	}
	if(GetPVarInt(playerid, "Restrained") == 1)
	{
		new brcst[126];
	    format(brcst, sizeof(brcst), "AdmCmd: %s has been automatically prisoned for logging while tazed. (%s)", GetName(playerid), l);
	    SendClientMessageToAll(COLOR_LIGHTRED, brcst);
		pInfo[playerid][pJail] = 15;
	}
	new str[256];
	format(str, sizeof(str), "%s has left the server (%s)", GetName(playerid), l);
	ProxDetector(50.0, playerid, str, COLOR_YELLOW);
    SaveStats(playerid);
	
	FloodByPlayer[playerid] = 0;
    KillTimer(FloodTimer[playerid]);
	
	for(new i = 0; i < MAX_ADMIN_CARS; i++)
    {
        if(AdminCars[i][1] != playerid) continue;
        if(AdminCars[i][0] != INVALID_VEHICLE_ID) DestroyVehicle(AdminCars[i][0]);
        AdminCars[i][0] = INVALID_VEHICLE_ID;
        AdminCars[i][1] = INVALID_PLAYER_ID;
        carcount--;
    }
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) //Checks if the player that just spawned is an NPC.
	{
		new npcname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, npcname, sizeof(npcname)); //Getting the NPC's name.

	    if(!strcmp(npcname, "Crazy_Train_Driver", true)) //Checking if the NPC's name is MyFirstNPC
	    {
	      	PutPlayerInVehicle(playerid, NPCVeh, 538); //Putting the NPC into the vehicle we created for it.
	    }

	    return 1;
	}
	SetPlayerScore(playerid, pInfo[playerid][pLevel]);
	IsAfterLifing[playerid] = 0;
    if(IsDead[playerid] == 1)
    {
        SetPlayerPos(playerid,DeathPosX[playerid],DeathPosY[playerid],DeathPosZ[playerid]);
		SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
        SetPlayerCameraPos(playerid,DeathPosX[playerid],DeathPosY[playerid],DeathPosZ[playerid]+5);
        SetPlayerCameraLookAt(playerid,DeathPosX[playerid],DeathPosY[playerid],DeathPosZ[playerid]);
        TogglePlayerControllable(playerid,false);
        ApplyAnimation(playerid,"PARACHUTE","FALL_skyDive_DIE", 4.0, 0, 0, 0, 1, 0);
		LoseHPTimer[playerid] = SetTimerEx("LoseHP", AUTODEATH_SECONDS * 100, true, "i", playerid);
        SendClientMessage(playerid,COLOR_RED,"------------------ Health Advise -----------------");
        SendClientMessage(playerid,-1,"You are now bleeding to death");
        SendClientMessage(playerid,-1,"Use /EMS to call for a medic.");
        SendClientMessage(playerid,-1,"You can type /acceptdeath, if no medics are available.");
        SendClientMessage(playerid,COLOR_RED,"--------------------------------------------------------");
		return 1;
	}
	if(pInfo[playerid][pJail] >= 1)
		{
			new rand = random(sizeof(CellDestinations));
			SetPVarInt(playerid, "Dragged", 0);
			SetPVarInt(playerid, "Cuffed", 0);
			TogglePlayerControllable(playerid, 1);
			ResetPlayerWeapons(playerid);
			FreezePlayer(playerid, 3);
			SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], CellDestinations[rand][0], CellDestinations[rand][1], CellDestinations[rand][2], 5, 0, 0, 0, 0, 0, 0);
			SetPlayerInterior(playerid, pInfo[playerid][pInt]);
			SendClientMessage(playerid, COLOR_LIGHTRED, "You are still in jail.");
			rtimer[playerid] = SetTimerEx("arrestrelease", 60000, true, "i", playerid);
		}
	TextDrawShowForPlayer(playerid, ServerMSG);
	TextDrawShowForPlayer(playerid, ServerLogo);
	TextDrawShowForPlayer(playerid, Clock);
	TextDrawShowForPlayer(playerid, Rand);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(IsDead[playerid] == 0)
	{
		SetPlayerHealth(playerid, 100);
		new Float:pX, Float:pY, Float:pZ;
		GetPlayerPos(playerid, pX, pY, pZ);
		DeathPosX[playerid] = pX;
		DeathPosY[playerid] = pY;
		DeathPosZ[playerid] = pZ;
		IsDead[playerid] = 1;
		SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], DeathPosX[playerid], DeathPosY[playerid], DeathPosZ[playerid], 0, 0, 0, 0, 0, 0, 0);
		SpawnPlayer(playerid);
		SetPVarInt(playerid, "injured", 1);
		return 1;
	}
	if(IsDead[playerid] == 1)
	{
		AutoDeath(playerid);
		KillTimer(LoseHPTimer[playerid]);
	}
	for(new i; MAX_PLAYERS>i; i++)
	if(beingdragged[i] == playerid)
	{
		if(GetPVarInt(i, "Dragged") == 1)
		{
			SetPVarInt(i, "Dragged", 0);
			beingdragged[i] = 0;
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(vehicleid == AdminCars[i][0])
		{
			DestroyVehicle(AdminCars[i][0]);
			AdminCars[i][0] = INVALID_VEHICLE_ID;
			AdminCars[i][1] = INVALID_PLAYER_ID;
			carcount--;
			continue;
		}
		else continue;
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new message[128], string[126];
	FloodByPlayer[playerid] = FloodByPlayer[playerid] +1;
	if(ChatMute[playerid] == 1) return 0;
	if (IsAfterLifing[playerid] == 1) return 0;
	if(OnCall[playerid] == 0 ||OnCall[playerid] == -1)
	{
		format(message, sizeof(message), "%s says: %s", GetName(playerid), text);
		ProxDetector(30.0, playerid, message, -1);
		SetPlayerChatBubble(playerid, text, COLOR_WHITE, 20.0, 5000);
	}
	else if(OnCall[playerid] != -1 || OnCall[playerid] != 0)
	{
		format(string, sizeof(string), "(cellphone) %s says: %s", GetName(playerid), text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1);
		SetPlayerChatBubble(playerid,text,COLOR_WHITE,20.0,5000);
	}
	if(IsPlayerConnected(OnCall[playerid]))
	{
		if(OnCall[OnCall[playerid]] == playerid)
		{
			format(string, sizeof(string), "(cellphone) %s says: %s", GetName(playerid), text);
			SetPlayerChatBubble(playerid,text,COLOR_WHITE,20.0,5000);
			SendClientMessage(OnCall[playerid], COLOR_YELLOW, string);
			Log("/logs/cellphone.txt", message);
		}
	}
	else if(Call911[playerid] == 1)
	{
	    new choice[32];
		if(sscanf(text, "s[32]", choice)) return SendClientMessage(playerid, COLOR_LIGHTRED, "OPERATOR: Police or Paramedics?");
		format(message, sizeof(message), "%s says: %s", GetName(playerid), text);
  		ProxDetector(30.0, playerid, message, -1);
		if(strcmp(choice, "Police", true) == 0)
		{
		    new zone[126], str[126];
			zone = GetPlayer3DZone(playerid);
			SendClientMessage(playerid, COLOR_YELLOW, "(cellphone) SAPD: Hello. Your call has been sent to our operators - please wait for a response.");
			format(str, sizeof(str), "* [911]: Call from number %i, %s from location %s.", pInfo[playerid][pPhone], GetName(playerid), zone);
			SendClientMessageToSAPDOnDuty(COLOR_TWBLUE, str);
			format(str, sizeof(str), "* /acceptcall %i to speak with the caller.", playerid);
			SendClientMessageToSAPDOnDuty(COLOR_TWBLUE, str);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			SetPlayerAttachedObject(playerid, 9, 330 , 6);
			OnCall[playerid] = 911;
		    return 1;
		}
		if(strcmp(choice, "Paramedics", true) == 0)
		{
		    new zone[126], str[126];
			zone = GetPlayer3DZone(playerid);
			SendClientMessage(playerid, COLOR_YELLOW, "(cellphone) LAFMD: Hello. Your call has been sent to our operators - please wait for a response.");
			format(str, sizeof(str), "* [911]: Call from number %i, %s from location %s.", pInfo[playerid][pPhone], GetName(playerid), zone);
			SendClientMessageToLAFMD(COLOR_LIGHTRED, str);
			format(str, sizeof(str), "* /acceptcall %i to speak with the caller.", playerid);
			SendClientMessageToLAFMD(COLOR_LIGHTRED, str);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			SetPlayerAttachedObject(playerid, 9, 330 , 6);
			OnCall[playerid] = 911;
		    return 1;
		} 
	}
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	/*if (strcmp("/animlist", cmdtext, true) == 0)
	{
		SendClientMessage(playerid,COLOR_YELLOW,"|__ - G4M3Ov3r's AnimList - __|");
        SendClientMessage(playerid,COLOR_YELLOW2,"/handsup, /dance[1-4], /rap, /rap2, /rap3, /wankoff, /wank, /strip[1-7], /sexy[1-8], /bj[1-4], /cellin, /cellout, /lean, /piss, /follow");
        SendClientMessage(playerid,COLOR_YELLOW2,"/greet, /injured, /injured2, /hitch, /bitchslap, /cpr, /gsign1, /gsign2, /gsign3, /gsign4, /gsign5, /gift, /getup");
        SendClientMessage(playerid,COLOR_YELLOW2,"/chairsit, /stand, /slapped, /slapass, /drunk, /gwalk, /gwalk2, /mwalk, /fwalk, /celebrate, /celebrate2, /win, /win2");
        SendClientMessage(playerid,COLOR_YELLOW2,"/yes, /deal, /deal2, /thankyou, /invite1, /invite2, /sit, /scratch, /bomb, /getarrested, /laugh, /lookout, /robman");
        SendClientMessage(playerid,COLOR_YELLOW2,"/crossarms, /crossarms2, /crossarms3, /lay, /cover, /vomit, /eat, /wave, /crack, /crack2, /smokem, /smokef, /msit, /fsit");
        SendClientMessage(playerid,COLOR_YELLOW2,"/chat, /fucku, /taichi, /chairsit, /relax, /bat1, /bat2, /bat3, /bat4, /bat5, /nod, /cry1, /cry2, /chant, /carsmoke, /aim");
        SendClientMessage(playerid,COLOR_YELLOW2,"/gang1, /gang2, /gang3, /gang4, /gang5, /gang6, /gang7, /bed1, /bed2, /bed3, /bed4, /carsit, /carsit2, /stretch, /angry");
        SendClientMessage(playerid,COLOR_YELLOW2,"/kiss1, /kiss2, /kiss3, /kiss4, /kiss5, /kiss6, /kiss7, /kiss8, /exhausted, /ghand1, /ghand2, /ghand3, /ghand4, /ghand5");
        SendClientMessage(playerid,COLOR_YELLOW2,"/basket1, /basket2, /basket3, /basket4, /basket5, /basket6, /akick, /box, /cockgun");
        SendClientMessage(playerid,COLOR_YELLOW2,"/bar1, /bar2, /bar3, /bar4, /lay2, /liftup, /putdown, /die, /joint, /die2, /aim2");
        SendClientMessage(playerid,COLOR_YELLOW2,"/benddown, /checkout");
        return 1;
    }
	
	else if(strcmp(cmdtext, "/handsup", true) == 0)
	{
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
		    return 1;
	}
	
	else if(strcmp(cmdtext,"/stopanim",true) == 0)
	{
		    ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);
		    return 1;
    }
    
    else if(strcmp(cmdtext, "/dance", true) == 0)
	{
            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
            return 1;
	}
	
    else if(strcmp(cmdtext, "/dance2", true) == 0)
    {
            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/dance3", true) == 0)
    {
            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/dance4", true) == 0)
    {
            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
            return 1;
	}
	else if(strcmp(cmdtext, "/rap", true) == 0)
	{
            ApplyAnimation(playerid,"RAPPING","RAP_A_Loop",4.0,1,1,1,1,0);
            return 1;
    }
    
	else if(strcmp(cmdtext, "/rap2", true) == 0)
	{
            ApplyAnimation(playerid,"RAPPING","RAP_B_Loop",4.0,1,1,1,1,0);
            return 1;
    }
    
    else if(strcmp(cmdtext, "/rap3", true) == 0)
	{
            ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.0,1,1,1,1,0);
            return 1;
    }
    
    else if(strcmp(cmdtext, "/wankoff", true) == 0)
    {
            ApplyAnimation(playerid,"PAULNMAC","wank_in",4.0,1,1,1,1,0);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/wank", true) == 0)
    {
            ApplyAnimation(playerid,"PAULNMAC","wank_loop",4.0,1,1,1,1,0);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/strip", true) == 0)
	{
            ApplyAnimation(playerid,"STRIP","strip_A",4.0,1,1,1,1,0);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/strip2", true) == 0)
	{
            ApplyAnimation(playerid,"STRIP","strip_B",4.0,1,1,1,1,0);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/strip3", true) == 0)
	{
            ApplyAnimation(playerid,"STRIP","strip_C",4.0,1,1,1,1,0);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/strip4", true) == 0)
	{
            ApplyAnimation(playerid,"STRIP","strip_D",4.0,1,1,1,1,0);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/strip5", true) == 0)
	{
            ApplyAnimation(playerid,"STRIP","strip_E",4.0,1,1,1,1,0);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/strip6", true) == 0)
	{
            ApplyAnimation(playerid,"STRIP","strip_F",4.0,1,1,1,1,0);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/strip7", true) == 0)
	{
            ApplyAnimation(playerid,"STRIP","strip_G",4.0,1,1,1,1,0);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/sexy", true) == 0)
	{
            ApplyAnimation(playerid,"SNM","SPANKING_IDLEW",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/sexy2", true) == 0)
	{
            ApplyAnimation(playerid,"SNM","SPANKING_IDLEP",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/sexy3", true) == 0)
	{
            ApplyAnimation(playerid,"SNM","SPANKINGW",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/sexy4", true) == 0)
	{
            ApplyAnimation(playerid,"SNM","SPANKINGP",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/sexy5", true) == 0)
	{
            ApplyAnimation(playerid,"SNM","SPANKEDW",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/sexy6", true) == 0)
	{
            ApplyAnimation(playerid,"SNM","SPANKEDP",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/sexy7", true) == 0)
	{
            ApplyAnimation(playerid,"SNM","SPANKING_ENDW",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/sexy8", true) == 0)
	{
            ApplyAnimation(playerid,"SNM","SPANKING_ENDP",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/bj", true) == 0)
	{
            ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_START_P",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/bj2", true) == 0)
	{
            ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_START_W",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/bj3", true) == 0)
	{
            ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_P",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/bj4", true) == 0)
	{
            ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_W",4.1,0,1,1,1,1);
            return 1;
	}
	
	else if(strcmp(cmdtext, "/cellin", true) == 0)
    {
        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
        return 1;
    }

    else if(strcmp(cmdtext, "/cellout", true) == 0)
	{
        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
        return 1;
    }

    else if(strcmp(cmdtext, "/lean", true) == 0)
	{
        ApplyAnimation(playerid,"GANGS","leanIDLE", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }
    
    else if(strcmp(cmdtext, "/piss", true) == 0)
	{
        SetPlayerSpecialAction(playerid, 68);
        return 1;
    }

    else if(strcmp(cmdtext, "/follow", true) == 0)
	{
        ApplyAnimation(playerid,"WUZI","Wuzi_follow",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/greet", true) == 0)
	{
        ApplyAnimation(playerid,"WUZI","Wuzi_Greet_Wuzi",4.0,0,0,0,0,0);
        return 1;
    }
    
    else if(strcmp(cmdtext, "/stand", true) == 0)
	{
        ApplyAnimation(playerid,"WUZI","Wuzi_stand_loop", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/injured2", true) == 0)
	{
        ApplyAnimation(playerid,"SWAT","gnstwall_injurd", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/hitch", true) == 0)
	{
        ApplyAnimation(playerid,"MISC","Hiker_Pose", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/bitchslap", true) == 0)
	{
        ApplyAnimation(playerid,"MISC","bitchslap",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/cpr", true) == 0)
	{
        ApplyAnimation(playerid,"MEDIC","CPR", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }
    
    else if(strcmp(cmdtext, "/gsign1", true) == 0)
	{
        ApplyAnimation(playerid,"GHANDS","gsign1",4.0,0,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/gsign2", true) == 0)
	{
        ApplyAnimation(playerid,"GHANDS","gsign2",4.0,0,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/gsign3", true) == 0)
	{
        ApplyAnimation(playerid,"GHANDS","gsign3",4.0,0,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/gsign4", true) == 0)
	{
        ApplyAnimation(playerid,"GHANDS","gsign4",4.0,0,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/gsign5", true) == 0)
	{
        ApplyAnimation(playerid,"GHANDS","gsign5",4.0,0,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/gift", true) == 0)
	{
        ApplyAnimation(playerid,"KISSING","gift_give",4.0,0,0,0,0,0);
        return 1;
    }
    
    else if(strcmp(cmdtext, "/chairsit", true) == 0)
	{
        ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/injured", true) == 0) {
    
        ApplyAnimation(playerid,"SWEET","Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/slapped", true) == 0)
	{
        ApplyAnimation(playerid,"SWEET","ho_ass_slapped",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/slapass", true) == 0)
	{
        ApplyAnimation(playerid,"SWEET","sweet_ass_slap",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/drunk", true) == 0)
	{
        ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/skate", true) == 0)
	{
        ApplyAnimation(playerid,"SKATE","skate_run",4.1,1,1,1,1,1);
        return 1;
    }
    
    else if(strcmp(cmdtext, "/gwalk", true) == 0) {
        ApplyAnimation(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/gwalk2", true) == 0)
	{
        ApplyAnimation(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/limp", true) == 0)
	{
        ApplyAnimation(playerid,"PED","WALK_old",4.1,1,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/eatsit", true) == 0)
	{
        ApplyAnimation(playerid,"FOOD","FF_Sit_Loop", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/celebrate", true) == 0)
	{
        ApplyAnimation(playerid,"benchpress","gym_bp_celebrate", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }
    
    else if(strcmp(cmdtext, "/win", true) == 0)
	{
        ApplyAnimation(playerid,"CASINO","cards_win", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/win2", true) == 0)
	{
        ApplyAnimation(playerid,"CASINO","Roulette_win", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/yes", true) == 0)
	{
        ApplyAnimation(playerid,"CLOTHES","CLO_Buy", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/deal2", true) == 0)
	{
        ApplyAnimation(playerid,"DEALER","DRUGS_BUY", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/thankyou", true) == 0)
	{
        ApplyAnimation(playerid,"FOOD","SHP_Thank", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }
    
    else if(strcmp(cmdtext, "/invite1", true) == 0)
	{
        ApplyAnimation(playerid,"GANGS","Invite_Yes",4.1,0,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/invite2", true) == 0)
	{
        ApplyAnimation(playerid,"GANGS","Invite_No",4.1,0,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/celebrate2", true) == 0)
	{
        ApplyAnimation(playerid,"GYMNASIUM","gym_tread_celebrate", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/sit", true) == 0)
	{
        ApplyAnimation(playerid,"INT_OFFICE","OFF_Sit_Type_Loop", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/scratch", true) == 0)
	{
        ApplyAnimation(playerid,"MISC","Scratchballs_01", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if (strcmp("/bomb", cmdtext, true) == 0)
	{
        ClearAnimations(playerid);
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
        return 1;
    }

    else if (strcmp("/getarrested", cmdtext, true, 7) == 0)
	{
        ApplyAnimation(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1); // Gun Arrest
        return 1;
    }

    else if (strcmp("/laugh", cmdtext, true) == 0)
	{
        ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0); // Laugh
        return 1;
    }

    else if (strcmp("/lookout", cmdtext, true) == 0)
	{
        ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0); // Rob Lookout
        return 1;
    }

    else if (strcmp("/robman", cmdtext, true) == 0)
	{
        ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0); // Rob
        return 1;
    }

    else if (strcmp("/crossarms", cmdtext, true) == 0)
	{
        ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1); // Arms crossed
        return 1;
    }

    else if (strcmp("/crossarms2", cmdtext, true) == 0)
	{
        ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.0, 0, 1, 1, 1, -1); // Arms crossed 2
        return 1;
    }

    else if (strcmp("/crossarms3", cmdtext, true) == 0)
	{
        ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.0, 0, 1, 1, 1, -1); // Arms crossed 3
        return 1;
    }

    else if (strcmp("/lay", cmdtext, true, 6) == 0)
	{
        ApplyAnimation(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0); // Lay down
        return 1;
    }

    else if (strcmp("/vomit", cmdtext, true) == 0)
	{
        ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit
        return 1;
    }
    
    else if (strcmp("/eat", cmdtext, true) == 0) {
        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eat Burger
        return 1;
    }

    else if (strcmp("/wave", cmdtext, true) == 0) {
        ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0); // Wave
        return 1;
    }

    else if (strcmp("/deal", cmdtext, true) == 0) {
        ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 3.0, 0, 0, 0, 0, 0); // Deal Drugs
        return 1;
    }

    else if (strcmp("/crack", cmdtext, true, 6) == 0) {
        ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0); // Dieing of Crack
        return 1;
    }

    else if (strcmp("/smokem", cmdtext, true, 4) == 0) {
        ApplyAnimation(playerid,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0); // Smoke
        return 1;
    }

    else if (strcmp("/smokef", cmdtext, true) == 0) {
        ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0); // Female Smoking
        return 1;
    }

    else if (strcmp("/msit", cmdtext, true, 4) == 0) {
        ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0); // Male Sit
        return 1;
    }

    else if (strcmp("/fsit", cmdtext, true, 4) == 0) {
        ApplyAnimation(playerid,"BEACH", "ParkSit_W_loop", 4.0, 1, 0, 0, 0, 0); // Female Sit
        return 1;
    }

    else if(strcmp(cmdtext, "/chat", true) == 0) {
        ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1,1,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/fucku", true) == 0)
	{
        ApplyAnimation(playerid,"PED","fucku",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/taichi", true) == 0)
	{
        ApplyAnimation(playerid,"PARK","Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/chairsit", true) == 0)
	{
        ApplyAnimation(playerid,"BAR","dnk_stndF_loop", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/relax", true) == 0)
	{
        ApplyAnimation(playerid,"BEACH","Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/bat1", true) == 0)
	{
        ApplyAnimation(playerid,"BASEBALL","Bat_IDLE", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/bat2", true) == 0)
	{
        ApplyAnimation(playerid,"BASEBALL","Bat_M", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/bat3", true) == 0)
	{
        ApplyAnimation(playerid,"BASEBALL","BAT_PART", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/bat4", true) == 0)
	{
        ApplyAnimation(playerid,"CRACK","Bbalbat_Idle_01", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/bat5", true) == 0)
	{
        ApplyAnimation(playerid,"CRACK","Bbalbat_Idle_02", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/nod", true) == 0)
	{
        ApplyAnimation(playerid,"COP_AMBIENT","Coplook_nod",4.0,0,0,0,0,0);
        return 1;
    }
    
    else if(strcmp(cmdtext, "/gang1", true) == 0)
	{
        ApplyAnimation(playerid,"GANGS","hndshkaa",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/gang2", true) == 0)
	{
        ApplyAnimation(playerid,"GANGS","hndshkba",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/gang3", true) == 0)
	{
        ApplyAnimation(playerid,"GANGS","hndshkca",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/gang4", true) == 0)
	{
        ApplyAnimation(playerid,"GANGS","hndshkcb",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/gang5", true) == 0)
	{
        ApplyAnimation(playerid,"GANGS","hndshkda",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/gang6", true) == 0)
	{
        ApplyAnimation(playerid,"GANGS","hndshkea",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/gang7", true) == 0)
	{
        ApplyAnimation(playerid,"GANGS","hndshkfa",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/cry1", true) == 0)
	{
        ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/cry2", true) == 0)
	{
        ApplyAnimation(playerid,"GRAVEYARD","mrnM_loop", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/bed1", true) == 0)
	{
        ApplyAnimation(playerid,"INT_HOUSE","BED_In_L",4.1,0,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/bed2", true) == 0)
	{
        ApplyAnimation(playerid,"INT_HOUSE","BED_In_R",4.1,0,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/bed3", true) == 0)
	{
        ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_L", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/bed4", true) == 0)
	{
        ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_R", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/kiss2", true) == 0)
	{
        ApplyAnimation(playerid,"BD_FIRE","Grlfrd_Kiss_03",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/kiss3", true) == 0)
	{
    
        ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_01",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/kiss4", true) == 0)
	{
        ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_02",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/kiss5", true) == 0)
	{
        ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_03",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/kiss6", true) == 0)
	{
        ApplyAnimation(playerid,"KISSING","Playa_Kiss_01",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/kiss7", true) == 0)
	{
        ApplyAnimation(playerid,"KISSING","Playa_Kiss_02",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/kiss8", true) == 0)
	{
        ApplyAnimation(playerid,"KISSING","Playa_Kiss_03",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/carsit", true) == 0)
	{
        ApplyAnimation(playerid,"CAR","Tap_hand", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/carsit2", true) == 0)
	{
        ApplyAnimation(playerid,"LOWRIDER","Sit_relaxed", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/fwalk", true) == 0)
	{
        ApplyAnimation(playerid,"ped","WOMAN_walksexy",4.1,1,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/mwalk", true) == 0)
	{
        ApplyAnimation(playerid,"ped","WALK_player",4.1,1,1,1,1,1);
        return 1;
    }

    else if(strcmp(cmdtext, "/stretch", true) == 0)
	{
        ApplyAnimation(playerid,"PLAYIDLES","stretch",4.0,0,0,0,0,0);
        return 1;
    }

    else if(strcmp(cmdtext, "/chant", true) == 0)
	{
        ApplyAnimation(playerid,"RIOT","RIOT_CHANT", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }

    else if(strcmp(cmdtext, "/angry", true) == 0)
	{
        ApplyAnimation(playerid,"RIOT","RIOT_ANGRY",4.0,0,0,0,0,0);
        return 1;
    }

    else if (strcmp("/crack2", cmdtext, true, 6) == 0)
	{
        ApplyAnimation(playerid, "CRACK", "crckidle2", 4.0, 1, 0, 0, 0, 0);
        return 1;
    }
    
    else if(strcmp(cmdtext, "/ghand1", true) == 0)
	{
	    ApplyAnimation(playerid,"GHANDS","gsign1LH",4.0,0,1,1,1,1);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/ghand2", true) == 0)
	{
	    ApplyAnimation(playerid,"GHANDS","gsign2LH",4.0,0,1,1,1,1);
	    return 1;
    }
    else if(strcmp(cmdtext, "/ghand3", true) == 0)
	{
	    ApplyAnimation(playerid,"GHANDS","gsign3LH",4.0,0,1,1,1,1);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/ghand4", true) == 0)
	{
	    ApplyAnimation(playerid,"GHANDS","gsign4LH",4.0,0,1,1,1,1);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/ghand5", true) == 0)
	{
	    ApplyAnimation(playerid,"GHANDS","gsign5LH",4.0,0,1,1,1,1);
	    return 1;
    }

    else if(strcmp(cmdtext, "/exhausted", true) == 0)
	{
	    ApplyAnimation(playerid,"FAT","IDLE_tired", 4.0, 1, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/carsmoke", true) == 0)
	{
	    ApplyAnimation(playerid,"PED","Smoke_in_car", 4.0, 1, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/aim", true) == 0)
	{
	    ApplyAnimation(playerid,"PED","gang_gunstand", 4.0, 1, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/getup", true) == 0)
	{
	    ApplyAnimation(playerid,"PED","getup",4.0,0,0,0,0,0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/basket1", true) == 0)
	{
	    ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop", 4.0, 1, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/basket2", true) == 0)
	{
	    ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop", 4.0, 1, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/basket3", true) == 0)
	{
	    ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/basket4", true) == 0)
	{
	    ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/basket5", true) == 0)
	{
	    ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.1,0,1,1,1,1);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/basket6", true) == 0)
	{
	    ApplyAnimation(playerid,"BSKTBALL","BBALL_run",4.1,1,1,1,1,1);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/akick", true) == 0)
	{
	    ApplyAnimation(playerid,"FIGHT_E","FightKick",4.0,0,0,0,0,0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/box", true) == 0)
	{
	    ApplyAnimation(playerid,"GYMNASIUM","gym_shadowbox",4.1,1,1,1,1,1);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/cockgun", true) == 0)
	{
	    ApplyAnimation(playerid, "SILENCED", "Silence_reload", 3.0, 0, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/bar1", true) == 0)
	{
	    ApplyAnimation(playerid, "BAR", "Barcustom_get", 3.0, 0, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/bar2", true) == 0)
	{
	    ApplyAnimation(playerid, "BAR", "Barcustom_order", 3.0, 0, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/bar3", true) == 0)
	{
	    ApplyAnimation(playerid, "BAR", "Barserve_give", 3.0, 0, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/bar4", true) == 0)
	{
	    ApplyAnimation(playerid, "BAR", "Barserve_glass", 3.0, 0, 0, 0, 0, 0);
	    return 1;
    }
    
    else if (strcmp("/lay2", cmdtext, true, 6) == 0)
	{
        ApplyAnimation(playerid,"BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0); // Lay down
        return 1;
    }
    
    else if(strcmp(cmdtext, "/liftup", true) == 0)
	{
	    ApplyAnimation(playerid, "CARRY", "liftup", 3.0, 0, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/putdown", true) == 0)
	{
	    ApplyAnimation(playerid, "CARRY", "putdwn", 3.0, 0, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/joint", true) == 0)
	{
	    ApplyAnimation(playerid,"GANGS","smkcig_prtl",4.0,0,1,1,1,1);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/die", true) == 0)
	{
	    ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Die",4.1,0,1,1,1,1);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/shakehead", true) == 0)
	{
	    ApplyAnimation(playerid, "MISC", "plyr_shkhead", 3.0, 0, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/shakehead", true) == 0)
	{
	    ApplyAnimation(playerid, "MISC", "plyr_shkhead", 3.0, 0, 0, 0, 0, 0);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/die2", true) == 0)
	{
	    ApplyAnimation(playerid, "PARACHUTE", "FALL_skyDive_DIE", 4.0, 0, 1, 1, 1, -1);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/aim2", true) == 0)
	{
	    ApplyAnimation(playerid, "SHOP", "SHP_Gun_Aim", 4.0, 0, 1, 1, 1, -1);
	    return 1;
    }
    
    else if(strcmp(cmdtext, "/benddown", true) == 0)
	{
        ApplyAnimation(playerid, "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0);
        return 1;
    }
    
    else if(strcmp(cmdtext, "/checkout", true) == 0)
	{
        ApplyAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 0, 0, 0, 0, 0);
        return 1;
    } */
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new playerstate = GetPlayerState(playerid);
	new vid = GetVehicleID(vehicleid);
	if(IsABycicle(GetVehicleModel(vehicleid)))
	{
		new variables[7];
		SetVehicleParamsEx(vehicleid, 1, variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
	}
	else if(IsACopCar(GetVehicleModel(vehicleid)) && pInfo[playerid][pFaction] != 1)
	{
		if(playerstate == PLAYER_STATE_DRIVER)
		{
			new Float: x, Float: y, Float: z;
			GetPlayerPos(playerid, x, y, z);
			SetPlayerPos(playerid, x, y, z);
			SendClientMessage(playerid, COLOR_GREY, "You are not part of the SAPD");
		}
	}
	else if(IsAAmbulance(GetVehicleModel(vehicleid)) && pInfo[playerid][pFaction] != 2)
	{
		if(playerstate == PLAYER_STATE_DRIVER)
		{
			new Float: x, Float: y, Float: z;
			GetPlayerPos(playerid, x, y, z);
			SetPlayerPos(playerid, x, y, z);
			SendClientMessage(playerid, COLOR_GREY, "You are not part of the LAFMD");
		}
	}
	else if(GetVehicleModel(vehicleid) == 570)
	{
		pInfo[playerid][pCash] -= 500;
		SendClientMessage(playerid, COLOR_ORANGE, "You have just paid the train fee of R650");
	}
	else if(vInfo[vid][vLocked] == 1)
	{
		new Float: x, Float: y, Float: z;
		GetPlayerPos(playerid, x, y, z);
		SetPlayerPos(playerid, x, y, z);
		SendClientMessage(playerid, COLOR_GREY, "Vehicle is locked");
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	new str[128];
	SetPVarInt(playerid, "VehicleAccess", 0);
	cardetain[playerid] = vehicleid;
	if(InRace[playerid] == 1)
	{
		PutPlayerInVehicle(playerid, vehicleid, 0);
	}
	RemovePlayerAttachedObject(playerid,1);
	Seatbelt[playerid] = 0;
	SetPVarInt(playerid, "SeatBelt", 0);
	
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
	    {
	        if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == 2 && TransportDuty[i] > 0)
			{
				TaxiCallTime[i] = 0;
				format(str, sizeof(str), "* Passenger %s has exited your Taxi.", name);
				SendClientMessage(i, COLOR_LIGHTBLUE, str);
			}
		}
	}
	
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	if(InRace[playerid] == 1)
	{
		RepairVehicle(vehicleid);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerAdmin(playerid))
	{
		new vid = GetVehicleID(GetPlayerVehicleID(playerid));
		if(vInfo[vid][vDealer] == 1)
		{
			new str[128];
			format(str, sizeof(str), "Price: R%d\nWould you like to buy\nthis car?", vInfo[vid][vPrice]);
			ShowPlayerDialog(playerid, DIALOG_VBUY, DIALOG_STYLE_MSGBOX, "Buy Vehicle", str, "Buy", "Cancel");
			SetPVarInt(playerid, "DealershipVehicle", vInfo[vid][vModel]);
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
        if(IsACopCar(GetVehicleModel(vehicleid)) && pInfo[playerid][pFaction] != 1)
	    {
            RemovePlayerFromVehicle(playerid);
		    SendClientMessage(playerid, COLOR_GREY, " You are not in SAPD faction.");
	    }
		else if(IsAAmbulance(GetVehicleModel(vehicleid)) && pInfo[playerid][pFaction] != 2)
	    {
            RemovePlayerFromVehicle(playerid);
		    SendClientMessage(playerid, COLOR_GREY, " You are not in LAFMD faction.");
	    }
	//	SetTimerEx("Speedometer", 1000, true, "i", playerid);
	//	FuelTimer[vehicleid] = SetTimerEx("Fuelmeter", 20000, true, "i", playerid);
	}
	else if(newstate == PLAYER_STATE_PASSENGER) // TAXI & BUSSES
	{
	    new string[128];
	    new name[MAX_PLAYER_NAME];
	    GetPlayerName(playerid, name, sizeof(name));
	    for(new i = 0; i < MAX_PLAYERS; i++)
	    {
	        if(IsPlayerConnected(i))
	        {
	            if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == 2 && TransportDuty[i] > 0)
	            {
	                if(GetPlayerMoney(playerid) < TransportValue[i])
	                {
	                    format(string, sizeof(string), "* You need R%d to enter.", TransportValue[i]);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						RemovePlayerFromVehicle(playerid);
	                }
	                else
	                {
	                    if(TransportDuty[i] == 1)
	                    {
	                        format(string, sizeof(string), "* You paid R%d to the Taxi Driver.", TransportValue[i]);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Passenger %s has entered your Taxi.", name);
							SendClientMessage(i, COLOR_LIGHTBLUE, string);
							pInfo[playerid][pCash] -= TransportValue[i];
							TransportMoney[i] += TransportValue[i];
							TransportTime[i] = 1;
	                    	TransportTime[playerid] = 1;
	                    	TransportCost[playerid] = TransportValue[i];
	                    	TransportCost[i] = TransportValue[i];
	                    	TransportDriver[playerid] = i;
							KillTimer(TaxiDestTimer[i]);
							TaxiCall = 999;
							DisablePlayerCheckpoint(i);
	                    }
	                }
	            }
	        }
	    }
	}
	return 1;
} 

public OnPlayerEnterCheckpoint(playerid)
{
	/* */
	if(JobCPT[playerid] == 1)
	{
		DisablePlayerCheckpoint(playerid);
	}
	if(FedexCPT[playerid] == 1)
	{
		ShowPlayerDialog(playerid, DIALOG_FEDEXCOLLECT, DIALOG_STYLE_LIST, "Fedex Deliveries", "Short Distance\n\nCar Parts \nBuilding Supplies \nBurger Patties \n \nLong Distance\n\nChicken \nSprunk Drinks \n Boxes", "Start", "Cancel");
		DisablePlayerCheckpoint(playerid);
		TogglePlayerControllable(playerid, 0);
	}
	/* ======= Fedex Short =======*/
	else if(FedexCPT[playerid] == 2)
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 498) return SendClientMessage(playerid, COLOR_GREY, "You are not in a fedex van");
		SetPlayerCheckpoint(playerid, -2134.0183, -228.0478, 35.0474, 10);
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~y~ Unloading Van...", 5000, 3);
		FreezePlayer(playerid, 5);
		FedexCPT[playerid] = 3;
		SendClientMessage(playerid, COLOR_ORANGE, "Go back to the depot to collect your pay");
	}	
	else if(FedexCPT[playerid] == 3)
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 498) return SendClientMessage(playerid, COLOR_GREY, "You are not in a fedex van");
		DisablePlayerCheckpoint(playerid);
		FedexCPT[playerid] = 0;
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~y~ Collecting Pay...", 3000, 3);
		FreezePlayer(playerid, 3);
		new rand, str[25];
		rand = random(850)+50;
		pInfo[playerid][pCash] += rand;
		format(str, sizeof(str), "Your pay is: R%i", rand);
		SendClientMessage(playerid, COLOR_ORANGE, str);
	}
	/* ======= Fedex Long =======*/
	else if(FedexCPT[playerid] == 4)
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 498) return SendClientMessage(playerid, COLOR_GREY, "You are not in a fedex van");
		SetPlayerCheckpoint(playerid, -2134.0183, -228.0478, 35.0474, 10);
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~y~ Unloading Van...", 5000, 3);
		FreezePlayer(playerid, 5);
		FedexCPT[playerid] = 3;
		SendClientMessage(playerid, COLOR_ORANGE, "Go back to the depot to collect your pay");
	}
	else if(FedexCPT[playerid] == 3)
	{
		DisablePlayerCheckpoint(playerid);
		FedexCPT[playerid] = 0;
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~y~ Collecting Pay...", 3000, 3);
		FreezePlayer(playerid, 3);
		new rand, str[25];
		rand = random(1250)+250;
		pInfo[playerid][pCash] += rand;
		format(str, sizeof(str), "Your pay is: R%i", rand);
		SendClientMessage(playerid, COLOR_ORANGE, str);
	}
	/* ======= CDL =======*/
	else if(CDLCPT[playerid] == 1)
	{
		ShowPlayerDialog(playerid, DIALOG_CDLFUEL, DIALOG_STYLE_LIST, "Fuel Tanker", "Broadway \n24/7", "Ok", "Cancel");
	}
	/* ======= Pizza Delivery =======*/
	else if(PizzaDeliveryCPT[playerid] == 1)
	{
		new rand = random(sizeof(PizzaDelivery));
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~y~ Loading Pizza...", 5000, 3);
		FreezePlayer(playerid, 5);
		SetPlayerCheckpoint(playerid, PizzaDelivery[rand][0], PizzaDelivery[rand][1], PizzaDelivery[rand][2], 5);
		PizzaDeliveryCPT[playerid] = 2;
		SendClientMessage(playerid, COLOR_ORANGE, "Go and deliver the pizza's ASAP");
	}
	else if(PizzaDeliveryCPT[playerid] == 2)
	{
		new str[52];
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~y~ Delivering Pizza...", 3000, 3);
		FreezePlayer(playerid, 3);
		new rand = random(300) + 25;
		pInfo[playerid][pCash] += rand;
		format(str, sizeof(str), "You have just been paid R%i for the delivery", rand);
		SendClientMessage(playerid, COLOR_GREEN, str);
		PizzaDeliveryCPT[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	}
	/* ======= Drug Smuggler =======*/
	else if(DrugSCPT[playerid] == 1)
	{
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~y~ Loading Drugs...", 3000, 3);
		FreezePlayer(playerid, 5);
		SendClientMessage(playerid, COLOR_ORANGE, "Go deliver the drugs to the crack den");
		DrugSCPT[playerid] = 2;
		SetPlayerCheckpoint(playerid, 2171.8550,-1677.9586,15.0859, 5);
	}
	else if(DrugSCPT[playerid] == 2)
	{
		new str[52];
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~y~ Unloading Drugs...", 3000, 3);
		FreezePlayer(playerid, 3);
		new rand = random(850) + 250;
		DrugSCPT[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
		pInfo[playerid][pCash] += rand;
		format(str, sizeof(str), "You have just been paid R%i for the delivery", rand);
		SendClientMessage(playerid, COLOR_GREEN, str);
	}
	/* ======= Warehouse Worker =======*/
	else if(WareHouseCPT[playerid] == 1)
	{
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~y~ Loading Materials...", 3000, 3);
		FreezePlayer(playerid, 5);
		SendClientMessage(playerid, COLOR_ORANGE, "Go deliver the materials to the warehouse");
		WareHouseCPT[playerid] = 2;
		SetPlayerCheckpoint(playerid, 2114.8262, -1872.4198, 13.5469, 5);
	}
	else if(WareHouseCPT[playerid] == 2)
	{
		new str[68];
		TogglePlayerControllable(playerid, 0);
		GameTextForPlayer(playerid, "~y~ Unloading Materials...", 3000, 3);
		FreezePlayer(playerid, 3);
		new rand = random(500) + 250;
		new rand2 = random(50) + 25;
		new rand3 = random(250) + 100;
		pInfo[playerid][pMats] += rand2;
		WareHouseCPT[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
		pInfo[playerid][pCash] += rand;
		format(str, sizeof(str), "You have just been paid R%i for the delivery. Bonus: %i materials", rand, rand2);
		SendClientMessage(playerid, COLOR_GREEN, str);
		Materials += rand3;
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(RaceTrack == 1)
	{
		RaceCheckpoint_Dillimore(playerid);
	}
	else if(RaceTrack == 2)
	{
		RaceCheckpoint_Montgomery(playerid);
	}
	else if(RaceTrack == 3)
	{
		RaceCheckpoint_GoKartSF(playerid);
	}
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new vehicleid;
	vehicleid = GetPlayerVehicleID(playerid);
	SetPlayerMoney(playerid, pInfo[playerid][pCash]);
	
	if(GetPVarInt(playerid, "Dragged") == 1)
	{
		if(beingdragged[playerid] == -1)
		{
			SetPVarInt(playerid, "Dragged", 0);
		}
		if(beingdragged[playerid] == INVALID_PLAYER_ID)
		{
			beingdragged[playerid] = -1;
			SetPVarInt(playerid, "Dragged", 0);
		}
		new Float: gx, Float: gy, Float: gz;
		GetPlayerPos(beingdragged[playerid], gx, gy, gz);
		SetPlayerInterior(playerid, GetPlayerInterior(beingdragged[playerid]));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(beingdragged[playerid]));
		SetPlayerPos(playerid, gx, gy-1, gz);
	}
	if(tazer[playerid] == 1)
	{
		SetPlayerArmedWeapon(playerid, 23);
	}
	if(GetPVarInt(playerid, "VehicleID"))
	{
		if(vehicleid != 0)
		{
			for(new i = 1; i < MAX_FSTATIONS; i++)
			{
				if(IsPlayerInRangeOfPoint(playerid,3.0,fInfo[i][fPos][0], fInfo[i][fPos][1], fInfo[i][fPos][2]))
				{	
					new id = GetPlayerVehicleID(playerid);
					new str[128];
					format(str, sizeof(str), "Vehicle ID: %i", id);
					SendClientMessage(playerid, COLOR_GREY, str);
				}
			}
		}
	}
	if(IsPlayerInRangeOfPoint(playerid, 5, 2116.1904, -1887.2052, 13.5391))
	{
		new str[56];
		format(str, sizeof(str), "~r~ Mats in stock: %i ~g~~n~ /buymats to buy materials", Materials);
		GameTextForPlayer(playerid, str, 5000, 3);
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SetPlayerArmedWeapon(playerid, 0);
	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
    	case DIALOG_REGISTER:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext) || strlen(inputtext) > 128)
	            {
	                new string1[128];
	                SendClientMessage(playerid, red, "[ERROR]: You must insert a password between 1-128 characters!");
 					format(string1, sizeof(string1), "Welcome %s\nPlease register to continue.",pName(playerid));
 					ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, ""COL_RED"Register", string1, "Register", "Quit");
	            }
	            else if(strlen(inputtext) > 0 && strlen(inputtext) < 128)
	            {
   		        	new escpass[100];
			        mysql_escape_string(inputtext, escpass);
			        MySQL_Register(playerid, escpass);
					ShowPlayerDialog(playerid, DIALOG_REGISTEREMAIL1, DIALOG_STYLE_INPUT, ""COL_ORANGE"Register email address", "Please register your email address. \nYou will need this email address\nif you need a password reset.", "Register", "Cancel");
	            }
	        }
	        if(!response)
	        {
				ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_MSGBOX, "Kicked", "You must register to play", "Close", "");
				Kick(playerid);
	        }
	    }
	    case DIALOG_LOGIN:
	    {
	        if(!response)
	        {
 				ShowPlayerDialog(playerid, DIALOG_KICKED, DIALOG_STYLE_MSGBOX, "Kicked", "You must login to play", "Close", "");
				Kick(playerid);
	        }
	        if(response)
			{
	            new query[200], rows, fields;
	            mysql_format(dbHandle, query, sizeof(query), "SELECT `Username` FROM PlayerData WHERE Username = '%s' AND Password = SHA1('%e')", pName(playerid), inputtext);
	            mysql_query(dbHandle, query);
	            cache_get_data(rows, fields);

	            if(rows) MySQL_Login(playerid);

	            if(!rows)
	            {
	                Invalid[playerid]++;
	                if(Invalid[playerid]==4)
	                {
						Kick(playerid);
					}
					else
					{
		                new str1[256];
				 		format(str1,sizeof(str1),"Wrong password!\n\nWelcome back %s\nPlease login to contiune.\n\nLogin chance: %d",pName(playerid),4-Invalid[playerid]);
				 		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,""COL_ORANGE"Login Panel",str1,"Login","Quit");
					}
	            }
	        }
	    }
		case DIALOG_REGISTEREMAIL1:
		{
			if(!response)
			{
				ShowPlayerDialog(playerid, DIALOG_REGISTEREMAIL1, DIALOG_STYLE_INPUT, ""COL_ORANGE"Register email address", "Please register your email address. \nYou will need this email address\nif you need a password reset.", "Register", "Cancel");
			}
			else
			{
				new Query[150];
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PlayerData` SET `Email` = '%s' WHERE `Username` = '%s'",
				inputtext,
				pName(playerid));
				mysql_query(dbHandle,Query,false);
				ShowPlayerDialog(playerid, DIALOG_REGISTERSEX, DIALOG_STYLE_LIST, ""COL_ORANGE"What gender are you?", "Male \nFemale", "Ok", "Cancel");
			}
		}
		case DIALOG_REGISTEREMAIL2:
		{
			if(!response) return 1;
			else
			{
				new Query[150], str[128];
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PlayerData` SET `Email` = '%s' WHERE `Username` = '%s'",
				inputtext,
				pName(playerid));
				mysql_query(dbHandle,Query,false);
				format(str, sizeof(str), "Your new email address is: %s", inputtext);
				SendClientMessage(playerid, COLOR_ORANGE, str);
			}
		}
		case DIALOG_REGISTERSEX:
		{
			if(!response)
			{
				ShowPlayerDialog(playerid, DIALOG_REGISTERSEX, DIALOG_STYLE_LIST, "What gender are you?", "Male\nFemale", "Ok", "Cancel");
				SendClientMessage(playerid, red, "You need to select your gender.");
			}
			if(response)
			{
				new Query[500];
				if(listitem == 0)
				{
					pInfo[playerid][pGender] = 1;
					SendClientMessage(playerid, -1, "Alright so you are a male.");
				}
				if(listitem == 1)
				{
					pInfo[playerid][pGender] = 2;
					SendClientMessage(playerid, -1, "Alright so you are a female.");
				}
				
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PlayerData` SET `pGender` = '%d' WHERE `Username` = '%s'",
				pInfo[playerid][pGender],
				pName(playerid));
				mysql_query(dbHandle,Query,false);
				
				ShowPlayerDialog(playerid, DIALOG_REGISTERAGE, DIALOG_STYLE_INPUT, ""COL_ORANGE"How old are you?", "Please insert your age. \n Minimum age: 18 \nMaximum age: 99", "Ok", "Cancel");
			}
		}
		case DIALOG_REGISTERAGE:
		{
			if(!response)
			{
				ShowPlayerDialog(playerid, DIALOG_REGISTERAGE, DIALOG_STYLE_INPUT, "How old are you?", "Please insert your age. \n Minimum age: 18 \nMaximum age: 99", "Ok", "Cancel");
				SendClientMessage(playerid, red, "You need to input your age.");
			}
			if(response)
			{
				new skin, Query[500];
				skin = 1+random(299);
				pInfo[playerid][pAge] = strval(inputtext);
				TogglePlayerSpectating(playerid, 0);
				SetSpawnInfo(playerid, 0, skin, 1757.4214, -1866.6447, 13.5712, 358.6700, 0, 0, 0, 0, 0, 0);
				SpawnPlayer(playerid);
				pInfo[playerid][pSkin] = skin;
				
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PlayerData` SET `pAge` = '%d', `pSkin` = '%d' WHERE `Username` = '%s'",
				pInfo[playerid][pAge],
				pInfo[playerid][pSkin],
				pName(playerid));
				mysql_query(dbHandle,Query,false);
				pInfo[playerid][pLogged] = 1;
			}
		}
		case DIALOG_KICKED:
		{
			if(response || !response) return Kick(playerid);
		}
		case DIALOG_BANNED:
		{
			if(response)
			{
				Kick(playerid);
			}
			else Kick(playerid);
		}
		case DIALOG_NAME:
		{
		    if(!response)
		    {
				Kick(playerid);
			}
			if(response)
			{
			    if (!isnull(inputtext)) SetPlayerName(playerid, inputtext);
			    else return ShowPlayerDialog(playerid, DIALOG_NAME, DIALOG_STYLE_INPUT,""COL_WHITE"Name Change",""COL_WHITE"Type in another name to play with. \nFirstname_Lastname","Change","No!");
    			new Name[MAX_PLAYER_NAME], Len;
				GetPlayerName(playerid, Name, sizeof(Name));
				Len = strlen(Name);
				if(Name[Len - 1] == '_' || Name[0] == '_' || strfind(Name, "_", false) == -1)
				{
					SendClientMessage(playerid, COLOR_CYAN, "You failed to select a role play name, please select another name.");
					ShowPlayerDialog(playerid, DIALOG_NAME, DIALOG_STYLE_INPUT,""COL_WHITE"Name Change",""COL_WHITE"Type in another name to use. \nFirstname_Lastname","Change","No!");
					return 1;
				}
				SetPlayerName(playerid, inputtext);
				
        		new Query[300], rows, fields;
				mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `PlayerData` WHERE `Username` = '%e'", pName(playerid));
				mysql_query(dbHandle,Query);
				cache_get_data(rows, fields);
				if(rows)
				{		
					new str[128], string[256], IP[24];
					
					GetPlayerIp(playerid, IP, sizeof(IP));
					format(str, sizeof(str), "%s Login - %s", COL_ORANGE, GetName(playerid));		
					format(string, sizeof(string), "Welcome to Escudo-Gaming, %s \n\n IP Address: %s \n\n That name you are using is registered, please login below.", GetName(playerid), IP);
					ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, str, string, "Login", "Cancel");
				}
				else if(!rows)
				{
					new str[128], string[164], IP[24];
					
					GetPlayerIp(playerid, IP, sizeof(IP));
					format(str, sizeof(str), "%sRegister - %s", COL_ORANGE, GetName(playerid));
					format(string, sizeof(string), "Welcome to Escudo-Gaming, %s \n\n IP Address: %s \n\n You may register an account by entering a desired password here:", GetName(playerid), IP);
					ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, str, string, "Register", "Cancel");
				}
			}
		}
		case DIALOG_CHANGENAME:
        {
            if(!response)
			{
				new str[86];
				new id = GetPVarInt(playerid, "nrnplayerid");
				format(str, sizeof(str), "%s has refused to change their name", GetName(playerid));
				SendClientMessage(id, COLOR_YELLOW, str);
			}
			if(response)
			{
				new Query[250];
			    if(doesAccountExist(inputtext)) return SendClientMessage(playerid, -1, "Name is already taken.");
	            new oldName[MAX_PLAYER_NAME], str[150];
	            GetPlayerName(playerid, oldName, sizeof(oldName));
	            new name[MAX_PLAYER_NAME];
	            format(name, sizeof(name), "%s", inputtext);
	            SetPlayerName(playerid, name);
             	new PlayerName2[MAX_PLAYER_NAME], Length;
				GetPlayerName(playerid, PlayerName2, sizeof(PlayerName2));
				Length = strlen(PlayerName2);
				if(oldName[playerid] == PlayerName2[playerid]) return 1;
				if(PlayerName2[Length - 1] == '_' || PlayerName2[0] == '_' || strfind(PlayerName2, "_", false) == -1)
				{
				    SetPlayerName(playerid, oldName);
					SendClientMessage(playerid, COLOR_CYAN, "You failed to select a role play name, please select another name.");
					ShowPlayerDialog(playerid, DIALOG_CHANGENAME, DIALOG_STYLE_INPUT,""COL_WHITE"Name Change",""COL_WHITE"Type in another name to use. eg. Firstname_Lastname","Change","No!");
					return 1;
				}
				format(str, sizeof(str), "AdmWarn: %s (ID: %i) has changed name to %s.", oldName, playerid, name);
				SendClientMessageToAdmins(COLOR_YELLOW, str, 1);
				
				mysql_format(dbHandle, Query, sizeof(Query), "UPDATE `PlayerData` SET `Username` = '%s' WHERE `Username` = '%s'", pName(playerid), oldName[playerid]);
				mysql_query(dbHandle, Query, false);
				
				SetPVarInt(playerid, "RecentlyChangedName", 1);
				Log("/logs/changename.txt", str);
				return 1;
			}
		}
		case DIALOG_CHANGEPASS:
		{
			if(response)
			{
				new Query[256];
				if(strlen(inputtext) > 64)
				{
					SendClientMessage(playerid, COLOR_GREY, "[USAGE]: /changepass [newpass(max:64 char)]");
					ShowPlayerDialog(playerid, DIALOG_REGISTEREMAIL2, DIALOG_STYLE_INPUT, ""COL_ORANGE"Change Password", "Please change your password below.", "Change", "Cancel");
				}
				mysql_format(dbHandle, Query, sizeof(Query), "UPDATE `PlayerData` SET `Password` = SHA1('%e') WHERE `Username` = '%s'", inputtext, pName(playerid));
				mysql_query(dbHandle, Query, false);
				SendClientMessage(playerid, COLOR_ORANGE, "You have successfully changed your password");
			}
		}
		case DIALOG_VBUY:
		{
			if(!response) return RemovePlayerFromVehicle(playerid);
			if(response)
			{
				new id = GetVehicleID(GetPlayerVehicleID(playerid));
				if(pInfo[playerid][pCash] >= vInfo[id][vPrice])
				{
					SendClientMessage(playerid, -1, "Enjoy your new car.");
					
					new ID, Col, Query[512], rows, fields;
					new Float: pX, Float: pY, Float: pZ, Float: pA;
					
					new rand = random(sizeof(DealershipSpawn));
					new pName2[24];
					GetPlayerName(playerid, pName2, sizeof(pName2));
					new vid = GetVehicleID(GetPlayerVehicleID(playerid));
					new vehicleid;
					
					pX = DealershipSpawn[rand][0];
					pY = DealershipSpawn[rand][1];
					pZ = DealershipSpawn[rand][2];
					pA = 0;
					Col = random(10);
					ID = GetPVarInt(playerid, "DealershipVehicle");
										
					strcat(Query,"INSERT INTO `vehicles`(`Dealer`,`ID`,`Owner`, `Model`, `Price`,`PosX`,`PosY`,`PosZ`, `PosA`, `Color1`, `Color2`, `Fuel`)");
					strcat(Query," VALUES (0, NULL, '%s', '%d', 0, '%f', '%f', '%f', '%f', '%d', '%d', 100)");
					mysql_format(dbHandle, Query, sizeof(Query), Query, pName2, ID, pX, pY, pZ, pA, Col, Col);
					mysql_query(dbHandle, Query, false);
					
					pInfo[playerid][pCash] -= vInfo[vid][vPrice];					
				//	AddStaticVehicleEx(ID, pX, pY, pZ, pA, Col, Col, 60000);
					RemovePlayerFromVehicle(playerid);
					SetPlayerPos(playerid, pX, pY, pZ+4);
					for(new i; i < MAX_VEHICLES; i++)
					{
						mysql_format(dbHandle,Query, sizeof(Query), "SELECT `ID` FROM `vehicles` WHERE `ID` = '%d'", i);
						mysql_query(dbHandle,Query);
						cache_get_data(rows, fields);
						if(rows)
						{
							vehicleid = i;
						}
					}
					Load_Vehicle(vehicleid);
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREY, "You dont have enough money.");
					RemovePlayerFromVehicle(playerid);
				}
			}
		}
		case DIALOG_VSELL:
		{
			if(!response) SendClientMessage(GetPVarInt(playerid, "vSeller"), COLOR_GREY, "They buyer refused your offer.");
			if(response)
			{
				new price = GetPVarInt(playerid, "vPrice");
				new vid = GetPVarInt(playerid, "vID");
				new giveplayerid = GetPVarInt(playerid, "vSeller");
				if(pInfo[playerid][pCash] < price) return SendClientMessage(playerid, COLOR_GREY, "You dont have enough money.");
				
				new pName2[25], str[128], Query[518];
				GetPlayerName(playerid, pName2, sizeof(pName2));
				
				pInfo[playerid][pCash] -= price;
				pInfo[giveplayerid][pCash] += price;
				vInfo[vid][vOwner] = pName2;
				
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Vehicles` SET `Owner` = '%s' WHERE `ID` = '%d'",
				pName2, vid);
				mysql_query(dbHandle,Query,false);
				
				format(str, sizeof(str), "You have bought %s vehicle for R%d", GetName(giveplayerid), price);
				SendClientMessage(playerid, -1, str);
				format(str, sizeof(str), "%s has bought your vehicle for R%d", GetName(playerid), price);
				SendClientMessage(giveplayerid, -1, str);
				
			}
		}
		case DIALOG_VEDIT:
		{
			if(!response) return 1;
			if(response)
			{
				new id = GetVehicleID(GetPlayerVehicleID(playerid));
				if(listitem == 0)
				{
					if(vInfo[id][vDealer] == 1)
					{
						SendClientMessage(playerid, COLOR_GREY, "You cannot give a new owner to a dealer vehicle!");
						new caption[126], info[256], str[256];
												
						format(caption, sizeof(caption), "Edit Vehicle: %d", vInfo[id][vID]);
						format(str, sizeof(str), "Owner:   %s \nModel:    %d \nPrice:    %d\n", vInfo[id][vOwner], vInfo[id][vModel], vInfo[id][vPrice]);
						strcat(info, str, sizeof(info));
						ShowPlayerDialog(playerid, DIALOG_VEDIT, DIALOG_STYLE_LIST, caption, info, "Ok", "Cancel");
					}
					else
					{
						ShowPlayerDialog(playerid, DIALOG_VEDITO, DIALOG_STYLE_INPUT, "Edit Owner", "Please insert the new owner's name.", "Ok", "Cancel");
					}
				}
				if(listitem == 1)
				{
					ShowPlayerDialog(playerid, DIALOG_VEDITM, DIALOG_STYLE_INPUT, "Edit Model", "Please insert the new model's id.", "Ok", "Cancel");
				}
				if(listitem == 2)
				{
					ShowPlayerDialog(playerid, DIALOG_VEDITP, DIALOG_STYLE_INPUT, "Edit Price", "Please insert the new vehicle's price.", "Ok", "Cance;");
				}
			}
		}
	/*	case DIALOG_VEDITO:
		{
			new id = GetVehicleID(GetPlayerVehicleID(playerid));
			if(!response)
			{
				new caption[126], info[256], str[256];								
				format(caption, sizeof(caption), "Edit Vehicle: %d", vInfo[id][vID]);
				format(str, sizeof(str), "Owner:   %s \nModel:    %d \nPrice:    %d\n", vInfo[id][vOwner], vInfo[id][vModel], vInfo[id][vPrice]);
				strcat(info, str, sizeof(info));
				ShowPlayerDialog(playerid, DIALOG_VEDIT, DIALOG_STYLE_LIST, caption, info, "Ok", "Cancel");
			}
			if(response)
			{
				if(strlen(inputtext) == 0)
				{
					SendClientMessage(playerid, COLOR_GREY, "You need to input a price!");
					ShowPlayerDialog(playerid, DIALOG_VEDITP, DIALOG_STYLE_INPUT, "Edit Price", "Please insert the new vehicle's price.", "Ok", "Cance;");
				}
				vInfo[id][vOwner] == inputtext;
			}
		} */
		case DIALOG_VEDITM:
		{
			new id = GetVehicleID(GetPlayerVehicleID(playerid));
			new vid = GetPlayerVehicleID(playerid);
			if(!response)
			{
				new caption[126], info[256], str[256];								
				format(caption, sizeof(caption), "Edit Vehicle: %d", vInfo[id][vID]);
				format(str, sizeof(str), "Owner:   %s \nModel:    %d \nPrice:    %d\n", vInfo[id][vOwner], vInfo[id][vModel], vInfo[id][vPrice]);
				strcat(info, str, sizeof(info));
				ShowPlayerDialog(playerid, DIALOG_VEDIT, DIALOG_STYLE_LIST, caption, info, "Ok", "Cancel");
			}
			if(response)
			{
				if(strlen(inputtext) == 0)
				{
					SendClientMessage(playerid, COLOR_GREY, "You need to input a model id!");
					ShowPlayerDialog(playerid, DIALOG_VEDITM, DIALOG_STYLE_INPUT, "Edit Model", "Please insert the new model id.", "Ok", "Cance;");
				}
				new Query[512];
				new model = strval(inputtext);
				vInfo[vid][vModel] = model;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Vehicles` SET `Model` = '%d' WHERE `ID` = '%d'",
				model, id);
				mysql_query(dbHandle,Query,false);
				
				new Float:X, Float:Y, Float:Z, Float:R;
				GetVehiclePos(vid, X, Y, Z);
				GetVehicleZAngle(vid, R);
				DestroyVehicle(vid);
				AddStaticVehicleEx(model, X, Y, Z, R, vInfo[vID][vColor1], vInfo[vID][vColor2], 600);
				PutPlayerInVehicle(playerid, vid, 0);
			}
		}	
		case DIALOG_VEDITP:
		{
			new id = GetVehicleID(GetPlayerVehicleID(playerid));
			new vid = GetPlayerVehicleID(playerid);
			if(!response)
			{
				new caption[126], info[256], str[256];								
				format(caption, sizeof(caption), "Edit Vehicle: %d", vInfo[id][vID]);
				format(str, sizeof(str), "Owner:   %s \nModel:    %d \nPrice:    %d\n", vInfo[id][vOwner], vInfo[id][vModel], vInfo[id][vPrice]);
				strcat(info, str, sizeof(info));
				ShowPlayerDialog(playerid, DIALOG_VEDIT, DIALOG_STYLE_LIST, caption, info, "Ok", "Cancel");
			}
			if(response)
			{
				new model;
				if(strlen(inputtext) == 0)
				{
					SendClientMessage(playerid, COLOR_GREY, "You need to input a model id!");
					ShowPlayerDialog(playerid, DIALOG_VEDITM, DIALOG_STYLE_INPUT, "Edit Model", "Please insert the new model id.", "Ok", "Cance;");
				}
				new Query[512];
				new price = strval(inputtext);
				vInfo[vid][vPrice] = price;
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Vehicles` SET `Price` = '%d' WHERE `ID` = '%d'",
				price, id);
				
				new Float:X, Float:Y, Float:Z, Float:R;
				GetVehiclePos(vid, X, Y, Z);
				GetVehicleZAngle(vid, R);
				model = GetVehicleModel(vid);
				DestroyVehicle(vid);
				AddStaticVehicleEx(model, X, Y, Z, R, vInfo[vID][vColor1], vInfo[vID][vColor2], 600);
				PutPlayerInVehicle(playerid, vid, 0);
				if(vInfo[id][vDealer] == 1)
				{
					new labeltext[128];
					format(labeltext, sizeof(labeltext), "Price: R%d", vInfo[vid][vPrice]);
					vInfo[vid][Label] = Create3DTextLabel(labeltext, 0xBB7700DD, 0, 0, 0, 10.0, 0, 0);
					Attach3DTextLabelToVehicle(vInfo[vid][Label], VehicleID[vid], 0, 0, 0);
				}
			}
		}
		case DIALOG_VDELETE:
		{
			if(!response) return 1;
			if(response)
			{
				new id = GetVehicleID(GetPlayerVehicleID(playerid));
				new vid = GetPlayerVehicleID(playerid);
				if(vInfo[id][vDealer] == 1)
				{
					new Query[500], str[128];
					mysql_format(dbHandle,Query, sizeof(Query), "DELETE FROM `dvehicles` WHERE `ID` = '%d'", id);
					mysql_query(dbHandle,Query);
					format(str, sizeof(str), "Dealership car | Vehicle ID: %d | Deleted by: %s", id, GetName(playerid));
					Log("/logs/vdelete.txt", str);
					DestroyVehicle(vid);
				}
				if(vInfo[id][vDealer] == 0)
				{
					new Query[500], str[128];
					mysql_format(dbHandle,Query, sizeof(Query), "DELETE FROM `vehicles` WHERE `ID` = '%d'", id);
					mysql_query(dbHandle,Query);
					format(str, sizeof(str), "Non-Dealership Car | Vehicle ID: %d | Deleted by: %s", id, GetName(playerid));
					Log("/logs/vdelete.txt", str);
					DestroyVehicle(vid);
				}
			}
		}
		case DIALOG_HOUSESELL:
		{
			if(!response) return 1;
			if(response)
			{
				new price, pid, hid;
				new Query[126], rows, fields, str[85];
				price = GetPVarInt(playerid, "houseprice");
				pid = GetPVarInt(playerid, "sellerid");
				hid = GetPVarInt(playerid, "houseid");
				pInfo[playerid][pCash] -= price;
				pInfo[pid][pCash] += price;
				
				mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `PHouses` SET `Owner` = '%s' WHERE `ID` = '%d'",
				GetName(playerid), hid);
				mysql_query(dbHandle,Query,false);
				
				Destroy_DynamicHouse(hid);
				
				mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `PHouses` WHERE `ID` = '%d'", hid);
				mysql_query(dbHandle,Query);
				cache_get_data(rows, fields);
				if(rows)
				{
					Load_PlayerHouse(hid);
				}
				format(str, sizeof(str), "%s has bought your house for R%i", GetName(playerid), price);
				SendClientMessage(pid, -1, str);
			}
		}
		case DIALOG_BUYSKIN:
		{
			if(!response) return ProxDetector(30, playerid, "Store clerk says: Have a nice day.", -1);
			if(response)
			{
				new skin;
				skin = strval(inputtext);
				if(skin == pInfo[playerid][pSkin]) return SendClientMessage(playerid, COLOR_GREY, "You already have that skin.");
				if(!IsNumeric(inputtext)) return SendClientMessage(playerid, COLOR_GREY, "Skin ID: 1 - 399");
				if(skin <= 0 || skin >= 300) return SendClientMessage(playerid, COLOR_GREY, "Invalid skin ID");
				SetPlayerSkin(playerid, skin);
				pInfo[playerid][pSkin] = skin;
				pInfo[playerid][pCash] -= 250;
				ProxDetector(30, playerid, "Store clerk says: Enjoy your new skin! Have a nice day.", COLOR_GREY);
			}
		}
		case DIALOG_247:
		{
			if(!response) return ProxDetector(30, playerid, "Store clerk says: Have a nice day.", -1);
			if(response)
			{
				if(listitem == 0)
				{
					if(pInfo[playerid][pCash] < 500) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
					new rand = random(9999) + 1;
					pInfo[playerid][pPhone] = rand;
					pInfo[playerid][pCash] -= 500;
					ProxDetector(30, playerid, "Store clerk says: Enjoy your new item. Have a nice day.", -1);
					new str[56];
					format(str, sizeof(str), "Your phone number: %i", rand);
					SendClientMessage(playerid, COLOR_YELLOW, str);
				}
				if(listitem == 1)
				{
					if(pInfo[playerid][pCash] < 250) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
					pInfo[playerid][pSpraycans] += 1;
					pInfo[playerid][pCash] -= 250;
					SendClientMessage(playerid, -1, "You just bought a spray can.");
					ProxDetector(30, playerid, "Store clerk says: Enjoy your new item. Have a nice day.", -1);
				}
				if(listitem == 2)
				{
					if(pInfo[playerid][pCash] < 150) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
					pInfo[playerid][pRope] += 3;
					pInfo[playerid][pCash] -= 150;
					SendClientMessage(playerid, -1, "You just bought 3 ropes.");
					ProxDetector(30, playerid, "Store clerk says: Enjoy your new item. Have a nice day.", -1);
				}
				if(listitem == 3)
				{
					if(pInfo[playerid][pCash] < 150) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
					pInfo[playerid][pBandage] += 3;
					pInfo[playerid][pCash] -= 150;
					SendClientMessage(playerid, -1, "You just bought 3 bandages.");
					ProxDetector(30, playerid, "Store clerk says: Enjoy your new item. Have a nice day.", -1);
				}
			}
		}
		case DIALOG_FEDEXCOLLECT:
		{
			if(!response)
			{
				TogglePlayerControllable(playerid, 1);
				return 1;
			}
			if(response)
			{
				if(listitem == 0)
				{
					ShowPlayerDialog(playerid, DIALOG_FEDEXCOLLECT, DIALOG_STYLE_LIST, "Fedex Deliveries", "Short Distance\n\nCar Parts \nBuilding Supplies \nBurger Patties \n \nLong Distance\n\nChicken \nSprunk Drinks \n Boxes", "Start", "Cancel");
					DisablePlayerCheckpoint(playerid);
					TogglePlayerControllable(playerid, 0);
				}
				if(listitem == 1)
				{
					SetPlayerCheckpoint(playerid, -2750.7920, 205.8566, 6.7457, 10);
					GameTextForPlayer(playerid, "~y~Loading Van", 5000, 3);
					FreezePlayer(playerid, 5);
					SendClientMessage(playerid, COLOR_ORANGE, "Go deliver these parts to Wheel Arch Angels");
					FedexCPT[playerid] = 2;
				}
				if(listitem == 2)
				{
					SetPlayerCheckpoint(playerid, -2075.3984, 230.3594, 35.0228, 10);
					GameTextForPlayer(playerid, "~y~Loading Van", 5000, 3);
					FreezePlayer(playerid, 5);
					SendClientMessage(playerid, COLOR_ORANGE, "Go deliver these building equipment to the construction site");
					FedexCPT[playerid] = 2;
				}
				if(listitem == 3)
				{
					SetPlayerCheckpoint(playerid, -2316.4116, -149.6434, 34.8839, 10);
					GameTextForPlayer(playerid, "~y~Loading Van", 5000, 3);
					FreezePlayer(playerid, 5);
					SendClientMessage(playerid, COLOR_ORANGE, "Go deliver these burger patties to Burger Shot");
					FedexCPT[playerid] = 2;
				}
				if(listitem == 4)
				{
					ShowPlayerDialog(playerid, DIALOG_FEDEXCOLLECT, DIALOG_STYLE_LIST, "Fedex Deliveries", "Short Distance\n\nCar Parts \nBuilding Supplies \nBurger Patties \n \nLong Distance\n\nChicken \nSprunk Drinks \n Boxes", "Start", "Cancel");
					DisablePlayerCheckpoint(playerid);
					TogglePlayerControllable(playerid, 0);
				}
				if(listitem == 5)
				{
					ShowPlayerDialog(playerid, DIALOG_FEDEXCOLLECT, DIALOG_STYLE_LIST, "Fedex Deliveries", "Short Distance\n\nCar Parts \nBuilding Supplies \nBurger Patties \n \nLong Distance\n\nChicken \nSprunk Drinks \n Boxes", "Start", "Cancel");
					DisablePlayerCheckpoint(playerid);
					TogglePlayerControllable(playerid, 0);
				}
				if(listitem == 6)
				{
					SetPlayerCheckpoint(playerid, -1214.6544, 1822.5430, 41.3276, 10);
					GameTextForPlayer(playerid, "~y~Loading Van", 5000, 3);
					FreezePlayer(playerid, 5);
					SendClientMessage(playerid, COLOR_ORANGE, "Go deliver these chickens to Cluckin Bell");
					FedexCPT[playerid] = 4;
					
				}
				if(listitem == 7)
				{
					SetPlayerCheckpoint(playerid, 157.1208, -169.7108, 1.1469, 10);
					GameTextForPlayer(playerid, "~y~Loading Van", 5000, 3);
					FreezePlayer(playerid, 5);
					SendClientMessage(playerid, COLOR_ORANGE, "Go deliver these drinks to 24/7");
					FedexCPT[playerid] = 4;
					
				}
				if(listitem == 8)
				{
					SetPlayerCheckpoint(playerid, -66.6201, -1120.0367, 0.6400, 10);
					GameTextForPlayer(playerid, "~y~Loading Van", 5000, 3);
					FreezePlayer(playerid, 5);
					SendClientMessage(playerid, COLOR_ORANGE, "Go deliver these boxes to RS Haul");
					FedexCPT[playerid] = 4;
					
				}
			}
		}
		case DIALOG_WEPSELL:
		{
			new id = 0, price = 0, weapon = 0, str[50];
			id = GetPVarInt(playerid, "dealerid");
			price = GetPVarInt(playerid, "wepprice");
			weapon = GetPVarInt(playerid, "weapon");
			if(!response)
			{
				format(str, sizeof(str), "%s declined your deal.", GetName(playerid));
				SendClientMessage(id, COLOR_GREY, str);
				SendClientMessage(playerid, COLOR_GREY, "You denied the weapon deal");
			}
			else if(response)
			{
				if(pInfo[playerid][pCash] >= price)
				{
					pInfo[playerid][pCash] -= price;
					pInfo[id][pCash] += price;
					
					if(weapon == 1)
					{
						if(pInfo[id][pMats] >= 150)
						{
							pInfo[id][pMats] -= 150;
							GivePlayerWeapon(playerid, 4, 99999);
							gInfo[playerid][pGuns][1] = 4;
							format(str, sizeof(str), "You have just bought a knife for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You don't have enough mats");
					}
					else if(weapon == 2)
					{
						if(pInfo[id][pMats] >= 150)
						{
							pInfo[id][pMats] -= 150;
							GivePlayerWeapon(playerid, 5, 99999);
							gInfo[playerid][pGuns][1] = 5;
							format(str, sizeof(str), "You have just bought a baseball bat for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}
					else if(weapon == 3)
					{
						if(pInfo[id][pMats] >= 200)
						{
							pInfo[id][pMats] -= 200;
							GivePlayerWeapon(playerid, 1, 99999);
							gInfo[playerid][pGuns][0] = 1;
							format(str, sizeof(str), "You have just bought a brass knuckles for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}
					else if(weapon == 4)
					{
						if(pInfo[id][pMats] >= 500)
						{
							pInfo[id][pMats] -= 500;
							GivePlayerWeapon(playerid, 8, 99999);
							gInfo[playerid][pGuns][1] = 8;
							format(str, sizeof(str), "You have just bought a katana for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}
					else if(weapon == 5)
					{
						if(pInfo[id][pMats] >= 750)
						{
							pInfo[id][pMats] -= 750;
							GivePlayerWeapon(playerid, 22, 99999);
							gInfo[playerid][pGuns][2] = 22;
							format(str, sizeof(str), "You have just bought a 9mm for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}
					else if(weapon == 6)
					{
						if(pInfo[id][pMats] >= 1000)
						{
							pInfo[id][pMats] -= 1000;
							GivePlayerWeapon(playerid, 25, 99999);
							gInfo[playerid][pGuns][3] = 25;
							format(str, sizeof(str), "You have just bought a shotgun for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}
					else if(weapon == 7)
					{
						if(pInfo[id][pMats] >= 1500)
						{
							pInfo[id][pMats] -= 1500;
							GivePlayerWeapon(playerid, 24, 99999);
							gInfo[playerid][pGuns][2] = 24;
							format(str, sizeof(str), "You have just bought a deagle for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}
					else if(weapon == 8)
					{
						if(pInfo[id][pMats] >= 2500)
						{
							pInfo[id][pMats] -= 2500;
							GivePlayerWeapon(playerid, 28, 99999);
							gInfo[playerid][pGuns][4] = 28;
							format(str, sizeof(str), "You have just bought a uzi for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}
					else if(weapon == 9)
					{
						if(pInfo[id][pMats] >= 3000)
						{
							pInfo[id][pMats] -= 3000;
							GivePlayerWeapon(playerid, 32, 99999);
							gInfo[playerid][pGuns][4] = 32;
							format(str, sizeof(str), "You have just bought a tech9 for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}
					else if(weapon == 10)
					{
						if(pInfo[id][pMats] >= 5500)
						{
							pInfo[id][pMats] -= 5500;
							GivePlayerWeapon(playerid, 29, 99999);
							gInfo[playerid][pGuns][4] = 29;
							format(str, sizeof(str), "You have just bought a mp5 for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}
					else if(weapon == 11)
					{
						if(pInfo[id][pMats] >= 7000)
						{
							pInfo[id][pMats] -= 7000;
							GivePlayerWeapon(playerid, 30, 99999);
							gInfo[playerid][pGuns][5] = 30;
							format(str, sizeof(str), "You have just bought a ak47 for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}
					else if(weapon == 12)
					{
						if(pInfo[id][pMats] >= 7500)
						{
							pInfo[id][pMats] -= 7500;
							GivePlayerWeapon(playerid, 31, 99999);
							gInfo[playerid][pGuns][5] = 31;
							format(str, sizeof(str), "You have just bought a m4 for R%i", price);
							SendClientMessage(playerid, COLOR_GREY, str);
						}
						else return SendClientMessage(id, COLOR_GREY, "You dont have enough mats");
					}					
				}
				else return SendClientMessage(playerid, COLOR_GREY, "You dont have enough money");
			}
		}
		case DIALOG_BANK:
		{
			if(!response) return 0;
			if(response)
			{
				if(listitem == 0)
				{
					new str[128];
		            format(str,sizeof(str),"Your Curret Balance Is : R%d\nEnter The Amount You Want To Deposit Below :",pInfo[playerid][pBank]);
	              	ShowPlayerDialog(playerid, DIALOG_DEPOSIT, DIALOG_STYLE_INPUT, "Deposit",str, "Deposit", "Back");
				}
				if(listitem == 1)
				{
					new str[128];
		            format(str,sizeof(str),"Your Curret Balance Is : R%d\nEnter The Amount You Want To Withdraw Below :",pInfo[playerid][pBank]);
	              	ShowPlayerDialog(playerid, DIALOG_WITHDRAW, DIALOG_STYLE_INPUT, "Withdraw",str, "Withdraw", "Back");				
				}
				if(listitem == 2)
				{
					new str[128];
		            format(str,sizeof(str),"Your Current Balance Is : R%d\nEnter The Player ID You Want To Transfer To Below :",pInfo[playerid][pBank]);
		            ShowPlayerDialog(playerid,DIALOG_TRANSFER1,DIALOG_STYLE_INPUT,"Transfer",str,"Next","Back");
				}	
				if(listitem == 3)
				{
					new str[128];
					format(str, sizeof(str), "Your current bank balance is: R%d", pInfo[playerid][pBank]);
					ShowPlayerDialog(playerid, DIALOG_BALANCE, DIALOG_STYLE_MSGBOX, "Bank account", str, "Back", "");
				}	
			}	
		}	
		case DIALOG_DEPOSIT:
		{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "{007A00}Bank account", " Deposit \n Withdraw \n Balance", "Select", "Cancel");
			else if(strval(inputtext) > GetPlayerMoney(playerid)) return SendClientMessage(playerid,COLOR_RED,"You Don't Have That Amount!");
			else if(!IsNumeric(inputtext))
			{
				new str[128];
				format(str,sizeof(str),"Your Curret Balance Is : R%d\nEnter The Amount You Want To Deposit Below :",pInfo[playerid][pBank]);
	           	ShowPlayerDialog(playerid, DIALOG_DEPOSIT, DIALOG_STYLE_INPUT, "Deposit",str, "Deposit", "Back");
				SendClientMessage(playerid,COLOR_RED,"Please Use Numbers");
			}
			else
			{
				new str[128];
				new inputext = strval(inputtext);
				pInfo[playerid][pBank] += inputext;
				pInfo[playerid][pCash] -= inputext;
				format(str, sizeof(str), "You have deposited R%d into your account. New balance: R%d", inputext, pInfo[playerid][pBank]);
				SendClientMessage(playerid, 0x008000FF, str);
			}		
		}
		case DIALOG_WITHDRAW:
		{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "{007A00}Bank account", " Deposit \n Withdraw \n Balance", "Select", "Cancel");
			else if(strval(inputtext) > pInfo[playerid][pBank]) return SendClientMessage(playerid,COLOR_RED,"You Don't Have That Amount in your bank");
			else if(!IsNumeric(inputtext))
			{
				new str[128];
				format(str,sizeof(str),"Your Curret Balance Is : R%d\nEnter The Amount You Want To Withdraw Below :",pInfo[playerid][pBank]);
	           	ShowPlayerDialog(playerid, DIALOG_WITHDRAW, DIALOG_STYLE_INPUT, "Withdraw",str, "Withdraw", "Back");
				SendClientMessage(playerid,COLOR_RED,"Please Use Numbers");
			}
			else
			{
				new str[128];
				new inputext = strval(inputtext);
				pInfo[playerid][pBank] -= inputext;
				pInfo[playerid][pCash] += inputext;
				format(str, sizeof(str), "You have withdrawn R%d out of your account. New balance: R%d", inputext, pInfo[playerid][pBank]);
				SendClientMessage(playerid, 0x008000FF, str);
			}	
		}
		case DIALOG_TRANSFER1:
		{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "{007A00}Bank account", " Deposit \n Withdraw \n Balance", "Select", "Cancel");
			else if(strval(inputtext) == INVALID_PLAYER_ID) return SendClientMessage(playerid,COLOR_RED,"Player Not Online");
			else if(!IsNumeric(inputtext))
			{
				new str[128];
				format(str,sizeof(str),"Your Current Balance Is : R%d\nEnter The Player ID You Want To Transfer To Below :", pInfo[playerid][pBank]);
				ShowPlayerDialog(playerid,1130,DIALOG_STYLE_INPUT,"Transfer",str,"Next","Back");
				SendClientMessage(playerid,COLOR_RED,"Please Use ID Not Name");
			}
			else
			{
				chosenpid = strval(inputtext);
				new str[128];
				format(str,sizeof(str),"Balance : %d\nChosen Player ID : %d\nNow Enter The Amount You Want To Transfer",pInfo[playerid][pBank],chosenpid);
				ShowPlayerDialog(playerid,DIALOG_TRANSFER2,DIALOG_STYLE_INPUT,"Transfer",str,"Transfer","Back");
			}	
		}
		case DIALOG_TRANSFER2:
		{
			if(!response) return ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "{007A00}Bank account", " Deposit \n Withdraw \n Balance", "Select", "Cancel");
			else if(strval(inputtext) > pInfo[playerid][pBank]) return SendClientMessage(playerid,COLOR_RED,"You Don't Have That Amount In Bank To Transfer");
			else if(!IsNumeric(inputtext))
			{
				new str[128];
				format(str,sizeof(str),"Chosen Player ID : %d\nNow Enter The Amount You Want To Transfer",chosenpid);
				ShowPlayerDialog(playerid,1131,DIALOG_STYLE_INPUT,"Transfer",str,"Transfer","Back");
				SendClientMessage(playerid,COLOR_RED,"Please Use Numbers");
			}
			else
			{
				pInfo[playerid][pBank] -= strval(inputtext);
				pInfo[chosenpid][pBank] += strval(inputtext);
				new str[128];
				format(str,sizeof(str),"You Transfered R%d To ID %d's Bank Account",strval(inputtext),chosenpid);
				SendClientMessage(playerid, 0x008000FF, str);
				new str2[128]; 
				format(str2,128,"Your New Balance Is : R%d",pInfo[playerid][pBank]);
				SendClientMessage(playerid,0x008000FF,str2);
				new str3[128]; 
				format(str3,128,"ID : %d Transfered R%d To Your Bank Account",playerid,strval(inputtext));
				SendClientMessage(chosenpid,0x008000FF,str3);
				new str4[128];
				format(str4, 128, "Your New Balance : R%d", pInfo[chosenpid][pBank]);
				SendClientMessage(chosenpid, 0x008000FF, str4);
				ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"Bank","Deposit\nWithdraw\nBalance\nTransfer","Select","Cancel");
			}	
		}	
		case DIALOG_BALANCE:
		{
			if(response)
			{
				ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "{007A00}Bank account", " Deposit \n Withdraw \n Transfer \n Balance", "Select", "Cancel");
			}	
		}
		case DIALOG_RADIO:
		{
			if(response)
			{
				if(listitem == 0)
		        {
					PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=914897");
		        	GameTextForPlayer(playerid, "~r~Idobi Radio Station ~g~on", 3000, 1);
				}
				if(listitem == 1)
				{
					PlayAudioStreamForPlayer(playerid, "http://icy-e-02.sharp-stream.com/kerranglow.mp3");
					GameTextForPlayer(playerid, "~r~Kerrang! Radio Station ~g~on", 3000, 1);
				}
				if(listitem == 2)
				{
					PlayAudioStreamForPlayer(playerid, "http://listen.radionomy.com/NicoMalan-radio");
					GameTextForPlayer(playerid, "~r~NM-Radio ~g~on", 3000, 1);
				}
				if(listitem == 3)
				{
					StopAudioStreamForPlayer(playerid);
					GameTextForPlayer(playerid, "~r~Radio ~g~off", 3000, 1);
				}
			}
		}
		case DIALOG_JOBHELP:
		{
			if(!response) return 1;
			if(response)
			{
				if(listitem == 0)
				{
					new str[250];
					strcat(str, "Fedex driver has to pickup and deliver goods to \ntheir destinations. Their are long and short trips. \n", sizeof(str));
					strcat(str, "Fedex is a legal job and the pay is random. \n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Location: Durban \n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Commands: /loadvan", sizeof(str));
					ShowPlayerDialog(playerid, DIALOG_FEDEXHELP1, DIALOG_STYLE_MSGBOX, "Fedex Driver Help", str, "Set GPS", "Cancel");
				}
				if(listitem == 1)
				{
					new str[282];
					strcat(str, "Arms dealers have to collect or buy materials from other\nplayers to craft weapons and sell them for profit. \n", sizeof(str));
					strcat(str, "Arms dealing is a illegal job and you can get arrested if caught. \n", sizeof(str));
					strcat(str, "You set the price of the weapons you sell.\n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Location: Cape Town \n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Commands: /sellweapon  /buymats", sizeof(str));
					ShowPlayerDialog(playerid, DIALOG_ADHELP1, DIALOG_STYLE_MSGBOX, "Arms Dealer Help", str, "Set GPS", "Cancel");
				}
				if(listitem == 2)
				{
					new str[250];
					strcat(str, "Pizza Delivery workers have to pickup pizzas from pizza stack\nand deliver them to the customers homes as fast as possible \n", sizeof(str));
					strcat(str, "Pizza Delivery is a legal job \n", sizeof(str));
					strcat(str, "Pizza Delivery pay is random\n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Location: Cape Town \n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Commands: /loadpizza", sizeof(str));
					ShowPlayerDialog(playerid, DIALOG_PIZZAHELP1, DIALOG_STYLE_MSGBOX, "Pizza Delivery Help", str, "Set GPS", "Cancel");
				}
				if(listitem == 3)
				{
					new str[250];
					strcat(str, "Drug smugglers have to smuggle drugs from the depot\nto the crack den as fast and smooth as possible. \n", sizeof(str));
					strcat(str, "Drug smuggling is a illegal job \n", sizeof(str));
					strcat(str, "Drug smuggling pay is random\n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Location: Cape Town \n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Commands: /loadvan", sizeof(str));
					ShowPlayerDialog(playerid, DIALOG_DRUGSHELP1, DIALOG_STYLE_MSGBOX, "Drug Smuggling Help", str, "Set GPS", "Cancel");
				}
				if(listitem == 4)
				{
					new str[250];
					strcat(str, "Taxi drivers have to collect customers and drive them\nto their destination safely. \n", sizeof(str));
					strcat(str, "Taxi driving is a legal job \n", sizeof(str));
					strcat(str, "Taxi Driver sets the price of the taxi\n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Location: Cape Town \n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Commands: /fare", sizeof(str));
					ShowPlayerDialog(playerid, DIALOG_TAXIHELP1, DIALOG_STYLE_MSGBOX, "Taxi Driver Help", str, "Set GPS", "Cancel");
				}
				if(listitem == 5)
				{
					new str[250];
					strcat(str, "Warehouse workers have to pickup and deliver materials \nto the marerials warehouse next to Pizza Stack. \n", sizeof(str));
					strcat(str, "Warehouse Worker is a legal job \n", sizeof(str));
					strcat(str, "Warehouse Worker pay is random\n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Location: Cape Town \n", sizeof(str));
					strcat(str, " \n", sizeof(str));
					strcat(str, "Commands: /loadvan", sizeof(str));
					ShowPlayerDialog(playerid, DIALOG_WAREHHELP1, DIALOG_STYLE_MSGBOX, "Warehouse Worker Help", str, "Set GPS", "Cancel");
				}
			}
		}
		case DIALOG_FEDEXHELP1:
		{
			if(!response) return 1;
			if(response)
			{
				SendClientMessage(playerid, COLOR_ORANGE, "You have set your checkpoint to Fedex Depot");
				SetPlayerCheckpoint(playerid, -2170.8921, -216.0832, 35.3203, 5);
				JobCPT[playerid] = 1;
			}
		}
		case DIALOG_ADHELP1:
		{
			if(!response) return 1;
			if(response)
			{
				SendClientMessage(playerid, COLOR_ORANGE, "You have set your checkpoint to Ammu Nation");
				SetPlayerCheckpoint(playerid, 1365.5328, -1275.6300, 13.5469, 5);
				JobCPT[playerid] = 1;
			}
		}
		case DIALOG_PIZZAHELP1:
		{
			if(!response) return 1;
			if(response)
			{
				SendClientMessage(playerid, COLOR_ORANGE, "You have set your checkpoint to Pizza Stack");
				SetPlayerCheckpoint(playerid, 2106.3145, -1788.5518, 13.5608, 5);
				JobCPT[playerid] = 1;
			}
		}
		case DIALOG_DRUGSHELP1:
		{
			if(!response) return 1;
			if(response)
			{
				SendClientMessage(playerid, COLOR_ORANGE, "You have set your checkpoint to Drug Smuggler Depot");
				SetPlayerCheckpoint(playerid, 1151.0225, -1203.6011, 19.4515, 5);
				JobCPT[playerid] = 1;
			}
		}
		case DIALOG_TAXIHELP1:
		{
			if(!response) return 1;
			if(response)
			{
				SendClientMessage(playerid, COLOR_ORANGE, "You have set your checkpoint to Taxi Depot");
				SetPlayerCheckpoint(playerid, 1743.5931, -1861.5200, 13.5774, 5);
				JobCPT[playerid] = 1;
			}
		}
		case DIALOG_WAREHHELP1:
		{
			if(!response) return 1;
			if(response)
			{
				SendClientMessage(playerid, COLOR_ORANGE, "You have set your checkpoint to the Warehouse");
				SetPlayerCheckpoint(playerid, 2180.1250, -2256.1853, 14.7734, 5);
				JobCPT[playerid] = 1;
			}
		}
		case DIALOG_SAPD:
        {
            if(!response)
            {
                return 1;
			}
			if(response)
			{
			    if(listitem == 0)
			    {
			        if(OnDuty[playerid] == 0)
			        {
					    SetPlayerColor(playerid, 0x0800FF00);
					    OnDuty[playerid] = 1;
						SetPlayerArmour(playerid, 100);
						SetPlayerHealth(playerid, 100);
						GivePlayerValidWeapon(playerid, 24, 99999);
						GivePlayerValidWeapon(playerid, 29, 99999);
						GivePlayerValidWeapon(playerid, 3, 99999);
						GivePlayerValidWeapon(playerid, 25, 99999);
						GivePlayerValidWeapon(playerid, 41, 99999);
					//	pInfo[playerid][pSkin] = 280;
						SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
						return 1;
					}
    			    if(OnDuty[playerid] == 1)
			        {
					    SetPlayerColor(playerid, 0xFFFFFF00);
					    OnDuty[playerid] = 0;
						SetPlayerArmour(playerid, 100);
						SetPlayerHealth(playerid, 100);
						ResetPlayerWeapons(playerid);
						RemovePlayerWeapons(playerid);
					//	PlayerInfo[playerid][pSkin] = 2;
						SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
						return 1;
					}
				}
               	if(listitem == 1)
			    {
                    ShowPlayerDialog(playerid, DIALOG_SAPD2, DIALOG_STYLE_LIST, "Equipment", "Desert Eagle (R0)\nShotgun (R0)\nMP5 (R0)\nM4(R0)\nSpray Can (R0)\nNitestick\nSpas-12 (R700)\nSniper (R800)\nFirst Aid Kit\nKevlar Vest", "Ok", "Close");
					return 1;
				}
                if(listitem == 2)
			    {
                    ShowPlayerDialog(playerid, DIALOG_SAPD3, DIALOG_STYLE_LIST, "Uniform", "Cadet\nOfficer\nCorporal\nCorporal2\nCorporal3\nBike Officer\nSergeant\nLieutenant\nChief\nSWAT", "Ok", "Close");
					return 1;
				}
				if(listitem == 2)
				{
				    ShowPlayerDialog(playerid, DIALOG_UNINVITESKIN, DIALOG_STYLE_INPUT,""COL_WHITE"Skin change",""COL_WHITE"Select a skin to use. Valid skin IDs are 0 to 299.","Change","No");
					return 1;
				}
			}
			return 1;
		}


		case DIALOG_SAPD2:
        {
            if(!response)
            {
            	ShowPlayerDialog(playerid, DIALOG_SAPD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform\nSelect Skin", "Ok", "Close");
				return 1;
			}
			if(response)
			{
			    switch(listitem)
			    {
			        case 0:
			        {
					GivePlayerValidWeapon(playerid, 24, 99999);
					}
					case 1:
					{
					GivePlayerValidWeapon(playerid, 25, 99999);
					}
					case 2:
					{
					GivePlayerValidWeapon(playerid, 29, 99999);
					}
					case 3:
					{
					GivePlayerValidWeapon(playerid, 31, 99999);
					}
					case 4:
					{
					GivePlayerValidWeapon(playerid, 41, 99999);
					}
					case 5:
					{
					GivePlayerValidWeapon(playerid, 3, 1);
					}
					case 6:
					{
					if(pInfo[playerid][pCash] < 700) { SendClientMessage(playerid, -1, "You don't have enough cash to buy this."); return -1; }
					GivePlayerValidWeapon(playerid, 27, 99999);
					pInfo[playerid][pCash] -= 700;
					}
					case 7:
					{
					if(pInfo[playerid][pCash] < 800) { SendClientMessage(playerid, -1, "You don't have enough cash to buy this."); return -1; }
					GivePlayerValidWeapon(playerid, 34, 99999);
					pInfo[playerid][pCash] -= 800;
					}
					case 8:
					{
					SetPlayerHealth(playerid, 100);
					}
					case 9:
					{
					SetPlayerArmour(playerid, 100);
					}
				}
				return 1;
			}
			return 1;
		}

        case DIALOG_SAPD3:
        {
            if(!response)
            {
            	ShowPlayerDialog(playerid, DIALOG_SAPD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform\nSelect Skin", "Ok", "Close");
				return 1;
			}
			if(response)
			{
			    if(listitem == 0)
			    {
					pInfo[playerid][pSkin] = 71; // cadet
					SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
				}
                if(listitem == 1)
			    {
					pInfo[playerid][pSkin] = 280; // officer
					SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
				}
    			if(listitem == 2)
			    {
					pInfo[playerid][pSkin] = 281; // corporal 1
					SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
				}
				if(listitem == 3)
				{
					pInfo[playerid][pSkin] = 266; // corporal 2
					SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
				}
				if(listitem == 4)
				{
					pInfo[playerid][pSkin] = 267; // corporal 3
					SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
				}
                if(listitem == 5)
				{
					pInfo[playerid][pSkin] = 284; // bike officer
					SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
				}
				if(listitem == 6)
				{
					pInfo[playerid][pSkin] = 282; // sergeant
					SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
				}
				if(listitem == 7)
				{
					pInfo[playerid][pSkin] = 283; // lieutenant
					SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
				}
    			if(listitem == 8)
				{
					pInfo[playerid][pSkin] = 288; // chief
					SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
				}
    			if(listitem == 9)
				{
					pInfo[playerid][pSkin] = 285; // SWAT
					SetPlayerSkin(playerid, pInfo[playerid][pSkin]);
				}
				return 1;
			}
			return 1;
		}
		case DIALOG_LAFMD:
		{
		    if(response)
		    {
		        if(listitem == 0)
      			{
              		if(OnDuty[playerid] == 0)
		            {
			            SetPlayerColor(playerid, 0x470000FF);
			            OnDuty[playerid] = 1;
			            SendClientMessage(playerid, -1, "You are now on duty as a medic/fireman.");
			            SetPVarInt(playerid, "Skin", pInfo[playerid][pSkin]);
			            if(pInfo[playerid][pGender] == 1)
			            {
			            	pInfo[playerid][pGender] = 274;
			            	SetPlayerSkin(playerid, 274);
		            	}
		            	if(pInfo[playerid][pGender] == 2)
		            	{
		            	    pInfo[playerid][pSkin] = 93;
		            	    SetPlayerSkin(playerid, 93);
		            	}
			            return 1;
		            }
		            if(OnDuty[playerid] == 1)
	                {
		                SetPlayerColor(playerid, 0xFFFFFF00);
			            OnDuty[playerid] = 0;
			            SendClientMessage(playerid, -1, "You are now off duty.");
			            pInfo[playerid][pSkin] = GetPVarInt(playerid, "Skin");
			            SetPlayerSkin(playerid, GetPVarInt(playerid, "Skin"));
			        	return 1;
		        	}
		    	}
			}
			if(listitem == 1)
			{
			    ShowPlayerDialog(playerid, DIALOG_LAFMD2, DIALOG_STYLE_LIST, "Equipment", "Fire extinguisher\nMorphine\nBandages", "Ok", "Cancel");
			    return 1;
			}
			if(listitem == 2)
			{
				ShowPlayerDialog(playerid, DIALOG_LAFMD3, DIALOG_STYLE_LIST, "Uniform", "Medic\nFire Fighter", "Ok", "Close");
				return 1;
			}
  		}
  		case DIALOG_LAFMD2:
  		{
  		    if(!response) return ShowPlayerDialog(playerid, DIALOG_LAFMD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform", "Ok", "Close");
  		    if(response)
  		    {
  		        if(listitem == 0)
  		        {
  		            SendClientMessage(playerid, -1, "You have picked up the fire extinguisher.");
  		            GivePlayerValidWeapon(playerid, 42, 999999);
  		            ShowPlayerDialog(playerid, DIALOG_LAFMD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform", "Ok", "Close");
  		            return 1;
  		        }
  		        if(listitem == 1)
  		        {
  		            if(pInfo[playerid][pMorphine] > 9)
  		            {
						SendClientMessage(playerid, -1, "You cant carry anymore morphine.");
  		                ShowPlayerDialog(playerid, DIALOG_LAFMD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform", "Ok", "Close");
  		                return 1;
  		            }
  		            else
  		            {
	  		            SendClientMessage(playerid, -1, "You have picked up the morphine.");
	  		            pInfo[playerid][pMorphine] += 5;
	  		            ShowPlayerDialog(playerid, DIALOG_LAFMD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform", "Ok", "Close");
  		            }
  		            return 1;
  		        }
				if(listitem == 2)
				{
					if(pInfo[playerid][pBandage] > 9)
					{
						SendClientMessage(playerid, -1, "You cant carry anymore bandages.");
  		                ShowPlayerDialog(playerid, DIALOG_LAFMD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform", "Ok", "Close");
  		                return 1;
					}
					else
					{
						SendClientMessage(playerid, -1, "You have picked up the bandages.");
						pInfo[playerid][pBandage] += 5;
						ShowPlayerDialog(playerid, DIALOG_LAFMD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform", "Ok", "Close");
					}
				}
  		    }
  		}
  		case DIALOG_LAFMD3:
  		{
  		    if(!response) return ShowPlayerDialog(playerid, DIALOG_LAFMD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform", "Ok", "Close");
  		    if(response)
  		    {
  		        if(listitem == 0)
  		        {
					pInfo[playerid][pSkin] =  274;
					SetPlayerSkin(playerid, 274);
  		            return 1;
  		        }
  		        if(listitem == 1)
  		        {
  		            pInfo[playerid][pSkin] =  277;
  		            SetPlayerSkin(playerid, 277);
  		            return 1;
				}
  		    }
  		}
		case DIALOG_TAXI:
		{
		    new str[128];
		    if(!response) return 1;
		    if(response)
		    {
			    if(TaxiCallTime[playerid] > 0)
				{
			 		SendClientMessage(playerid, COLOR_GREY, "You have already accepted a Taxi Call.");
					return 1;
	    		}
	    		if(PlayerOnMission[playerid] > 0)
			    {
			        SendClientMessage(playerid, COLOR_GREY, "On a mission right now, can't use this command.");
			        return 1;
			    }
       			if(TaxiCall < 999)
	            {
	              	if(IsPlayerConnected(TaxiCall))
	               	{
						new Float: pX, Float: pY, Float: pZ;
						GetPlayerPos(TaxiCall, pX, pY, pZ);
						SetPlayerCheckpoint(playerid, pX, pY, pZ, 1);
					    format(str, sizeof(str), "%s has accepted your request. Please stay were you are.", GetName(playerid));
					    SendClientMessage(TaxiCall, -1, str);
					    TaxiCallTime[playerid] = 1;
						TaxiAccepted[playerid] = TaxiCall;
						format(str, sizeof(str), "You have accepted %s's taxi call", GetName(TaxiCall));
						SendClientMessage(playerid, COLOR_YELLOW, str);
						TaxiDestTimer[playerid] = SetTimerEx("TaxiDestinationTimer", 1000, true, "i", playerid);
						TaxiDriver[TaxiCall] = playerid;
					}
				}
				else
	            {
	                SendClientMessage(playerid, COLOR_GREY, "No-one called for a Taxi yet.");
			    	return 1;
	            }
			}
		}
		case DIALOG_INVITE:
		{
			if(!response)
			{
				SendClientMessage(invitedby[playerid], COLOR_CYAN, "That person declined your invite");
				SendClientMessage(playerid, COLOR_CYAN, "You declined the faction invite");
			}
			if(response)
			{
				SendClientMessage(invitedby[playerid], COLOR_CYAN, "That person accepted your invite");
				SendClientMessage(playerid, COLOR_CYAN, "You accepted the faction invite");
				pInfo[playerid][pFaction] = invitedto[playerid];
			}
		}
	}
	return 1;
}


public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public AfterLife(playerid)
{
    IsAfterLifing[playerid] = 1;
    SecsToGo[playerid]--;
    new string[128];
    format(string,sizeof(string),"~b~ ~h~ ~h~you are in afterlife~n~ ~b~ ~h~ ~h~you will revive in %d seconds",SecsToGo[playerid]);
    GameTextForPlayer(playerid, string, 1100, 3);
    if (SecsToGo[playerid] <= 0)
    {
        CleanPlayerChat(playerid);
        KillTimer(AfterLifeTimer);
        SendClientMessage(playerid, COLOR_RED, "------------------ Health Advise -----------------");
        SendClientMessage(playerid, -1 ,"You're hospital bill was R500");
        SendClientMessage(playerid, -1 ,"The doctors have treated you.");
        SendClientMessage(playerid, -1, "Remember, you have lost memory from the most recent 30 minutes.");
        SendClientMessage(playerid, COLOR_RED, "--------------------------------------------------------");
		pInfo[playerid][pCash] -= 500;
		SetSpawnInfo(playerid, 0, pInfo[playerid][pSkin], 1173.8160, -1323.9063, 15.1953, 272.0021, 0, 0, 0, 0, 0, 0);
        SpawnPlayer(playerid);
        return 1;
    }
    return 1;
}
 
public AutoDeath(playerid)
{
    if (IsDead[playerid] == 0) { return 0; }
    else if (IsDead[playerid] == 1)
    {
        new saystring[128], name[28];
		new deathstring[128];
        GetPlayerName(playerid,name,sizeof(name));
        switch (random(2))
        {
			case 0:
			{
				format(saystring,sizeof(saystring),"%s mumbles: I can't hold more..", name);
				format(deathstring,sizeof(deathstring),"* %s closes his eyes, falling into death.", name);
			}
			case 1:
			{
				format(saystring,sizeof(saystring),"%s mumbles: Aghh.. It's cold.. I feel something.. A light-..",name);
				format(deathstring,sizeof(deathstring),"* %s is now inmobilized, and dead.",name);
			}
		}
		ProxDetector(30, playerid, deathstring, -1);
		ProxDetector(10, playerid, saystring, -1);
		IsDead[playerid] = 0;
		SecsToGo[playerid] = AFTERLIFE_SECONDS;
		SendClientMessage(playerid,COLOR_RED,"------------------ Health Advise -----------------");
		SendClientMessage(playerid,-1,"You are now in the afterlife. You may rest in peace.");
		SendClientMessage(playerid,-1,"When you revive, you will lose the last 30 minutes of memory.");
		SendClientMessage(playerid,-1,"If you were non-RPly killed, report the player.");
		SendClientMessage(playerid,COLOR_RED,"--------------------------------------------------------");
		SetPlayerPos(playerid, 0, 0, 0);
		SetPlayerCameraPos(playerid,DeathPosX[playerid],DeathPosY[playerid],DeathPosZ[playerid]);
		SetPlayerCameraLookAt(playerid,DeathPosX[playerid],DeathPosY[playerid],DeathPosZ[playerid]+100);
		AfterLifeTimer = SetTimerEx("AfterLife",1000,true,"i",playerid);
		KillTimer(LoseHPTimer[playerid]);
	}
    return 1;

}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
	if(tazer[playerid] == 1)
	{
		new playerState = GetPlayerState(damagedid); // Get the killer's state
		if (playerState == PLAYER_STATE_PASSENGER || playerState == PLAYER_STATE_DRIVER) return 1;
		if(playerid == damagedid) return Kick(playerid);
		new string[56];
		format(string, sizeof(string), "* %s fires their tazer at %s.", GetName(playerid), GetName(damagedid));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE);
		GameTextForPlayer(damagedid, "~r~Tazed", 3500, 3);
		TogglePlayerControllable(damagedid, 0);
	//	PreloadAnims(playerid);
		ApplyAnimation(damagedid,"CRACK","crckdeth2",4.1,0,1,1,1,1,0);
		SetTimerEx("untaze", 5000, false, "i", damagedid);
		SetPVarInt(damagedid, "Restrained", 1);
	}
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	new string[86];
	for(new i = 1; i < MAX_FSTATIONS; i++)
	{
		if(areaid == FuelArea[i])
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(Refueled[playerid] != 0) return 1;
			if(!IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid))) return 1;
			if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return 1;
			if(GetVehicleFuel(vehicleid) == 100) return 1;
			//new id = GetPlayerVehicleID(playerid);
			//new str[128];
			//format(str, sizeof(str), "Vehicle ID: %d", id);
			SetPVarInt(playerid, "RF ID", GetPlayerVehicleID(playerid));
			new vehid = GetPlayerVehicleID(playerid);
			SetPVarInt(playerid, "RF VID", GetVehicleID(vehid));
			format(string, sizeof(string), "* %s puts the nozzle of the gas pump in the car.", GetName(playerid));
			ProxDetector(30, playerid, string, COLOR_PURPLE);
			RefuelTimer[vehicleid] = SetTimerEx("refuel", 100, true, "i", playerid);
			GameTextForPlayer(playerid, "~g~Refueling", 5000, 6);
			TogglePlayerControllable(playerid, 0);
		}
	}
    return true;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	for(new i = 1; i < MAX_FSTATIONS; i++)
	{
		if(areaid == FuelArea[i])
		{
			KillTimer(RefuelTimer[vehicleid]);
		}
	}
	return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////
//============================== FORWARDS ==============================================//
//////////////////////////////////////////////////////////////////////////////////////////

forward PlayerTime(playerid);
public PlayerTime(playerid)
{
  /* for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            pInfo[i][pHours]++;
		}
    } */
	pInfo[playerid][pHours]++;
    return 1;
}

forward WepCheck();
public WepCheck()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(GetPlayerWeapon(i) == 38)
		{
			if(IsPlayerConnected(i))
			{
				new reason[56], string[235], Query[500], pIpAddress[15];
				format(reason, sizeof(reason), "Minigun");
				format(string, sizeof(string), "ADMCMD: %s has been banned by Anti-Hack. Reason: %s", GetName(i), reason);
				SendClientMessageToAll(COLOR_RED, string);
				GetPlayerIp(i, pIpAddress, sizeof(pIpAddress));
				strcat(Query,"INSERT INTO `bans`(`Name`,`Reason`,`BannedBy`,`IpAddress`,`Status`)");
				strcat(Query," VALUES ('%s', '%s', 'Anti-Hack', '%s', 1)");
				mysql_format(dbHandle, Query, sizeof(Query), Query, GetName(i), reason, pIpAddress);
				mysql_query(dbHandle, Query, false);
				Kick(i);
				format(string, sizeof(string), "ADMCMD: %s has been banned by Anti-Hack. Reason: %s", GetName(i), reason);
				Log("/logs/bans.txt", string);
			}
		}
	}
	return 1;
}

forward FloodCheck(playerid);
public FloodCheck(playerid)
{
    if(FloodByPlayer[playerid] >= MAX_FLOODLINES)
    {
        ChatMute[playerid] = 1;
		SendClientMessage(playerid, COLOR_RED, "You have been muted due to spam.");
		FloodByPlayer[playerid] = FloodByPlayer[playerid]-5;
		return 1;
    }
    else
	{
		FloodByPlayer[playerid] = 0;
		ChatMute[playerid] = 0;
	}
    return 1;
}

forward AfterLife(playerid);
forward AutoDeath(playerid);

forward LoseHP(playerid);
public LoseHP(playerid)
{
	new Float:HP;
	GetPlayerHealth(playerid, HP);
	SetPlayerHealth(playerid, HP-5);
	return 1;
}

forward enterance(playerid);
public enterance(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}

forward untaze(playerid);
public untaze(playerid)
{
	if(GetPVarInt(playerid, "Cuffed") == 1) return SetPVarInt(playerid, "Restrained", 0);
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, 1);
	SetPVarInt(playerid, "Restrained", 0);
	return 1;
}

forward refuel(playerid);
public refuel(playerid)
{
	new str[128];
	new vehicleid = GetPlayerVehicleID(playerid);
	new vid = GetPVarInt(playerid, "RF ID");
	new vehid = GetPVarInt(playerid, "RF VID");
	if(IsABycicle(vid)) return 1;
	if(IsPlayerNearVehicle(playerid, vid, 5))
	{
		for(new i = 1; i < MAX_FSTATIONS; i++)
		{
			if(IsPlayerInRangeOfPoint(playerid,7.0,fInfo[i][fPos][0], fInfo[i][fPos][1], fInfo[i][fPos][2]))
			{
				if(vInfo[vehid][vOwner] != 0)
				{
					if(vInfo[vehid][vFuel] < 100)
					{
						RefuelCost[playerid] += 25;
						vInfo[vehid][vFuel] += 1;
						return 1;
					}
					else if(vInfo[vehid][vFuel] >= 100)
					{
						format(str, sizeof(str), "You have refueled your car for R%d", RefuelCost[playerid]);
						SendClientMessage(playerid, COLOR_YELLOW, str);
						pInfo[playerid][pCash] -= RefuelCost[playerid];
						RefuelCost[playerid] = 0;
						KillTimer(RefuelTimer[vehicleid]);
						TogglePlayerControllable(playerid, 1);
						Refueled[playerid] = 1;
						SetTimerEx("RefuelSpam", 10000, false, "i", playerid);
						break;
					}
					return 1;
				}
				else
				{
					if(GetVehicleFuel(vid) < 100)
					{
						RefuelCost[playerid] += 25;
						gVehicleFuel[vid] += 1;
						return 1;
					}
					else if(GetVehicleFuel(vid) == 100)
					{
						TogglePlayerControllable(playerid, 1);
						break;
					}
					else if(GetVehicleFuel(vid) >= 100)
					{
						format(str, sizeof(str), "You have refueled your car for R%d", RefuelCost[playerid]);
						SendClientMessage(playerid, COLOR_YELLOW, str);
						pInfo[playerid][pCash] -= RefuelCost[playerid];
						RefuelCost[playerid] = 0;
						KillTimer(RefuelTimer[vehicleid]);
						TogglePlayerControllable(playerid, 1);
						Refueled[vehicleid] = 1;
						SetTimerEx("RefuelSpam", 10000, false, "i", vehicleid);
						break;
					}
				}
			}
			else KillTimer(RefuelTimer[vehicleid]);
		}
	}	
	return 1;
}

forward RefuelSpam(vehicleid);
public RefuelSpam(vehicleid)
{
	Refueled[vehicleid] = 0;
	KillTimer(RefuelTimer[vehicleid]);
	KillTimer(RefuelSpamTimer[vehicleid]);
	return 1;
}

forward arrestrelease(playerid);
public arrestrelease(playerid)
{
	if(pInfo[playerid][pJail] == 0)
	{
	    KillTimer(rtimer[playerid]);
	    SetPlayerColor(playerid, 0xFFFFFFAA);
		return 1;
	}
	if(pInfo[playerid][pJail] > 1)
	{
		pInfo[playerid][pJail] -= 1;
		return 1;
	}
	if(pInfo[playerid][pJail] <= 1)
	{
		SetPlayerPos(playerid, 1862.2820,-1702.5566,5202.5859);
		SetPlayerInterior(playerid, 5);
		SetPlayerVirtualWorld(playerid, 0);
		FreezePlayer(playerid, 3);
		pInfo[playerid][pJail] = 0;
		pInfo[playerid][pVW] = 0;
		pInfo[playerid][pInt] = 0;
		GameTextForPlayer(playerid, "Released. Try to be good now.", 5000, 3);
		SendClientMessage(playerid, COLOR_LIGHTRED, "You have finished your jail sentence.");
		SetPlayerColor(playerid, 0xFFFFFF00);
		KillTimer(rtimer[playerid]);
	}
	return 1;
}

forward MSG();
public MSG()
{
    TextDrawSetString(ServerMSG, RMessages[random(sizeof(RMessages))]);
	TextDrawSetString(ServerLogo, "Escudo-Gaming");
    return 1;
}

forward TaxiDestinationTimer(playerid);
public TaxiDestinationTimer(playerid)
{
	if(TaxiCall < 999)
	{
		new Float: pX, Float: pY, Float: pZ;
		GetPlayerPos(TaxiCall, pX, pY, pZ);
		SetPlayerCheckpoint(playerid, pX, pY, pZ, 1);
	}
}

forward settime();
public settime()
{
	new hour, minute, second;
	gettime(hour, minute, second);
	new str[156];
	new hour2 = hour;
	format(str, sizeof(str), "%d:0%d", hour, minute);
	TextDrawSetString(Clock, str);
	SetWorldTime(hour);
	if(hour2 < 0)
	{
		if(minute <= 9)
		{
			format(str, sizeof(str), "%d:0%d", hour, minute);
		}
		else
		{
			format(str, sizeof(str), "%d:%d", hour, minute);
		}
		TextDrawSetString(Clock, str);
		SetWorldTime(hour+13);
	}
	else
	{
		if(minute <= 9)
		{
			format(str, sizeof(str), "%d:0%d", hour, minute);
		}
		else
		{
			format(str, sizeof(str), "%d:%d", hour, minute);
		}
		TextDrawSetString(Clock, str);
		SetWorldTime(hour);
	}	
	if(minute == 0)
	{
		if(paydaycount == 0)
		{
			PayDay();
			SetTimer("rpcount", 60000, false);
		}
	}
}
/*
forward GetTime(hour, minute, second);
public GetTime(hour, minute, second);
{
	gettime(hour, minute, second);
	hour-9;
	if(hour < 0)
	{
		hour+15;
	}
	else
	{
		hour-9;
	}
	return hour, minute, second;
}	*/

forward PayDay();
public PayDay()
{
	if(paydaycount == 0)
	{
		paydaycount = 1;
		for(new i; i < MAX_PLAYERS; i++)
		{
			new interest, str[128];
			interest = pInfo[i][pBank] * 1/100;
			new total = interest;
			pInfo[i][pBank] += total;
			
			SendClientMessage(i, COLOR_GREEN, "============= PAYDAY =============");
			format(str, sizeof(str), "Interest: R%i", total);
			SendClientMessage(i, -1, str);
			format(str, sizeof(str), "Bank Total: R%i", pInfo[i][pBank]);
			SendClientMessage(i, -1, str);
			SendClientMessage(i, COLOR_GREEN, "==================================");
		}
	}
}

forward rpcount();
public rpcount()
{
	paydaycount = 0;
}

forward FlasherFunc();
public FlasherFunc() {
        new panelsx,doorsx,lightsx,tiresx;
        for (new p=0; p<MAX_VEHICLES; p++)
        {
                if (Flasher[p] == 1)
                {
                        if (FlasherState[p] == 1)
                        {
                                GetVehicleDamageStatus(p,panelsx,doorsx,lightsx,tiresx);
                                UpdateVehicleDamageStatus(p, panelsx, doorsx, 4, tiresx);
                                FlasherState[p] = 0;
                        }
                        else
                        {
                                GetVehicleDamageStatus(p,panelsx,doorsx,lightsx,tiresx);
                                UpdateVehicleDamageStatus(p, panelsx, doorsx, 1, tiresx);
                                FlasherState[p] = 1;
                        }
                }
        }
        return 1;
}

forward EMSAntiSpam(playerid);
public EMSAntiSpam(playerid)
{
	if(AES[playerid] >= 0)
	{
		if(GetPVarInt(playerid, "Injured") == 1)
		{
			AES[playerid] -= 1;
		}
		else
		{
			AES[playerid] = 0;
			KillTimer(AntiEMSTimer[playerid]);
		}
	}
	return 1;
}

forward HospitalDeliver(playerid);
public HospitalDeliver(playerid)
{
	if(HospitalCount[playerid] <= 0)
	{
		if(DeliverdTo[playerid] == 1)
		{
			TogglePlayerSpectating(playerid, 0);
			SetPlayerHealth(playerid, 80);
			KillTimer(LoseHPTimer[playerid]);
			LoseHPTimer[playerid] = 0;
			IsDead[playerid] = 0;
			pInfo[playerid][pCash] -= 100;
			SetPVarInt(playerid, "Injured", 0);
			KillTimer(HospitalTimer[playerid]);
			TogglePlayerControllable(playerid, 1);
			SendClientMessage(playerid, COLOR_LIGHTRED, "HOSPITAL: You have been delivered to the hospital and the health care costed you R100.");
			SetPlayerPos(playerid, 2030.08, -1425, 17);
		}
		else if(DeliverdTo[playerid] == 2)
		{
			TogglePlayerSpectating(playerid, 0);
			SetPlayerHealth(playerid, 80);
			KillTimer(LoseHPTimer[playerid]);
			LoseHPTimer[playerid] = 0;
			IsDead[playerid] = 0;
			pInfo[playerid][pCash] -= 100;
			SetPVarInt(playerid, "Injured", 0);
			KillTimer(HospitalTimer[playerid]);
			TogglePlayerControllable(playerid, 1);
			SendClientMessage(playerid, COLOR_LIGHTRED, "HOSPITAL: You have been delivered to the hospital and the health care costed you R100.");
			SetPlayerPos(playerid, 1181.34, -1323.80, 13.58);
		}
	}
	if(HospitalCount[playerid] > 0)
	{
		new str[56];
		format(str, sizeof(str), "~r~You will spawn in %i seconds", HospitalCount[playerid]);
		GameTextForPlayer(playerid, str, 1000, 3); 		
		HospitalCount[playerid]--;
	}
	return 1;
}

forward AdminAntiSpamTimer();
public AdminAntiSpamTimer()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
		AdminAntiSpam[i] = 0;
	}
	return 1;
}

forward ResetThePlayersWeapons(playerid);
public ResetThePlayersWeapons(playerid)
{
	ResetPlayerWeapons(playerid);
	Load_Weapons(playerid);
	return 1;
}

forward NewbPause(playerid);
public NewbPause(playerid)
{
	if(NoNewb[playerid] <= 0)
	{
		KillTimer(NewbTimer[playerid]);
	}
	else
	{
		NoNewb[playerid] --;
	}
	return 1;
}

forward serverrestart();
public serverrestart()
{
	if(CountDown <= 0)
	{
		SendRconCommand("gmx");
	}
	else if(CountDown >= 1)
	{
		if(CountDown == 30 || CountDown == 20 || CountDown == 10 || CountDown == 5 || CountDown == 3 || CountDown == 2 || CountDown == 1)
		{
			new str[56];
			format(str, sizeof(str), "Server Restart in %i seconds", CountDown);
			SendClientMessageToAll(COLOR_YELLOW, str);
		}
		CountDown--;
	}
	return 1;
}

forward ExplodeIdle1();
public ExplodeIdle1()
{
	if(Explotions <= 20)
	{
		CreateExplosion(1938.1843,-1775.6530,13.1118, 1, 20.0);
		CreateExplosion(1937.1843,-1774.6530,13.1118, 1, 20.0);
		CreateExplosion(1939.1843,-1774.6530,13.1118, 1, 20.0);
		CreateExplosion(1938.1843,-1773.6530,13.1118, 1, 20.0);
		CreateExplosion(1938.1843,-1774.6530,13.1118, 7, 20.0);
		Explotions++;
	}
	else KillTimer(ExplotionTimer);
	return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////
//============================== COMMANDS ==============================================//
//////////////////////////////////////////////////////////////////////////////////////////

CMD:help(playerid, params[])
{
	new helpinfo[1024];
	strcat(helpinfo, "GENERAL:  /me  /do  /s  /b /ooc  /hideooc  /unhideooc  /bank  /pay  \n", sizeof(helpinfo));
	strcat(helpinfo, "GENERAL:  /service  /cancel  /stats  /srm  /kill  /newb  /enter  /buymats \n", sizeof(helpinfo));
	strcat(helpinfo, "GENERAL:  /call  /sms  /acceptcall  /p  /h  /buy  /buyskin  /killcheckpoint  /radio  /buylevel \n", sizeof(helpinfo));
	strcat(helpinfo, "GENERAL:  /acceptdeath  /time  /tie  /untie  /am  /pm \n", sizeof(helpinfo));
	strcat(helpinfo, "JOB:  /join  /jobquit  /jobhelp  /loadvan  /sellweapon  /loadpizza \n", sizeof(helpinfo));
	strcat(helpinfo, "JOB:  /fare  /loadtrailer \n", sizeof(helpinfo));
	strcat(helpinfo, "VEHICLE:  /engine  /lights  /sb  /pvlock  /spraycar  /vehid  /refuel  /sellv \n", sizeof(helpinfo));
	strcat(helpinfo, "HOUSE:  /buyhouse  /sellhouse\n", sizeof(helpinfo));
	strcat(helpinfo, "FACTION:  /fh  \n", sizeof(helpinfo));
	strcat(helpinfo, "EVENT:  /joinrace  \n", sizeof(helpinfo));
	strcat(helpinfo, "ACCOUNT:  /changepass  /changeemail  /report  /requesthelp  \n", sizeof(helpinfo));
	strcat(helpinfo, "SERVER:  /updates  /rules  \n", sizeof(helpinfo));
	
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Help", helpinfo, "Ok", "");
	return 1;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//============================== GENERAL COMMANDS ==============================================///
///////////////////////////////////////////////////////////////////////////////////////////////////

CMD:me(playerid, params[])
{
    new string[128], action[100];
    if(sscanf(params, "s[100]", action))
    {
        SendClientMessage(playerid, -1, "USAGE: /me [action]");
        return 1;
    }
    else
    {
        format(string, sizeof(string), "* %s %s", GetName(playerid), action);
        ProxDetector(30, playerid, string, COLOR_PURPLE);
    }
    return 1;
}

CMD:do(playerid, params[])
{
    new
        string[128],
        action[100];
    if(sscanf(params, "s[100]", action))
    {
        SendClientMessage(playerid, -1, "USAGE: /do [action]");
        return 1;
    }
    else
    {
        format(string, sizeof(string), "* %s (( %s ))", action, GetName(playerid));
        ProxDetector(30, playerid, string, COLOR_PURPLE);
    }
    return 1;
}

CMD:s(playerid, params[]) return cmd_shout(playerid, params);
CMD:shout(playerid, params[])
{
    new
        string[128],
        shout[100];
    if(sscanf(params, "s[100]", shout))
    {
        SendClientMessage(playerid, -1, "USAGE: /(s)hout [message]");
        return 1;
    }
    else
    {
        format(string, sizeof(string), "%s shouts: %s!",GetName(playerid),shout);
        ProxDetector(50.0, playerid, string, -1);
		SetPlayerChatBubble(playerid, string, COLOR_WHITE, 20.0, 5000);
    }
    return 1;
}

CMD:b(playerid, params[])
{
	new string[128], text[100];
	if(sscanf(params, "s[100]", text)) return SendClientMessage(playerid, -1, "USAGE: /b [TEXT]");
 	format(string, sizeof(string), "(( %s says: %s ))", GetName(playerid), text);
	ProxDetector(30.0, playerid, string, COLOR_GREY);
	return 1;
}

CMD:ooc(playerid, params[])
{
	new msg[58], str[64];
	if(sscanf(params, "s[58]", msg)) return SendClientMessage(playerid, -1, "USAGE: /ooc [TEXT]");
	if(OOCChannel == 0) return SendClientMessage(playerid, COLOR_GREY, "OOC chat has been disabled by an admin");
	format(str, sizeof(str), "%s OOC chat: %s", GetName(playerid), msg);
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(OOCEnabled[i] == 1)
		{
			SendClientMessage(i, COLOR_CYAN, str);
		}
	}
	return 1;
}

CMD:hideooc(playerid, params[])
{
	if(OOCEnabled[playerid] == 1)
	{
		SendClientMessage(playerid, COLOR_CYAN, "You have hidden OOC chat channel");
		OOCEnabled[playerid] = 0;
	}
	else
	{
		SendClientMessage(playerid, COLOR_CYAN, "You have unhidden OOC chat channel");
		OOCEnabled[playerid] = 1;
	}
	return 1;
}
CMD:unhideooc(playerid, params[]) return cmd_hideooc(playerid, params);

CMD:bank(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 60, 246.375991, 109.245994, 1003.218750))
	{
		SendClientMessage(playerid,COLOR_GREY,"You Have To Be In The Bank");
	}	
	else
	{
		ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, "{007A00}Bank account", " Deposit \n Withdraw \n Transfer \n Balance", "Select", "Cancel");
	}	
	return 1;
}

CMD:pay(playerid, params[])
{
	new giveplayerid, amount, str[128], str2[128], str3[128];
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specifed.");
	if(sscanf(params, "di", giveplayerid, amount))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /pay [playerid] [amount]");
		return 1;
	}
	new Float:x,Float:y,Float:z;
    GetPlayerPos(giveplayerid,x,y,z);
    GetPlayerPos(playerid, x, y, z);
    if(IsPlayerInRangeOfPoint(giveplayerid,5,x,y,z))
	{
		if(pInfo[playerid][pCash] < amount) return SendClientMessage(playerid, COLOR_GREY, "You do not have the sufficient funds.");
	    pInfo[playerid][pCash] -= amount;
	    pInfo[giveplayerid][pCash] += amount;
	    format(str, sizeof(str), "*%s pulls out a roll of cash from his pocket and hands it to %s", GetName(playerid), GetName(giveplayerid));
	    ProxDetector(30.0, playerid, str, COLOR_PURPLE);
	    format(str2, sizeof(str2), "You were paid R%i by %s", amount, GetName(playerid));
	    SendClientMessage(giveplayerid, COLOR_GREEN, str2);
	    format(str3, sizeof(str3), "You have paid %s R%i", GetName(giveplayerid), amount);
	    SendClientMessage(playerid, COLOR_GREEN, str3);
	    return 1;
	}
	else
	{
	    SendClientMessage(playerid, -1, "You are not close enough to that player");
	}
	return 1;
}

CMD:service(playerid, params[])
{
	new choice[32], str[128];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /service [choice]");
		SendClientMessage(playerid, -1, "Choices: Taxi");
		return 1;
	}
	if(strcmp(choice, "taxi", true) == 0)
	{
	    for(new p;p<MAX_PLAYERS;p++)
	    {
	        if(TransportDuty[p] == 1)
	        {
	            TaxiCall = playerid;
	            format(str, sizeof(str), "%s is requesting a taxi.", GetName(playerid));
	            ShowPlayerDialog(p, DIALOG_TAXI, DIALOG_STYLE_MSGBOX, "Taxi Request", str, "Accept", "Cancel");
	        }
	    }
	    return 1;
	}
	return 1;
}

CMD:cancel(playerid, params[])
{
	new choice[32], str[128];
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /service [choice]");
		SendClientMessage(playerid, -1, "Choices: Taxi");
		return 1;
	}
	if(strcmp(choice, "taxi", true) == 0)
	{
		SendClientMessage(playerid, -1, "You have canceled your taxi request.");
		format(str, sizeof(str), "%s has canceled the taxi request", GetName(playerid));
		SendClientMessage(TaxiDriver[playerid], COLOR_YELLOW, str);
		PlayerOnMission[TaxiDriver[playerid]] = 0;
		TaxiCallTime[TaxiDriver[playerid]] = 0;
		KillTimer(TaxiDestTimer[TaxiDriver[playerid]]);
		DisablePlayerCheckpoint(TaxiDriver[playerid]);
		TaxiDriver[playerid] = -1;
	}
	return 1;
}

CMD:stats(playerid, params[])
{
	ShowStats(playerid, playerid);
	return 1;
}

CMD:srm(playerid, params[])
{
	new id, string[126], str[126];
	if(sscanf(params, "us[126]", id, string)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /srm [ID] [TEXT]");
	
	if(GetPVarInt(playerid, "ReportPending") == 2)
	{
		format(str, sizeof(str), "[ID: %d] %s says: %s", playerid, GetName(playerid), string);
		SendClientMessage(id, COLOR_LIGHTRED, str);
		
		format(str, sizeof(str), "You: %s", string);
		SendClientMessage(playerid, COLOR_LIGHTRED, str);
		return 1;
	}
	if(GetPVarInt(playerid, "OnReport") == 1)
	{
		if(pInfo[playerid][pAdminLevel] >= 1)
		{
			format(str, sizeof(str), "[ID: %d] Admin says: %s", playerid, string);
			SendClientMessage(id, COLOR_LIGHTRED, str);
		
			format(str, sizeof(str), "You: %s", string);
			SendClientMessage(playerid, COLOR_LIGHTRED, str);
		}
		else
		{
			format(str, sizeof(str), "[ID: %d] %s says: %s", playerid, GetName(playerid), string);
			SendClientMessage(id, COLOR_LIGHTRED, str);
			
			format(str, sizeof(str), "You: %s", string);
			SendClientMessage(playerid, COLOR_LIGHTRED, str);
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "An admin has not accepted your report");
	return 1;
}

CMD:kill(playerid, param[])
{
	if(GetPVarInt(playerid, "Injured") == 1) return SendClientMessage(playerid, COLOR_GREY, "You are injured. use /acceptdeath");
	SendClientMessage(playerid, COLOR_RED, "You have commited suicide.");
	SetPlayerHealth(playerid, 0);
	return 1;
}

CMD:newb(playerid, params[])
{
	new say[128], str[126];
	if(pInfo[playerid][pNewbMute] == 1) return SendClientMessage(playerid, COLOR_GREY, "Your are muted from newbie chat.");
	if(tognewbie[playerid] == 1) return SendClientMessage(playerid, COLOR_CYAN, "Your newbie chat is disabled, use /tognewb to enable.");
	if(isnull(params)) return SendClientMessage(playerid, -1, "USAGE: /newb [text]");
	if(sscanf(params, "s[100]", say)) return SendClientMessage(playerid, -1, "USAGE: /newb [text]");
	if(pInfo[playerid][pAdminLevel] > 1)
	{
		format(str, 126, "Admin %s: %s", GetName(playerid), say);
		Newbie(str);
		return 1;
	}
	if(pInfo[playerid][pModerator] == 4)
	{
		format(str, 126, "Chief Moderator %s: %s", GetName(playerid), say);
		Newbie(str);
		return 1;
	}
	if(pInfo[playerid][pModerator] == 3)
	{
		format(str, 126, "Senior Moderator %s: %s", GetName(playerid), say);
		Newbie(str);
		return 1;
	}
	if(pInfo[playerid][pModerator] == 2)
	{
		format(str, 126, "Moderator %s: %s", GetName(playerid), say);
		Newbie(str);
		return 1;
	}
	if(pInfo[playerid][pModerator] == 1)
	{
		format(str, 126, "Junior Moderator %s: %s", GetName(playerid), say);
		Newbie(str);
		return 1;
	}
 	if(NoNewb[playerid] == 1)
	{
		format(str, sizeof(str), "You have to wait %i seconds between each usage.", NoNewb[playerid]);
		SendClientMessage(playerid, -1, str);
		return 1;
	}
 	else
 	{
		format(str, 126, "Newbie %s: %s", GetName(playerid), say);
		Newbie(str);
		NoNewb[playerid] = 30;
		NewbTimer[playerid] = SetTimerEx("NewbPause", 30000, false, "i", playerid);
	}
	return 1;
}

CMD:enter(playerid, params[])
{
	new string[128];
	for(new i = 0; i < sizeof(dInfo); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid,3.0,dInfo[i][dEPos][0], dInfo[i][dEPos][1], dInfo[i][dEPos][2]))
		{
			format(string, sizeof(string), "* %s entered %s.", GetName(playerid), dInfo[i][dName]);
			ProxDetector(25.0, playerid, string, COLOR_PURPLE);
			SetPlayerInterior(playerid,dInfo[i][dInt]);
			pInfo[playerid][pInt] = dInfo[i][dInt];
			SetPlayerVirtualWorld(playerid, dInfo[i][dVW]);
			pInfo[playerid][pVW] = dInfo[i][dVW];
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			{
				SetPlayerPos(playerid,dInfo[i][dIPos][0],dInfo[i][dIPos][1],dInfo[i][dIPos][2]);
				SetPlayerFacingAngle(playerid, dInfo[i][dFacAng]);
				SetCameraBehindPlayer(playerid);
				TogglePlayerControllable(playerid, 0);
				SetTimerEx("enterance", 3000, false, "i", playerid);
			}
		/*	if(dInfo[i][ddVehicleAble] > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
			    new car;
			    car = GetPlayerVehicleID(playerid);
				SetVehiclePos(GetPlayerVehicleID(playerid), dInfo[i][ddInteriorX],dInfo[i][ddInteriorY],dInfo[i][ddInteriorZ]);
				SetVehicleZAngle(GetPlayerVehicleID(playerid), dInfo[i][ddInteriorA]);
				SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dInfo[i][ddInteriorVW]);
				PutPlayerInVehicle(playerid, car, 0);
				LinkVehicleToInterior(GetPlayerVehicleID(playerid), dInfo[i][ddInteriorInt]);
				TogglePlayerControllable(playerid, 0);
				SetTimerEx("enterance", 2000, false, "i", playerid);
				return 1;
			} */
		}
		else if(IsPlayerInRangeOfPoint(playerid,3,dInfo[i][dIPos][0], dInfo[i][dIPos][1], dInfo[i][dIPos][2]))
		{
			if(GetPlayerVirtualWorld(playerid) == dInfo[i][dVW])
			{
			/*	if(dInfo[i][ddVehicleAble] > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				{
					new car;
					car = GetPlayerVehicleID(playerid);
					SetVehiclePos(GetPlayerVehicleID(playerid), dInfo[i][ddExteriorX],dInfo[i][ddExteriorY],dInfo[i][ddExteriorZ]);
					SetVehicleZAngle(GetPlayerVehicleID(playerid), dInfo[i][ddExteriorA]);
					SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), dInfo[i][ddExteriorVW]);
					PutPlayerInVehicle(playerid, car, 0);
					TogglePlayerControllable(playerid, 0);
					SetTimerEx("enterance", 2000, false, "i", playerid);
					LinkVehicleToInterior(GetPlayerVehicleID(playerid), dInfo[i][ddExteriorInt]);
				} */
				format(string, sizeof(string), "* %s exited %s.", GetName(playerid), dInfo[i][dName]);
				ProxDetector(25.0, playerid, string, COLOR_PURPLE);
				SetPlayerInterior(playerid,dInfo[i][dEInt]);
				pInfo[playerid][pInt] = dInfo[i][dEInt];
				SetPlayerVirtualWorld(playerid, dInfo[i][dEVW]);
				pInfo[playerid][pVW] = dInfo[i][dEVW];
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
					SetPlayerPos(playerid, dInfo[i][dEPos][0], dInfo[i][dEPos][1],dInfo[i][dEPos][2]);
					SetPlayerFacingAngle(playerid, dInfo[i][dIFacAng]);
					SetCameraBehindPlayer(playerid);
					TogglePlayerControllable(playerid, 0);
					SetTimerEx("enterance", 3000, false, "i", playerid);
				}
			}
		}
	}
	for(new i = 0; i < sizeof(hInfo); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid,1,hInfo[i][hPos][0], hInfo[i][hPos][1], hInfo[i][hPos][2]))
		{
			format(string, sizeof(string), "* %s entered the house.", GetName(playerid));
			ProxDetector(25.0, playerid, string, COLOR_PURPLE);
			SetPlayerInterior(playerid, hInfo[i][hInt]);
			pInfo[playerid][pInt] = hInfo[i][hInt];
			SetPlayerVirtualWorld(playerid, hInfo[i][hVW]);
			pInfo[playerid][pVW] = hInfo[i][hVW];
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			{
				SetPlayerPos(playerid, hInfo[i][hIPos][0], hInfo[i][hIPos][1], hInfo[i][hIPos][2]);
				SetCameraBehindPlayer(playerid);
				TogglePlayerControllable(playerid, 0);
				SetTimerEx("enterance", 3000, false, "i", playerid);
			}
		}
		else if(IsPlayerInRangeOfPoint(playerid,1,hInfo[i][hIPos][0], hInfo[i][hIPos][1], hInfo[i][hIPos][2]))
		{
			if(GetPlayerVirtualWorld(playerid) == hInfo[i][hVW])
			{
				format(string, sizeof(string), "* %s exited the house.", GetName(playerid));
				ProxDetector(25.0, playerid, string, COLOR_PURPLE);
				SetPlayerInterior(playerid, 0);
				pInfo[playerid][pInt] = 0;
				SetPlayerVirtualWorld(playerid, 0);
				pInfo[playerid][pVW] = 0;
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
					SetPlayerPos(playerid, hInfo[i][hPos][0], hInfo[i][hPos][1], hInfo[i][hPos][2]);
					SetPlayerFacingAngle(playerid, hInfo[i][hFacAngle]+180);
					SetCameraBehindPlayer(playerid);
					TogglePlayerControllable(playerid, 0);
					SetTimerEx("enterance", 3000, false, "i", playerid);
				}
			}
		}
	}
	return 1;
}
CMD:exit(playerid, params[]) return cmd_enter(playerid, params);

CMD:buymats(playerid, params[])
{
    if(pInfo[playerid][pJob1] != 2) return SendClientMessage(playerid, -1, "You are not a weapon dealer.");
    new amount;
	if(sscanf(params, "d", amount))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /buymats [amount]");
		SendClientMessage(playerid, COLOR_GREY, "AMOUNTS: 1000 (R1000) | 2000 (R2000) | 5000 (R5000) | 10000 (R10000) ");
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 5, 2116.1904, -1887.2052, 13.5391))
	{
		if(Materials < amount) return SendClientMessage(playerid, -1, "There are not that many materials in stock at the moment.");
		if(amount == 1000)
		{
		    if(pInfo[playerid][pCash] < amount) return SendClientMessage(playerid, -1, "You dont have enough money.");
		    pInfo[playerid][pMats] += 1000;
		    pInfo[playerid][pCash] -= amount;
		    SendClientMessage(playerid, -1, "You just bought 1000 mats.");
		    Materials -= 1000;
			return 1;
		}
		if(amount == 2000)
		{
		    if(pInfo[playerid][pCash] < amount) return SendClientMessage(playerid, -1, "You dont have enough money.");
		    pInfo[playerid][pMats] += 2000;
		    pInfo[playerid][pCash] -= amount;
		    SendClientMessage(playerid, -1, "You just bought 2000 mats.");
		    Materials -= 2000;
			return 1;
		}
		if(amount == 5000)
		{
		    if(pInfo[playerid][pCash] < amount) return SendClientMessage(playerid, -1, "You dont have enough money.");
		    pInfo[playerid][pMats] += 5000;
		    pInfo[playerid][pCash] -= amount;
		    SendClientMessage(playerid, -1, "You just bought 5000 mats.");
		    Materials -= 5000;
			return 1;
		}
		if(amount == 10000)
		{
		    if(pInfo[playerid][pCash] < amount) return SendClientMessage(playerid, -1, "You dont have enough money.");
		    pInfo[playerid][pMats] += 10000;
		    pInfo[playerid][pCash] -= amount;
		    SendClientMessage(playerid, -1, "You just bought 10000 mats.");
		    Materials -= 10000;
			return 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GREY, "AMOUNTS: 1000 (R1000) | 2000 (R2000) | 5000 (R5000) | 10000 (R10000) ");
		}
	}
	else
	{
		SendClientMessage(playerid, -1, "You are not at the material's warehouse.");
	}
	return 1;
}

CMD:call(playerid, params[])
{
	new phonenumb, str[128], string[128];
	if(isnull(params)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /call [phonenumber]");
	phonenumb = strval(params);
	if(pInfo[playerid][pPhone] == 0) return SendClientMessage(playerid, COLOR_GREY, "You do not have a cell-phone");
	if(pInfo[playerid][pJail] > 0) return SendClientMessage(playerid,COLOR_GREY,"You can't use your phone while in jail.");
	if(GetPVarInt(playerid, "Injured") != 0 || GetPVarInt(playerid, "Recovering") != 0 || GetPVarInt(playerid, "Cuffed") != 0) return SendClientMessage(playerid,COLOR_GREY,"You can't use your phone right now.");
	format(str, sizeof(str), "* %s takes out a cell-phone and calls a number", GetName(playerid));
	ProxDetector(30.0, playerid, str, COLOR_PURPLE);
	PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
	if(phonenumb == 911)
	{
		OnCall[playerid] = 911;
		Call911[playerid] = 1;
		SendClientMessage(playerid, COLOR_LIGHTRED, "Service Operator: Police or Paramedic");
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		SetPlayerAttachedObject(playerid, 9, 330 , 6);
	}
	if(phonenumb == pInfo[playerid][pPhone])
	{
		SendClientMessage(playerid, COLOR_GREY, "You can't call yourself.");
		return 1;
	}
/*	if(OnCall[playerid] != -1)
	{
		SendClientMessage(playerid, COLOR_GRAD2, "You're already in a call...");
		return 1;
	} */
	foreach(Player, i)
	{
		if(pInfo[i][pPhone] == phonenumb && phonenumb != 0)
		{
			new giveplayerid = i;
			OnCall[playerid] = giveplayerid;
			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid == INVALID_PLAYER_ID) { SendClientMessage(playerid, COLOR_GREY, "* Unable to connect to the number specified."); return 1; }
				{
					format(string, sizeof(string), "Incomming call from number %i.. (Caller Name: %s) - /p to answer the call.", pInfo[playerid][pPhone], GetName(playerid));
					SendClientMessage(giveplayerid, COLOR_YELLOW, string);
					format(string, sizeof(string), "* %s's phone starts ringing.", GetName(i));
					ProxDetector(30.0, i, string, COLOR_PURPLE);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
					SetPlayerAttachedObject(playerid, 9, 330, 6);
					return 1;
				}
			}
		}
	}
	return 1;
}

CMD:sms(playerid, params[])
{
    new phonenumb, text[126];
	if(sscanf(params, "is", phonenumb, text)) return SendClientMessage(playerid, -1, "USAGE: /sms [number][text]");
	phonenumb = strval(params);
	if(pInfo[playerid][pJail] > 0) return SendClientMessage(playerid,COLOR_GREY,"You can't use your phone while in jail.");
	if(GetPVarInt(playerid, "Injured") != 0 || GetPVarInt(playerid, "Recovering") != 0 || GetPVarInt(playerid, "Cuffed") != 0) return SendClientMessage(playerid,COLOR_GREY,"You can't use your phone right now.");
	if(pInfo[playerid][pPhone] == 0) return SendClientMessage(playerid, COLOR_GRAD2, "You don't have a cell phone.");
    foreach(Player, i)
	{
		if(pInfo[i][pPhone] == phonenumb && phonenumb != 0)
		{
		    new giveplayerid = i;
		    new str[128], str2[128];
		    if(IsPlayerConnected(giveplayerid))
		    {
		        if(giveplayerid == INVALID_PLAYER_ID) { SendClientMessage(playerid, COLOR_GREY, "* Unable to connect to the number specified."); return 1; }
		        {
		            format(str, sizeof(str), "%i text: %s", pInfo[playerid][pPhone], text);
		            SendClientMessage(giveplayerid, 0xFFFF00AA, str);
		            format(str2, sizeof(str2), "%i text: %s", pInfo[giveplayerid][pPhone], text);
		            SendClientMessage(playerid, 0xFFFF00AA, str2);
		            
		        }
		    }
		}
		
	}
	return 1;
}

CMD:p(playerid, params[])
{
	new string[56];
	if(OnCall[playerid] != -1)
	{
		SendClientMessage(playerid, COLOR_GREY, "You are already on a call.");
		return 1;
	}
	if(IsAfterLifing[playerid] != 0 || GetPVarInt(playerid, "Cuffed") != 0)
	{
		SendClientMessage (playerid, COLOR_GREY, "You can't use your cellphone right now.");
		return 1;
	}
	foreach(Player, i)
	{
		if(OnCall[i] == playerid)
		{
			OnCall[playerid] = i;
			SendClientMessage(i,  COLOR_GREY, "They picked up the call.");
			format(string, sizeof(string), "* %s answers their cellphone.", GetName(playerid));
			ProxDetector(30.0, playerid, string, COLOR_PURPLE);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			SetPlayerAttachedObject(playerid, 9, 330, 6);
		}
	}
	return 1;
}

CMD:h(playerid, params[])
{
	new string[56];
	if(OnCall[playerid] == 0) return SendClientMessage(playerid, COLOR_GREY, "You are not on a call");
	format(string, sizeof(string), "* %s puts their cellphone away.", GetName(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE);
	SendClientMessage(OnCall[playerid], COLOR_YELLOW, "They put down the phone");
	if(IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid)))
	{
		ClearAnimations(OnCall[playerid]);
		RemovePlayerAttachedObject(OnCall[playerid], 9);
		OnCall[OnCall[playerid]] = -1;
		OnCall[playerid] = -1;
		RemovePlayerAttachedObject(playerid, 9);
		return 1;
	}
	else
	{
		ClearAnimations(OnCall[playerid]);
		RemovePlayerAttachedObject(OnCall[playerid], 9);
		OnCall[OnCall[playerid]] = -1;
		OnCall[playerid] = -1;
		RemovePlayerAttachedObject(playerid, 9);
	}
	return 1;
}

CMD:buy(playerid, params[])
{
	new int = GetPlayerInterior(playerid);
	if(int == 17)
	{
		ShowPlayerDialog(playerid, DIALOG_247, DIALOG_STYLE_LIST, "24/7", "Cell-Phone R500 \nSpray-Can R250 \nRope R150 \nBandages R150", "Buy", "Cancel");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not in a store.");
	return 1;
}

CMD:buyskin(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 30, 207.2720,-101.7905,1005.2578))
	{
		ShowPlayerDialog(playerid, DIALOG_BUYSKIN, DIALOG_STYLE_INPUT, "Buy Skin", "Skin Price: R250 \n\nPlease insert the skin ID \nyou would like to use.", "Buy", "Cancel");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not at a clothes shop.");
	return 1;
}

CMD:killcheckpoint(playerid, params[])
{
	DisablePlayerCheckpoint(playerid);
	FedexCPT[playerid] = 0;
	CDLCPT[playerid] = 0;
	PizzaDeliveryCPT[playerid] = 0;
	TaxiCallTime[playerid] = 0;
	PlayerOnMission[playerid] = 0;
	KillTimer(TaxiDestTimer[playerid]);
	SendClientMessage(playerid, -1, "You have killed your current checkpoint");
	return 1;
}

CMD:radio(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_RADIO, DIALOG_STYLE_LIST, "Live Radio Stations", "Idobi Radio Station \nKerrang! Radio Station \nNM-Radio \nRadio Off", "Listen", "Close");
	return 1;
}

CMD:buylevel(playerid, params[])
{
	new lvl = pInfo[playerid][pLevel];
	new hTime = pInfo[playerid][pHours]/60/60;
	new cost;
	if(hTime >= 8 && lvl == 1)
	{
		cost = 10000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 2;
		SetPlayerScore(playerid, 2);
		pInfo[playerid][pCash] -= 10000;
		SendClientMessage(playerid, -1, "You just reached level 2. Cost: R10000");
	}
	else if(hTime >= 12 && lvl == 2)
	{
		cost = 15000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 3;
		SetPlayerScore(playerid, 3);
		pInfo[playerid][pCash] -= 15000;
		SendClientMessage(playerid, -1, "You just reached level 3. Cost: R15000");
	}
	else if(hTime >= 18 && lvl == 3)
	{
		cost = 20000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 4;
		SetPlayerScore(playerid, 4);
		pInfo[playerid][pCash] -= 20000;
		SendClientMessage(playerid, -1, "You just reached level 4. Cost: R20000");
	}
	else if(hTime >= 24 && lvl == 4)
	{
		cost = 25000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 5;
		SetPlayerScore(playerid, 5);
		pInfo[playerid][pCash] -= 25000;
		SendClientMessage(playerid, -1, "You just reached level 5. Cost: R25000");
	}
	else if(hTime >= 30 && lvl == 5)
	{
		cost = 30000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 6;
		SetPlayerScore(playerid, 6);
		pInfo[playerid][pCash] -= 30000;
		SendClientMessage(playerid, -1, "You just reached level 6. Cost: R30000");
	}
	else if(hTime >= 38 && lvl == 6)
	{
		cost = 35000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 7;
		SetPlayerScore(playerid, 7);
		pInfo[playerid][pCash] -= 35000;
		SendClientMessage(playerid, -1, "You just reached level 7. Cost: R35000");
	}
	else if(hTime >= 48 && lvl == 7)
	{
		cost = 40000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 8;
		SetPlayerScore(playerid, 8);
		pInfo[playerid][pCash] -= 40000;
		SendClientMessage(playerid, -1, "You just reached level 8. Cost: R40000");
	}
	else if(hTime >= 60 && lvl == 8)
	{
		cost = 45000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 9;
		SetPlayerScore(playerid, 9);
		pInfo[playerid][pCash] -= 45000;
		SendClientMessage(playerid, -1, "You just reached level 9. Cost: R45000");
	}
	else if(hTime >= 72 && lvl == 9)
	{
		cost = 50000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 10;
		SetPlayerScore(playerid, 10);
		pInfo[playerid][pCash] -= 50000;
		SendClientMessage(playerid, -1, "You just reached level 10. Cost: R50000");
	}
	else if(hTime >= 86 && lvl == 10)
	{
		cost = 55000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 11;
		SetPlayerScore(playerid, 11);
		pInfo[playerid][pCash] -= 55000;
		SendClientMessage(playerid, -1, "You just reached level 11. Cost: R55000");
	}
	else if(hTime >= 100 && lvl == 11)
	{
		cost = 60000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 12;
		SetPlayerScore(playerid, 12);
		pInfo[playerid][pCash] -= 60000;
		SendClientMessage(playerid, -1, "You just reached level 12. Cost: R60000");
	}
	else if(hTime >= 120 && lvl == 12)
	{
		cost = 65000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 13;
		SetPlayerScore(playerid, 13);
		pInfo[playerid][pCash] -= 65000;
		SendClientMessage(playerid, -1, "You just reached level 13. Cost: R65000");
	}
	else if(hTime >= 142 && lvl == 13)
	{	
		cost = 70000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 14;
		SetPlayerScore(playerid, 14);
		pInfo[playerid][pCash] -= 70000;
		SendClientMessage(playerid, -1, "You just reached level 14. Cost: R70000");
	}
	else if(hTime >= 164 && lvl == 14)
	{
		cost = 75000;
		if(pInfo[playerid][pCash] < cost) return SendClientMessage(playerid, COLOR_GREY, "You do not have enough cash");
		pInfo[playerid][pLevel] = 15;
		SetPlayerScore(playerid, 15);
		pInfo[playerid][pCash] -= 75000;
		SendClientMessage(playerid, -1, "You just reached level 15. Cost: R75000");
	}
	else return SendClientMessage(playerid, COLOR_FADE1, "You cant level just yet");
	return 1;
}

CMD:ems(playerid, params[])
{
	new zone[126], str[128];
	if(GetPVarInt(playerid, "Injured") != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not injured");
	if(AES[playerid] >= 1)
	{
		format(str, sizeof(str), "You have to wait %i seconds before your next ems call", AES[playerid]);
		SendClientMessage(playerid, COLOR_GREY, str);
		return 1;
	}	
	zone = GetPlayer3DZone(playerid);
	format(str, sizeof(str), "EMS: %s has requested a call at %s", GetName(playerid), zone);
	SendClientMessageToLAFMD(COLOR_LIGHTRED, str);
	AES[playerid] = 30;
	AntiEMSTimer[playerid] = SetTimerEx("EMSAntiSpam", 1000, true, "i", playerid);
	SendClientMessage(playerid, COLOR_LIGHTRED, "You have called for EMS. please wait for a response");
	return 1;
}

CMD:acceptdeath(playerid, params[])
{
    if (IsDead[playerid] == 0) return 0; 
    else
    {
		IsDead[playerid] = 0;
		SecsToGo[playerid] = AFTERLIFE_SECONDS;
		CleanPlayerChat(playerid);
		SendClientMessage(playerid,COLOR_RED,"------------------ Health Advise -----------------");
		SendClientMessage(playerid,-1,"You are now in the afterlife. You may rest in peace.");
		SendClientMessage(playerid,-1,"When you revive, you will lost memory of last 30 minutes.");
		SendClientMessage(playerid,-1,"If you were non-RPly killed, report the player at the forums.");
		SendClientMessage(playerid,COLOR_RED,"--------------------------------------------------------");
		SetPlayerPos(playerid,0, 0, 0);
		SetPlayerCameraPos(playerid,DeathPosX[playerid],DeathPosY[playerid],DeathPosZ[playerid]);
		SetPlayerCameraLookAt(playerid,DeathPosX[playerid],DeathPosY[playerid],DeathPosZ[playerid]+100);
		AfterLifeTimer = SetTimerEx("AfterLife",1000,true,"i",playerid);
		KillTimer(LoseHPTimer[playerid]);
	}
	return 1;
}

CMD:time(playerid, params[])
{
	if (isnull(params))
    {
        SendClientMessage(playerid, COLOR_WHITE, "USAGE: /time [choice]");
        SendClientMessage(playerid, -1, "Choices: Jail | Payday");
        return 1;
    }
	if (!strcmp(params, "jail", true))
    {
        if(pInfo[playerid][pJail] < 1) return SendClientMessage(playerid, -1, "You are not in prison.");
        new str[44];
        format(str, sizeof (str), "You have %i minutes left of prison.", pInfo[playerid][pJail]);
        SendClientMessage(playerid, -1, str);
    }
	if(!strcmp(params, "payday", true))
	{
		new str[44], ttp;
		new h, m, s;
		gettime(h, m, s);
		ttp = 60 - m;
		format(str, sizeof(str), "Time left until payday: %i minutes", ttp);
		SendClientMessage(playerid, -1, str);
	}
	return 1;
}

CMD:tie(playerid, params[])
{
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return  SendClientMessage(playerid, -1, "You are not the driver!");
    new giveplayerid, str[126];
    if(sscanf(params, "d", giveplayerid))
    {
        SendClientMessage(playerid, COLOR_WHITE, "USAGE: /tie [playerid]");
        return 1;
    }
	if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not in the same vehicle as that player");
    if(Tie[giveplayerid] == 0)
    {
        if(pInfo[playerid][pRope] >= 1)
        {
	        TogglePlayerControllable(giveplayerid, 0);
	        GameTextForPlayer(giveplayerid, "~y~ Tied!", 3000, 1);
	        Tie[giveplayerid] = 1;
	        pInfo[playerid][pRope] -= 1;

	        format(str, sizeof(str), "You have tied %s", GetName(giveplayerid));
	        SendClientMessage(playerid, -1, str);
	        return 1;
		}
		else return SendClientMessage(playerid, -1, "You dont have any rope!");
	}
	if(Tie[giveplayerid] == 1)
	{
 		TogglePlayerControllable(giveplayerid, 1);
	    GameTextForPlayer(giveplayerid, "~y~ Untied!", 3000, 1);
	    Tie[giveplayerid] = 0;

        format(str, sizeof(str), "You have untied %s", GetName(giveplayerid));
        SendClientMessage(playerid, -1, str);
        return 1;
	}
	return 1;
}
CMD:untie(playerid, params[]) return cmd_tie(playerid, params);

CMD:am(playerid, params[])
{
	if(pInfo[playerid][pAMMute] == 0)
	{
		new text[128], str[128];
		if(sscanf(params, "s[128]", text)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /am [text]");
		format(str, sizeof(str), "%s [ID: %i] : %s", GetName(playerid), playerid, text);
		SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
		SendClientMessage(playerid, COLOR_ORANGE, "Admin message sent.");
		return 1;
	}
	else
	{
		SendClientMessage(playerid, COLOR_ORANGE, "You have been muted from using am.");
	}
	return 1;
}

CMD:pm(playerid, params[])
{
	new id, text[103], str[128];
	if(sscanf(params, "is[128]", id, text)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /pm [playerid] [text]");
	format(str, sizeof(str), "PM: %s(%i): %s", GetName(playerid), playerid, text);
	SendClientMessage(id, COLOR_YELLOW, str);
	format(str, sizeof(str), "PM to %s(%i): %s", GetName(id), id, text);
	SendClientMessage(playerid, COLOR_YELLOW, str);
	return 1;
}

CMD:engine(playerid, params[])
{
    new variables[7], vehicleid = GetPlayerVehicleID(playerid);
	new vid = GetVehicleID(vehicleid);
	new Name[25];
	GetPlayerName(playerid, Name, sizeof(Name));
    GetVehicleParamsEx(vehicleid, variables[0], variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
	if(vehicleid == 0) return SendClientMessage(playerid, COLOR_GREY, "You are not in a vehicle");
	if(GetVehicleFuel(vehicleid) > 0)
	{
		if(variables[0] != VEHICLE_PARAMS_ON)
		{
			new str[128];
			SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
			format(str, sizeof(str), "%s puts the key in the ignition turning the vehicle on.", GetName(playerid));
			ProxDetector(30.0, playerid, str, COLOR_PURPLE);
			SetTimerEx("Speedometer", 1000, true, "i", playerid);
			FuelTimer[vehicleid] = SetTimerEx("Fuelmeter", 20000, true, "i", playerid);
		}
		else
		{
			new str[128];
			SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
			format(str, sizeof(str), "%s turns the key in the ignition turning the vehicle off.", GetName(playerid));
			ProxDetector(30.0, playerid, str, COLOR_PURPLE);
			KillTimer(FuelTimer[vehicleid]);
		}
		return 1;
	}
	if(vInfo[vid][vFuel] > 0)
	{
		if(strcmp(Name, vInfo[vid][vOwner], true) == 0 || IsPlayerAdmin(playerid))
		{
			if(variables[0] != VEHICLE_PARAMS_ON)
			{
				new str[128];
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
				format(str, sizeof(str), "* %s puts the key in the ignition turning the vehicle on.", GetName(playerid));
				ProxDetector(30.0, playerid, str, COLOR_PURPLE);
				SetTimerEx("Speedometer", 1000, true, "i", playerid);
				FuelTimer[vehicleid] = SetTimerEx("Fuelmeter", 20000, true, "i", playerid);
			}
			else
			{
				new str[128];
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
				format(str, sizeof(str), "* %s turns the key in the ignition turning the vehicle off.", GetName(playerid));
				ProxDetector(30.0, playerid, str, COLOR_PURPLE);
				KillTimer(FuelTimer[vehicleid]);
			}
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You are not the owner of this vehicle");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "This vehicle is out of fuel.");
    return 1;
}

CMD:lights(playerid, params[])
{
	new variables[7], str[68], vehicleid = GetPlayerVehicleID(playerid);
    GetVehicleParamsEx(vehicleid, variables[0], variables[1], variables[2], variables[3], variables[4], variables[5], variables[6]);
	if(vehicleid == 0) return SendClientMessage(playerid, COLOR_GREY, "You are not in a vehicle");
	if(variables[1] != VEHICLE_PARAMS_ON)
	{
		SetVehicleParamsEx(vehicleid, variables[0], VEHICLE_PARAMS_ON, variables[2], variables[3], variables[4], variables[5], variables[6]);
		format(str, sizeof(str), "* %s switches the vehicles lights on.", GetName(playerid));
		ProxDetector(30.0, playerid, str, COLOR_PURPLE);
	}
	else
	{
		SetVehicleParamsEx(vehicleid, variables[0], VEHICLE_PARAMS_OFF, variables[2], variables[3], variables[4], variables[5], variables[6]);
		format(str, sizeof(str), "* %s switches the vehicles lights off.", GetName(playerid));
		ProxDetector(30.0, playerid, str, COLOR_PURPLE);
	}
	return 1;
}

CMD:sb(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid) == 0)
	{
        SendClientMessage(playerid, -1, "You are not in a vehicle!");
        return 1;
    }
	new string[50 + MAX_PLAYER_NAME];
    if(IsPlayerInAnyVehicle(playerid) == 1 && Seatbelt[playerid] == 0)
	{
        Seatbelt[playerid] = 1;
		SetPVarInt(playerid, "Seatbelt", 1);
        if(IsABike(GetPlayerVehicleID(playerid)))
		{
            format(string, sizeof(string), "* %s reaches for their helmet, and puts it on.", GetName(playerid));
            SendClientMessage(playerid, COLOR_WHITE, "You have put on your helmet.");
            SetPlayerAttachedObject(playerid, 1, 18645, 2, 0.07, 0, 0, 88, 75, 0);
        }
        else
		{
            format(string, sizeof(string), "* %s reaches for their seatbelt, and buckles it up.", GetName(playerid));
            SendClientMessage(playerid, COLOR_WHITE, "You have put on your seatbelt.");
            
        }

    }
    else if(IsPlayerInAnyVehicle(playerid) == 1 && Seatbelt[playerid] == 1)
	{
        Seatbelt[playerid] = 0;
		SetPVarInt(playerid, "Seatbelt", 0);
        if(IsABike(GetPlayerVehicleID(playerid)))
		{
            format(string, sizeof(string), "* %s reaches for their helmet, and takes it off.", GetName(playerid));
            SendClientMessage(playerid, COLOR_WHITE, "You have taken off your helmet.");
            RemovePlayerAttachedObject(playerid,1);
        }
        else
		{
            format(string, sizeof(string), "* %s reaches for their seatbelt, and unbuckles it.", GetName(playerid));
            SendClientMessage(playerid, COLOR_WHITE, "You have taken off your seatbelt.");
        }
    }
    ProxDetector(30.0, playerid, string, COLOR_PURPLE);
    return 1;
}

CMD:pvlock(playerid, params[])
{
	new Name[25], vlocked = 0, Float: vX, Float: vY, Float: vZ;
	GetPlayerName(playerid, Name, sizeof(Name));
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		new vehid = GetVehicleID(i);
		GetVehiclePos(i, vX, vY, vZ);
		if(IsPlayerInRangeOfPoint(playerid, 5, vX, vY, vZ))
		if(strcmp(Name, vInfo[vehid][vOwner], true) == 0)
		{
			vlocked = 1;
			if(vInfo[vehid][vLocked] == 0)
			{
				vInfo[vehid][vLocked] = 1;
				GameTextForPlayer(playerid, "~g~Vehicle ~r~Locked", 1000, 3);
				break;
			}
			else if(vInfo[vehid][vLocked] == 1)
			{
				vInfo[vehid][vLocked] = 0;
				GameTextForPlayer(playerid, "~g~Vehicle ~g~Unlocked", 1000, 3);
				break;
			}
		}
	}
	if(vlocked == 0) return SendClientMessage(playerid, COLOR_GREY, "You are not in range of a vehicle you own");
	return 1;
}

CMD:spraycar(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new vid = GetVehicleID(vehicleid);
	new col1, col2;
	if(sscanf(params, "ii", col1, col2)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /spraycar [color1][color2]");
	if(pInfo[playerid][pSpraycans] < 1) return SendClientMessage(playerid, COLOR_GREY, "You do not have any spray cans");
	if(vehicleid == 0) return SendClientMessage(playerid, COLOR_GREY, "You are not in a vehicle");
	if(strcmp(GetNameEx(playerid), vInfo[vid][vOwner], true) == 0)
	{
		ChangeVehicleColor(vehicleid, col1, col2);
		vInfo[vid][vColor1] = col1;
		vInfo[vid][vColor2] = col2;
		pInfo[playerid][pSpraycans] -= 1;
		Save_Vehicle(vid);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You do not own this vehicle");
	return 1;
}

CMD:vehid(playerid, params[])
{
	if(!IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid))) return SendClientMessage(playerid, COLOR_GREY, "You are not in a vehicle.");
	new id = GetPlayerVehicleID(playerid);
	new str[128];
	format(str, sizeof(str), "Vehicle ID: %d", id);
	SendClientMessage(playerid, -1, str);
	return 1;
}

CMD:refuel(playerid, params[])
{
	if(IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid))) return SendClientMessage(playerid, COLOR_GREY, "You need to get out of your vehicle to refuel.");
	new vehid, string[128];
	if(sscanf(params, "i", vehid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /refuel [vehicle id]");
	for(new i = 0; i < MAX_DVEHICLES; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 7.0,fInfo[i][fPos][0], fInfo[i][fPos][1], fInfo[i][fPos][2]))
		{
			if(IsPlayerNearVehicle(playerid, vehid, 5))
			{
				SetPVarInt(playerid, "RF ID", vehid);
				SetPVarInt(playerid, "RF VID", GetVehicleID(vehid));
				format(string, sizeof(string), "* %s puts the nozzle of the gas pump in the car.", GetName(playerid));
				ProxDetector(30, playerid, string, COLOR_PURPLE);
				RefuelTimer[vehid] = SetTimerEx("refuel", 100, true, "i", playerid);
				break;
			}
			else return SendClientMessage(playerid, COLOR_GREY, "You are not near that vehicle.");
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You are not near a fuel station.");
	}
	return 1;
}

CMD:sellv(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_GREY, "You are not driving a vehicle.");
	new id = GetVehicleID(GetPlayerVehicleID(playerid));
	new owner[25], name[25];
	owner = vInfo[id][vOwner];
	name = GetNameEx(playerid);
	if(strcmp(vInfo[id][vOwner], GetNameEx(playerid), true) == 0)
	{	
		new str[128], price, giveplayerid;
		if(sscanf(params, "ud", giveplayerid, price)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /sellv [playerid] [price]");
		if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_GREY, "Invalid player");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(giveplayerid,x,y,z);
		GetPlayerPos(playerid, x, y, z);
		if(IsPlayerInRangeOfPoint(giveplayerid,5,x,y,z))
		{
			SetPVarInt(giveplayerid, "vPrice", price);
			SetPVarInt(giveplayerid, "vID", id);
			SetPVarInt(giveplayerid, "vSeller", playerid);
			format(str, sizeof(str), "%s would like to sell you their car for R%d", GetName(playerid), price);
			ShowPlayerDialog(giveplayerid, DIALOG_VSELL, DIALOG_STYLE_MSGBOX, "Vehicle Sell", str, "Buy", "Cancel");
		}
		else return SendClientMessage(playerid, -1, "You are not close enough to that player");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not the owner of this vehicle.");
	return 1;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//============================== HOUSE COMMANDS ==================================================//
////////////////////////////////////////////////////////////////////////////////////////////////////

CMD:buyhouse(playerid, params[])
{
	new NotInRange = 0;
	if(pInfo[playerid][pHouses] <= 2)
	{
		for(new i = 0; i < sizeof(hInfo); i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 1, hInfo[i][hPos][0], hInfo[i][hPos][1], hInfo[i][hPos][2]))
			{
				if(HouseBought[i] == 0)
				{
					if(pInfo[playerid][pCash] >= hInfo[i][hPrice])
					{
						new str[55], Query[500], rows, fields;
						HouseBought[i] = 1;
						pInfo[playerid][pCash] -= hInfo[i][hPrice];
						pInfo[playerid][pHouses] += 1;
						strcat(Query,"INSERT INTO `phouses`(`ID`, `Owner`, `Size`, `HouseInt`, `Price`,`PosX`,`PosY`,`PosZ`, `FaceAngle`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
						strcat(Query," VALUES ('%d', '%s', '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%f', 10, '%i')");
						mysql_format(dbHandle, Query, sizeof(Query), Query, i, GetName(playerid), hInfo[i][hSize], hInfo[i][hHouseInt], hInfo[i][hPrice], hInfo[i][hPos][0], hInfo[i][hPos][1], hInfo[i][hPos][2], hInfo[i][hFacAngle], hInfo[i][hIPos][0], hInfo[i][hIPos][1], hInfo[i][hIPos][2], hInfo[i][hVW]);
						mysql_query(dbHandle, Query, false);
						
						mysql_format(dbHandle,Query, sizeof(Query), "DELETE FROM `Houses` WHERE `ID` = '%d'", i);
						mysql_query(dbHandle,Query);
						Destroy_DynamicHouse(i);
						
						mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `PHouses` WHERE `ID` = '%d'", i);
						mysql_query(dbHandle,Query);
						cache_get_data(rows, fields);
						if(rows)
						{
							Load_PlayerHouse(i);
						}						
						
						format(str, sizeof(str), "You just bought this house for R%i", hInfo[i][hPrice]);
						SendClientMessage(playerid, COLOR_ORANGE, str);
						NotInRange = 0;
						return 1;
					}
					else return SendClientMessage(playerid, COLOR_GREY, "You don't have enough money");
				}
				else return SendClientMessage(playerid, COLOR_GREY, "That house is already owned");
			}
			NotInRange = 1;
		}
	}
	else if(NotInRange == 1) return SendClientMessage(playerid, COLOR_GREY, "You are not near a buyable house");
	else return SendClientMessage(playerid, COLOR_GREY, "You already have 2 houses");
	return 1;
}

CMD:sellhouse(playerid, params[])
{
	new id, hid, price, str[128], string[128];
	if(sscanf(params, "udd", id, hid, price)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /sellhouse [playerid] [houseid] [price]");
	if(pInfo[playerid][pHouses] == 0) return SendClientMessage(playerid, COLOR_GREY, "You do not own a house");
	if(strcmp(GetName(playerid), hInfo[hid][hOwner], true) == 0)
	{
		SetPVarInt(id, "houseprice", price);
		SetPVarInt(id, "houseid", hInfo[hid][hID]);
		SetPVarInt(id, "sellerid", playerid);
		format(str, sizeof(str), "%s would like to sell you his/her house. \nHouse ID: %i \nHouse Size: %s\nPrice: R%i", GetName(playerid), hInfo[hid][hID], hInfo[hid][hSize], price);
		strcat(string, str, sizeof(string));
		ShowPlayerDialog(id, DIALOG_HOUSESELL, DIALOG_STYLE_MSGBOX, "House sell", str, "Buy", "Cancel");
		format(str, sizeof(str), "You are selling your house to %s. Price: R%i", GetName(id), price);
		SendClientMessage(playerid, -1, str);
		format(str, sizeof(str), "%", GetName(id), price);
		SendClientMessage(playerid, -1, str);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You do not own that house");
	return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//============================== JOB COMMANDS ==================================================//
//////////////////////////////////////////////////////////////////////////////////////////////////

CMD:jobhelp(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_JOBHELP, DIALOG_STYLE_LIST, "Job Help", "Fedex Driver \nArms Dealer \nPizza Delivery \nDrug Smuggler \nTaxi Driver \nWarehouse Worker", "Next", "Cancel");
	return 1;
}

CMD:join(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 10, -2170.8921, -216.0832, 35.3203))
	{
		pInfo[playerid][pJob1] = 1;
		SendClientMessage(playerid, COLOR_GREY, "You have joined the Fedex Driver job");
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 10, 1365.5328, -1275.6300, 13.5469))
	{
		pInfo[playerid][pJob1] = 2;
		SendClientMessage(playerid, COLOR_GREY, "You have joined the Arms Dealer job");
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 10, 2106.3145, -1788.5518, 13.5608))
	{
		pInfo[playerid][pJob1] = 3;
		SendClientMessage(playerid, COLOR_GREY, "You have joined the Pizza Delivery job");
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 10, 1151.0225, -1203.6011, 19.4515))
	{
		pInfo[playerid][pJob1] = 4;
		SendClientMessage(playerid, COLOR_GREY, "You have joined the Drug Smuggler job");
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 10, 1743.5931, -1861.5200, 13.5774))
	{
		pInfo[playerid][pJob1] = 5;
		SendClientMessage(playerid, COLOR_GREY, "You have joined the Taxi Driver job");
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 10, 2180.1250, -2256.1853, 14.7734))
	{
		pInfo[playerid][pJob1] = 6;
		SendClientMessage(playerid, COLOR_GREY, "You have joined the Warehouse Worker job");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not at a join spot");
	return 1;
}

CMD:jobquit(playerid, params[])
{
	pInfo[playerid][pJob1] = 0;
	SendClientMessage(playerid, COLOR_GREY, "You are now unemployed");
	return 1;
}

CMD:loadvan(playerid, params[])
{
	if(pInfo[playerid][pJob1] == 1)
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 498)
		{
			if(FedexCPT[playerid] != 0) return SendClientMessage(playerid, COLOR_GREY, "You are currently on a route");
			SetPlayerCheckpoint(playerid, -2135.5891, -247.7673, 36.2484, 10);
			FedexCPT[playerid] = 1;
			SendClientMessage(playerid, COLOR_ORANGE, "Go get the goods from the collection point");
		}
		else 
			return SendClientMessage(playerid, COLOR_GREY, "You are not in a Fedex van");
	}
	else if(pInfo[playerid][pJob1] == 4)
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 418)
		{
			if(DrugSCPT[playerid] != 0) return SendClientMessage(playerid, COLOR_GREY, "You are currently on a route");
			SetPlayerCheckpoint(playerid, 1086.0110, -1226.7229, 15.8203, 10);
			DrugSCPT[playerid] = 1;
			SendClientMessage(playerid, COLOR_ORANGE, "Go get the drugs from the collection point");
		}
		else 
			return SendClientMessage(playerid, COLOR_GREY, "You are not in a Drug Smuggler van");
	}
	else if(pInfo[playerid][pJob1] == 6)
	{
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 414)
		{
			if(WareHouseCPT[playerid] != 0) return SendClientMessage(playerid, COLOR_GREY, "You are currently on a route");
			SetPlayerCheckpoint(playerid, 2154.7505, -2290.6321, 13.3947, 10);
			WareHouseCPT[playerid] = 1;
			SendClientMessage(playerid, COLOR_ORANGE, "Go get the goods from the collection point");
		}
		else 
			return SendClientMessage(playerid, COLOR_GREY, "You are not in a Warehouse Worker van");
	}
	else 
		return SendClientMessage(playerid, COLOR_GREY, "Your job does not use that command.");
	return 1;
}

CMD:loadtrailer(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsTrailerAttachedToVehicle(vehicleid))
	{
		if(GetVehicleModel(GetVehicleTrailer(vehicleid)) == 584)
		{
			new Float: pX, Float: pY, Float: pZ;
			new Float: ClosestFS = 0;
			for(new i = 1; i <= 6; i++)
			{
				pX = FuelDepot[i][0];
				pY = FuelDepot[i][1];
				pZ = FuelDepot[i][2];
				
				if(ClosestFS == 0)
				{
					ClosestFS = GetPlayerDistanceFromPoint(playerid, pX, pY, pZ);
				}
				else if(GetPlayerDistanceFromPoint(playerid, pX, pY, pZ) < ClosestFS)
				{
					ClosestFS = GetPlayerDistanceFromPoint(playerid, pX, pY, pZ);
					SetPlayerCheckpoint(playerid, pX, pY, pZ, 10);
					CDLCPT[playerid] = 1;
				}
				SendClientMessage(playerid, COLOR_GREY, "Loop");
			}
			SendClientMessage(playerid, COLOR_GREY, "Go to the loading station");		
			return 1;
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You do not have a trailer attached"); 
	return 1;
}

CMD:sellweapon(playerid, params[])
{
	if(pInfo[playerid][pJob1] == 2)
	{
		new wep[15], id, amount, str[128];
		if(sscanf(params, "us[15]d", id, wep, amount))
		{
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /sellweapon [playerid] [weapon] [price]");
			SendClientMessage(playerid, COLOR_GREY, "============= WEAPONS ===========");
			SendClientMessage(playerid, COLOR_GREY, "Knife: 150 mats | Bat: 150 mats | Knuckles: 200 mats");
			SendClientMessage(playerid, COLOR_GREY, "Katana: 500 mats | 9mm: 750 mats | Shotgun: 1000 mats");
			SendClientMessage(playerid, COLOR_GREY, "Deagle: 1500 mats | Uzi: 2500 mats | Tech9: 3000 mats");
			SendClientMessage(playerid, COLOR_GREY, "MP5: 5500 mats | AK47: 7000 mats | M4: 7500 mats");
			return 1;
		}
		if(strcmp(wep, "knife", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 1);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: Knife \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a knife to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "bat", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 2);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: Baseball Bat \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a bat to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "knuckles", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 3);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: Knuckles \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a knuckles to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "katana", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 4);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: Katana \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a katana to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "9mm", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 5);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: 9mm \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a 9mm to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "shotgun", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 6);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: Shotgun \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a shotgun to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "deagle", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 7);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: Desert Eagle \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a deagle to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "uzi", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 8);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: Uzi \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a uzi to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "tech9", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 9);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: Tech9 \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a tech9 to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "mp5", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 10);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: MP5 \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a mp5 to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "ak47", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 11);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: AK47 \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a ak47 to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(wep, "m4", true) == 0)
		{
			SetPVarInt(id, "wepprice", amount);
			SetPVarInt(id, "dealerid", playerid);
			SetPVarInt(id, "weapon", 12);
			format(str, sizeof(str), "%s would like to sell you a weapon. \nWeapon: M4 \nPrice: R%i", GetName(playerid), amount);
			ShowPlayerDialog(id, DIALOG_WEPSELL, DIALOG_STYLE_MSGBOX, "Weapon Deal", str, "Buy", "Cancel");
			format(str, sizeof(str), "You are selling a m4 to %s for: R%i", GetName(playerid), amount);
			SendClientMessage(playerid, -1, str);
		}
		SetPlayerSkillLevel(playerid, 0, 1);
		SetPlayerSkillLevel(playerid, 1, 1);
		SetPlayerSkillLevel(playerid, 2, 1);
		SetPlayerSkillLevel(playerid, 3, 1);
		SetPlayerSkillLevel(playerid, 4, 1);
		SetPlayerSkillLevel(playerid, 5, 1);
		SetPlayerSkillLevel(playerid, 6, 1);
		SetPlayerSkillLevel(playerid, 7, 1);
		SetPlayerSkillLevel(playerid, 8, 1);
		SetPlayerSkillLevel(playerid, 9, 1);
		SetPlayerSkillLevel(playerid, 10, 1);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not a weapon dealer");
	return 1;
}

CMD:loadpizza(playerid, params[])
{
	if(pInfo[playerid][pJob1] != 3) return SendClientMessage(playerid, COLOR_GREY, "You are not a pizza delivery guy");
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 448) return SendClientMessage(playerid, COLOR_GREY, "You are not on a pizza delivery scooter");
	if(PizzaDeliveryCPT[playerid] != 0) return SendClientMessage(playerid, COLOR_GREY, "You are already on a delivery"); 
	SetPlayerCheckpoint(playerid, 2095.4126, -1806.6326, 13.5515, 3);
	PizzaDeliveryCPT[playerid] = 1;
	return 1;
}

CMD:fare(playerid, params[])
{
	new str[128], amount;
	if(sscanf(params, "i", amount)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /fare [fare amount]");
	if(pInfo[playerid][pJob1] == 5)
	{
	    if(amount == 0)
	    {
	        SetPlayerColor(playerid, 0xFFFFFF00);
	        TransportDuty[playerid] = 0;
			format(str, sizeof(str), "* You are now Off Duty and earned R%d.", TransportMoney[playerid]);
			SendClientMessage(playerid, COLOR_YELLOW, str);
			pInfo[playerid][pCash] += TransportMoney[playerid];
			ConsumingMoney[playerid] = 1;
		 	TransportValue[playerid] = 0;
			TransportMoney[playerid] = 0;
			return 1;
	    }
	    if(amount > 10)
	    {
		    SetPlayerColor(playerid, 0xFFFF0000);
		    format(str, sizeof(str), "You are now on duty as a taxi driver. Your fare is R%i", amount);
		    SendClientMessage(playerid, COLOR_YELLOW, str);
		    TransportDuty[playerid] = 1;
			TransportValue[playerid] = amount;
		}
		else return SendClientMessage(playerid, COLOR_GREY, "FARE: Off: 0 - Minimum: 10 - Maximum: 500");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not a taxi driver.");
	return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//============================== ACCOUNT COMMANDS ==============================================//
//////////////////////////////////////////////////////////////////////////////////////////////////

CMD:changepass(playerid, params[])
{
	SendClientMessage(playerid, COLOR_ORANGE, "Please insert your new password");
	ShowPlayerDialog(playerid, DIALOG_CHANGEPASS, DIALOG_STYLE_PASSWORD, ""COL_ORANGE"Change Password", "Please change your password below.", "Change", "Cancel");
	return 1;
}

CMD:changeemail(playerid, params[])
{
	SendClientMessage(playerid, COLOR_ORANGE, "Please insert your new email address");
	ShowPlayerDialog(playerid, DIALOG_REGISTEREMAIL2, DIALOG_STYLE_INPUT, ""COL_ORANGE"Change email address", "Please register your email address. \nYou will need this email address\nif you need a password reset.", "Change", "Cancel");
	return 1;
}

CMD:report(playerid, params[])
{
	new text[126], str[128];
	if(sscanf(params, "s[126]", text)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /report [text]");
	if(GetPVarInt(playerid, "ReportPending") == 0)
	{
		SetPVarInt(playerid, "ReportPending", 1);
		SetPVarString(playerid, "ReportText", text);
		SetPVarInt(playerid, "ReportTime", gettime());
		
		SendClientMessage(playerid, COLOR_LIGHTRED, "Your report has been sent to the admins.");
		format(str, sizeof(str), "[Report ID: %d]: %s", playerid, text);
		SendClientMessageToAdmins(COLOR_LIGHTRED, str, 1);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You already have an active report.");
	return 1;
}

CMD:requesthelp(playerid, params[])
{
	new text[126], str[128];
	if(sscanf(params, "s[126]", text)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /requesthelp [text]");
	if(GetPVarInt(playerid, "HRPending") == 0)
	{
		SetPVarInt(playerid, "HRPending", 1);
		SetPVarString(playerid, "HRText", text);
		SetPVarInt(playerid, "HRTime", gettime());
		
		SendClientMessage(playerid, COLOR_CYAN, "Your help request has been sent to the moderators.");
		format(str, sizeof(str), "[HR ID: %d]: %s", playerid, text);
		SendClientMessageToModsOnDuty(COLOR_CYAN, str, 1);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You already have an active help request.");
	return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//============================== SERVER COMMANDS ==============================================//
//////////////////////////////////////////////////////////////////////////////////////////////////

CMD:updates(playerid, params[])
{
	new updateinfo[256];
	strcat(updateinfo, "- Vehicle dealership \n", sizeof(updateinfo));
	strcat(updateinfo, "- Vehicle fuel system \n", sizeof(updateinfo));
	strcat(updateinfo, "- SAPD faction \n", sizeof(updateinfo));
	strcat(updateinfo, "- LAFMD faction \n", sizeof(updateinfo));
	strcat(updateinfo, "- New commands \n", sizeof(updateinfo));
	strcat(updateinfo, "- New maps \n", sizeof(updateinfo));
	strcat(updateinfo, "- Prison system \n", sizeof(updateinfo));
	strcat(updateinfo, "- House ownership \n", sizeof(updateinfo));
	strcat(updateinfo, "- House sales \n", sizeof(updateinfo));
	strcat(updateinfo, " \n", sizeof(updateinfo));
	strcat(updateinfo, "Working on v0.2 \n", sizeof(updateinfo));
	
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Update v0.1", updateinfo, "Ok", "");
	return 1;
}

CMD:rules(playerid, params[])
{
	new info[512];
	strcat(info, "Death Matching(DM): Death matching is not alowed on this server unless you RP it. \n", sizeof(info));
	strcat(info, "Meta-Gaming(MG): Do not meta-game on this server. \n", sizeof(info));
	strcat(info, "Power Gaming(PG): Using UNRP actions are not alowed on this server. \n", sizeof(info));
	strcat(info, "Bunny Hopping(BH): Bunny hopping is not allowed here because it is not RP. \n", sizeof(info));
	strcat(info, "Revenge Killing(RK): Revenge killing is not RP. \n", sizeof(info));
	strcat(info, "Hacking: Hacking is not alowed on this server and will result in a Perminant Ban. \n", sizeof(info));
	strcat(info, " \n", sizeof(info));
	strcat(info, "This is just a small version of the rules. Visit forums.escudo-gaming.com for more info. \n", sizeof(info));

	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Rules", info, "Ok", "");
	return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//============================== Moderator COMMANDS ============================================//
//////////////////////////////////////////////////////////////////////////////////////////////////

CMD:chelp(playerid, params[])
{
	if(pInfo[playerid][pModerator] >= 1 || pInfo[playerid][pAdminLevel] >= 1)
	{
		new helpinfo[512];
		strcat(helpinfo, "Junior Moderator:  /chelp  /c  /moderators \n", sizeof(helpinfo));
		strcat(helpinfo, "Moderator:  /cduty  /hrs  /accepthr  /endhr  /park \n", sizeof(helpinfo));
		strcat(helpinfo, "Senior Moderator:  /newbmute  /nrn \n", sizeof(helpinfo));
		strcat(helpinfo, "Cheif Moderator:  /helprequests  /modinvite  /modkick  /modpromote \n", sizeof(helpinfo));
		ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Moderator Help", helpinfo, "Ok", "");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:c(playerid, params[])
{
	if(pInfo[playerid][pModerator] >= 1 || pInfo[playerid][pAdminLevel] >= 1)
	{
		new text[128], str[128];
		if(sscanf(params, "s[128]", text)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /c [text]");
		if(pInfo[playerid][pAdminLevel] >= 1)
		{
			format(str, sizeof(str), "%s %s: %s", GetAdminName(playerid), GetName(playerid), text);
			SendClientMessageToMods(COLOR_CYAN, str, 1);
			return 1;
		}
		if(pInfo[playerid][pModerator] >= 1)
		{
			format(str, sizeof(str), "%s %s: %s", GetModName(playerid), GetName(playerid), text);
			SendClientMessageToMods(COLOR_CYAN, str, 1);
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:moderators(playerid, params[])
{
	if(pInfo[playerid][pModerator] >= 1 || pInfo[playerid][pAdminLevel] >= 1)
	{
		new count, str[128], mods[500];
		for(new i;i < MAX_PLAYERS; i++)
		{
			if(pInfo[i][pModerator])
			{
				if(OnDuty[i] == 0)
				{
					format(str, sizeof(str), "%s %s \n", GetModName(i), GetName(i));
					strcat(mods, str, sizeof(mods));
					count++;
				}
				if(OnDuty[i] == 1)
				{
					format(str, sizeof(str), ""#00FFFF"%s %s \n", GetModName(i), GetName(i));
					strcat(mods, str, sizeof(mods));
					count++;
				}
			}
		}
		if(count == 0) return SendClientMessage(playerid, COLOR_GREY, "There are no moderators online.");
		else ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Moderators Online", mods, "Ok", "");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:tognewb(playerid, params[])
{
	if(pInfo[playerid][pModerator] >= 2 || pInfo[playerid][pAdminLevel] >= 1)
	{
		if(tognewbie[playerid] == 0)
		{
			tognewbie[playerid] = 1;
			SendClientMessage(playerid, COLOR_GREY, "You have disabled newbie chat.");
			return 1;
		}
		if(tognewbie[playerid] == 1)
		{
			tognewbie[playerid] = 0;
			SendClientMessage(playerid, COLOR_GREY, "You have enabled newbie chat.");
			return 1;
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:cduty(playerid, params[])
{
	if(pInfo[playerid][pModerator] >= 2)
	{
		if(CDuty[playerid] == 0)
		{
			CDuty[playerid] = 1;
			SendClientMessage(playerid, COLOR_CYAN, "You are now on moderator duty.");
			return 1;
		}
		if(CDuty[playerid] == 1)
		{
			CDuty[playerid] = 0;
			SendClientMessage(playerid, COLOR_CYAN, "You are now off moderator duty.");
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:hrs(playerid, params[])
{
	if(pInfo[playerid][pModerator] >= 2 || pInfo[playerid][pAdminLevel] >= 1)
	{
		new count, hrinfo[128];
		for(new i;i < MAX_PLAYERS; i++)
		{
			if(GetPVarInt(i, "HRPending") == 1)
			{
				new string[200], reporttext[126], pendingtime;
				GetPVarString(i, "HRText", reporttext, sizeof(reporttext));
				pendingtime = (gettime()-GetPVarInt(i, "HRTime"))/60;
				format(string, sizeof(string), "%s [ID: %i] | %s | Pending: %d minutes \n", GetName(i), i, reporttext, pendingtime);
				strcat(hrinfo, string, sizeof(hrinfo));
				count++;
			}
			if(GetPVarInt(i, "HRPending") == 2)
			{
				new string[200], reporttext[126], pendingtime;
				GetPVarString(i, "HRText", reporttext, sizeof(reporttext));
				pendingtime = (gettime()-GetPVarInt(i, "HRTime"))/60;
				format(string, sizeof(string), "%s [ID: %d] | %s | Accepted \n", GetName(i), i, reporttext, pendingtime);
				strcat(hrinfo, string, sizeof(hrinfo));
				count++;			
			}
		}
		if(count == 0) return SendClientMessage(playerid, COLOR_GREY, "There are not active reports.");
		else ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Help Requests", hrinfo, "Ok", "");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:accepthr(playerid, params[])
{
	if(pInfo[playerid][pModerator] >= 2 || pInfo[playerid][pAdminLevel] >= 1)
	{
		if(CDuty[playerid] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty. use /cduty.");
		if(GetPVarInt(playerid, "OnHR") == 0)
		{
			new id, string[126];
			new Float: pX, Float: pY, Float: pZ;
			if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /ar [ID]");
			if(GetPVarInt(id, "HRPending") != 1) return SendClientMessage(playerid, COLOR_GREY, "That HR does not exist");
			SetPVarInt(id, "HRPending", 2);
			
			SetPVarInt(playerid, "OnHR", 1);
			
			GetPlayerPos(playerid, HRPos[playerid][0], HRPos[playerid][1], HRPos[playerid][2]);
			GetPlayerPos(id, pX, pY, pZ);
			GetPlayerInterior(id);
			SetPVarInt(playerid, "HRInt", GetPlayerInterior(playerid));
			SetPVarInt(playerid, "HRVW", GetPlayerVirtualWorld(playerid));
			SetPlayerPos(playerid, pX, pY, pZ);
			SetPlayerInterior(playerid, GetPlayerInterior(id));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
			
			format(string, sizeof(string), "%s has accepted the HR from %s [ID: %d]", GetName(playerid), GetName(id), id);
			SendClientMessageToModsOnDuty(COLOR_CYAN, string, 1);
			
			format(string, sizeof(string), "(( Hello. I am moderator %s. How may I help you today? ))", GetName(playerid));
			ProxDetector(30.0, playerid, string, COLOR_GREY);
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You already have an active report.");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:endhr(playerid, params[])
{
	new id, string[126];
	if(pInfo[playerid][pModerator] >= 2 || pInfo[playerid][pAdminLevel] >= 1)
	{
		if(sscanf(params, "i", id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /endhr [HRID]");
		if(CDuty[playerid] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty. use /cduty.");
		if(GetPVarInt(playerid, "OnHR") == 1)
		{
			SetPVarInt(id, "HRPending", 0);
			SetPVarInt(playerid, "OnHR", 0);
			format(string, sizeof(string), "(( Have a good day. Please use /requesthelp if you need help. ))", GetName(playerid));
			ProxDetector(30.0, playerid, string, COLOR_GREY);
			SetPlayerPos(playerid, HRPos[playerid][0], HRPos[playerid][1], HRPos[playerid][2]);
			SetPlayerInterior(playerid, GetPVarInt(playerid, "HRInt"));
			SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "HRVW"));
			format(string, sizeof(string), "%s has ended the HR from %s [ID: %d]", GetName(playerid), GetName(id), id);
			SendClientMessageToModsOnDuty(COLOR_CYAN, string, 1);
			pInfo[playerid][pHRs] += 1;
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You are not on a help request.");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:park(playerid, params[])
{
	if(pInfo[playerid][pModerator] >= 2 || pInfo[playerid][pAdminLevel] >= 1)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_GREY, "You are not driving a vehicle");
		new Query[500], str[128];		
		new Float:X, Float:Y, Float:Z, Float:R;
		new id = GetPlayerVehicleID(playerid);
		new vid = GetVehicleID(GetPlayerVehicleID(playerid));
		GetVehiclePos(id, X, Y, Z);
		GetVehicleZAngle(id, R);
		new c1 = vInfo[vid][vColor1];
		new c2 = vInfo[vid][vColor2];
		if(vInfo[vid][vDealer] == 1)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `DVehicles` SET `PosX` = '%f', `PosY` = '%f', `PosZ` = '%f', `PosA` = '%f' WHERE `ID` = '%d'",
			X, Y, Z, R, vid);
			mysql_query(dbHandle,Query,false);
			printf("carid: %", vid);
		}
		else
		{
			mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `Vehicles` SET `PosX` = '%f', `PosY` = '%f', `PosZ` = '%f', `PosA` = '%f' WHERE `ID` = '%d'",
			X, Y, Z, R, vid);
			mysql_query(dbHandle,Query,false);
			printf("carid: %", vid);
		}
		
		format(str, sizeof(str), "Vehicle Pos: %f %f %f", X, Y, Z);
		SendClientMessage(playerid, COLOR_GREY, str);
		format(str, sizeof(str), "Vehicle ID: %d", vid);
		SendClientMessage(playerid, COLOR_GREY, str);
		DestroyVehicle(id);
		AddStaticVehicleEx(vInfo[vid][vModel], X, Y, Z, R, c1, c2, 100);
		PutPlayerInVehicle(playerid, id, 0);
		
		if(vInfo[id][vDealer] == 1)
		{
			new labeltext[128];
			format(labeltext, sizeof(labeltext), "Price: R%d", vInfo[id][vPrice]);
			vInfo[id][Label] = Create3DTextLabel(labeltext, 0xBB7700DD, 0, 0, 0, 10.0, 0, 0);
			Attach3DTextLabelToVehicle(vInfo[id][Label], VehicleID[id], 0, 0, 0);
		}
		
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:newbmute(playerid, params[])
{
	if(pInfo[playerid][pModerator] >= 3 || pInfo[playerid][pAdminLevel] >= 1)
	{
		new giveplayerid, str[128];
		if(sscanf(params, "i", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /newbmute [playerid]");
		{
			if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "Invalid player specified.");
			pInfo[giveplayerid][pNewbMute] = 1;
			format(str, sizeof(str), "%s has muted %s from using newbie.");
			SendClientMessageToMods(COLOR_CYAN, str, 1);
			SendClientMessage(playerid, COLOR_CYAN, "You have been muted from using newbie.");
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:nrn(playerid, params[])
{
	new giveplayerid;
	if(pInfo[playerid][pModerator] < 3 && pInfo[playerid][pAdminLevel] < 1) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this command.");
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, -1, "USAGE: /nrn [playerid]");
	if(pInfo[giveplayerid][pModerator] > 0 && pInfo[playerid][pAdminLevel] < 1) return SendClientMessage(playerid, -1, "You can't use this command on a Moderator as a Moderator.");
	if(pInfo[giveplayerid][pLevel] > 1 && pInfo[playerid][pAdminLevel] < 1) return SendClientMessage(playerid, -1, "You can't use this command on players higher than level 1 as a Moderator");
	if(pInfo[giveplayerid][pAdminLevel] > 0) return SendClientMessage(playerid, -1, "You can not use this command on an admin");
	if(pInfo[giveplayerid][pLogged] != 1) return SendClientMessage(playerid, -1, "That person has not logged in yet");
	ShowPlayerDialog(giveplayerid, DIALOG_CHANGENAME, DIALOG_STYLE_INPUT,""COL_WHITE"Name Change",""COL_WHITE"A Moderator or Admin thinks your name is non-rp and you have to change it.  \nFirstname_Lastname","Change","No!");
	new str[126];
	format(str, sizeof(str), "AdmWarn: %s has forced %s to change his name due to it being non-rp.", GetName(playerid), GetName(giveplayerid));
	SendClientMessageToAdmins(COLOR_YELLOW, str, 1);
	format(str, sizeof(str), "HelpWarn: %s has forced %s to change his name due to it being non-rp.", GetName(playerid), GetName(giveplayerid));
	SendClientMessageToMods(COLOR_YELLOW, str, 1);
	SetPVarInt(giveplayerid, "nrnplayerid", playerid);
	return 1;
}

CMD:helprequests(playerid, params[])
{
	if(pInfo[playerid][pModerator] == 4 || pInfo[playerid][pAdminLevel] >= 1)
	{
		new str[128], giveplayerid;
		if(sscanf(params, "i", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /helprequests [playerid]");
		if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_GREY, "Invalid playerid");
		if(pInfo[giveplayerid][pModerator] == 0) return SendClientMessage(playerid, COLOR_GREY, "That player is not a moderator");
		format(str, sizeof(str), "%s has done %i help requests.",GetName(giveplayerid), pInfo[giveplayerid][pHRs]);
		SendClientMessage(playerid, COLOR_CYAN, str);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:modinvite(playerid, params[])
{
	if(pInfo[playerid][pModerator] == 4 || pInfo[playerid][pAdminLevel] >= 1)
	{
		new str[128], giveplayerid;
		if(sscanf(params, "i", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /modinvite [playerid]");
		if(pInfo[giveplayerid][pModerator] >= 1) return SendClientMessage(playerid, COLOR_GREY, "That player is already a moderator.");
		if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_GREY, "Invalid player.");
		pInfo[giveplayerid][pModerator] = 1;
		format(str, sizeof(str), "You have made %s a Junior Moderator", GetName(giveplayerid));
		SendClientMessage(playerid, COLOR_CYAN, str);
		SendClientMessage(giveplayerid, COLOR_CYAN, "You have been accepted into the moderation team.");
		format(str, sizeof(str), "%s has made %s a Junior Moderator", GetName(playerid), GetName(giveplayerid));
		Log("/logs/moderator.txt", str);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:modkick(playerid, params[])
{
	if(pInfo[playerid][pModerator] == 4 || pInfo[playerid][pAdminLevel] >= 1)
	{
		new str[256], reason[128], giveplayerid;
		if(sscanf(params, "is[128]", giveplayerid, reason)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /modkick [playerid] [reason]");
		pInfo[giveplayerid][pModerator] = 0;
		SendClientMessage(playerid, COLOR_CYAN, "You have been removed from the moderation team.");
		format(str, sizeof(str), "%s has kicked %s from moderator team: reason %s", GetName(playerid), GetName(giveplayerid), reason);
		Log("/logs/moderator.txt", str);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:modpromote(playerid, params[])
{
	if(pInfo[playerid][pModerator] == 4 || pInfo[playerid][pAdminLevel] >= 1)
	{
		new str[128], giveplayerid;
		if(sscanf(params, "i", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /modpromote [playerid]");
		if(pInfo[giveplayerid][pModerator] >= 4) return SendClientMessage(playerid, COLOR_GREY, "That player is already a cheif moderator.");
		if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_GREY, "Invalid player.");
		pInfo[giveplayerid][pModerator]++;
		format(str, sizeof(str), "%s was just promoted to %s", GetName(giveplayerid), GetModName(giveplayerid));
		SendClientMessageToMods(COLOR_CYAN, str, 1);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//============================== Event COMMANDS ================================================//
//////////////////////////////////////////////////////////////////////////////////////////////////

CMD:joinrace(playerid, params[])
{
	if(EventOpen == 0) return SendClientMessage(playerid, COLOR_GREY, "There are no races currently open");
	if(InRace[playerid] != 0) return SendClientMessage(playerid, COLOR_GREY, "You are already in a race");
	if(RaceTrack == 1)
	{
		new Float: pX, Float: pY, Float: pZ, str[56];
		new col1 = random(50);
		new col2 = random(50);
		new GridStart = GetGridPos(playerid);
		rInfo[playerid][rGridPos] = GridStart;
		
		GetPlayerPos(playerid, pX, pY, pZ);
		BeforeRaceX[playerid] = pX;
		BeforeRaceY[playerid] = pY;
		BeforeRaceZ[playerid] = pZ;
		
		SetPlayerPos(playerid, DillimoreGrid[GridStart][0], DillimoreGrid[GridStart][1], DillimoreGrid[GridStart][2]+0.7);
		new vehicleid = AddStaticVehicleEx(RaceVehicle, DillimoreGrid[GridStart][0], DillimoreGrid[GridStart][1], DillimoreGrid[GridStart][2], 88.6200, col1, col2, 1000);
		gVehicleFuel[vehicleid] = 100;
		rInfo[playerid][rVehicleID] = vehicleid;
		SetPVarInt(playerid, "RaceVehicleID", vehicleid);
		SetVehicleVirtualWorld(vehicleid, 101);
		SetPlayerVirtualWorld(playerid, 101);
		InRace[playerid] = 1;
		SetPVarInt(playerid, "InRace", 1);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		LastRaceVehicle++;
		format(str, sizeof(str), "%s has joined the race", GetName(playerid));
		SendClientMessageToRacers(COLOR_YELLOW, str);
	}
	else if(RaceTrack == 2)
	{
		new Float: pX, Float: pY, Float: pZ, str[56];
		new col1 = random(50);
		new col2 = random(50);
		new GridStart = GetGridPos(playerid);
		rInfo[playerid][rGridPos] = GridStart;
		
		GetPlayerPos(playerid, pX, pY, pZ);
		BeforeRaceX[playerid] = pX;
		BeforeRaceY[playerid] = pY;
		BeforeRaceZ[playerid] = pZ;
		
		SetPlayerPos(playerid, MontgomeryGrid[GridStart][0], MontgomeryGrid[GridStart][1], MontgomeryGrid[GridStart][2]+0.7);
		new vehicleid = AddStaticVehicleEx(RaceVehicle, MontgomeryGrid[GridStart][0], MontgomeryGrid[GridStart][1], MontgomeryGrid[GridStart][2], 155.5799, col1, col2, 1000);
		gVehicleFuel[vehicleid] = 100;
		rInfo[playerid][rVehicleID] = vehicleid;
		SetVehicleVirtualWorld(vehicleid, 102);
		SetPlayerVirtualWorld(playerid, 102);
		InRace[playerid] = 1;
		PutPlayerInVehicle(playerid, vehicleid, 0);
		LastRaceVehicle++;
		format(str, sizeof(str), "%s has joined the race", GetName(playerid));
		SendClientMessageToRacers(COLOR_YELLOW, str);
	}
	else if(RaceTrack == 3)
	{
		new Float: pX, Float: pY, Float: pZ, str[56];
		new col1 = random(50);
		new col2 = random(50);
		new GridStart = GetGridPos(playerid);
		rInfo[playerid][rGridPos] = GridStart;
		
		GetPlayerPos(playerid, pX, pY, pZ);
		BeforeRaceX[playerid] = pX;
		BeforeRaceY[playerid] = pY;
		BeforeRaceZ[playerid] = pZ;
		
		SetPlayerPos(playerid, GoKartSFGrid[GridStart][0], GoKartSFGrid[GridStart][1], GoKartSFGrid[GridStart][2]+0.7);
		new vehicleid = AddStaticVehicleEx(RaceVehicle, GoKartSFGrid[GridStart][0], GoKartSFGrid[GridStart][1], GoKartSFGrid[GridStart][2], -90.0600, col1, col2, 1000);
		gVehicleFuel[vehicleid] = 100;
		rInfo[playerid][rVehicleID] = vehicleid;
		SetVehicleVirtualWorld(vehicleid, 103);
		SetPlayerVirtualWorld(playerid, 103);
		InRace[playerid] = 1;
		PutPlayerInVehicle(playerid, vehicleid, 0);
		LastRaceVehicle++;
		format(str, sizeof(str), "%s has joined the race", GetName(playerid));
		SendClientMessageToRacers(COLOR_YELLOW, str);
	}
	return 1;
}

CMD:leaverace(playerid, params[])
{
	new str[56];
	if(InRace[playerid] == 0) return SendClientMessage(playerid, COLOR_GREY, "You are not in a race");
	SetPlayerPos(playerid, BeforeRaceX[playerid], BeforeRaceY[playerid], BeforeRaceZ[playerid]);
	SetPlayerVirtualWorld(playerid, 0);
	InRace[playerid] = 0;
	DisablePlayerRaceCheckpoint(playerid);
	DestroyVehicle(rInfo[playerid][rVehicleID]);
	format(str, sizeof(str), "%s has left the race", GetName(playerid));
	SendClientMessageToRacers(COLOR_YELLOW, str);
	GridPosTaken[rInfo[playerid][rGridPos]] = 0;
	return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//============================== Faction COMMANDS ==============================================//
//////////////////////////////////////////////////////////////////////////////////////////////////

CMD:fh(playerid, params[])
{
	new helpinfo[1024];
	if(pInfo[playerid][pFaction] == 0) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command");
	if(pInfo[playerid][pFaction] == 1)
	{
		strcat(helpinfo, "SAPD:  /badge  /gate  /r  /d  /lockers  /siren  /m  /acceptcall  /checkbelt \n", sizeof(helpinfo));
		strcat(helpinfo, "SAPD:  /tazer  /drag  /cuff  /uncuff  /detain  /su  /fine  /checksb\n", sizeof(helpinfo));
		strcat(helpinfo, "SAPD:  /clearwanted  /arrest  /deploycone  /destroycone \n", sizeof(helpinfo));
		strcat(helpinfo, "SAPD:  /deploycade  /destroycade  /destroycades \n", sizeof(helpinfo));
		
		if(pInfo[playerid][pFacRank] >= 13)
		{
			strcat(helpinfo, "Cheif of SAPD: /finvite  /fkick \n", sizeof(helpinfo));
		}
	}
	if(pInfo[playerid][pFaction] == 2)
	{
		strcat(helpinfo, "LAFMD:  /badge  /gate  /r  /d  /lockers  /siren  /aid \n", sizeof(helpinfo));
		strcat(helpinfo, "LAFMD:  /inject  /load  /deliver  /extinguisher \n", sizeof(helpinfo));
		
		if(pInfo[playerid][pFacRank] >= 13)
		{
			strcat(helpinfo, "Cheif of LAFMD: /finvite  /fkick \n", sizeof(helpinfo));
		}
	}
	
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Faction Help", helpinfo, "Ok", "");
	return 1;
}

CMD:badge(playerid, params[])
{
	if(pInfo[playerid][pFaction] == 1)
	{
		if(OnDuty[playerid] == 0)
		{
			SetPlayerColor(playerid, 0x0800FF00);
			SendClientMessage(playerid, -1, "You are now on duty.");
			OnDuty[playerid] = 1;
			return 1;
		}
		if(OnDuty[playerid] == 1)
		{
			SetPlayerColor(playerid, 0xFFFFFF00);
			SendClientMessage(playerid, -1, "You are now off duty.");
			OnDuty[playerid] = 0;
		}
	}
	else if(pInfo[playerid][pFaction] == 2)
	{
		if(OnDuty[playerid] == 0)
		{
			SetPlayerColor(playerid, 0xFF634700);
			SendClientMessage(playerid, -1, "You are now on duty.");
			OnDuty[playerid] = 1;
			return 1;
		}
		if(OnDuty[playerid] == 1)
		{
			SetPlayerColor(playerid, 0xFFFFFF00);
			SendClientMessage(playerid, -1, "You are now off duty.");
			OnDuty[playerid] = 0;
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You're faction cannot go on duty.");
	return 1;
}

CMD:gate(playerid, params[])
{
	new str[128];
	/*======== SAPD ======== */
	if(IsPlayerInRangeOfPoint(playerid, 10, 1588.3325, -1637.0227, 13.4127))
	{
		if(pInfo[playerid][pFaction] == 1)
		{
			if(SAPDGStatus == 0)
			{
				SendClientMessage(playerid, COLOR_BLUE,"SAPD Gate is Open and will Close in 5 seconds.");
				MoveDynamicObject(SAPDGate[0], 1588.62109, -1637.92908, 6.94298, 2.00);
				MoveDynamicObject(SAPDGate[1], 1579.91394, -1637.92480, 6.94298, 2.00);
				format(str, sizeof(str), "* %s presses the button and opens the gate.", GetName(playerid));
				ProxDetector(30, playerid, str, COLOR_PURPLE);
				SAPDGStatus = 1;
				SetTimer("SAPDGateClose", 5000, 0);
				return 1;
			}
			if(SAPDGStatus == 1)
			{
				SendClientMessage(playerid, COLOR_GREY, "Gate is Already Opened");
				return 1;
			}
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You are not part of the SAPD.");
	}
	else if(IsPlayerInRangeOfPoint(playerid, 10, 1545.0344, -1627.3746, 13.3828))
	{
		if(pInfo[playerid][pFaction] == 1)
		{
			if(SAPDBStatus == 0)
			{
				SendClientMessage(playerid, COLOR_BLUE,"SAPD Barrier is Open and will Close in 5 seconds.");
				MoveDynamicObject(SAPDBarrier, 1544.68750, -1630.70203, 13.26834, 2, 0.30006, 0.98026, 89.76016);
				format(str, sizeof(str), "* %s presses the button and opens the barrier.", GetName(playerid));
				ProxDetector(30, playerid, str, COLOR_PURPLE);
				SAPDBStatus = 1;
				SetTimer("SAPDBarrierClose", 5000, 0);
				return 1;
			}
			if(SAPDBStatus == 1)
			{
				SendClientMessage(playerid, COLOR_GREY, "Barrier is Already Opened");
				return 1;
			}
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You are not part of the SAPD.");
	}
	/*======== Prison ======== */
	else if(IsPlayerInRangeOfPoint(playerid, 7, 942.08740, -2376.97559, 13.61776) || IsPlayerInRangeOfPoint(playerid, 7, 938.24390, -2370.35962, 13.61776))
	{
		if(pInfo[playerid][pFaction] == 1)
		{
			if(PrisonGStatus == 0)
			{
				MoveDynamicObject(PrisonGate[0], 945.8779, -2383.5732, 13.6178, 3, 0.0000, 0.0000, 120.2982);
				MoveDynamicObject(PrisonGate[1], 945.8779, -2383.5732, 13.6178, 4, 0.0000, 0.0000, 120.2982);
				
				format(str, sizeof(str), "* %s presses the button and opens the gate.", GetName(playerid));
				ProxDetector(30, playerid, str, COLOR_PURPLE);
				PrisonGStatus = 1;
				return 1;
			}
			if(PrisonGStatus == 1)
			{
				MoveDynamicObject(PrisonGate[0], 942.08740, -2376.97559, 13.61776, 3);
				MoveDynamicObject(PrisonGate[1], 938.24390, -2370.35962, 13.61776, 3);
				format(str, sizeof(str), "* %s presses the button and closes the gate.", GetName(playerid));
				ProxDetector(30, playerid, str, COLOR_PURPLE);
				PrisonGStatus = 0;
				return 1;
			}
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You are not part of the SAPD.");
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5, 936.25976562, -2383.10839844, 13.61776352))
	{
		if(pInfo[playerid][pFaction] == 1)
		{
			if(PrisonGaStatus == 0)
			{
				MoveDynamicObject(PrisonGarage, 936.25976562, -2383.10839844, 8.61776352, 2);
				format(str, sizeof(str), "* %s presses the button and opens the gate.", GetName(playerid));
				ProxDetector(30, playerid, str, COLOR_PURPLE);
				PrisonGaStatus = 1;
				return 1;
			}
			if(PrisonGaStatus == 1)
			{
				MoveDynamicObject(PrisonGarage, 936.25976562, -2383.10839844, 13.61776352, 2);
				format(str, sizeof(str), "* %s presses the button and closes the gate.", GetName(playerid));
				ProxDetector(30, playerid, str, COLOR_PURPLE);
				PrisonGaStatus = 0;
				return 1;
			}
		}
	}
	else if(IsPlayerInRangeOfPoint(playerid, 15,1811.59, -1795.36, 13.87))
	{
		if(pInfo[playerid][pFaction] == 1 || pInfo[playerid][pFaction] == 2)
		{
			if(fdg == 1 || fdg2 == 1) 
			{ 
				SendClientMessage(playerid, COLOR_GREY, "Gate is Already Opened"); 
				return 1; 
			}
			MoveDynamicObject(fdgate1, 1811.59, -1782.96, 13.87, 5);
			MoveDynamicObject(fdgate2, 1811.59, -1808.19, 13.87, 5);
			SetTimer("LAFMDGateClose", 5000, 0);
			SendClientMessage(playerid, COLOR_LIGHTRED,"Fire Department Gate is Open and will Close in 5 seconds.");
			format(str, sizeof(str), "* %s takes his/her remote and opens a gate.", GetName(playerid));
			ProxDetector(30.0, playerid, str, COLOR_PURPLE);
			fdg = 1;
			fdg2 = 1;
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You are not part of the LAFMD");
		return 1;
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not near a gate.");
	return 1;
}

CMD:r(playerid, params[])
{
	new string[128], text[100];
	if(pInfo[playerid][pFaction] != 1 && pInfo[playerid][pFaction] != 2)
	{
	    SendClientMessage(playerid, COLOR_GREY, "You are not in a faction with a radio.");
	    return 1;
	}
 	if(sscanf(params, "s[100]", text))
    {
        SendClientMessage(playerid, COLOR_GREY, "USAGE: /r(adio) [text]");
        return 1;
    }
	if(pInfo[playerid][pFaction] == 1)
	{
		format(string, sizeof(string), "* %s %s: %s", GetRankName(playerid), GetName(playerid), text);
		SendClientMessageToSAPD(RADIO, string);
		Log("/logs/radio.txt", string);
		SetPlayerChatBubble(playerid,text,COLOR_WHITE,20.0,5000);
	}
	if(pInfo[playerid][pFaction] == 2)
	{
		format(string, sizeof(string), "* %s %s: %s", GetRankName(playerid), GetName(playerid), text);
		SendClientMessageToLAFMD(RADIO, string);
		Log("/logs/radio.txt", string);
		SetPlayerChatBubble(playerid,text,COLOR_WHITE,20.0,5000);
	}
	return 1;
}

CMD:d(playerid, params[])
{
	new string[128], text[100];
	if(pInfo[playerid][pFaction] != 1 && pInfo[playerid][pFaction] != 2)
	{
	    SendClientMessage(playerid, COLOR_GREY, "You are not in a faction with a department radio.");
	    return 1;
	}
 	if(sscanf(params, "s[100]", text))
    {
        SendClientMessage(playerid, COLOR_GREY, "USAGE: /d(epartment chat) [text]");
        return 1;
    }
    
	format(string, sizeof(string), "** %s (%s) %s: %s", GetRankName(playerid), GetFacName(playerid), GetName(playerid), text);
	
 	SendClientMessageToDepartments(RADIO, string);
	Log("/logs/radio.txt", string);
	return 1;
}

CMD:lockers(playerid, params[])
{
	new faction = pInfo[playerid][pFaction];
	if(faction != 1 && faction != 2) return SendClientMessage(playerid, COLOR_GREY, "You are not in a faction with lockers.");
	if(faction == 1 && !IsPlayerInRangeOfPoint(playerid, 20, 264.73, 77.07, 1003.64)) return SendClientMessage(playerid, COLOR_GREY, "You are not near your lockers.");
	if(faction == 2 && !IsPlayerInRangeOfPoint(playerid, 20, 489.0727, 1421.5646, 1084.3738)) return SendClientMessage(playerid, COLOR_GREY, "You are not near your lockers.");

	if(pInfo[playerid][pFaction] == 1)
	{
	    ShowPlayerDialog(playerid, DIALOG_SAPD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform\nSelect Skin", "Ok", "Close");
		return 1;
	}
	if(pInfo[playerid][pFaction] == 2)
	{
	    ShowPlayerDialog(playerid, DIALOG_LAFMD, DIALOG_STYLE_LIST, "Locker", "Duty\nEquipment\nUniform", "Ok", "Close");
		return 1;
	}
	return 1;
}

CMD:siren(playerid, params[])
{
        new vehicleid,panels,doors,lights,tires;
        vehicleid = GetPlayerVehicleID(playerid);
        if(pInfo[playerid][pFaction] != 1 && pInfo[playerid][pFaction] != 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use that command.");
		if(!Flasher[vehicleid]) {
                if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                {
                        return SendClientMessage(playerid, COLOR_GREY, "You're not at the driver's seat.");
                }
                if (!GetVehicleModel(vehicleid)) return SendClientMessage(playerid, COLOR_GREY, "You need to be in a vehicle to use that command!");
                if (IsValidObject(obj[vehicleid]) || IsValidObject(obj2[vehicleid]) || IsValidObject(obj3[vehicleid]) || IsValidObject(obj4[vehicleid]) || IsValidObject(obj5[vehicleid]))
                {
                        SendClientMessage(playerid, COLOR_GREY, "INFO:{FFFFFF} You turned off the siren."), DestroyObject(obj[vehicleid]), DestroyObject(obj2[vehicleid]), DestroyObject(obj3[vehicleid]), DestroyObject(obj4[vehicleid]), DestroyObject(obj5[vehicleid]);
                        GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                        if(LightPwr[vehicleid] == 1)
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
                        else
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
                        Flasher[vehicleid] = 0;
                }
                switch (GetVehicleModel(vehicleid))
                {
                        case 596:
                        {
								obj3[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj4[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj5[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								AttachObjectToVehicle(obj3[vehicleid], vehicleid, -0.02, 2.18, -0.15,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj4[vehicleid], vehicleid, -0.60, -1.67, 0.39,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj5[vehicleid], vehicleid, 0.50, -1.67, 0.39,   0.00, 0.00, 0.00);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 597:
                        {
                                obj[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj2[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj3[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj4[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj5[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								AttachObjectToVehicle(obj[vehicleid], vehicleid, -0.53, -0.43, 0.79,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj2[vehicleid], vehicleid, 0.46, -0.43, 0.79,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj3[vehicleid], vehicleid, -0.02, 2.18, -0.15,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj4[vehicleid], vehicleid, -0.60, -1.67, 0.39,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj5[vehicleid], vehicleid, 0.50, -1.67, 0.39,   0.00, 0.00, 0.00);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 598:
                        {
								obj3[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj4[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								obj5[vehicleid] = CreateObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
								AttachObjectToVehicle(obj3[vehicleid], vehicleid, -0.02, 2.18, -0.15,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj4[vehicleid], vehicleid, -0.60, -1.67, 0.39,   0.00, 0.00, 0.00);
								AttachObjectToVehicle(obj5[vehicleid], vehicleid, 0.50, -1.67, 0.39,   0.00, 0.00, 0.00);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 599:
                        {
                                obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                obj2[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.524999,0.000000,1.125000,0.000000,0.000000,0.000000);
                                AttachObjectToVehicle(obj2[vehicleid], vehicleid, -0.524999,0.000000,1.125000,0.000000,0.000000,0.000000);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 541:
                        {
                                obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.375000,0.524999,0.375000,0.000000,0.000000,0.000000);

                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 426:
                        {
                                obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.524999,0.749999,0.375000,0.000000,0.000000,0.000000);

                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 427:
                        {
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 416:
                        {
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 407:
                        {
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 560:
                        {
                                obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.225000,0.750000,0.449999,0.000000,0.000000,0.000000);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 490:
                        {
                                obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                                AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.000000,1.125000,0.599999,0.000000,0.000000,0.000000);
                                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                                Flasher[vehicleid] = 1;
                        }
                        case 566:
                        {
                            obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
							AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.524999,0.749999,0.375000,0.000000,0.000000,0.000000);
							GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                            Flasher[vehicleid] = 1;
                        }
                        case 411:
                        {
                        	obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                         	AttachObjectToVehicle(obj[vehicleid], vehicleid, 0.505000,0.824999,0.275000,0.000000,0.000000,0.000000);
                         	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                         	Flasher[vehicleid] = 1;
                        }
						case 402:
						{
						    obj[vehicleid] = CreateObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                         	AttachObjectToVehicle(obj[vehicleid], vehicleid, -0.605000,-0.204999,0.775000,0.000000,0.000000,0.000000);
                         	GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                         	Flasher[vehicleid] = 1;
                        }
                        default:
                        {
                                return SendClientMessage(playerid, COLOR_RED, "ERROR:{FFFFFF} This vehicle is not supported with /siren command");
                        }
                }
                return SendClientMessage(playerid, COLOR_GREY, "INFO:{FFFFFF} You have sucesfully turned on your siren.");
        } else {
                if (IsValidObject(obj[vehicleid]) || IsValidObject(obj2[vehicleid]) || IsValidObject(obj3[vehicleid]) || IsValidObject(obj4[vehicleid]) || IsValidObject(obj5[vehicleid])) {
                        SendClientMessage(playerid, COLOR_GREY, "INFO:{FFFFFF} You have sucesfully turned off your siren."), DestroyObject(obj[vehicleid]), DestroyObject(obj2[vehicleid]), DestroyObject(obj3[vehicleid]), DestroyObject(obj4[vehicleid]), DestroyObject(obj5[vehicleid]);
                }
                GetVehicleDamageStatus(vehicleid,panels,doors,lights,tires);
                if(LightPwr[vehicleid] == 1)
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
                else
                        UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
                Flasher[vehicleid] = 0;
        }
        return 1;
}

CMD:finvite(playerid, params[])
{
	new giveplayerid, str[126];
	if(pInfo[playerid][pFaction] == 0) return SendClientMessage(playerid, -1, "You are not in a faction.");
	if(pInfo[playerid][pFacRank] < 13) return SendClientMessage(playerid, -1, "You are not cheif of your faction");
    if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, -1, "USAGE: /finvite [playerid]");
    if(pInfo[giveplayerid][pFaction] != 0) return SendClientMessage(playerid, -1, "The specified player is already in a faction.");
    invitedby[giveplayerid] = playerid;
    invitedto[giveplayerid] = pInfo[playerid][pFaction];
    format(str, sizeof(str), "%s has invited you to the faction %s.", GetName(playerid), GetRankName(pInfo[playerid][pFaction]));
    SendClientMessage(giveplayerid, COLOR_CYAN, str);
	ShowPlayerDialog(giveplayerid, DIALOG_INVITE, DIALOG_STYLE_MSGBOX, "Invitation", "You have been invited into a faction.", "Accept", "Decline");
    format(str, sizeof(str), "You have invited %s to %s.", GetName(giveplayerid), GetRankName(pInfo[playerid][pFaction]));
    SendClientMessage(playerid, COLOR_CYAN, str);
    format(str, sizeof(str), "%s has invited %s to %s.", GetName(playerid), GetName(giveplayerid), GetFactionName(pInfo[playerid][pFaction]));
	Log("/logs/invite.txt", str);
	return 1;
}

CMD:fkick(playerid, params[])
{
	new id, str[250], reason[56];
	if(pInfo[playerid][pFaction] == 0) return SendClientMessage(playerid, -1, "You are not in a faction.");
	if(pInfo[playerid][pFacRank] < 13) return SendClientMessage(playerid, -1, "You are not cheif of your faction");
	if(pInfo[playerid][pFaction] != pInfo[id][pFaction]) return SendClientMessage(playerid, -1, "They are not in the same faction as you.");
	if(sscanf(params, "us[56]", id)) return SendClientMessage(playerid, -1, "USAGE: /fkick [playerid] [reason]");
	SendClientMessage(id, COLOR_CYAN, "You have been removed from you're faction");
	format(str, sizeof(str), "You have kicked %s from their facion. Reason: %s", GetName(id), reason);
	SendClientMessage(playerid, COLOR_CYAN, str);
	format(str, sizeof(str), "%s has kicked %s from their faction: reason %s", GetName(playerid), GetName(id), reason);
	Log("/logs/factionkick.txt", str);
	pInfo[id][pFaction] = 0;
	return 1;
}

///////////////////
//===== SAPD ===///
///////////////////


CMD:m(playerid, params[])
{
	new
        string[128],
        action[100];
	if(pInfo[playerid][pFaction] != 1)
	{
	    SendClientMessage(playerid, COLOR_GREY, "You are not in a faction with a megaphone.");
	    return 1;
	}
    if(sscanf(params, "s[100]", action))
    {
        SendClientMessage(playerid, COLOR_GREY, "USAGE: /m [text]");
        return 1;
    }
    else
    {
        format(string, sizeof(string), "[MEGAPHONE] %s: %s", GetName(playerid), action);
        ProxDetector(30, playerid, string, COLOR_YELLOW);
    }
	return 1;
}

CMD:acceptcall(playerid, params[])
{
    new str[126], giveplayerid;
	if(pInfo[playerid][pFaction] != 2 && pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not a paramedic or in the SAPD.");
	if(sscanf(params, "i", giveplayerid)) return SendClientMessage(playerid, -1, "USAGE: /acceptcall [playerid/partofname]");
	/* LAFMD ACCEPT CALL */
	if(pInfo[playerid][pFaction] == 2)
	{
		if(OnCall[giveplayerid] != 911) return SendClientMessage(playerid, COLOR_GREY, "The specified person have either hung up or have not called 911.");
		format(str, sizeof(str), "LAFMD %s %s has accepted your 911 call and will speak with you shortly", GetRankName(playerid), GetName(playerid));
		SendClientMessage(giveplayerid, -1, str);
		format(str, sizeof(str), "You have accepted %s's 911 call.", GetName(giveplayerid));
		SendClientMessage(playerid, -1, str);
		format(str, sizeof(str), "* %s %s has accepted the 911-call from %s.", GetRankName(playerid), GetName(playerid), GetName(giveplayerid));
		SendClientMessageToLAFMD(RADIO, str);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		SetPlayerAttachedObject(playerid, 9, 330 , 6);
		OnCall[giveplayerid] = playerid;
		OnCall[playerid] = giveplayerid;
		return 1;
	}
	/* LSPD ACCEPT CALL */
	if(pInfo[playerid][pFaction] == 1)
	{
	    if(OnCall[giveplayerid] != 911) return SendClientMessage(playerid, COLOR_GREY, "The specified person have either hung up or have not called 911.");
		format(str, sizeof(str), "SAPD %s %s has accepted your 911 call and will speak with you shortly", GetRankName(playerid), GetName(playerid));
		SendClientMessage(giveplayerid, -1, str);
		format(str, sizeof(str), "You have accepted %s's 911 call.", GetName(giveplayerid));
		SendClientMessage(playerid, -1, str);
		format(str, sizeof(str), "* %s %s has accepted the 911-call from %s.", GetRankName(playerid), GetName(playerid), GetName(giveplayerid));
		SendClientMessageToSAPD(RADIO, str);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
		SetPlayerAttachedObject(playerid, 9, 330 , 6);
		OnCall[giveplayerid] = playerid;
		OnCall[playerid] = giveplayerid;
		return 1;
	}
	return 1;
}

CMD:checkbelt(playerid, params[])
{
	new str[126], giveplayerid;
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, -1, "You are not part of the SAPD.");
	if(sscanf(params, "d", giveplayerid)) return SendClientMessage(playerid, -1, "USAGE: checkbelt [playerid]");
	
	new Float: x, Float: y, Float: z;
	GetPlayerPos(giveplayerid, x, y, z);
	if(!IsPlayerInRangeOfPoint(playerid, 10, x, y, z)) return SendClientMessage(playerid, -1, "You are not near the suspect.");
	
	format(str, sizeof(str), "*Officer %s peaks through the drivers window to see if they are wearing a seatbelt.", GetName(playerid));
	ProxDetector(30.0, playerid, str, COLOR_PURPLE);
	if(Seatbelt[giveplayerid] == 1)
	{
		//SendClientMessage(playerid, COLOR_PURPLE, "They are wearing their seatbelts.");
		ProxDetector(30.0, playerid, "They are wearing their seatbelts.", COLOR_PURPLE);
	}
	if(Seatbelt[giveplayerid] == 0)
	{
		//SendClientMessage(playerid, COLOR_PURPLE, "They are not wearing their seatbelts.");
		ProxDetector(30.0, playerid, "They are not wearing their seatbelts.", COLOR_PURPLE);
	}
	return 1;
}

CMD:tazer(playerid, params[])
{
	new string[128];
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not a Law Enforcement Officer.");
	if(tazer[playerid] == 0)
	{
	        waitcheck[playerid] = 1;
	        if(waitcheck[playerid] == 2)
	    	{
 				waitcheck[playerid] = 0;
	   		} 
			tazerreplace[playerid] = gInfo[playerid][pGuns][2];
			if(gInfo[playerid][pGuns][2] != 0) RemovePlayerWeapon(playerid, gInfo[playerid][pGuns][2]);
   			format(string, sizeof(string), "* %s unholsters their tazer.", GetName(playerid));
			ProxDetector(30, playerid, string, COLOR_PURPLE);
			GivePlayerWeapon(playerid, 23, 60000);
			Log("/logs/weapon.txt", string);
			tazer[playerid] = 1;
		} 
		else 
		{
      		waitcheck[playerid] = 2;
        	if(waitcheck[playerid] == 2)
	    	{
 				waitcheck[playerid] = 0;
	   		}
			RemovePlayerWeapon(playerid, 23);
			GivePlayerWeapon(playerid, tazerreplace[playerid], 60000);
			format(string, sizeof(string), "* %s holsters their tazer.", GetName(playerid));
			ProxDetector(30, playerid, string, COLOR_PURPLE);
			tazer[playerid] = 0;
			Log("/logs/weapon.txt", string);
			ResetThePlayersWeapons(playerid);
			return 1;
	}
	return 1;
}

CMD:drag(playerid, params[])
{
	new string[128], giveplayerid, Float:x, Float:y, Float:z;
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not in the law enforcment.");
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /drag [playerid/partofname]");
	GetPlayerPos(giveplayerid, x, y, z);
	if(!IsPlayerInRangeOfPoint(playerid, 20, x, y, z)) return SendClientMessage(playerid, COLOR_GREY, "You are not close enough to the player.");
	if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_GREY, "You can not drag yourself");
	if(GetPVarInt(giveplayerid, "Cuffed") == 0) return SendClientMessage(playerid, COLOR_GREY, "Player is not cuffed.");
	if(GetPVarInt(giveplayerid, "Dragged") == 1)
	{
		beingdragged[giveplayerid] = -1;
		format(string, sizeof(string), "* %s has stopped dragging %s.", GetName(playerid), GetName(giveplayerid));
		ProxDetector(30, playerid, string, COLOR_PURPLE);
		SetPVarInt(giveplayerid, "Dragged", 0);
		return 1;
	}
	beingdragged[giveplayerid] = playerid;
	SetPVarInt(giveplayerid, "Dragged", 1);
	format(string, sizeof(string), "* %s is dragging %s.", GetName(playerid), GetName(giveplayerid));
	ProxDetector(30, playerid, string, COLOR_PURPLE);
	return 1;
}

CMD:cuff(playerid, params[])
{
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not in the law enforcment.");
	new string[128], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /cuff [playerid]");
	if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_GREY, "You can't cuff yourself");
	if(GetPVarInt(giveplayerid, "Restrained") == 0) return SendClientMessage(playerid, COLOR_GREY, "Player is not restrained.");
	SetPVarInt(giveplayerid, "Cuffed", 1);
	SetPlayerSkin(giveplayerid, GetPlayerSkin(giveplayerid));
	ClearAnimations(giveplayerid);
	TogglePlayerControllable(giveplayerid, 0);
	format(string, sizeof(string), "* %s has cuffed %s.", GetName(playerid), GetName(giveplayerid));
	ProxDetector(30, playerid, string, COLOR_PURPLE);
	SendClientMessage(giveplayerid, COLOR_CYAN, "You are cuffed.");
	SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_CUFFED);

    return 1;
}

CMD:uncuff(playerid, params[])
{
    if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not in the law enforcment.");
	new string[128], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /uncuff [playerid]");
	if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_GREY, "You can't uncuff yourself");
	if(GetPVarInt(giveplayerid, "Cuffed") == 0) return SendClientMessage(playerid, COLOR_GREY, "That player is not cuffed.");
	SetPVarInt(giveplayerid, "Cuffed", 0);
	SetPVarInt(giveplayerid, "Restrained", 0);
	TogglePlayerControllable(giveplayerid, 1);
	format(string, sizeof(string), "* %s has uncuffed %s.", GetName(playerid), GetName(giveplayerid));
	ProxDetector(30, playerid, string, COLOR_PURPLE);
	SendClientMessage(giveplayerid, COLOR_CYAN, "You have been uncuffed.");
	SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_NONE);
	ClearAnimations(giveplayerid);
	SetPlayerSkin(giveplayerid, GetPlayerSkin(giveplayerid));
	beingdragged[giveplayerid] = -1;
	SetPVarInt(giveplayerid, "Dragged", 0);
	return 1;
}

CMD:detain(playerid, params[])
{
    if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not in the law enforcment.");
	new str[128];
	new giveplayerid, seat;
    if(sscanf(params, "ui", giveplayerid, seat)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /detain [playerid] [seat 1-3]");
    if(GetPVarInt(giveplayerid, "Cuffed") == 0) return SendClientMessage(playerid, COLOR_GREY, "That player is not cuffed.");
    if(cardetain[playerid] == -1) return SendClientMessage(playerid, COLOR_GREY, "You have not entered any car to detain the player in.");
    if(seat == 0) return SendClientMessage(playerid, COLOR_GREY, "You can not detain someone in the driver seat.");
    if(seat > 3) return SendClientMessage(playerid, COLOR_GREY, "Valid seat ids are 1-3.");
    SetPVarInt(giveplayerid, "Dragged", 0);
	beingdragged[giveplayerid] = -1;
    RemovePlayerFromVehicle(giveplayerid);
	new Float: X, Float: Y, Float: Z;
	GetPlayerPos(giveplayerid, X, Y, Z);
	SetPlayerPos(giveplayerid, X, Y, Z+1);
    ClearAnimations(giveplayerid);
    SetPlayerSkin(giveplayerid, GetPlayerSkin(giveplayerid));
	PutPlayerInVehicle(giveplayerid, cardetain[playerid], seat);
	format(str, sizeof(str), "* %s has detained %s.", GetName(playerid), GetName(giveplayerid));
	ProxDetector(30, playerid, str, COLOR_PURPLE);
	return 1;
}

CMD:su(playerid, params[])
{
	new string[128], crime[128], giveplayerid;
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not in the law enforcment.");
	if(sscanf(params, "us[128]", giveplayerid, crime)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /su [playerid] [crime]");
	if(pInfo[giveplayerid][pWanted] > 5) return SendClientMessage(playerid, COLOR_GREY, "The suspect is already most wanted.");
	format(string, sizeof(string), "ALL UNITS: Officer %s has placed a charge on %s. Crime: %s.", GetName(playerid), GetName(giveplayerid), crime);
	SendClientMessageToSAPD(RADIO, string);
	format(string, sizeof(string), "You have recieved a charge from officer %s, crime: %s.", GetName(playerid), crime);
	SendClientMessage(giveplayerid, COLOR_CYAN, string);
	pInfo[giveplayerid][pWanted] += 1;
	pInfo[giveplayerid][pCrimes] += 1;
	SetPlayerWantedLevel(giveplayerid, pInfo[giveplayerid][pWanted]);
	return 1;
}

CMD:fine(playerid, params[])
{
	new string[128], amount, id;
	new Float: x, Float: y, Float: z;
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not in the law enforcment.");
	if(sscanf(params, "ii", id, amount)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /fine [playerid] [amount]");
	GetPlayerPos(id,x,y,z);
    GetPlayerPos(playerid, x, y, z);
    if(IsPlayerInRangeOfPoint(id,5,x,y,z))
	{
		if(amount > 5000 || amount < 100) return SendClientMessage(playerid, COLOR_GREY, "amount max: R5000 | minimum: R100");
		pInfo[id][pCash] -= amount;
		format(string, sizeof(string), "You have fined %s for R%i", GetName(id), amount);
		SendClientMessage(playerid, COLOR_LIGHTRED, string);
		format(string, sizeof(string), "You have been fined R%i by officer %s", amount, GetName(playerid));
		SendClientMessage(id, COLOR_LIGHTRED, string);
		format(string, sizeof(string), "%s has been fined R%i by officer %s", GetName(id), amount, GetName(playerid));
		Log("/logs/SAPD_fine.txt", string);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not in range of that player");
	return 1;
}

CMD:checksb(playerid, params[])
{
	new str[125], id;
	new Float: x, Float: y, Float: z;
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not in the law enforcment.");
	if(sscanf(params, "i", id)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /checksb [playerid]");
	GetPlayerPos(id,x,y,z);
    GetPlayerPos(playerid, x, y, z);
    if(!IsPlayerInRangeOfPoint(id,5,x,y,z)) return SendClientMessage(playerid, COLOR_GREY, "You are not in range of that player");
	format(str, sizeof(str), "** Officer %s checks to see if %s seat belt is on", GetName(playerid), GetName(id));
	ProxDetector(30, playerid, str, COLOR_PURPLE);
	if(Seatbelt[id] == 1) { format(str, sizeof(str), "** %s has got their seat belt on", GetName(id)); ProxDetector(30, playerid, str, COLOR_PURPLE);}
	else if(Seatbelt[id] == 0) { format(str, sizeof(str), "** %s has not got their seat belt on", GetName(id)); ProxDetector(30, playerid, str, COLOR_PURPLE);}
	return 1;
}

CMD:clearwanted(playerid, params[])
{
	new giveplayerid, str[128];
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, COLOR_GREY, "You are not in the law enforcment.");
	if(pInfo[playerid][pFacRank] < 5) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /clearwanted [playerid]");
	pInfo[giveplayerid][pWanted] = 0;
	format(str, 128, "Your wanted record has been cleared by officer %s.", GetName(playerid));
	SendClientMessage(giveplayerid, COLOR_CYAN, str);
	format(str, 128, "You have cleared %s's wanted record", GetName(giveplayerid));
	SendClientMessage(giveplayerid, COLOR_CYAN, str);
	format(str, 128, "%s has cleared %s's wanted record", GetName(playerid), GetName(giveplayerid));
	SendClientMessageToSAPD(RADIO, str);
	SetPlayerWantedLevel(giveplayerid, 0);
	return 1;
}

CMD:arrest(playerid, params[])
{
	new string[128];
	new rand = random(sizeof(CellDestinations));
	new giveplayerid, time, fine, bail;
	new Float: gpX, Float: gpY, Float: gpZ;
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, -1, "You are not in the law enforcment.");
	if(!IsPlayerInRangeOfPoint(playerid, 10, 1526, -1676, 5.89)) return SendClientMessage(playerid, -1, "You are not at the arrest point.");
    if(sscanf(params, "uiii", giveplayerid, time, fine, bail)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /arrest [playerid] [time (1-60 min)] [fine (0-50000)] [bail (0-100000)]");
	GetPlayerPos(giveplayerid, gpX, gpY, gpZ);
	if(!IsPlayerInRangeOfPoint(playerid, 10, gpX, gpY, gpZ)) return SendClientMessage(playerid, -1, "You are not near the suspect.");
	if(pInfo[giveplayerid][pWanted] == 0) return SendClientMessage(playerid, -1, "Player is not wanted.");
	if(time > 60 || time < 1) return SendClientMessage(playerid, -1, "Valid arrest time is between 1 and 60");
	if(fine > 50000 || fine < 0) return SendClientMessage(playerid, -1, "Valid fine is between 0 and 50000");
	if(bail > 100000 || bail < 0) return SendClientMessage(playerid, -1, "Valid bail is between 0 and 10000");
	if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "Invalid player specified.");
	if(giveplayerid == playerid) return SendClientMessage(playerid, -1, "You can not arrest yourself.");
	pInfo[giveplayerid][pJail] = time;
	pInfo[giveplayerid][pBail] = bail;
	pInfo[giveplayerid][pWanted] = 0;
	SetPlayerWantedLevel(giveplayerid, 0);
	pInfo[giveplayerid][pCash] -= fine;
	pInfo[giveplayerid][pArrests] += 1;
//	SetPlayerColor(giveplayerid, 0xFF8C0000);
	beingdragged[giveplayerid] = 0;
	SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_NONE);
	ClearAnimations(giveplayerid);
	SetPVarInt(giveplayerid, "Dragged", 0);
	TogglePlayerControllable(giveplayerid, 1);
	ResetPlayerWeapons(giveplayerid);
	SetPVarInt(giveplayerid, "Cuffed", 0);
	SetPlayerPos(giveplayerid, CellDestinations[rand][0], CellDestinations[rand][1], CellDestinations[rand][2]+0.7);
	FreezePlayer(giveplayerid, 3);
	SetCameraBehindPlayer(giveplayerid);
	format(string, sizeof(string), "You have been arrested by Officer %s for %i minutes and have been fined R%i.", GetName(playerid), time, fine);
	SendClientMessage(giveplayerid, COLOR_CYAN, string);
	format(string, sizeof(string), "You have arrested %s for %i minutes, fined R%i and set the bail to %i.", GetName(giveplayerid), time, fine, bail);
	SendClientMessage(playerid, COLOR_CYAN, string);
	format(string, sizeof(string), "[SAPD JAIL] %s has arrested %s for %i minutes, fined R%i and set the bail to %i.", GetName(playerid), GetName(giveplayerid), time, fine, bail);
	Log("/logs/prison.txt", string);
	format(string, sizeof(string), "ALL UNITS: %s has arrested %s for %i minutes and fined R%i.", GetName(playerid), GetName(giveplayerid), time, fine);
	SendClientMessageToSAPD(RADIO, string);
	if(pInfo[giveplayerid][pBail] > 0)
	{
		format(string, sizeof(string), "Your bail is: %i.", bail);
	}
	SendClientMessage(giveplayerid, COLOR_LIGHTRED, string);
	rtimer[giveplayerid] = SetTimerEx("arrestrelease", 60000, true, "i", giveplayerid);
	RemovePlayerWeapons(giveplayerid);
	if(pInfo[giveplayerid][pWanted] < 1) return SendClientMessage(playerid, -1, "Player is not wanted.");
	return 1;
}

CMD:deploycone(playerid, params[])
{
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, -1, "You are not authorized to use that command!");
	new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
 	GetPlayerPos(playerid, plocx, plocy, plocz);
  	GetPlayerFacingAngle(playerid,ploca);
   	CreateCone(plocx-0.8,plocy-0.8,plocz,ploca);
    return 1;
}

CMD:destroycones(playerid, params[])
{
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, -1, "You are not authorized to use that command!");
	DeleteAllCone();
	return 1;
}

CMD:deploycade(playerid, params[])
{
    new str[126], zone[126];
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, -1, "You are not a Law Enforcement Officer.");
	new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
 	GetPlayerPos(playerid, plocx, plocy, plocz);
  	GetPlayerFacingAngle(playerid,ploca);
   	CreateCade(plocx-0.8,plocy-0.8,plocz,ploca);
 	GetPlayer3DZone(playerid);
	format(str, sizeof(str), "* %s %s has deployed a barricade at %s.", GetRankName(playerid), GetName(playerid), zone);
	SendClientMessageToSAPD(RADIO, str);
    return 1;
}

CMD:destroycade(playerid, params[])
{
	if(pInfo[playerid][pFaction] != 1 ) return SendClientMessage(playerid, -1, "You are not a Law Enforcement Officer.");
	DeleteClosestCade(playerid);
	return 1;
}

CMD:destroycades(playerid, params[])
{
	new str[126];
	if(pInfo[playerid][pFaction] != 1) return SendClientMessage(playerid, -1, "You are not a Law Enforcement Officer.");
	format(str, sizeof(str), "* %s %s has picked up all barricades.", GetRankName(playerid), GetName(playerid));
	SendClientMessageToSAPD(RADIO, str);
 	DeleteAllCade();
 	return 1;
}

////////////////////
//===== LAFMD ===///
////////////////////

CMD:aid(playerid, params[])
{
	new id, str[56];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /aid [playerid]");
	if(pInfo[playerid][pBandage] >= 1)
	{
		new Float: hp;
		GetPlayerHealth(playerid, hp);
		SetPlayerHealth(id, hp+25);
		format(str, sizeof(str), "* %s wraps bandages around %s", GetName(playerid), GetName(id));
		ProxDetector(30.0, playerid, str, COLOR_PURPLE);
		format(str, sizeof(str), "You bandaged up %s", GetName(id));
		SendClientMessage(playerid, COLOR_LIGHTRED, str);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You do not have any bandages");
	return 1;
}

CMD:inject(playerid, params[])
{
	new id, str[56];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /inject [playerid]");
	if(pInfo[playerid][pMorphine] >= 1)
	{
		format(str, sizeof(str), "* %s injects morphine into %s", GetName(playerid), GetName(id));
		ProxDetector(30.0, playerid, str, COLOR_PURPLE);
		KillTimer(LoseHPTimer[id]);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You do not have any morphine");
	return 1;
}

CMD:load(playerid, params[])
{
	new giveplayerid, seat, Float:x, Float:y, Float:z, str[126];
	if(pInfo[playerid][pFaction] != 2) return SendClientMessage(playerid, COLOR_GREY, "You are not a paramedic.");
	if(sscanf(params, "ui", giveplayerid, seat)) return SendClientMessage(playerid, -1, "USAGE: /load [playerid/partofname] [seat]");
	if(GetPVarInt(giveplayerid, "Injured") != 1) return SendClientMessage(playerid, COLOR_GREY, "Player is not injured.");
	GetPlayerPos(giveplayerid, x, y, z);
	if(seat == 0) return SendClientMessage(playerid, -1, "You can not load a patient in the driver seat.");
	if(cardetain[playerid] == -1) return SendClientMessage(playerid, COLOR_GREY, "Invalid detain vehicle.");
	if(!IsPlayerInRangeOfPoint(playerid, 20, x, y, z)) return SendClientMessage(playerid, COLOR_GREY, "You are not close enough to the patient.");
	KillTimer(LoseHPTimer[giveplayerid]);
	LoseHPTimer[giveplayerid] = 0;
	SendClientMessage(giveplayerid, -1, "You have been loaded..");
	format(str, sizeof(str), "You have loaded %s. Go to the hospital loading point and type /deliver", GetName(giveplayerid));
	TogglePlayerControllable(giveplayerid, 0);
	SendClientMessage(playerid, -1, str);
	PutPlayerInVehicle(giveplayerid, cardetain[playerid], seat);
	return 1;
}

CMD:deliver(playerid, params[])
{
	new giveplayerid, Float:x, Float:y, Float:z, str[126];
	if(pInfo[playerid][pFaction] != 2) return SendClientMessage(playerid, COLOR_GREY, "You are not a paramedic.");
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, -1, "USAGE: /deliver [playerid/partofname]");
	if(GetPVarInt(giveplayerid, "Injured") != 1) return SendClientMessage(playerid, COLOR_GREY, "Player is not injured.");
	GetPlayerPos(giveplayerid, x, y, z);
	if(!IsPlayerInRangeOfPoint(playerid, 20, x, y, z)) return SendClientMessage(playerid, COLOR_GREY, "You are not close enough to the patient.");
	if(!IsNearLoadingPoint(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not close enough to a delivery point.");
	format(str, sizeof(str), "* %s %s has delivered patient %s at the hospital in %s.", GetRankName(playerid), GetName(playerid), GetName(giveplayerid), GetPlayer3DZone(playerid));
	SendClientMessageToLAFMD(COLOR_PURPLE, str);
	
	new cash = random(500) + 50;
	pInfo[playerid][pCash] += cash;
	
	format(str, sizeof(str), "You have recieved R%d for delivering the patient.", cash);
	SendClientMessage(playerid, COLOR_CYAN, str);
	if(IsPlayerInRangeOfPoint(playerid, 50, 2016.95, -1413.74, 16.99))
	{
		DeliverdTo[giveplayerid] = 1;
		HospitalTimer[giveplayerid] = SetTimerEx("HospitalDeliver", 1000, true, "i", giveplayerid);
		TogglePlayerSpectating(giveplayerid, 1);
		HospitalCount[playerid] = 15;
		//SetPlayerPos(giveplayerid, 2030.08, -1425, 17);
	}
    if(IsPlayerInRangeOfPoint(playerid, 50, 1140.90, -1326, 13.64))
	{
		DeliverdTo[giveplayerid] = 2;
		HospitalTimer[giveplayerid] = SetTimerEx("HospitalDeliver", 1000, true, "i", giveplayerid);
		TogglePlayerSpectating(giveplayerid, 1);
		HospitalCount[playerid] = 15;
		//SetPlayerPos(giveplayerid, 1181.34, -1323.80, 13.58);
	}
	return 1;
}

CMD:extinguisher(playerid, params[])
{
	if(pInfo[playerid][pFaction] == 2)
	{
		GivePlayerWeapon(playerid, 42, 9999);
		SendClientMessage(playerid, COLOR_LIGHTRED, "You have equipped a fire extinguisher");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not part of the LAFMD");
	return 1;
}

///////////////////////
//===== Mechanic ===///
///////////////////////



////////////////////
//===== News ===////
////////////////////


////////////////////
//===== DOC ===////
////////////////////

CMD:dooropen(playerid, params[])
{
	if(pInfo[playerid][pFaction] == 1)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2.0,1849.32995605,-1714.31005859,5201.54003906))
        {
            MoveDynamicObject(door1,1849.32995605-1.25,-1714.31005859,5201.54003906,0.50);
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: door 1 has been opened!");
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 2.0,1847.31994629,-1722.56994629,5201.54003906))
        {
            MoveDynamicObject(door2,1847.31994629,-1722.56994629-1.25,5201.54003906,0.50);
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: door 2 has been opened!");
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 2.0,1854.01953125,-1726.27343750,5201.54003906))
        {
            MoveDynamicObject(door3,1854.01953125,-1726.27343750-1.25,5201.54003906,0.50);
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: door 3 has been opened!");
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 2.0,1862.02246094,-1710.91992188,5201.54003906))
        {
            MoveDynamicObject(door4,1862.02246094-1.25,-1710.91992188,5201.54003906,0.50);
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: door 4 has been opened!");
            return 1;
        }
        else SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: You are not near any door!");
	}
	else
	{
	    SendClientMessage(playerid, -1, "You are not authorized to use that command!");
	}
	return 1;
}
CMD:doorclose(playerid, params[])
{
	if(pInfo[playerid][pFaction] == 1)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 2.0,1849.32995605,-1714.31005859,5201.54003906))
        {
            MoveDynamicObject(door1,1849.32995605,-1714.31005859,5201.54003906,0.50);
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: door 1 has been closed!");
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 2.0,1847.31994629,-1722.56994629,5201.54003906))
        {
            MoveDynamicObject(door2,1847.31994629,-1722.56994629,5201.54003906,0.50);
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: door 2 has been closed!");
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 2.0,1854.01953125,-1726.27343750,5201.54003906))
        {
            MoveDynamicObject(door3,1854.01953125,-1726.27343750,5201.54003906,0.50);
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: door 3 has been closed!");
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 2.0,1862.02246094,-1710.91992188,5201.54003906))
        {
            MoveDynamicObject(door4,1862.02246094,-1710.91992188,5201.54003906,0.50);
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: door 4 has been closed!");
            return 1;
        }
        else SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: You are not near any door!");
	}
	else
	{
	    SendClientMessage(playerid, -1, "You are not authorized to use that command!");
	}
	return 1;
}



////////////////////////////////////////////////////////////////////////////////////////////////
//============================== Admin COMMANDS ==============================================//
////////////////////////////////////////////////////////////////////////////////////////////////

CMD:ah(playerid, params[])
{
	new AdminHelp[1024];
	if(pInfo[playerid][pAdminLevel] < 1) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		strcat(AdminHelp, "Junior Staff:  /a  /reports  /ar  /er  /amr  /admins  /newbunmute \n", sizeof(AdminHelp));
	}
	
	if(pInfo[playerid][pAdminLevel] >= 2)
	{
		strcat(AdminHelp, "Staff:  /tr  /adminduty  /aduty  /kick  /spec  /slap  /sslap  /fix  /flip  /arefuel  /ammute  /disarm \n", sizeof(AdminHelp));
		strcat(AdminHelp, "Staff:  /check  /prison  /clearchat  /auncuff  /auntie  /jetpack \n", sizeof(AdminHelp));
	}
	
	if(pInfo[playerid][pAdminLevel] >= 3)
	{
		strcat(AdminHelp, "General Staff:  /revive  /release  /veh  /teleport  /gethere  /afine \n", sizeof(AdminHelp));
	}
	
	if(pInfo[playerid][pAdminLevel] >= 4)
	{
		strcat(AdminHelp, "Senior Staff: /vehdestroy  /destroyveh  /ban  /goto  /gotoid  /gotox  /rac  /givemoney \n", sizeof(AdminHelp));
	}
	
	if(pInfo[playerid][pAdminLevel] >= 5)
	{
		strcat(AdminHelp, "Supervisor: /set  /unban  /enableooc  /disableooc  /givegun \n", sizeof(AdminHelp));
	}
	
	if(pInfo[playerid][pAdminLevel] >= 6)
	{
		strcat(AdminHelp, "Shift Manager:  /mole  \n", sizeof(AdminHelp));
	}
	
	if(pInfo[playerid][pAdminLevel] >= 7)
	{
		strcat(AdminHelp, "Operations Manager:  /setfac  /setfacrank  /explode  \n", sizeof(AdminHelp));
	}
	
	if(pInfo[playerid][pAdminLevel] >= 8)
	{
		strcat(AdminHelp, "Server Director:  /makeadmin  /restart  /announcerace  /startrace  /endrace \n", sizeof(AdminHelp));
	}
	if(IsPlayerAdmin(playerid))
	{
		strcat(AdminHelp, "RCon:  /createdveh  /editv  /vdelete  /createfstation  /doorcreate  /dooredit \n", sizeof(AdminHelp));
		strcat(AdminHelp, "RCon:  /doorname  /doornear  /housecreate  /housedestroy \n", sizeof(AdminHelp));
	}
	
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Admin Help", AdminHelp, "Ok", "");
	return 1;
}
CMD:ahelp(playerid, params[]) return cmd_ah(playerid, params);

////////////////////////////
//===== Junior Staff ===////
////////////////////////////

CMD:a(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 1) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new str[128], text[100];
	if(sscanf(params, "s[56]", text)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /a [text]");
	format(str, sizeof(str), "%s %s: %s", GetAdminName(playerid), GetName(playerid), text);
	SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
	return 1;
}

CMD:reports(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 1) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new reports[128];
	new count;
	count = 0;
	for(new i;i < MAX_PLAYERS; i++)
	{
		if(GetPVarInt(i, "ReportPending") == 1)
		{
			new string[200], reporttext[126], pendingtime;
			GetPVarString(i, "ReportText", reporttext, sizeof(reporttext));
			pendingtime = (gettime()-GetPVarInt(i, "ReportTime"))/60;
			format(string, sizeof(string), "%s [ID: %i] | %s | Pending: %d minutes \n", GetName(i), i, reporttext, pendingtime);
			strcat(reports, string, sizeof(reports));
			count++;
		}
		if(GetPVarInt(i, "ReportPending") == 2)
		{
			new string[200], reporttext[126], pendingtime;
			GetPVarString(i, "ReportText", reporttext, sizeof(reporttext));
			pendingtime = (gettime()-GetPVarInt(i, "ReportTime"))/60;
			format(string, sizeof(string), "%s [ID: %d] | %s | Accepted \n", GetName(i), i, reporttext, pendingtime);
			strcat(reports, string, sizeof(reports));
			count++;			
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_GREY, "There are no active reports.");
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Reports", reports, "Ok", "");
	return 1;
}

CMD:ar(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 1) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	
	if(GetPVarInt(playerid, "OnReport") == 0)
	{
		new id, string[126];
		if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /ar [ID]");
		
		SetPVarInt(id, "ReportPending", 2);
		
		SetPVarInt(playerid, "OnReport", 1);
		
		format(string, sizeof(string), "%s has accepted the report from %s [ID: %d]", GetName(playerid), GetName(id), id);
		SendClientMessageToAdmins(COLOR_LIGHTRED, string, 1);
		
		format(string, sizeof(string), "%s has accepted your report. Use /srm %d to talk to them.", GetName(playerid), playerid);
		SendClientMessage(id, COLOR_LIGHTRED, string);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You already have an active report.");
	
	return 1;
}

CMD:er(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 1) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "OnReport") == 1)
	{
		new id, string[126];
		if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /er [ID]");
		
		DeletePVar(id, "ReportText");
		DeletePVar(id, "ReportTime");
		DeletePVar(id, "ReportPending");
		
		DeletePVar(playerid, "OnReport");
		
		format(string, sizeof(string), "%s has ended the report from %s [ID: %d]", GetName(playerid), GetName(id), id);
		SendClientMessageToAdmins(COLOR_LIGHTRED, string, 1);
		
		format(string, sizeof(string), "%s has ended your report.", GetName(playerid));
		SendClientMessage(id, COLOR_LIGHTRED, string);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not on a report.");
	return 1;
}

CMD:amr(playerid, params[])
{
	new id, text[128], str[128];
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		if(sscanf(params, "is[128]", id, text)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /amr [playerid] [text]");
		if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_GREY, "Invalid Player.");
		format(str, sizeof(str), "Admin: %s", text);
		SendClientMessage(id, COLOR_ORANGE, str);
		format(str, sizeof(str), "%s %s: %s", GetAdminName(playerid), GetName(playerid), text);
		SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:admins(playerid, params[])
{
	new str[64], str2[500], count = 0;
	if(pInfo[playerid][pAdminLevel] <= 0) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(pInfo[i][pAdminLevel] >= 1)
		{
			if(GetPVarInt(playerid, "AdminDuty") == 0)
			{
				format(str, sizeof(str), "%s %s \n", GetAdminName(i), GetName(i));
				strcat(str2, str, sizeof(str2));
				count++;
			}
			else
			{
				format(str, sizeof(str), ""COL_ORANGE"%s %s \n", GetAdminName(i), GetName(i));
				strcat(str2, str, sizeof(str2));
				count++;
			}
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_GREY, "There are no admins online");
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_MSGBOX, "Admins online", str2, "Ok", "");
	return 1;
}

CMD:newbunmute(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] >= 1)
	{
		new giveplayerid, str[128];
		if(sscanf(params, "i", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /newbmute [playerid]");
		{
			if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "Invalid player specified.");
			pInfo[giveplayerid][pNewbMute] = 0;
			format(str, sizeof(str), "%s has un-muted %s from using newbie.");
			SendClientMessageToMods(COLOR_CYAN, str, 1);
			SendClientMessage(giveplayerid, COLOR_CYAN, "You have been muted from using newbie.");
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

//////////////////////
//===== Staff ===////
/////////////////////

CMD:tr(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	
	new id, string[126];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /tr [ID]");
	
	DeletePVar(id, "ReportText");
	DeletePVar(id, "ReportTime");
	DeletePVar(id, "ReportPending");
	
	format(string, sizeof(string), "%s has denied the report from %s [ID: %d]", GetName(playerid), GetName(id), id);
	SendClientMessageToAdmins(COLOR_LIGHTRED, string, 1);
	
	format(string, sizeof(string), "%s has denied your report due to it being invalid.", GetName(playerid));
	SendClientMessage(id, COLOR_LIGHTRED, string);
	return 1;
}

CMD:adminduty(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 0)
	{
		new str[126];
		SetPlayerColor(playerid, 0xFF9900AA);
		SetPlayerMarkerForPlayer(playerid, -1, 0xFF9900AA);
		format(str, sizeof(str), "%s is now on duty.", GetName(playerid));
		SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
		SendClientMessageToAll(COLOR_ORANGE, "There is an admin on duty.");
		SetPVarInt(playerid, "AdminDuty", 1);
		return 1;
	}
	if(GetPVarInt(playerid, "AdminDuty") == 1)
	{
		new str[126];
		SetPlayerColor(playerid, 0xFFFFFFFF);
		SetPlayerColor(playerid, GetPlayerColor(playerid) & 0xFFFFFF00);
		format(str, sizeof(str), "%s is now off duty.", GetName(playerid));
		SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
		SetPVarInt(playerid, "AdminDuty", 0);	
		
		for(new i;i < MAX_PLAYERS; i++)
		{
			for(new v = 0; v < MAX_ADMIN_CARS; v++)
			{
				if(AdminCars[i][v] > 0)
				{
					DestroyVehicle(AdminCars[i][v]);
					AdminCars[i][v] = 0;
				}
			}
		}		
	}
	return 1;
}

CMD:aduty(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 0)
	{
		new str[126];
		format(str, sizeof(str), "%s is now on duty.", GetName(playerid));
		SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
		SetPVarInt(playerid, "AdminDuty", 1);
		return 1;
	}
	else if(GetPVarInt(playerid, "AdminDuty") == 1)
	{
		new str[126];
		format(str, sizeof(str), "%s is now off duty.", GetName(playerid));
		SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
		SetPVarInt(playerid, "AdminDuty", 0);	
		
		for(new i;i < MAX_PLAYERS; i++)
		{
			for(new v = 0; v < MAX_ADMIN_CARS; v++)
			{
				if(AdminCars[i][v] > 0)
				{
					DestroyVehicle(AdminCars[i][v]);
					AdminCars[i][v] = 0;
				}
			}
		}
		return 1;
	}
	return 1;
}

CMD:kick(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] == 8)
	{
		new id, reason[126], str[128];
		if(sscanf(params, "us[126]", id, reason)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /kick [ID] [REASON]");
		format(str, sizeof(str), "%s has kicked you. \n \nReason: %s",GetName(playerid), reason);
		ShowPlayerDialog(id, DIALOG_KICKED, DIALOG_STYLE_MSGBOX, ""COL_ORANGE"Kicked", str, "Ok", "");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	return 1;
}

CMD:spec(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] == 8)
	{
		new giveplayerid;
		if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, -1, "USAGE: /spec [playerid/off]");
		if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_GREY, "You cant spectate yourself");
		if(strcmp(params, "off", true) == 0)
		{
			SetPVarInt(playerid, "SpecOff", 1);
			TogglePlayerSpectating(playerid, false);
			SetCameraBehindPlayer(playerid);
			SetPlayerPos(playerid,rrP[playerid][0], rrP[playerid][1], rrP[playerid][2]);
			spec[playerid] = -1;
			return 1;
		}
		if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specified.");
		if(IsPlayerInAnyVehicle(giveplayerid))
		{
	//		GetPlayerPos(playerid, x, y, z);
			GetPlayerPos(playerid, rrP[playerid][0], rrP[playerid][1], rrP[playerid][2]);
			TogglePlayerSpectating(playerid, true);
			new carid = GetPlayerVehicleID(giveplayerid);
			PlayerSpectateVehicle(playerid, carid);
			SetPlayerInterior(playerid, GetPlayerInterior(giveplayerid));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(giveplayerid));
			spec[playerid] = giveplayerid;
		}
		else
		{
	//	    GetPlayerPos(playerid, x, y, z);
			GetPlayerPos(playerid, rrP[playerid][0], rrP[playerid][1], rrP[playerid][2]);
			TogglePlayerSpectating(playerid, true);
			PlayerSpectatePlayer(playerid, giveplayerid);
			SetPlayerInterior(playerid, GetPlayerInterior(giveplayerid));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(giveplayerid));
			spec[playerid] = giveplayerid;
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	return 1;
}

CMD:slap(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] == 8)
	{
		if(AdminAntiSpam[playerid] == 0)
		{
			new giveplayerid;
			new string[128];
			if(pInfo[playerid][pAdminLevel] < pInfo[giveplayerid][pAdminLevel]) return SendClientMessage(playerid, -1, "You can't do this on a higher level administrator.");
			if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /slap [ID]");
			if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specified.");
			if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specified.");
			GetPlayerPos(giveplayerid, pInfo[giveplayerid][pPosX], pInfo[giveplayerid][pPosY], pInfo[giveplayerid][pPosZ]);
			SetPlayerPos(giveplayerid, pInfo[giveplayerid][pPosX], pInfo[giveplayerid][pPosY], pInfo[giveplayerid][pPosZ]+2);
			format(string, sizeof(string), "AdmCmd: %s was slapped by %s", GetName(giveplayerid), GetName(playerid));
			SendClientMessageToAdmins(COLOR_LIGHTRED, string, 1);
			PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
			PlayerPlaySound(giveplayerid, 1190, 0.0, 0.0, 0.0);
			AdminAntiSpam[playerid] = 1;
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You need to wait a few seconds.");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	return 1;
}

CMD:sslap(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] == 8)
	{
		if(AdminAntiSpam[playerid] == 0)
		{
			new giveplayerid;
			if(pInfo[playerid][pAdminLevel] < pInfo[giveplayerid][pAdminLevel]) return SendClientMessage(playerid, -1, "You can't do this on a higher level administrator.");
			if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /slap [ID]");
			if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specified.");
			if(giveplayerid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specified.");
			GetPlayerPos(giveplayerid, pInfo[giveplayerid][pPosX], pInfo[giveplayerid][pPosY], pInfo[giveplayerid][pPosZ]);
			SetPlayerPos(giveplayerid, pInfo[giveplayerid][pPosX], pInfo[giveplayerid][pPosY], pInfo[giveplayerid][pPosZ]+2);
			PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
			PlayerPlaySound(giveplayerid, 1190, 0.0, 0.0, 0.0);
			AdminAntiSpam[playerid] = 1;
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You need to wait a few seconds.");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	return 1;
}

CMD:fix(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] == 8)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		RepairVehicle(vehicleid);
		SendClientMessage(playerid, COLOR_WHITE, "Vehicle fixed");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	return 1;
}

CMD:flip(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] >= 2)
    {
		if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] == 8)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new Float:angle;
			GetVehicleZAngle(vehicleid, angle);
			SetVehicleZAngle(vehicleid, angle);
			SendClientMessage(playerid, COLOR_WHITE, "Vehicle flipped");
		}
		else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:arefuel(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] == 8)
    {
		for(new i = 0; i < MAX_VEHICLES; i++)
		{
			new vehicleid = GetPlayerVehicleID(i);
			new vid = GetVehicleID(vehicleid);
			gVehicleFuel[vehicleid] = 100;
			vInfo[vid][vFuel] = 100;
		}
		SendClientMessage(playerid, COLOR_WHITE, "Vehicles refueled");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	return 1;
}

CMD:ammute(playerid, params[])
{
	new id, str[56];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /ammute [playerid]");
	if(pInfo[playerid][pAdminLevel] >= 2)
	{
		if(pInfo[id][pAMMute] == 1)
		{
			pInfo[id][pAMMute] = 1;
			format(str, sizeof(str), "%s has muted %s from use /am", GetName(playerid), GetName(id));
			SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
		}
		else
		{
			pInfo[id][pAMMute] = 0;
			format(str, sizeof(str), "%s has un-muted %s from use /am", GetName(playerid), GetName(id));
			SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:disarm(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] >= 2)
	{
		new giveplayerid, str[128], reason[56];
		if(sscanf(params, "us[56]", giveplayerid, reason)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /disarm [playerid] [reason]");
		SendClientMessage(giveplayerid, COLOR_GREY, "An Admin has disarmed you from your weapons");
		RemovePlayerWeapons(giveplayerid);
		format(str, sizeof(str), "AdmCmd: %s was disarmed by %s. Reason: %s.", GetName(giveplayerid), GetName(playerid), reason);
		SendClientMessageToAll(COLOR_LIGHTRED, str);
		Log("/logs/disarm.txt", str);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:check(playerid, params[])
{
	new id, str[56];
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /check [playerid]");
	if(pInfo[playerid][pAdminLevel] >= 2)
	{
		ShowStats(playerid, id);
		format(str, sizeof(str), "You are inspecting %s", GetName(id));
		SendClientMessage(playerid, COLOR_ORANGE, str);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	return 1;
}

CMD:prison(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] >= 8)
	{
		new giveplayerid, str[128], time, reason[56];
	    new rand = random(sizeof(CellDestinations));
		if(sscanf(params, "uis[56]", giveplayerid, time, reason)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /prison [playerid] [time] [reason]");
        if(pInfo[playerid][pAdminLevel] < pInfo[giveplayerid][pAdminLevel]) return SendClientMessage(playerid, -1, "You can't do this on a higher level administrator.");
		pInfo[giveplayerid][pJail] = time;
		pInfo[giveplayerid][pBail] = 0;
		beingdragged[giveplayerid] = -1;
		SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_NONE);
		ClearAnimations(giveplayerid);
		SetPVarInt(giveplayerid, "Dragged", 0);
		SetPVarInt(giveplayerid, "Cuffed", 0);
		TogglePlayerControllable(giveplayerid, 1);
		ResetPlayerWeapons(giveplayerid);
		SetPlayerPos(giveplayerid, CellDestinations[rand][0], CellDestinations[rand][1], CellDestinations[rand][2]);
		FreezePlayer(giveplayerid, 3);
		format(str, 126, "AdmCmd: %s was prisoned by %s. Reason: %s.", GetName(giveplayerid), GetName(playerid), reason);
		SendClientMessageToAll(COLOR_LIGHTRED, str);
		Log("/logs/prison.txt", str);
		SetPlayerColor(giveplayerid, 0x99330000);
		rtimer[giveplayerid] = SetTimerEx("arrestrelease", 60000, true, "i", giveplayerid);
		RemovePlayerWeapons(giveplayerid);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	return 1;
}

CMD:clearchat(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] >= 8)
	{
		for(new i = 0; i < 100; i++)
		{
			SendClientMessageToAll(-1, " ");
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	return 1;
}

CMD:auncuff(playerid, params[])
{
    if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 || pInfo[playerid][pAdminLevel] != 8) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new string[128], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /auncuff [playerid]");
	if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_GREY, "You can't uncuff yourself");
	if(GetPVarInt(giveplayerid, "Cuffed") == 0) return SendClientMessage(playerid, COLOR_GREY, "That player is not cuffed.");
	SetPVarInt(giveplayerid, "Cuffed", 0);
	SetPVarInt(giveplayerid, "Restrained", 0);
	TogglePlayerControllable(giveplayerid, 1);
	format(string, sizeof(string), "Admin %s has uncuffed %s.", GetName(playerid), GetName(giveplayerid));
	SendClientMessageToAdmins(COLOR_ORANGE, string, 1);
	SendClientMessage(giveplayerid, COLOR_CYAN, "You have been uncuffed by an admin");
	SetPlayerSpecialAction(giveplayerid, SPECIAL_ACTION_NONE);
	ClearAnimations(giveplayerid);
	SetPlayerSkin(giveplayerid, GetPlayerSkin(giveplayerid));
	beingdragged[giveplayerid] = -1;
	SetPVarInt(giveplayerid, "Dragged", 0);
	return 1;
}

CMD:auntie(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 || pInfo[playerid][pAdminLevel] != 8) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new string[128], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /auncuff [playerid]");
	if(giveplayerid == playerid) return SendClientMessage(playerid, COLOR_GREY, "You can't uncuff yourself");
	TogglePlayerControllable(giveplayerid, 1);
	GameTextForPlayer(giveplayerid, "~y~ Untied!", 3000, 1);
	Tie[giveplayerid] = 0;

    format(string, sizeof(string), "You have untied %s", GetName(giveplayerid));
    SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:jetpack(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 2) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 || pInfo[playerid][pAdminLevel] != 8) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "JetPack") == 0)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
		SendClientMessage(playerid, COLOR_GREY, "Jetpack enabled");
		SetPVarInt(playerid, "JetPack", 1);
	}
	else if(GetPVarInt(playerid, "JetPack") == 1)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		SendClientMessage(playerid, COLOR_GREY, "Jetpack disabled");
		SetPVarInt(playerid, "JetPack", 0);
	}
	return 1;
}

//////////////////////////////
//===== General Staff ===/////
/////////////////////////////

CMD:revive(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 3) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] == 8)
	{
		new giveplayerid, str[128];
		if(sscanf(params, "i", giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /revive [playerid]");
		if(IsDead[giveplayerid] == 1)
		{
			KillTimer(LoseHPTimer[giveplayerid]);
			IsDead[giveplayerid] = 0;
			LoseHPTimer[giveplayerid] = 0;
			IsAfterLifing[giveplayerid] = 0;
			ClearAnimations(giveplayerid);
			format(str, sizeof(str), "You have revived %s", GetName(giveplayerid));
			SendClientMessage(playerid, -1, str);
			SendClientMessage(giveplayerid, -1, "You have been revived by an admin.");
			TogglePlayerControllable(giveplayerid, 1);
			SetCameraBehindPlayer(giveplayerid);
			KillTimer(AntiEMSTimer[giveplayerid]);
			SetPVarInt(giveplayerid, "Injured", 0);
			AES[giveplayerid] = 0;
		}
		else return SendClientMessage(playerid, COLOR_GREY, "That player is not dying.");
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	return 1;
}

CMD:release(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 3) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 1 || pInfo[playerid][pAdminLevel] == 8)
	{
		new giveplayerid, reason[126], str[126];
		if(sscanf(params, "us[126]", giveplayerid, reason)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /release [playerid/partofname] [reason]");
		if(pInfo[giveplayerid][pJail] < 1) return SendClientMessage(playerid, COLOR_GREY, "The specified player is not in jail.");
		SetPlayerPos(giveplayerid, 1862.2820,-1702.5566,5202.5859);
		SetPlayerInterior(giveplayerid, 5);
		SetPlayerVirtualWorld(giveplayerid, 0);
		FreezePlayer(giveplayerid, 3);
		SetPVarInt(giveplayerid, "Cuffed", 0);
		pInfo[giveplayerid][pJail] = 0;
		ResetPlayerWeapons(giveplayerid);
		GameTextForPlayer(giveplayerid, "Released.", 5000, 3);
		KillTimer(rtimer[giveplayerid]);
		SendClientMessage(giveplayerid, COLOR_CYAN, "You have been released from prison by an admin.");
		format(str, 126, "AdmCmd: %s was released from prison by %s. Reason: %s.", GetName(giveplayerid), GetName(playerid), reason);
		SendClientMessageToAll(COLOR_LIGHTRED, str);
		SetPlayerColor(giveplayerid, 0xFFFFFF00);
		Log("/logs/prison.txt", str);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
	return 1;
}

CMD:veh(playerid, params[])
{
    if(pInfo[playerid][pAdminLevel] < 3) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
    if(!GetPVarInt(playerid, "AdminDuty") && pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use the commands.");
    new carid, col1, col2;
    if(sscanf(params, "iI(0)I(0)", carid, col1, col2)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /veh [ID] [COL1] [COL2]");
    if(!(400 <= carid <= 611)) return SendClientMessage(playerid, COLOR_GREY, "Vehicle number can't be below 400 or above 611!");
    if(!((0 <= col1 <= 256) && (0 <= col2 <= 256))) return SendClientMessage(playerid, COLOR_GREY, "Color number can't be below 0 or above 256!");
    new free = -1;
    for(new i = 0; i < MAX_ADMIN_CARS; i++)
    {
        if(AdminCars[i][0] != INVALID_VEHICLE_ID)
        {
            if(AdminCars[i][1] == playerid && pInfo[playerid][pAdminLevel] < 8)
            {
                free = -1;
                break;
            }
            continue;
        }
        free = i;
        break;
    }
    if(free == -1) return SendClientMessage(playerid, COLOR_GREY, "You must use /vehdestroy because you have reached the maximum Admin cars.");
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    AdminCars[free][0] = CreateVehicle(carid, X + 2, Y + 2, Z + 1, 0.0, col1, col2, 60000);
    AdminCars[free][1] = playerid;
    gVehicleFuel[AdminCars[free][0]] = 100;
    carcount++;
	SetVehicleVirtualWorld(AdminCars[free][0], GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(AdminCars[free][0], GetPlayerInterior(playerid));
    new string[50];
    format(string, sizeof(string), "Vehicle %d spawned. Total of %d cars spawned.", AdminCars[free][0], carcount);
    SendClientMessage(playerid, COLOR_GREY, string);
    return 1;
}

CMD:teleport(playerid, params[])
{
	new giveplayerid, choice[32];
	if(pInfo[playerid][pAdminLevel] < 3) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty as an admin");
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specifed.");
	if(sscanf(params, "ds", giveplayerid, choice))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /teleport [playerid] [choice]");
		SendClientMessage(playerid, -1, "Choices: CT | JB | DB | Allsaints | Gym | Trucker");
		return 1;
	}
	if(strcmp(choice, "ct", true) == 0)
	{
		if(IsPlayerInAnyVehicle(giveplayerid))
		{
			SetPlayerPos(giveplayerid, 1529.58, -1687, 13.37);
			new veh = GetPlayerVehicleID(giveplayerid);
			SetVehiclePos(veh, 1529.58, -1687, 13.37);
			PutPlayerInVehicle(giveplayerid, veh, 0);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
			SetPlayerArmedWeapon(giveplayerid,0);
		}
		else
		{
			SetPlayerPos(giveplayerid, 1529.58, -1687, 13.37);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
		}
	}
	if(strcmp(choice, "jb", true) == 0)
	{
		if(IsPlayerInAnyVehicle(giveplayerid))
		{
			SetPlayerPos(giveplayerid, 1692.95, 1442.26, 10.76);
			new veh = GetPlayerVehicleID(giveplayerid);
			SetVehiclePos(veh, 1692.95, 1442.26, 10.76);
			PutPlayerInVehicle(giveplayerid, veh, 0);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
			SetPlayerArmedWeapon(giveplayerid,0);
		}
		else
		{
			SetPlayerPos(giveplayerid, 1692.95, 1442.26, 10.76);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
		}
	}
	if(strcmp(choice, "db", true) == 0)
	{
		if(IsPlayerInAnyVehicle(giveplayerid))
		{
			SetPlayerPos(giveplayerid, -1410.49, -315.44, 14);
			new veh = GetPlayerVehicleID(giveplayerid);
			SetVehiclePos(veh, -1410.49, -315.44, 14);
			PutPlayerInVehicle(giveplayerid, veh, 0);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
			SetPlayerArmedWeapon(giveplayerid,0);
		}
		else
		{
			SetPlayerPos(giveplayerid, -1410.49, -315.44, 14);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
		}
	}
	if(strcmp(choice, "allsaints", true) == 0)
	{
		if(IsPlayerInAnyVehicle(giveplayerid))
		{
			SetPlayerPos(giveplayerid, 1187.06, -1318.26, 13.57);
			new veh = GetPlayerVehicleID(giveplayerid);
			SetVehiclePos(veh, 1187.06, -1318.26, 13.57);
			PutPlayerInVehicle(giveplayerid, veh, 0);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
			SetPlayerArmedWeapon(giveplayerid,0);
		}
		else
		{
			SetPlayerPos(giveplayerid, 1187.06, -1318.26, 13.57);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
		}
	}
	if(strcmp(choice, "gym", true) == 0)
	{
		if(IsPlayerInAnyVehicle(giveplayerid))
		{
			SetPlayerInterior(giveplayerid, 0);
			new veh = GetPlayerVehicleID(giveplayerid);
			SetVehiclePos(veh, 2223.96, -1717.37, 13.51);
			PutPlayerInVehicle(giveplayerid, veh, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
			SetPlayerPos(giveplayerid, 2223.96, -1717.37, 13.51);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
			SetPlayerArmedWeapon(giveplayerid,0);
		}
		else
		{
			SetPlayerPos(giveplayerid, 2223.96, -1717.37, 13.51);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
		}
	}
	if(strcmp(choice, "trucker", true) == 0)
	{
		if(IsPlayerInAnyVehicle(giveplayerid))
		{
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
			SetPlayerPos(giveplayerid, 2446.9150, -2118.4492, 13.1525);
			new veh = GetPlayerVehicleID(giveplayerid);
			SetVehiclePos(veh, 2446.9150, -2118.4492, 13.1525);
			PutPlayerInVehicle(giveplayerid, veh, 0);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
			SetPlayerArmedWeapon(giveplayerid,0);
		}
		else
		{
			SetPlayerPos(giveplayerid, 2446.9150, -2118.4492, 13.1525);
			SendClientMessage(giveplayerid, -1, "You have been teleported.");
			SendClientMessage(playerid, -1, "Player has been teleported.");
			SetPlayerInterior(giveplayerid, 0);
			SetPlayerVirtualWorld(giveplayerid, 0);
		}
	}
	return 1;
}

CMD:gethere(playerid, params[])
{
	new giveplayerid;
	if(pInfo[playerid][pAdminLevel] < 3) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty as an admin");
	if(pInfo[playerid][pAdminLevel] < pInfo[giveplayerid][pAdminLevel]) return SendClientMessage(playerid, COLOR_GREY, "You can't do this on a higher level administrator.");
	new Float:gotoX, Float:gotoY, Float:gotoZ;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, -1, "USAGE: /gethere [playerid/partofname]");
	if(pInfo[playerid][pAdminLevel] < pInfo[giveplayerid][pAdminLevel]) return SendClientMessage(playerid, COLOR_GREY, "You can't do this on a higher level administrator.");
	GetPlayerPos(playerid, gotoX, gotoY, gotoZ);
	SetPlayerVirtualWorld(giveplayerid, GetPlayerVirtualWorld(playerid));
	SetPlayerInterior(giveplayerid, GetPlayerInterior(playerid));
	SetPlayerPos(giveplayerid, gotoX, gotoY, gotoZ);
	SendClientMessage(giveplayerid, -1, "You have been teleported.");
	return 1;
}

CMD:afine(playerid, params[])
{
	new str[128], amount, id, reason[56];
	if(pInfo[playerid][pAdminLevel] < 3) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty as an admin");
	if(sscanf(params, "uis[56]", id, amount, reason)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /afine [playerid] [amount] [reason]");
	if(pInfo[playerid][pAdminLevel] < pInfo[id][pAdminLevel]) return SendClientMessage(playerid, COLOR_GREY, "You can't do this on a higher level administrator.");
	pInfo[id][pCash] -= amount;
	format(str, sizeof(str), "AdmCmd: %s was fined R%i Reason: %s", GetName(id), amount, reason);
	SendClientMessageToAll(COLOR_LIGHTRED, str);
	format(str, sizeof(str), "AdmCmd: %s was fined R%i by %s Reason: %s", GetName(id), amount, GetName(playerid), reason);
	Log("/logs/bans.txt", str);
	return 1;
}

//////////////////////////////
//===== Senior Staff ===//////
/////////////////////////////

CMD:vehdestroy(playerid, params[])
{
    if(pInfo[playerid][pAdminLevel] < 5) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
    if(!GetPVarInt(playerid, "AdminDuty") && pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use that command.");
    for(new i = 0; i < MAX_ADMIN_CARS; i++)
    {
		if(AdminCars[i][0] == INVALID_VEHICLE_ID) continue;
		DestroyVehicle(AdminCars[i][0]);
		AdminCars[i][0] = INVALID_VEHICLE_ID;
		AdminCars[i][1] = INVALID_PLAYER_ID;
		carcount--;
    }
    SendClientMessage(playerid, COLOR_GREY, "All admin cars have been removed.");
    return 1;
}

CMD:ban(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 4) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You need to be on admin duty to use that command.");
	new id, Query[500], string[150], reason[28], IP[16];
	if(sscanf(params, "us[28]", id, reason)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /ban [playerid] [reason]");
	GetPlayerIp(playerid, IP, sizeof(IP));
	strcat(Query,"INSERT INTO `bans`(`Name`,`Reason`, `BannedBy`, `IpAddress`,`Status`)");
	strcat(Query," VALUES ('%s', '%s', '%s', '%s', 1)");
	mysql_format(dbHandle, Query, sizeof(Query), Query, pName(id), reason, pName(playerid), IP);
	mysql_query(dbHandle, Query, false);
	Checkban(id);
	format(string, sizeof(string), "ADMCMD: %s has been banned by %s. Reason: %s", GetName(id), GetName(playerid), reason);
	SendClientMessageToAll(COLOR_LIGHTRED, string);
	Log("/logs/bans.txt", string);
	Kick(id);
	return 1;
}

CMD:goto(playerid, params[])
{
	new choice[32];
	if(pInfo[playerid][pAdminLevel] < 4) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this command.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] > 8) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty as an admin");
	if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /goto [choice]");
		SendClientMessage(playerid, COLOR_GREY, "Choices: CT | JB | DB | Allsaints | Gym | Trucker | Prison");
		return 1;
	}
	if(strcmp(choice, "ct", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid)) 
		{
			new veh = GetPlayerVehicleID(playerid);
			SetPlayerPos(playerid, 1529.58, -1687, 13.37);
			SetVehiclePos(veh, 1529.58, -1687, 13.37); 
			PutPlayerInVehicle(playerid, veh, 0); 
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerArmedWeapon(playerid,0);
			pInfo[playerid][pInt] = 0;
		}
		else
		{
			SetPlayerPos(playerid, 1529.58, -1687, 13.37); 
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			pInfo[playerid][pInt] = 0;
		}	
	}	
	else if(strcmp(choice, "jb", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid)) 
		{
			new veh = GetPlayerVehicleID(playerid);
			SetPlayerPos(playerid, 1692.95, 1442.26, 10.76);
			SetVehiclePos(veh, 1692.95, 1442.26, 10.76); 
			PutPlayerInVehicle(playerid, veh, 0); 
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerArmedWeapon(playerid,0);
			pInfo[playerid][pInt] = 0;
		}
		else
		{
			SetPlayerPos(playerid, 1692.95, 1442.26, 10.76); 
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			pInfo[playerid][pInt] = 0;
		}
	}
	else if(strcmp(choice, "db", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new veh = GetPlayerVehicleID(playerid);
			SetPlayerPos(playerid, -1410.49, -315.44, 14);
			SetVehiclePos(veh, -1410.49, -315.44, 14); 
			PutPlayerInVehicle(playerid, veh, 0); 
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerArmedWeapon(playerid,0);
			pInfo[playerid][pInt] = 0;
		}
		else
		{
			SetPlayerPos(playerid, -1410.49, -315.44, 14); 
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			pInfo[playerid][pInt] = 0;
		}	
	}
	else if(strcmp(choice, "allsaints", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new veh = GetPlayerVehicleID(playerid);
			SetPlayerPos(playerid, 1187.06, -1318.26, 13.57);
			SetVehiclePos(veh, 1187.06, -1318.26, 13.57); 
			PutPlayerInVehicle(playerid, veh, 0); 
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerArmedWeapon(playerid,0);
			pInfo[playerid][pInt] = 0;
		}
		else
		{
			SetPlayerPos(playerid, 1187.06, -1318.26, 13.57); 
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			pInfo[playerid][pInt] = 0;
		}	
	}
	else if(strcmp(choice, "gym", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new veh = GetPlayerVehicleID(playerid);
			SetPlayerInterior(playerid, 0);
			SetVehiclePos(veh, 2223.96, -1717.37, 13.51); 
			PutPlayerInVehicle(playerid, veh, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 2223.96, -1717.37, 13.51);
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerArmedWeapon(playerid,0);
			pInfo[playerid][pInt] = 0;
		}
		else
		{
			SetPlayerPos(playerid, 2223.96, -1717.37, 13.51); 
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			pInfo[playerid][pInt] = 0;
		}	
	}
	else if(strcmp(choice, "trucker", true) == 0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new veh = GetPlayerVehicleID(playerid);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 2446.9150, -2118.4492, 13.1525);
			SetVehiclePos(veh, 2446.9150, -2118.4492, 13.1525); 
			PutPlayerInVehicle(playerid, veh, 0);
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerArmedWeapon(playerid,0);
			pInfo[playerid][pInt] = 0;
		}
		else
		{
			SetPlayerPos(playerid, 2446.9150, -2118.4492, 13.1525); 
			SendClientMessage(playerid, -1, "You have been teleported.");
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			pInfo[playerid][pInt] = 0;
		}	
	}
	else if(strcmp(choice, "prison", true) == 0)
	{
		SetPlayerPos(playerid, 1849.32995605,-1714.31005859,5201.54003906);
		SendClientMessage(playerid, -1, "You have been teleported.");
		SetPlayerInterior(playerid, 5);
		SetPlayerVirtualWorld(playerid, 0);
		pInfo[playerid][pInt] = 0;
	}
	else
	{
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /goto [choice]");
		SendClientMessage(playerid, COLOR_GREY, "Choices: LA | LV | SF | Allsaints | Gym | Trucker | Prison");
		return 1;
	}
	return 1;
}

CMD:gotoid(playerid, params[])
{
	new giveplayerid;
	if(pInfo[playerid][pAdminLevel] < 4) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] > 8) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty as an admin");
	new Float:gotoX, Float:gotoY, Float:gotoZ;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessage(playerid, -1, "USAGE: /gotoid [playerid/partofname]");
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Invalid player specifed.");
	GetPlayerPos(giveplayerid, gotoX, gotoY, gotoZ);
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(giveplayerid));
	SetPlayerInterior(playerid, GetPlayerInterior(giveplayerid));
	SetPlayerPos(playerid, gotoX, gotoY, gotoZ);
	SendClientMessage(playerid, -1, "You have been teleported.");
	return 1;
}

CMD:gotox(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 4) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	new Float: X, Float: Y, Float: Z;
	new int;
	if(sscanf(params, "fffi(1)", X, Y, Z, int)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /gotox [x] [y] [z] [int]");
	SetPlayerPos(playerid, X, Y, Z);
	SetPlayerInterior(playerid, int);
	SendClientMessage(playerid, -1, "You have been teleported.");
	return 1;
}

CMD:rac(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] <= 4) return SendClientMessage(playerid, COLOR_RED, "You are not admin!");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] > 8) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty as an admin");
	new bool:vehicleused[MAX_VEHICLES];
	Save_Vehicles();
	new vehspawn = 0;
	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
			vehicleused[GetPlayerVehicleID(i)] = true;
		}
	}
	for(new i=1; i < MAX_VEHICLES; i++)
	{
		if(!vehicleused[i])
		{
			new vid = GetVehicleID(i);
			if(vInfo[vid][vOwner] != 0)
			{
				if(vehspawn == 0)
				{
					Destroy_DealershipVehicles();
					Load_DealershipVehicles();
					vehspawn = 1;
				}
				Respawn_PlayerVehicle(i);
			}
			else
			{
				SetVehicleToRespawn(i);
			}
		}
	}
	SendClientMessageToAll(COLOR_YELLOW, "An admin has respawned all unused vehicles");
	return 1;
}

CMD:givemoney(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 4) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty as an admin");
	new str[128], giveplayerid, amount;
	if(sscanf(params, "ud", giveplayerid, amount)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /givemoney [playerid] [amount]");
	if(giveplayerid == INVALID_PLAYER_ID || giveplayerid == playerid) return SendClientMessage(playerid, COLOR_GREY, "Invalid player.");
	pInfo[giveplayerid][pCash] += amount;
	format(str, sizeof(str), "You have given %s R%d.", GetName(giveplayerid), amount);
	
	format(str, sizeof(str), "You have given %s R%d.", GetName(giveplayerid), amount);
	
	SendClientMessage(playerid, -1, str);
	format(str, sizeof(str), "You have been given R%d from an admin.", amount);
	SendClientMessage(giveplayerid, -1, str);
	format(str, sizeof(str), "%s has given %s R%d.", GetName(playerid), GetName(giveplayerid), amount);
	Log("/logs/acommands.txt", str);
	return 1;
}

//////////////////////////////
//===== Supervisor ===///////
/////////////////////////////

CMD:set(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] <= 5) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] > 8) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty as an admin");
	new id, string[56], choice[12], amount;
	if(sscanf(params, "is[56]i", id, choice, amount))
	{	
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /set [playerid] [choice] [amount]");
		SendClientMessage(playerid, COLOR_GREY, "CHOICES: health | armour | money | skin | material | vw");
		return 1;
	}
	if(strcmp(choice, "health", true) == 0)
	{
		SetPlayerHealth(id, amount);
		format(string, sizeof(string), "You have set %s health to %i", GetName(id), amount);
		SendClientMessage(playerid, -1, string);
		SendClientMessage(id, COLOR_ORANGE, "An admin has reset your health");
		format(string, sizeof(string), "%s has set %s health to %i", GetName(playerid), GetName(id), amount);
		Log("/logs/acommands.txt", string);
		return 1;
	}
	if(strcmp(choice, "armour", true) == 0)
	{
		SetPlayerArmour(id, amount);
		format(string, sizeof(string), "You have set %s armour to %i", GetName(id), amount);
		SendClientMessage(playerid, -1, string);
		SendClientMessage(id, COLOR_ORANGE, "An admin has reset your armour");
		format(string, sizeof(string), "%s has set %s armour to %i", GetName(playerid), GetName(id), amount);
		Log("/logs/acommands.txt", string);
		return 1;
	}
	if(strcmp(choice, "money", true) == 0)
	{
		pInfo[id][pCash] = amount;
		format(string, sizeof(string), "You have set %s money to R%i", GetName(id), amount);
		SendClientMessage(playerid, -1, string);
		SendClientMessage(id, COLOR_ORANGE, "An admin has reset your money");
		format(string, sizeof(string), "%s has set %s money to R%i", GetName(playerid), GetName(id), amount);
		Log("/logs/acommands.txt", string);
		return 1;
	}
	if(strcmp(choice, "skin", true) == 0)
	{
		if(amount <= 0 || amount >= 299) return SendClientMessage(playerid, COLOR_GREY, "Invalid Skin");
		pInfo[id][pSkin] = amount;
		SetPlayerSkin(id, amount);
		format(string, sizeof(string), "You have set %s skin to %i", GetName(id), amount);
		SendClientMessage(playerid, -1, string);
		SendClientMessage(id, COLOR_ORANGE, "An admin has reset your skin");
		format(string, sizeof(string), "%s has set %s skin to %i", GetName(playerid), GetName(id), amount);
		Log("/logs/acommands.txt", string);
		return 1;
	}
	if(strcmp(choice, "material", true) == 0)
	{
		pInfo[id][pMats] = amount;
		format(string, sizeof(string), "You have set %s materials to %i", GetName(id), amount);
		SendClientMessage(playerid, -1, string);
		SendClientMessage(id, COLOR_ORANGE, "An admin has reset your materials");
		format(string, sizeof(string), "%s has set %s materials to %i", GetName(playerid), GetName(id), amount);
		Log("/logs/acommands.txt", string);
		return 1;
	}
	if(strcmp(choice, "vw", true) == 0)
	{
		pInfo[id][pVW] = amount;
		SetPlayerVirtualWorld(id, amount);
		SendClientMessage(id, COLOR_ORANGE, "An admin has set your virtual world");
		format(string, sizeof(string), "%s has set %s virtual world to %i", GetName(playerid), GetName(id), amount);
		Log("/logs/acommands.txt", string);
	}
	return 1;
}

CMD:unban(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 5) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] > 8) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty as an admin");
	new name[24], Query[512], string[128];
	if(sscanf(params, "s[24]", name)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /unban [NAME]");
	mysql_format(dbHandle,Query, sizeof(Query), "DELETE FROM `bans` WHERE `Name` = '%s'", name);
	mysql_query(dbHandle,Query);
	format(string, sizeof(string), "You have unbanned %s", name);
	SendClientMessage(playerid, COLOR_RED, string);
	format(string, sizeof(string), "%s has unbanned %s", GetName(playerid), name);
	Log("/logs/unbans.txt", string);
	return 1;
}

CMD:enableooc(playerid, params[])
{
	new str[56];
	if(pInfo[playerid][pAdminLevel] < 5) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	if(OOCChannel == 1)
	{
		OOCChannel = 0;
		SendClientMessageToAll(COLOR_CYAN, "OOC chat channel closed");
		format(str, sizeof(str), "Admin %s closed the OOC chat channel", GetName(playerid));
		SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
	}
	else
	{
		OOCChannel = 1;
		SendClientMessageToAll(COLOR_CYAN, "OOC chat channel open");
		format(str, sizeof(str), "Admin %s opened the OOC chat channel", GetName(playerid));
		SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
	}
	return 1;
}
CMD:disableooc(playerid, params[]) return cmd_enableooc(playerid, params);

CMD:givegun(playerid, params[])
{
	new str[58];
	new giveplayerid, gun;
	if(pInfo[playerid][pAdminLevel] < 5) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this command.");
	if(GetPVarInt(playerid, "AdminDuty") == 0 && pInfo[playerid][pAdminLevel] > 8) return SendClientMessage(playerid, COLOR_GREY, "You are not on duty as an admin");
	if(sscanf(params, "ui", giveplayerid, gun)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /givegun [playerid] [weaponid]");
	format(str, sizeof(str), "You gave %s a gun", GetName(giveplayerid));
	SendClientMessage(playerid, -1, str);
	SendClientMessage(giveplayerid, -1, "An admin gave you a gun");
	GivePlayerValidWeapon(giveplayerid, gun, 999999);
	return 1;
}

////////////////////////////////
//===== Shift Manager ===///////
////////////////////////////////

CMD:mole(playerid, params[])
{
	new text[56], str[62];
	if(pInfo[playerid][pAdminLevel] < 6) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	if(sscanf(params, "s[56]", text)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /mole [text]");
	format(str, sizeof(str), "SMS: %s, Sender: Mole (555)", text);
	SendClientMessageToAll(COLOR_YELLOW, str);
	format(str, sizeof(str), "Mole %s: %s", GetName(playerid), text);
	Log("/logs/acommands.txt", str);
	return 1;
}

/////////////////////////////////
//===== Operations Manager ===///
////////////////////////////////

CMD:setfac(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 7) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	new id, str[56], fac, rank;
	if(sscanf(params, "iii", id, fac, rank)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /setfac [playerid] [faction id] [faction rank]");
	pInfo[id][pFaction] = fac;
	pInfo[id][pFacRank] = rank;
	format(str, sizeof(str), "You have set %s faction to %s. Rank: %s", GetName(id), GetFacName(id), GetRankName(id));
	SendClientMessage(playerid, -1, str);
	SendClientMessage(id, -1, "An admin has set your faction");
	format(str, sizeof(str), "%s has set %s faction to %s and rank %s",GetName(playerid), GetName(id), GetFacName(id), GetRankName(id));
	Log("/logs/setfaction.txt", str);
	return 1;
}

CMD:setfacrank(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 7) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this commad.");
	new id, str[56], rank;
	if(sscanf(params, "ii", id, rank)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /setfac [playerid] [faction rank]");
	pInfo[id][pFacRank] = rank;
	format(str, sizeof(str), "You have set %s faction rank to %s", GetName(id), GetRankName(id));
	SendClientMessage(playerid, -1, str);
	SendClientMessage(id, -1, "An admin has set your faction");
	format(str, sizeof(str), "%s has set %s faction rank to %s",GetName(playerid), GetName(id), GetRankName(id));
	Log("/logs/setfaction.txt", str);
	return 1;
}

CMD:explode(playerid, params[])
{
	new choice[38];
	if(pInfo[playerid][pAdminLevel] < 7) return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this command.");
    if(sscanf(params, "s[32]", choice))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /explode [choice]");
		SendClientMessage(playerid, -1, "Choices: Idlewood, ");
		return 1;
	}
	if(strcmp(choice, "Idlewood", true) == 0)
	{
		CreateExplosion(1938.1843,-1775.6530,13.1118, 1, 20.0);
		CreateExplosion(1937.1843,-1774.6530,13.1118, 1, 20.0);
	    CreateExplosion(1939.1843,-1774.6530,13.1118, 1, 20.0);
	    CreateExplosion(1938.1843,-1773.6530,13.1118, 1, 20.0);
	    CreateExplosion(1938.1843,-1774.6530,13.1118, 7, 20.0);
		Explotions = 0;
	    ExplotionTimer = SetTimer("ExplodeIdle1", 1000, 1);
	}
	return 1;
}

//////////////////////////////
//===== Server Director ===///
/////////////////////////////

CMD:makeadmin(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new id, level, str[128];
	if(sscanf(params, "ui", id, level)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /makeadmin [ID] [LEVEL]");
	pInfo[id][pAdminLevel] = level;
	if(level == 0)
	{
		format(str, sizeof(str), "%s has been removed from the admin team by %s", GetName(id), GetAdminName(id), GetName(playerid));
		SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
		Log("/logs/newadmins.txt", str);
		return 1;
	}
	format(str, sizeof(str), "You have been promoted to %s.", GetAdminName(id));
	SendClientMessage(id, COLOR_ORANGE, str);
	format(str, sizeof(str), "%s has been promoted to %s.", GetName(id), GetAdminName(id));
	SendClientMessageToAdmins(COLOR_ORANGE, str, 1);
	format(str, sizeof(str), "%s has been promoted to %s by %s", GetName(id), GetAdminName(id), GetName(playerid));
	Log("/logs/newadmins.txt", str);
	return 1;
}

CMD:restart(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	CountDown = 30;
	SetTimer("serverrestart", 1000, true);
	return 1;
}

CMD:announcerace(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(EventOpen == 1) return SendClientMessage(playerid, COLOR_GREY, "There is already a race open.");
	new track[24], lap, veh, str[128];
	if(sscanf(params, "s[24]ii", track, lap, veh))
	{
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /announcerace [track] [laps] [vehicle]");
		SendClientMessage(playerid, COLOR_GREY, "=============Tracks=============");
		SendClientMessage(playerid, COLOR_GREY, "Dillimore | Montgomery | GokartSF");
		return 1;
	}
	if(veh < 400 || veh > 609) return SendClientMessage(playerid, COLOR_GREY, "Vehicle ID between 400-600");
	if(strcmp(track, "dillimore", true) == 0)
	{
		LoadTrack_Dillimore();
		EventOpen = 1;
		RaceTrack = 1;
		RaceLaps = lap;
		RaceVehicle = veh;
		format(str, sizeof(str), "A race event has been announced by Admin %s, type /joinrace to participate.", GetName(playerid));
		SendClientMessageToAll(COLOR_YELLOW, str);
	}
	else if(strcmp(track, "montgomery", true) == 0)
	{
		LoadTrack_Montgomery();
		EventOpen = 1;
		RaceTrack = 2;
		RaceLaps = lap;
		RaceVehicle = veh;
		format(str, sizeof(str), "A race event has been announced by Admin %s, type /joinrace to participate.", GetName(playerid));
		SendClientMessageToAll(COLOR_YELLOW, str);
	}
	else if(strcmp(track, "gokartsf", true) == 0)
	{
		LoadTrack_GoKartSF();
		EventOpen = 1;
		RaceTrack = 3;
		RaceLaps = lap;
		RaceVehicle = veh;
		format(str, sizeof(str), "A race event has been announced by Admin %s, type /joinrace to participate.", GetName(playerid));
		SendClientMessageToAll(COLOR_YELLOW, str);
	}
	return 1;
}

CMD:startrace(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(EventOpen == 1)
	{
		EventOpen = 0;
		countdown = 15;
		RaceStartTimer = SetTimerEx("RaceCountDown", 1000, true, "i", playerid);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "There is no race to start");
	return 1;
}

CMD:endrace(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	EventOpen = 0;
	if(RaceTrack == 1)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(InRace[i] != 0)
			{
				InRace[i] = 0;
				SetPVarInt(playerid, "InRace", 0);
				DisablePlayerRaceCheckpoint(i);
				DestroyVehicle(rInfo[i][rVehicleID]);
				SetPlayerPos(i, BeforeRaceX[i], BeforeRaceY[i], BeforeRaceZ[i]);
				SetPlayerVirtualWorld(i, 0);
				PlayerTextDrawHide(i, rLapCount[i]);
				SendClientMessage(i, COLOR_YELLOW, "The race is over. Thanks for participating");
			}
		}
		RemoveTrack_Dillimore();
	}
	else if(RaceTrack == 2)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(InRace[i] != 0)
			{
				InRace[i] = 0;
				DisablePlayerRaceCheckpoint(i);
				DestroyVehicle(rInfo[i][rVehicleID]);
				SetPlayerPos(i, BeforeRaceX[i], BeforeRaceY[i], BeforeRaceZ[i]);
				SetPlayerVirtualWorld(i, 0);
				PlayerTextDrawHide(i, rLapCount[i]);
			}
		}
		RemoveTrack_Montgomery();
	}
	else if(RaceTrack == 3)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(InRace[i] != 0)
			{
				InRace[i] = 0;
				DisablePlayerRaceCheckpoint(i);
				DestroyVehicle(rInfo[i][rVehicleID]);
				SetPlayerPos(i, BeforeRaceX[i], BeforeRaceY[i], BeforeRaceZ[i]);
				SetPlayerVirtualWorld(i, 0);
				PlayerTextDrawHide(i, rLapCount[i]);
			}
		}
		RemoveTrack_GoKartSF1();
	}
	return 1;
}

////////////////////
//===== RCon ===///
///////////////////

CMD:createdveh(playerid, params[])
{	
	new ID, Col1, Col2, Query[512], price;
	new Float: pX, Float: pY, Float: pZ, Float: pA;
	if(pInfo[playerid][pAdminLevel] < 8) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(sscanf(params, "iiii", ID, price, Col1, Col2)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /createdvehicle [ID] [PRICE] [COLOR] [COLOR]");
	GetPlayerPos(playerid, pX, pY, pZ);
	GetPlayerFacingAngle(playerid, pA);
	strcat(Query,"INSERT INTO `dvehicles`(`ID`,`Dealer`,`Owner`, `Model`, `Price`,`PosX`,`PosY`,`PosZ`, `PosA`, `Color1`, `Color2`)");
	strcat(Query," VALUES (NULL, 1, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%d', '%d')");
	mysql_format(dbHandle, Query, sizeof(Query), Query, DEFAULT_VEHICLE_OWNER, ID, price, pX, pY, pZ, pA, Col1, Col2);
	mysql_query(dbHandle, Query, false);
	SendClientMessage(playerid, COLOR_ORANGE, "Dealership car created successfully.");
	//AddStaticVehicleEx(ID, pX, pY, pZ, pA, Col1, Col2, 60000);	
	Destroy_DealershipVehicles();
	Load_DealershipVehicles();
	return 1;
}

CMD:editv(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new caption[126], info[256], str[256];
		new id = GetVehicleID(GetPlayerVehicleID(playerid));
		SetPVarInt(playerid, "DialogValue1", id);
		
		format(caption, sizeof(caption), "Edit Vehicle: %d", vInfo[id][vID]);
		format(str, sizeof(str), "Owner:    %s \nModel:    %d \nPrice:    %d\n", vInfo[id][vOwner], vInfo[id][vModel], vInfo[id][vPrice]);
		strcat(info, str, sizeof(info));
		
		ShowPlayerDialog(playerid, DIALOG_VEDIT, DIALOG_STYLE_LIST, caption, info, "Ok", "Close");
	}
	else SendClientMessage(playerid, COLOR_GREY, "You are not in a vehicle!");
	return 1;
}

CMD:vdelete(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new id = GetVehicleID(GetPlayerVehicleID(playerid));
		SetPVarInt(playerid, "VehicleID", id);
		ShowPlayerDialog(playerid, DIALOG_VDELETE, DIALOG_STYLE_MSGBOX, "Delete this vehicle?", "Are you sure you want \nto delete this vehicle?", "Yes", "No");
	}
	else SendClientMessage(playerid, COLOR_GREY, "You are not in a vehicle!");
	return 1;
}

CMD:createfstation(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new Query[358];
	new Float: pX, Float: pY, Float: pZ;
	GetPlayerPos(playerid, pX, pY, pZ);
	strcat(Query,"INSERT INTO `fuelstations`(`ID`,`PosX`, `PosY`, `PosZ`)");
	strcat(Query," VALUES (NULL, '%f', '%f', '%f')");
	mysql_format(dbHandle, Query, sizeof(Query), Query, pX, pY, pZ);
	mysql_query(dbHandle, Query, false);
	Destroy_FuelStation();
	Load_FuelStations();
	SendClientMessage(playerid, COLOR_GREY, "You have just created a fuel station.");
	return 1;
}

CMD:doorcreate(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new Query[500], Name[32], pickup, doorid = 0, str[25], rows, fields, rand;
	if(sscanf(params, "s[32]i", Name, pickup)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /doorcreate [name] [pickup id]");
	rand = random(10000)+1;
	strcat(Query,"INSERT INTO `doors`(`ID`, `Name`, `PickupID`, `VW`)");
	strcat(Query," VALUES (NULL, '%s', '%d', '%i')");
	mysql_format(dbHandle, Query, sizeof(Query), Query, Name, pickup, rand);
	mysql_query(dbHandle, Query, false);
	for(new i = 0; i<= MAX_DOORS; i++)
	{
		mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `Doors` WHERE `ID` = '%d'", i);
		mysql_query(dbHandle,Query);
		cache_get_data(rows, fields);
		if(rows)
		{
			doorid = i;
		}
	}
	format(str, sizeof(str), "Door Created ID: %i", doorid);
	SendClientMessage(playerid, COLOR_GREY, str);
	return 1;
}

CMD:dooredit(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new string[128], choice[32], doorid, Query[500], amount;
	
	new Float: pX, Float: pY, Float: pZ, Float: fangle;
	
	if(sscanf(params, "s[32]dD(1)", choice, doorid, amount))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /dooredit [name] [doorid] [amount]");
		SendClientMessage(playerid, COLOR_GREY, "Names: Exterior | Interior | Pickup");
	}
	else if(strcmp(choice, "exterior", true) == 0)
	{
		GetPlayerPos(playerid, pX, pY, pZ);
		GetPlayerFacingAngle(playerid, fangle);
		
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `doors` SET `ExtX` = '%f', `ExtY` = '%f', `ExtZ` = '%f', `FacingAngle` = '%f' WHERE `ID` = '%d'",
		pX,
		pY,
		pZ,
		fangle,
		doorid);
		mysql_query(dbHandle,Query,false);
		format(string, sizeof(string), "You have changed the exterior of door ID: %d", doorid);
		SendClientMessage(playerid, COLOR_GREY, string);
	}
	else if(strcmp(choice, "interior", true) == 0)
	{
		GetPlayerPos(playerid, pX, pY, pZ);
		GetPlayerFacingAngle(playerid, fangle);
		new Int = GetPlayerInterior(playerid);
		new VW = random(5000) + 1500;
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `doors` SET `IntX` = '%f', `IntY` = '%f', `IntZ` = '%f', `IFacingAngle` = '%f', `Interior` = '%d', `VW` = '%d' WHERE `ID` = '%d'",
		pX,
		pY,
		pZ,
		fangle,
		Int,
		VW,
		doorid);
		mysql_query(dbHandle,Query,false);
		format(string, sizeof(string), "You have changed the interior of door ID: %d", doorid);
		SendClientMessage(playerid, COLOR_GREY, string);
	}
	else if(strcmp(choice, "pickup", true) == 0)
	{
		mysql_format(dbHandle,Query, sizeof(Query), "UPDATE `doors` SET `PickupID` '%d' WHERE `ID` = '%d'",
		amount,
		doorid);
		mysql_query(dbHandle,Query,false);
		format(string, sizeof(string), "You have changed the pickup id of door ID: %d", doorid);
		SendClientMessage(playerid, COLOR_GREY, string);
	}
	Destroy_DynamicDoor(doorid);
	Load_DynamicDoor(doorid);
	return 1;
}

CMD:doorname(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new doorid, str[128];
	if(sscanf(params, "d", doorid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /doorname [door id]");
	format(str, sizeof(str), "Door name: %s", dInfo[doorid][dName]);
	SendClientMessage(playerid, -1, str);
	return 1;
}

CMD:doornear(playerid, params[])
{
    if(IsPlayerAdmin(playerid))
	{
		new Float:X, Float:Y, Float:Z;
  		GetPlayerPos(playerid, X, Y, Z);
		for(new i;i<MAX_DOORS;i++)
		{
  			 if(IsPlayerInRangeOfPoint(playerid, 15, dInfo[i][dEPos][0], dInfo[i][dEPos][1], dInfo[i][dEPos][2]))
			{
				if(dInfo[i][dName] != 0)
				{
				    new string[128];
			    	format(string, sizeof(string), "Door ID %d | %f from you", i, GetDistance(dInfo[i][dEPos][0], dInfo[i][dEPos][1], dInfo[i][dEPos][2], X, Y, Z));
			    	SendClientMessage(playerid, COLOR_WHITE, string);
				}
			}
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GRAD2, "You're not authorized to use that command!");
	}
	return 1;
}

CMD:test(playerid, params[])
{
	new str[25];
	format(str, sizeof(str), "Max Houses: %i", MAX_HOUSES);
	SendClientMessage(playerid, COLOR_GREY, str);
	return 1;
}

CMD:housecreate(playerid, params[])
{
	new size[15], amount, int1, int2, int;
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command");
	if(sscanf(params, "s[15]dI(0)I(0)", size, amount, int1, int2))
	{
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /housecreate [size] [price] [Max Interior] [Minimum Interior]");
		SendClientMessage(playerid, COLOR_GREY, "Sizes: Tiny (1) | Small (5) | Medium (9) | Big (6)");
		return 1;
	}	
	if(strcmp(size, "tiny", true) == 0)
	{
		if(int1 == 0 && int2 == 0)
		{
			int = random(1)+1;
		}
		else
		{
			int = random(int1 -= 1)+int2;
		}
		Make_TinyHouse(playerid, amount, int);
	}
	else if(strcmp(size, "small", true) == 0)
	{
		if(int1 == 0 && int2 == 0)
		{
			int = random(4)+1;
		}
		else if(int1 == int2)
		{
			int = int1;
		}
		else
		{
			int = random(int1 -= 1)+int2;
			while(int > 5)
			{
				int = random(int1 -= 1)+int2;
			}
		}
		Make_SmallHouse(playerid, amount, int);		
	}
	else if(strcmp(size, "medium", true) == 0)
	{
		if(int1 == 0 && int2 == 0)
		{
			int = random(4)+1;
		}
		else if(int1 == int2)
		{
			int = int1;
		}
		else
		{
			int = random(int1 -= 1)+int2;
			while(int > 9)
			{
				int = random(int1 -= 1)+int2;
			}
		}
		Make_MediumHouse(playerid, amount, int);
	}
	else if(strcmp(size, "big", true) == 0)
	{
		if(int1 == 0 && int2 == 0)
		{
			int = random(4)+1;
		}
		else if(int1 == int2)
		{
			int = int1;
		}
		else
		{
			int = random(int1 -= 1)+int2;
			while(int > 6)
			{
				int = random(int1 -= 1)+int2;
			}
		}
		Make_BigHouse(playerid, amount, int);
	}
	return 1;
}

CMD:houseedit(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new str[125], choice[15], amount, hid;
	if(sscanf(params, "is[15]d", hid, choice, amount))
	{
		SendClientMessage(playerid, COLOR_GREY, "USAGE: /houseedit [houseid] [choice] [amount]");
		SendClientMessage(playerid, COLOR_GREY, "CHOICES: interior | price");
		return 1;
	}
	if(hInfo[hid][hID] != 0)
	{
		if(strcmp(choice, "interior", true) == 0)
		{
			Change_Interior(hid, amount);
			format(str, sizeof(str), "Edited house ID: %i", hid);
			SendClientMessage(playerid, COLOR_GREY, str);
		}
		else if(strcmp(choice, "price", true) == 0)
		{
			Change_Price(hid, amount);
			format(str, sizeof(str), "Edited house ID: %i", hid);
			SendClientMessage(playerid, COLOR_GREY, str);
		}
	}
	else return SendClientMessage(playerid, COLOR_GREY, "That house does not exist");
	return 1;
}

/*CMD:housecreate(playerid, params[])
{
	new Query[500], amount, level, rows, fields, houseid = 0, str[150], rand;
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	if(sscanf(params, "id", level, amount)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /housecreate [level] [price]");
	new Float: x, Float: y, Float: z;
	new Float: ix, Float: iy, Float: iz, Float: fac;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, fac);
	rand = random(2500)+10;
	if(level == 1)
	{		
		ix = 243.72; iy = 304.91; iz = 999.15;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 1, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 2)
	{
		ix = 2259.5205; iy = -1135.9044; iz = 1050.6328;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `FaceAngle`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%f', 10, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, "Server", level, amount, x, y, z, fac+180, ix+1, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
		{
			mysql_format(dbHandle,Query, sizeof(Query), "SELECT * FROM `Houses` WHERE `ID` = '%d'", i);
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 3)
	{
		ix = 266.50; iy = 304.90; iz = 999.15;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 2, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 4)
	{
		ix = 2218.40; iy = -1076.18; iz = 1050.48;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 1, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 5)
	{
		ix = 2233.64; iy = -1115.26; iz = 1051.00;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 5, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 6)
	{
		ix = -42.59; iy = 1405.47; iz = 1084.43;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 8, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 7)
	{
		ix = 2283.04; iy = -1140.28; iz = 1050.90;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 11, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 8)
	{
		ix = 223.20; iy = 1287.08; iz = 1082.14;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 1, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 9)
	{
		ix = 223.20; iy = 1287.08; iz = 1082.14;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 1, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 10)
	{
		ix = 260.85; iy = 1237.24; iz = 1084.26;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 9, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 11)
	{
		ix = -68.81; iy = 1351.21; iz = 1080.21;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 6, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 12)
	{
		ix = 261.12; iy = 1284.30; iz = 1080.26;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 4, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 13)
	{
		ix = 2237.59; iy = -1081.64; iz = 1049.02;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 2, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 14)
	{
		ix = 295.04; iy = 1472.26; iz = 1080.26;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 15, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 15)
	{
		ix = 235.34; iy = 1186.68; iz = 1080.26;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 3, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 16)
	{
		ix = 234.19; iy = 1063.73; iz = 1084.21;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 6, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 17)
	{
		ix = 225.68; iy = 1021.45; iz = 1084.02;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 7, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 18)
	{
		ix = 2324.53; iy = -1149.54; iz = 1050.71;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 12, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 19)
	{
		ix = 140.17; iy = 1366.07; iz = 1083.65;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 5, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else if(level == 20)
	{
		ix = 1267.663208; iy = -781.323242; iz = 1091.906250;
		strcat(Query,"INSERT INTO `houses`(`ID`, `Owner`, `Level`, `Price`,`PosX`,`PosY`,`PosZ`, `IPosX`, `IPosY`, `IPosZ`, `Interior`, `VirtualWorld`)");
		strcat(Query," VALUES (NULL, '%s', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', 5, '%i')");
		mysql_format(dbHandle, Query, sizeof(Query), Query, DEFUALT_HOUSE_OWNER, level, amount, x, y, z, ix, iy, iz, rand);
		mysql_query(dbHandle, Query, false);
		
		for(new i = 0; i<= MAX_HOUSES; i++)
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
		format(str, sizeof(str), "PosX: %f | PosY: %f | PosZ: %f", x, y, z);
		SendClientMessage(playerid, COLOR_GREY, str);
	}
	else return SendClientMessage(playerid, COLOR_GREY, "That is an invalid level.");
	return 1;
} */

CMD:housedestroy(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GREY, "You are not authorised to use that command.");
	new houseid, Query[500], str[30];
	if(sscanf(params, "i", houseid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /housedestroy [houseid]");
	if(hInfo[houseid][hPlayerHouse] == 0)
	{
		strcat(Query, "DELETE FROM `lla`.`houses` WHERE `houses`.`ID` = %d;");
		mysql_format(dbHandle, Query, sizeof(Query), Query, houseid);
		mysql_query(dbHandle, Query, false);
	}
	else
	{
		strcat(Query, "DELETE FROM `lla`.`phouses` WHERE `houses`.`ID` = %d;");
		mysql_format(dbHandle, Query, sizeof(Query), Query, houseid);
		mysql_query(dbHandle, Query, false);
	}
	format(str, sizeof(str), "House ID: %i destroyed", houseid);
	SendClientMessage(playerid, COLOR_GREY, str);
	Destroy_DynamicHouse(houseid);
	return 1;
}

CMD:prank(playerid, params[])
{
	if(pInfo[playerid][pAdminLevel] >= 8)
	{
		new id, choice[25], str[128];
		if(sscanf(params, "is[25]", id, choice))
		{	
			SendClientMessage(playerid, COLOR_GREY, "USAGE: /prank [playerid] [choice]");
			SendClientMessage(playerid, COLOR_GREY, "CHOICES: mother | bell | calling | filth | razor");
		}
		else if(strcmp(choice, "mother", true) == 0)
		{
			PlayerPlaySound(id, 39000, 0.0, 0.0, 0.0);
			format(str, sizeof(str), "You have pranked %s", GetName(id));
			SendClientMessage(playerid, -1, str);
		} 
		else if(strcmp(choice, "bell", true) == 0)
		{
			PlayerPlaySound(id, 3401, 0.0, 0.0, 0.0);
			format(str, sizeof(str), "You have pranked %s", GetName(id));
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(choice, "calling", true) == 0)
		{
			PlayerPlaySound(id, 3600, 0.0, 0.0, 0.0);
			format(str, sizeof(str), "You have pranked %s", GetName(id));
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(choice, "filth", true) == 0)
		{
			PlayerPlaySound(id, 39002, 0.0, 0.0, 0.0);
			format(str, sizeof(str), "You have pranked %s", GetName(id));
			SendClientMessage(playerid, -1, str);
		}
		else if(strcmp(choice, "razor", true) == 0)
		{
			PlayerPlaySound(id, 4400, 0.0, 0.0, 0.0);
			format(str, sizeof(str), "You have pranked %s", GetName(id));
			SendClientMessage(playerid, -1, str);
		}
	}
	return 1;
}