class CfgAmmo {
    class SmokeShell;
    class rhs_40mm_smoke_white: SmokeShell {
        simulation = "shotSmoke";
        deflectionSlowDown = 0;
    };

    class SmokeShellRed;
    class rhs_40mm_smoke_red: SmokeShellRed {
        simulation = "shotSmoke";
        deflectionSlowDown = 0;
    };

    class SmokeShellGreen;
    class rhs_40mm_smoke_green: SmokeShellGreen {
        simulation = "shotSmoke";
        deflectionSlowDown = 0;
    };

    class SmokeShellYellow;
    class rhs_40mm_smoke_yellow: SmokeShellYellow {
        simulation = "shotSmoke";
        deflectionSlowDown = 0;
    };

    class rhs_g_vog25;
    class rhs_g_vg40md_white: rhs_g_vog25 {
        simulation = "shotSmoke";
        deflecting = 30;
        deflectionSlowDown = 0;
    }
};
