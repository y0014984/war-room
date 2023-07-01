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
};

true;