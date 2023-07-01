params ["_entity", "_screenIndex"];

private  _updateUiOnTexHandle = _entity getVariable [format ["WR_updateUiOnTexScreen%1Handle", _screenIndex], -1];
[_updateUiOnTexHandle] call CBA_fnc_removePerFrameHandler;

//private _uavDirAdjustHandle = _uav getVariable ["WR_uavDirAdjustHandle", -1];
//removeMissionEventHandler ["Draw3D", _uavDirAdjustHandle];

/* 
private _drone1DirAdjustHandle = uiNamespace getVariable ["drone1DirAdjustHandle", -1];
removeMissionEventHandler ["Draw3D", _drone1DirAdjustHandle];

private _drone2DirAdjustHandle = uiNamespace getVariable ["drone2DirAdjustHandle", -1];
removeMissionEventHandler ["Draw3D", _drone2DirAdjustHandle]; */

systemChat "removed 'update ui on texture' event handler";

true;