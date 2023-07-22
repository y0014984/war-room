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
        _headlineCtrl ctrlSetText format ["%1 %2 (%3)", _warRoomName, _dayTimeString, _dateString];

		/* ---------------------------------------- */

		// output current resolution and FPS to subheadline of war room display
		private _subHeadlineCtrl = _uiOnTextureDisplay displayCtrl 7001;
        private _horizontalResolution = _entity getVariable [format ["WR_horizontalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
        private _verticalResolution = _entity getVariable [format ["WR_verticalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
		private _uiClass = _entity getVariable [format ["WR_uiClassScreen%1", _screenIndex], ""];
		_subHeadlineCtrl ctrlSetText format ["Screen %1 - %2x%3@%4fps (UI Class: %5)", _screenIndex, _horizontalResolution, _verticalResolution, _fps, _uiClass];

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