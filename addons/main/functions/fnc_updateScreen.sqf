params ["_entity", "_screenIndex", "_horizontalResolution", "_verticalResolution", "_uiClass"];

if (!canSuspend) exitWith { systemChat "calling 'updateScreen' unscheduled is forbidden" };

private _hiddenSelection = _entity getVariable [format ["WR_hiddenSelectionScreen%1", _screenIndex], -1];

[_entity, _hiddenSelection, _screenIndex] call WR_main_fnc_terminateUiOnTex;

[_entity, _hiddenSelection, _screenIndex, _horizontalResolution, _verticalResolution, _uiClass] call WR_main_fnc_initUiOnTex;

systemChat format ["Set screen %1 resolution to %2x%3 and layout to %4", _screenIndex, _horizontalResolution, _verticalResolution, _uiClass];