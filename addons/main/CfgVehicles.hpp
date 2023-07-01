class CfgVehicles 
{
	/* ================================================================================ */

	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Combo;
			class ModuleDescription;	// Module description
		};
		// Description base classes, for more information see below
		class ModuleDescription
		{
			class AnyBrain;
		};
	};

    /* ================================================================================ */

	class WR_Module_EnableWarRoom: Module_F
	{
		// Standard object definitions
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		//scopeCurator = 2; // Zeus visability; 2 will show it in the menu, 0 will hide it.
		displayName = "War Room"; // Name displayed in the menu
		//icon = "\y\wr\addons\main\ui\WR_Module_Icon_enableWarRoom.paa"; // Map icon. Delete this entry to use the default icon
		category = "WR_mainModules";

		// Name of function triggered once conditions are met
		function = "WR_main_fnc_module_enableWarRoom";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 1;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 1;
		// 1 if modules is to be disabled once it is activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// 1 to run init function in Eden Editor as well
		is3DEN = 0;

		// Menu displayed when the module is placed or double-clicked on by Zeus
		//curatorInfoType = "WR_UserInterface_Zeus_Module_EnableWarRoom";

		// Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
		class Attributes: AttributesBase
		{
			class WR_Module_EnableWarRoom_AssetsScope: Combo
			{
				property = "WR_Module_EnableWarRoom_AssetsScope";
				displayName = "Assets Scope";
				tooltip = "'Global' means that all supported assets in the mission are available for War Room Interaction. 'Synced' means that you can only interact with synced assets.";
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = """GLOBAL""";

				// Listbox items:
				class Values
				{
					class Global	{ name = "Global";	value = "GLOBAL"; };
					class Synced	{ name = "Synced";	value = "SYNCED"; };
				};
			};

			class WR_Module_EnableWarRoom_UnitsScope: Combo
			{
				property = "WR_Module_EnableWarRoom_UnitsScope";
				displayName = "Units Scope";
				tooltip = "'Global' means that all units in the mission can use War Room Interaction. 'Synced' means that only synced units can interact with assets.'Side ...' means that only units of the selected side can interact with assets.";
				typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = """GLOBAL""";

				// Listbox items:
				class Values
				{
					class Global	        { name = "Global";	            value = "GLOBAL"; };
					class Synced	        { name = "Synced";	            value = "SYNCED"; };
					class SideBlufor        { name = "side BLUFOR";	        value = "SIDE-BLUFOR"; };
					class SideOpfor         { name = "side OPFOR";	        value = "SIDE-OPFOR"; };
					class SideIndependent   { name = "side INDEPENDENT";    value = "SIDE-INDEPENDENT"; };
					class SideCivilian      { name = "side CIVILIAN";	    value = "SIDE-CIVILIAN"; };
				};
			};

			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};

		// Module description. Must inherit from base class, otherwise pre-defined entities won't be available
		class ModuleDescription: ModuleDescription
		{
			description = "Place this module into your mission to enable War Room ACE3 Interactions for assets. Setup the settings above accordingly. You can use multiple Modules in your mission."; // Short description, will be formatted as structured text
		};
	};

	/* ================================================================================ */

    class Land_TripodScreen_01_large_F;
    class Land_TripodScreen_01_large_sand_F: Land_TripodScreen_01_large_F
    {
        class War_Room 
        {
            WR_supported = 1; // 1 == true; 0 == false
            WR_screenHiddenSelections[] = {0}; // index of hidden selections
            WR_resolution = 1024;
            WR_uiClasses[] = {"WarRoom5"};
        };
    };

    /* ================================================================================ */

	class Land_TripodScreen_01_dual_v2_F;
	class Land_TripodScreen_01_dual_v2_sand_F: Land_TripodScreen_01_dual_v2_F
	{
        class War_Room 
        {
            WR_supported = 1; // 1 == true; 0 == false
            WR_screenHiddenSelections[] = {0,1}; // index of hidden selections
            WR_resolution = 1024;
            WR_uiClasses[] = {"WarRoom1", "WarRoom1"};
        };
	};

    /* ================================================================================ */

	class Land_MultiScreenComputer_01_base_F;
	class Land_MultiScreenComputer_01_sand_F: Land_MultiScreenComputer_01_base_F
	{
        class War_Room 
        {
            WR_supported = 1; // 1 == true; 0 == false
            WR_screenHiddenSelections[] = {1,2,3}; // index of hidden selections
            WR_resolution = 1024;
            WR_uiClasses[] = {"WarRoom1", "WarRoom1", "WarRoom1"};
        };
	};

	/* ================================================================================ */
};