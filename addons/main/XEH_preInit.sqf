#include "script_component.hpp"
#include "XEH_PREP.hpp"

private _supportedAssetClasses = 
    [
        "Land_TripodScreen_01_large_sand_F"
    ];

{
    private _eventFunc = 
    {
        params ["_entity"];
        
        private _warRoomCfg = configFile >> "CfgVehicles" >> typeOf _entity >> "War_Room";

        if (!isClass _warRoomCfg) exitWith {};

        private _supported = (_warRoomCfg >> "WR_supported") call BIS_fnc_getCfgDataBool;
        if (_supported) then
        {
            _entity setVariable ["WR_supported", _supported, true];
            private _displayHiddenSelections = (_warRoomCfg >> "WR_displayHiddenSelections") call BIS_fnc_getCfgDataArray;
            _entity setVariable ["WR_displayHiddenSelections", _displayHiddenSelections, true];
        };
    };

    [_x, "init", _eventFunc] call CBA_fnc_addClassEventHandler;
} forEach _supportedAssetClasses;