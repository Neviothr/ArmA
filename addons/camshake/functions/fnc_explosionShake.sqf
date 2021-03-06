#include "script_component.hpp"

/*
 * Author: Cyruz143
 * Applies a camera shaking effect to a unit based on distance from explosion.
 *
 * Arguments:
 * 0: Explotion source <OBJECT>
 *
 * Return Value:
 * None.
 *
 * Example:
 * [killedVehicle] call nev_camshake_fnc_explosionShake
 *
 * Public: No
 https://github.com/Cyruz143/ark_inhouse/blob/master/addons/ark_camshake/client_postinit.sqf
*/

params ["_explosionSource"];
private _distanceToPlayer = player distance2D _explosionSource;
TRACE_2("",_explosionSource,_distanceToPlayer);

if (_distanceToPlayer > 1000) exitWith {INFO_1("Distance is greater than 1000 (%1), terminating")};

// If you pass 0 in _distanceToPlayer (vehicle blows up with you in it) you get a zero divisor error.
if (_distanceToPlayer isEqualTo 0) then {
    _distanceToPlayer = 50;
};

private _force = (1000 / _distanceToPlayer) min 20;
private _delay = _distanceToPlayer / 343;
TRACE_2("",_force,_delay);

[{addCamShake [(_this #0), 1, 5]}, [_force], _delay] call CBA_fnc_waitAndExecute;
