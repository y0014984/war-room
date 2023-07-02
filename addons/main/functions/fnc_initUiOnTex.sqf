params ["_entity", "_hiddenSelection", "_screenIndex", "_resolution", "_uiClass"];

[_entity, _hiddenSelection, _screenIndex, _resolution, _uiClass] spawn
{
    params ["_entity", "_hiddenSelection", "_screenIndex", "_resolution", "_uiClass"];

    private _uiOnTextureDisplayName = format ["UiOnTexture-%1-%2", getObjectID _entity, _screenIndex];

    private _texture = format ["#(rgb,%1,%1,1)ui('%2','%3')", _resolution, _uiClass, _uiOnTextureDisplayName];

	_entity setObjectTexture [_hiddenSelection, _texture];
	
	waitUntil { !isNull findDisplay _uiOnTextureDisplayName };
	
	private _uiOnTextureDisplay = findDisplay _uiOnTextureDisplayName;

	_entity setVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], _uiOnTextureDisplay];
	_entity setVariable [format ["WR_uiOnTextureDisplayNameScreen%1", _screenIndex], _uiOnTextureDisplayName];
	_entity setVariable [format ["WR_uiClassScreen%1", _screenIndex], _uiClass];
	_entity setVariable [format ["WR_hiddenSelectionScreen%1", _screenIndex], _hiddenSelection];

	systemChat format ["'ui on texture' display for screen %1 initialized.", _screenIndex];
};

true;