params ["_entity", "_uav"];

private  _updateUiOnTexHandle = _entity getVariable ["WR_updateUiOnTexHandle", -1];
[_updateUiOnTexHandle] call CBA_fnc_removePerFrameHandler;

private _uavDirAdjustHandle = _uav getVariable ["WR_uavDirAdjustHandle", -1];
removeMissionEventHandler ["Draw3D", _uavDirAdjustHandle];

/* 
private _drone1DirAdjustHandle = uiNamespace getVariable ["drone1DirAdjustHandle", -1];
removeMissionEventHandler ["Draw3D", _drone1DirAdjustHandle];

private _drone2DirAdjustHandle = uiNamespace getVariable ["drone2DirAdjustHandle", -1];
removeMissionEventHandler ["Draw3D", _drone2DirAdjustHandle]; */

true;