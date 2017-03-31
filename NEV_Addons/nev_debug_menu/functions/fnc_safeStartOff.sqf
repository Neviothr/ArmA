#include "script_component.hpp"

// Make sure the block is ran on an actual unit, not the server or a HC
if (hasInterface) then {

	// Disable SafeStart loop
	isSafeStart = false;

	// Notify players that game is about to begin
	hint "Weapons are live in 5 seconds.";
	uisleep 5; // Delay as per above hint

	// Remove `fired` EHs
	player removeEventHandler ["Fired", ssDelManProj];
	if (!isNil "ssDelVehProj") then {
		(ssDelVehProj select 0) removeEventHandler ["Fired", (ssDelVehProj select 1)]; // Remove `fired` EH from vehicles, if was applied
	};
	player allowDamage true; // Allow damage again

	// Notifiy of game on
	titleText ["Game on!", "PLAIN"];
};