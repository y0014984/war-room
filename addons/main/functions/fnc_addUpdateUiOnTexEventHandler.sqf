params ["_entity", "_screenIndex", "_fps"];

private _updateInterval = 1 / _fps;

private _updateUiOnTexHandle = 
[
	{
        (_this select 0) params ["_entity", "_screenIndex", "_fps"];

		private _uiOnTextureDisplay = _entity getVariable [format ["WR_uiOnTextureDisplayScreen%1", _screenIndex], displayNull];
        if (isNull _uiOnTextureDisplay) exitWith {};

		/* ---------------------------------------- */

		private _warRoomName = _entity getVariable [format ["WR_warRoomName%1", _screenIndex], "Operation Unknown"];

		/* ---------------------------------------- */

		// output war room name, current date and time to headline of war room display
		private _headlineCtrl = _uiOnTextureDisplay displayCtrl 2001;
        private _date = date;
        _date = [_date] call WR_main_fnc_addLeadingZerosToDateTime;
        _date params ["_year", "_month", "_day", "_hours", "_minutes"];
        private _dateString = format ["%1-%2-%3", _year, _month, _day];
		private _dayTimeString = [dayTime, "HH:MM:SS"] call BIS_fnc_timeToString;
        _headlineCtrl ctrlSetText format ["Screen %1 (%2) - Date %3 - Time %4", _screenIndex, _warRoomName, _dateString, _dayTimeString];

		/* ---------------------------------------- */

		// output current resolution and FPS to subheadline of war room display
		private _subHeadlineCtrl = _uiOnTextureDisplay displayCtrl 7001;
        private _horizontalResolution = _entity getVariable [format ["WR_horizontalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
        private _verticalResolution = _entity getVariable [format ["WR_verticalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
		_subHeadlineCtrl ctrlSetText format ["War Room Mod v0.1.0 by y0014984 - %1x%2@%3fps", _horizontalResolution, _verticalResolution, _fps];

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