#include <a_samp>
#include <zcmd>
#include <sscanf2>

#define COL_GREY        					"{C3C3C3}"

	new reports = 0;
	new reported[MAX_PLAYERS] = 0;
	new reportid[MAX_PLAYERS] = 0;
	new reporttext[MAX_PLAYERS][156];

CMD:report(playerid, params)
{
	new report[168], str[168];
	if(sscanf(params, "s[168]", report)) return SendClientMessage(playerid, COL_GREY, "USAGE: /report [text]");
	if(reported[playerid] == 1) return SendClientMessage(playerid, COL_GREY, "You already have an active report.");
	if(reports > 99) reports = 0;
	reports++; 
	reported[playerid] = 1;
	reportid[playerid] = reports;
	format(reporttext[playerid], sizeof(reporttext) , "%s [ID: %i] [Report ID: %i]: %s", GetName(playerid), playerid, reports, report);
	SendClientMessageToAdmins(playerid, COLOR_LIGHTRED, reporttext, 1);
	return 1;
}