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
            private _displayHiddenSelections = (_warRoomCfg >> "WR_displayHiddenSelections") call BIS_fnc_getCfgDataArray;
            private _resolution = (_warRoomCfg >> "WR_resolution") call BIS_fnc_getCfgData;
            private _uiClass = (_warRoomCfg >> "WR_uiClass") call BIS_fnc_getCfgData;

            _entity setVariable ["WR_supported", _supported, true];
            _entity setVariable ["WR_displayHiddenSelections", _displayHiddenSelections, true];
            _entity setVariable ["WR_resolution", _resolution, true];
            _entity setVariable ["WR_uiClass", _uiClass, true];
        };

        [_entity] call WR_main_fnc_addAce3Interaction;
    };

    [_x, "init", _eventFunc] call CBA_fnc_addClassEventHandler;
} forEach _supportedAssetClasses;