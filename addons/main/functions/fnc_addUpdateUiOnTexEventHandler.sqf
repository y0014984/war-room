params ["_entity", "_screenIndex", "_fps"];

private _updateInterval = 1 / _fps;

private _updateUiOnTexHandle = 
[
	{
        (_this select 0) params ["_entity", "_screenIndex", "_fps"];

		private _uiOnTextureDisplay = _entity getVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], displayNull];
        if (isNull _uiOnTextureDisplay) exitWith {};

		/* ---------------------------------------- */

		[_entity, _screenIndex, _fps, _uiOnTextureDisplay] call WR_main_fnc_updateUiElements;

		/* ---------------------------------------- */

		// update ui on texture (re-render)
		displayUpdate _uiOnTextureDisplay;
	}, 
	_updateInterval, 
	[_entity, _screenIndex, _fps]
] call CBA_fnc_addPerFrameHandler;

// save the handle for this per-frame-event-handler in ui namespace for later use
_entity setVariable [format ["WR_updateUiOnTexScreen%1Handle", _screenIndex], _updateUiOnTexHandle];

systemChat format ["added 'update ui on texture' event handler to screen %1", _screenIndex];

true;