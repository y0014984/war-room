#include "script_component.hpp"

class CfgPatches
{
    class main
	{
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = "y0014984";
        VERSION_CONFIG;
    };
};

// Grid Macros and Styles
#include "defines.inc"

// Various Event Handlers
#include "CfgEventHandlers.hpp"