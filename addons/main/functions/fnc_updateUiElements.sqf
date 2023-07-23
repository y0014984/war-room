params ["_entity", "_screenIndex", "_fps", "_display"];

/* ---------------------------------------- */

private _warRoomName = _entity getVariable [format ["WR_warRoomName%1", _screenIndex], "Operation Unknown"];

/* ---------------------------------------- */

// output war room name, current date and time to headline of war room display
private _headlineCtrl = _display displayCtrl 2001;
private _date = date;
_date = [_date] call WR_main_fnc_addLeadingZerosToDateTime;
_date params ["_year", "_month", "_day", "_hours", "_minutes"];
private _dateString = format ["%1-%2-%3", _year, _month, _day];
private _dayTimeString = [dayTime, "HH:MM:SS"] call BIS_fnc_timeToString;
_headlineCtrl ctrlSetText format ["%1 %2 (%3)", _warRoomName, _dayTimeString, _dateString];

/* ---------------------------------------- */

// output current resolution and FPS to subheadline of war room display
private _subHeadlineCtrl = _display displayCtrl 7001;
private _horizontalResolution = _entity getVariable [format ["WR_horizontalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
private _verticalResolution = _entity getVariable [format ["WR_verticalResolutionScreen%1", _screenIndex], WR_defaultScreenResolution];
private _uiClass = _entity getVariable [format ["WR_uiClassScreen%1", _screenIndex], ""];
_subHeadlineCtrl ctrlSetText format ["Screen %1 - %2x%3@%4fps (UI Class: %5)", _screenIndex, _horizontalResolution, _verticalResolution, _fps, _uiClass];

/* ---------------------------------------- */