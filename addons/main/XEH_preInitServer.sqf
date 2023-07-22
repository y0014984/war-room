// runs pre-init on server

private _supportedAssetClasses = 
    [
        "Land_TripodScreen_01_large_sand_F",
        "Land_TripodScreen_01_dual_v2_sand_F",
        "Land_MultiScreenComputer_01_sand_F",
        "Land_Laptop_03_sand_F",
        "Land_BriefingRoomScreen_01_F"
    ];

missionNamespace setVariable ["WR_supportedAssetClasses", _supportedAssetClasses, true];

[_supportedAssetClasses] call WR_main_fnc_initSupportedAssetClasses;