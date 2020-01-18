#include <a_samp>

new AntiSpam[MAX_PLAYERS] = 0;
 
forward ResetCount(playerid);
 
forward ResetCommandCount(playerid);
 
#define SpamLimit (3000)
#define COLOR_RED 0xFF0000FF
 
public OnFilterScriptInit()
{
        printf("[*] ChristopherM's Anti-Spam Loaded. Limit: %d", SpamLimit);
 
        return 1;
}
 
public OnFilterScriptExit()
{
        print("[*] ChristopherM's Anti-Spam Unloaded.");
 
        return 1;
}
 
public ResetCount(playerid)
{
        SetPVarInt(playerid, "TextSpamCount", 0);
}
 
public ResetCommandCount(playerid)
{
        SetPVarInt(playerid, "CommandSpamCount", 0);
}

forward CMDAntiSpam(playerid);
public CMDAntiSpam(playerid)
{
	new TCount, KMessage[128];
       
    TCount = GetPVarInt(playerid, "CommandSpamCount");
       
    TCount++;
      
    SetPVarInt(playerid, "CommandSpamCount", TCount);
       
    if(TCount == 2) 
	{
		SendClientMessage(playerid, 0xFFFFFF, "[Anti-Spam]: Warning you are one command away from being kicked!");
    }
    else if(TCount == 3) 
	{
		GetPlayerName(playerid, KMessage, sizeof(KMessage));
		format(KMessage, sizeof(KMessage), "[Anti-Spam]: %s has been kicked for command spamming.", KMessage);
		SendClientMessageToAll(0xFFFFFF, KMessage);
		print(KMessage);
		Kick(playerid);
	}
 
    SetTimerEx("ResetCommandCount", SpamLimit, false, "i", playerid);
	return 1;
}

forward ChatAntiSpam(playerid);
public ChatAntiSpam(playerid)
{
	new TCount;
       
    TCount = GetPVarInt(playerid, "TextSpamCount");
       
    TCount++;
       
    SetPVarInt(playerid, "TextSpamCount", TCount);
       
    if(TCount == 2) 
	{
        SendClientMessage(playerid, COLOR_RED, "[Anti-Spam]: Warning you are one message away from being kicked!");
    }
    else if(TCount == 3) 
	{
		AntiSpam[playerid] = 1;
        SendClientMessage(playerid, COLOR_RED, "You have been muted for 5 seconds.");
		SetTimerEx("UnmuteChat", SpamLimit, false, "i", playerid);
    }
 
    SetTimerEx("ResetCount", 5000, false, "i", playerid);
	return 1;
}

forward UnmuteChat(playerid);
public UnmuteChat(playerid)
{
	if(AntiSpam[playerid] == 1)
	{
		AntiSpam[playerid] = 0;
		SendClientMessage(playerid, COLOR_RED, "You have been unmuted.");
	}
	return 1;
}