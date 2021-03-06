#include "script_component.hpp"

/*
 * Author: Neviothr
 * Apply weather effects based on slider values. Called every time a weather slider's value changes through 'onSliderPosChanged' EH.
 *
 * Arguments:
 * 0: Slider control <CONTROL>
 * 1: Slider value <NUMBER>
 *
 * Return Value:
 * None.
 *
 * Example:
 * onSliderPosChanged = "_this call nev_debug_menu_fnc_changeWeather"
 *
 * Public: No
*/

params ["_control", "_value"];
(fogParams) params ["_fogValue", "_fogDecay", "_fogBase"];

TRACE_5("",_control,_value,_fogValue,_fogDecay,_fogBase);

switch (str _control) do {
    case "Control #80001": {
        skipTime -24;
        86400 setOvercast _value;
        skipTime 24;

        forceWeatherChange;
        simulWeatherSync;
    };

    case "Control #80002": {
        0 setFog [_value, _fogDecay, _fogBase];
    };

    case "Control #80003": {
        0 setFog [_fogValue, _value, _fogBase];
    };

    case "Control #80004": {
        0 setFog [_fogValue, _fogDecay, _value];
    };

    case "Control #80005": {
        0 setRain _value;
        forceWeatherChange;
    };

    case "Control #80006": {
        0 setWindStr _value;
    };

    case "Control #80007": {
        0 setLightnings _value;
    };

    case "Control #80008": {
        0 setWaves _value;
    };
};
