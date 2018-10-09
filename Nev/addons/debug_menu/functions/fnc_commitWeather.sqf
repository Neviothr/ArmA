#include "script_component.hpp"

(_this select 0) params ["_control", "_value"];
(fogParams) params ["_fogValue", "_fogDecay", "_fogBase"];

switch (str _control) do {
	// Overcast
	case "Control #80003": {
		// To say on the same date
		skipTime -24;
		86400 setOvercast _value;
		skipTime 24;
	};
	case "Control #80004": {
		// Lightnings
		0 setLightnings _value;
	};
	case "Control #80005": {
		// Fog value
		0 setFog [_value, _fogDecay, _fogBase];
	};
	case "Control #80006": {
		// Fog decay
		0 setFog [_fogValue, _value, _fogBase];
	};
	case "Control #80007": {
		// Fog base
		0 setFog [_fogValue, _fogDecay, _value];
	};
	case "Control #80008": {
		// Rain
		0 setRain _value;
	};
	case "Control #80009": {
		// Waves
		0 setWaves _value;
	}
};

// Sync weather effects
simulWeatherSync;
forceWeatherChange;
