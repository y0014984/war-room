params ["_entity", "_selectionIndex", "_resolution", "_uiClass"];

[_entity, _selectionIndex, _resolution, _uiClass] spawn
{
    params ["_entity", "_selectionIndex", "_resolution", "_uiClass"];

    private _uiOnTextureDisplayName = "UiOnTexture";

    private _texture = format ["#(rgb,%1,%1,1)ui('%2','%3')", _resolution, _uiClass, _uiOnTextureDisplayName];

	_entity setObjectTexture [_selectionIndex, _texture];
	
	waitUntil { !isNull findDisplay _uiOnTextureDisplayName };
	
	private _uiOnTextureDisplay = findDisplay _uiOnTextureDisplayName;

	_entity setVariable ["WR_uiOnTextureDisplay", _uiOnTextureDisplay];
};

true;