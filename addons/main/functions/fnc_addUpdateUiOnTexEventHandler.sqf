params ["_entity", "_screenIndex"];

private _fps = _entity getVariable [format ["WR_fpsScreen%1", _screenIndex], WR_defaultScreenFps];
_entity setVariable [format ["WR_fpsScreen%1", _screenIndex], _fps];
private _updateInterval = 1 / _fps;

private _updateUiOnTexHandle = 
[
	{
        (_this select 0) params ["_entity", "_screenIndex"];

		private _uiOnTextureDisplay = _entity getVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], displayNull];
        if (isNull _uiOnTextureDisplay) exitWith {};

		// set current date and time on headline of war room display
		private _headlineCtrl = _uiOnTextureDisplay displayCtrl 2001;
        private _date = date;
        _date = [_date] call WR_main_fnc_addLeadingZerosToDateTime;
        _date params ["_year", "_month", "_day", "_hours", "_minutes"];
        private _dateString = format ["%1-%2-%3", _year, _month, _day];
		private _dayTimeString = [dayTime, "HH:MM:SS"] call BIS_fnc_timeToString;
        _headlineCtrl ctrlSetText format ["War Room - Screen %1 - Date %2 - Time %3", _screenIndex, _dateString, _dayTimeString];
		
		// update ui on texture (re-render)
		displayUpdate _uiOnTextureDisplay;
	}, 
	_updateInterval, 
	[_entity, _screenIndex]
] call CBA_fnc_addPerFrameHandler;

// save the handle for this per-frame-event-handler in ui namespace for later use
_entity setVariable [format ["WR_updateUiOnTexScreen%1Handle", _screenIndex], _updateUiOnTexHandle];

systemChat format ["added 'update ui on texture' event handler to screen %1", _screenIndex];

true;