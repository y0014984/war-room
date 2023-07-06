params ["_dialog", "_horizontalResolution", "_verticalResolution", "_uiClass"];

private _entity = _dialog getVariable ["WR_target", objNull];
private _screenIndex = _dialog getVariable ["WR_screenIndex", -1];

private _uiOnTextureDisplayName = _entity getVariable [format ["WR_uiOnTextureDisplayNameScreen%1", _screenIndex], ""];
//private _uiClass = _entity getVariable [format ["WR_uiClassScreen%1", _screenIndex], ""];
private _hiddenSelection = _entity getVariable [format ["WR_hiddenSelectionScreen%1", _screenIndex], -1];

private _texture = format ["#(rgb,%1,%2,1)ui('%3','%4')", _horizontalResolution, _verticalResolution, _uiClass, _uiOnTextureDisplayName];

_entity setObjectTexture [_hiddenSelection, _texture];
	
systemChat format ["Set screen %1 resolution to %2x%3", _screenIndex, _horizontalResolution, _verticalResolution];

true;