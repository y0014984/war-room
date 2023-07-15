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
            _entity setVariable ["WR_supported", _supported, true];

            private _screenCount = (_warRoomCfg >> "WR_screenCount") call BIS_fnc_getCfgData;

            private _screens = [];

            for [{ private _i = 0 }, { _i < _screenCount }, { _i = _i + 1 }] do
            { 
                private _screenCfg = _warRoomCfg >> format ["Screen%1", _i];
                if (!isClass _screenCfg) exitWith {};
                
                private _hiddenSelection = (_screenCfg >> "WR_hiddenSelection") call BIS_fnc_getCfgData;
                private _allowedUiClasses = (_screenCfg >> "WR_allowedUiClasses") call BIS_fnc_getCfgDataArray;
                private _defaultUiClass = (_screenCfg >> "WR_defaultUiClass") call BIS_fnc_getCfgData;

                private _uiClassCfg = configFile >> _allowedUiClasses select _defaultUiClass;
                private _uiScreenItemCount = (_uiClassCfg >> "WR_uiScreenItemCount") call BIS_fnc_getCfgData;

                _screens pushBack [_hiddenSelection, _allowedUiClasses, _defaultUiClass, _uiScreenItemCount];
            };

            _entity setVariable ["WR_screens", _screens, true];
        };

        [_entity] call WR_main_fnc_addAce3Interactions;
    };

    [_x, "init", _eventFunc] call CBA_fnc_addClassEventHandler;
} forEach _supportedAssetClasses;