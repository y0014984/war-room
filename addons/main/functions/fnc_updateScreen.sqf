params ["_entity", "_screenIndex", "_horizontalResolution", "_verticalResolution", "_fps", "_uiClass"];

if (!canSuspend) exitWith { systemChat "calling 'updateScreen' unscheduled is forbidden" };

// if dedicated server or headless client
if (!hasInterface) exitWith {};

private _hiddenSelection = _entity getVariable [format ["WR_hiddenSelectionScreen%1", _screenIndex], -1];

[_entity, _hiddenSelection, _screenIndex] call WR_main_fnc_terminateUiOnTex;

[_entity, _hiddenSelection, _screenIndex, _horizontalResolution, _verticalResolution, _fps, _uiClass] call WR_main_fnc_initUiOnTex;

systemChat format ["Set screen %1 resolution to %2x%3@%4fps and UI class to %5", _screenIndex, _horizontalResolution, _verticalResolution, _fps, _uiClass];