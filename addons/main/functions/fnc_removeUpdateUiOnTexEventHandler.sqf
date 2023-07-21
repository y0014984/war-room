params ["_entity", "_screenIndex"];

private  _updateUiOnTexHandle = _entity getVariable [format ["WR_updateUiOnTexScreen%1Handle", _screenIndex], -1];
[_updateUiOnTexHandle] call CBA_fnc_removePerFrameHandler;

systemChat "removed 'update ui on texture' event handler";

true;