// runs pre-init on server

params ["_supportedAssetClasses"];

{
    private _eventFunc = 
    {
        params ["_entity"];
        
        private _warRoomCfg = configFile >> "CfgVehicles" >> typeOf _entity >> "War_Room";

        if (!isClass _warRoomCfg) exitWith {};

        private _supported = (_warRoomCfg >> "WR_supported") call BIS_fnc_getCfgDataBool;
        if (_supported) then
        {
            private _screenHiddenSelections = (_warRoomCfg >> "WR_screenHiddenSelections") call BIS_fnc_getCfgDataArray;
            private _resolution = (_warRoomCfg >> "WR_resolution") call BIS_fnc_getCfgData;
            private _uiClasses = (_warRoomCfg >> "WR_uiClasses") call BIS_fnc_getCfgDataArray;
            private _uiClassCfg = configFile >> _uiClass;
            private _uiPlaceholderCount = (_uiClassCfg >> "WR_uiPlaceholderCount") call BIS_fnc_getCfgData;

            _entity setVariable ["WR_supported", _supported, true];
            _entity setVariable ["WR_screenHiddenSelections", _screenHiddenSelections, true];
            _entity setVariable ["WR_resolution", _resolution, true];
            _entity setVariable ["WR_uiClasses", _uiClasses, true];
            _entity setVariable ["WR_uiPlaceholderCount", _uiPlaceholderCount, true];
        };

        [_entity] call WR_main_fnc_addAce3Interactions;
    };

    [_x, "init", _eventFunc] call CBA_fnc_addClassEventHandler;
} forEach _supportedAssetClasses;