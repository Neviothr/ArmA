#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = "NEV Component - Map";
        author = "Neviothr";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"nev_main"};
        VERSION_CONFIG;
    };
};

#include "CfgEventhandlers.hpp"

// Tints the map ever so slightly in yellow, easier on eyes.
class RscMapControl {
    colorBackground[]={1,1,0.85000002,0.94999999};
};
