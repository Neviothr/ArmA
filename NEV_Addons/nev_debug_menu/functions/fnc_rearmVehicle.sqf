#include "script_component.hpp"

_vehicle = vehicle player;

// Rearm
if !(_vehicle == player) then {
	_vehicle setVehicleAmmo 1;
} else {
	{
		_vehicle setAmmo [_x, 1000000];
	} forEach weapons _vehicle;
};

// Notifiy the user
["nev_notification", ["REARM", "The current vehicle/unit has been fully rearmed."]] call BIS_fnc_showNotification;