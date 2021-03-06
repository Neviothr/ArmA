#include "script_component.hpp"

/*
 * Author: Neviothr
 * Handles various aspects of the debug menu upon loading -
 * slider postions, listbox population, map centering, eventhandler assignment,
 * marker creation, editing and disabling of certain controls.
 *
 * Arguments:
 * 0: Debug Menu Dialog <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * onLoad = "call nev_debug_menu_fnc_onLoad"
 *
 * Public: No
*/

params ["_dialog"];

TRACE_1("",_dialog);

private _overcastSlider = _dialog displayCtrl IDC_overcastSlider;
_overcastSlider sliderSetPosition overcast;

private _fogValueSlider = _dialog displayCtrl IDC_fogValueSlider;
_fogValueSlider sliderSetPosition (fogParams select 0);

private _fogDecaySlider = _dialog displayCtrl IDC_fogDecaySlider;
_fogDecaySlider sliderSetPosition (fogParams select 1);

private _fogBaseSlider = _dialog displayCtrl IDC_fogBaseSlider;
_fogBaseSlider sliderSetPosition (fogParams select 2);

private _rainSlider = _dialog displayCtrl IDC_rainSlider;
_rainSlider sliderSetPosition rain;

private _windSlider = _dialog displayCtrl IDC_windSlider;
_windSlider sliderSetPosition windStr;

private _lightningsSlider = _dialog displayCtrl IDC_lightningsSlider;
_lightningsSlider sliderSetPosition lightnings;

private _wavesSlider = _dialog displayCtrl IDC_wavesSlider;
_wavesSlider sliderSetPosition waves;

// Inconsistancy of weather commands rises after game load,
// detect this, and disable them to prevent issues.
if !(isNil QGVAR(disableWeatherSliders)) then {
    {
        _x ctrlEnable false;
    } forEach [_overcastSlider, _fogValueSlider, _fogDecaySlider, _fogBaseSlider, _rainSlider, _windSlider, _lightningsSlider, _wavesSlider]
};

private _yearBox = _dialog displayCtrl IDC_yearBox;
for "_year" from 1982 to 2050 do {
    _yearBox lbAdd str _year;
};

// Years go from 1982 to 2050, while listbox indexs go from 0 to 68,
// to get the currect index from 'date' we must subract 1982 from it.
// This is also valid for the month and day listboxes.
_yearBox lbSetCurSel (date select 0) - 1982;

// Use 'ctrlAddEventHandler' instead of a 'onLBSelChanged' config EH because running
// 'lbSetCurSel' fires the 'onLBSelChanged' EH.
// This is valid for all listboxes
_yearBox ctrlAddEventHandler ["LBSelChanged", {call FUNC(setDate)}];

private _monthBox = _dialog displayCtrl IDC_monthBox;
_monthBox lbAdd "January";
_monthBox lbAdd "February";
_monthBox lbAdd "March";
_monthBox lbAdd "April";
_monthBox lbAdd "May";
_monthBox lbAdd "June";
_monthBox lbAdd "July";
_monthBox lbAdd "August";
_monthBox lbAdd "September";
_monthBox lbAdd "October";
_monthBox lbAdd "November";
_monthBox lbAdd "December";
_monthBox lbSetCurSel ((date select 1) - 1);
_monthBox ctrlAddEventHandler ["LBSelChanged", {call FUNC(setDate)}];

private _dayBox = _dialog displayCtrl IDC_dayBox;
for "_day" from 1 to ([date select 0, date select 1] call BIS_fnc_monthDays) do {
    _dayBox lbAdd str _day;
};
_dayBox lbSetCurSel ((date select 2) - 1);
_dayBox ctrlAddEventHandler ["LBSelChanged", {call FUNC(setDate)}];

private _hourBox = _dialog displayCtrl IDC_hourBox;
for "_hour" from 0 to 23 do {
    _hourBox lbAdd str _hour;
};
_hourBox lbSetCurSel (date select 3);
_hourBox ctrlAddEventHandler ["LBSelChanged", {call FUNC(setDate)}];

private _minuteBox = _dialog displayCtrl IDC_minuteBox;
for "_minute" from 0 to 59 do {
    _minuteBox lbAdd str _minute;
};
_minuteBox lbSetCurSel (date select 4);
_minuteBox ctrlAddEventHandler ["LBSelChanged", {call FUNC(setDate)}];

if !(isMultiplayer) then {
    private _execGlobalButton = _dialog displayCtrl IDC_execGlobalButton;
    private _execServerButton = _dialog displayCtrl IDC_execServerButton;
    _execGlobalButton ctrlEnable false;
    _execServerButton ctrlEnable false;
};

private _missionInfo = _dialog displayCtrl IDC_missionInfo;
_missionInfo ctrlSetStructuredText parseText format [
    "<t size = '1' font = 'RobotoCondensedBold' color='#ffffff' align = 'left'>
    %1 on %2
    <br/>
    Cursor Object: %3
    <br/>
    Active SQF: %4 Active FSM: %5 Pos: %6 Time: %7m
    </t>",
    missionName call CBA_fnc_decodeURL,
    worldName,
    ["NULL-Object", format ["%1 (%2)", typeOf cursorObject, cursorObject]] select (!isNull cursorObject),
    (diag_activeScripts select 0) + (diag_activeScripts select 1) + (diag_activeScripts select 2),
    diag_activeScripts select 3,
    getPos player apply {floor _x},
    floor (time / 60)
];

private _mapDisplay = _dialog displayCtrl IDC_mapDisplay;
_mapDisplay ctrlAddEventHandler ["Destroy", {{deleteMarkerLocal _x} forEach GVAR(moduleMarkers)}];
_mapDisplay ctrlAddEventHandler ["MouseButtonDown", {_this call FUNC(mapMouseButtonClick)}];

GVAR(moduleMarkers) = [];

{
    private _marker = createMarkerLocal [str _x, getPos _x];
    _marker setMarkerTextLocal str _x;
    _marker setMarkerType "respawn_inf";
    _marker setMarkerColorLocal "colorOPFOR";

    GVAR(moduleMarkers) pushBackUnique _marker;
} forEach entities "nev_mission_framework_waveSpawnModule";

if (GVAR(mapCentering)) then {
    _mapDisplay ctrlMapAnimAdd [0, 0.05, [worldSize / 2, worldsize / 2, 0]];
    ctrlMapAnimCommit _mapDisplay;
};

// Disable config dump button and edit box if filePatching is disabled, since script and extention are in A3 root.
if !(isFilePatchingEnabled) then {
    private _configDumpButton = _dialog displayCtrl IDC_configDumpButton;
    private _configDumpHandle = _dialog displayCtrl IDC_configDumpHandle;

    _configDumpButton ctrlEnable false;
    _configDumpHandle ctrlEnable false;
};
