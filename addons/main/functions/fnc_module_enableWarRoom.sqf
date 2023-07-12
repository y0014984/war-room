params ["_logic", "_syncedEntities", "_activated"];

/* ANNOTATION: Multiple modules can be used in a mission. To process the settings, each settings pair is stored in an array. */

// store variables about the module config in mission namespace
missionNamespace setVariable ["WR_moduleEnableWarRoom", true, true];
private _moduleEnableWarRoomSettings = missionNamespace getVariable ["WR_moduleEnableWarRoomSettings", []];
private _assetsScope = _logic getVariable ["WR_Module_EnableWarRoom_AssetsScope", ""];
private _unitsScope = _logic getVariable ["WR_Module_EnableWarRoom_UnitsScope", ""];
_moduleEnableWarRoomSettings pushBackUnique [_assetsScope, _unitsScope];
missionNamespace setVariable ["WR_moduleEnableWarRoomSettings", _moduleEnableWarRoomSettings, true];

if (_unitsScope isEqualTo "GLOBAL") then
{
    // if units scope global then add class event handler to all units
    private _className = "Man";
    private _eventName = "init";
    private _eventFunc = { params ["_entity"]; _entity setVariable ["WR_interactionAllowedGlobal", true, true]; };
    private _allowInheritance = true;
    private _excludedClasses = [];
    private _applyInitRetroactively = true;
    [_className, _eventName, _eventFunc, _allowInheritance, _excludedClasses, _applyInitRetroactively] call CBA_fnc_addClassEventHandler;
};

private _supportedAssetClasses = missionNamespace getVariable ["WR_supportedAssetClasses", []];

if (_assetsScope isEqualTo "GLOBAL") then
{
    // if assets scope global then add class event handler to all supported assets

    {
        private _className = _x;
        private _eventName = "init";
        private _eventFunc =
        {
            params ["_entity"];

            _entity setVariable ["WR_interactionAllowedGlobal", true, true];
            private _screens = _entity getVariable ["WR_screens", []];
            {
                private _hiddenSelection = _x select 0;
                _entity setObjectTexture [_hiddenSelection, "\y\wr\addons\main\ui\WarRoom_DefaultDisplay_1024x1024.paa"];
            } forEach _screens;
        };
        private _allowInheritance = true;
        private _excludedClasses = [];
        private _applyInitRetroactively = true;
        [_className, _eventName, _eventFunc, _allowInheritance, _excludedClasses, _applyInitRetroactively] call CBA_fnc_addClassEventHandler;
    } forEach _supportedAssetClasses;
};

// delete module
deleteVehicle _logic;