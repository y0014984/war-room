params ["_dateTime"];

{
    if (_x < 10) then
    {
        _dateTime set [_forEachIndex, format ["0%1", _x]];
    } 
    else
    {
        _dateTime set [_forEachIndex, format ["%1", _x]];
    };
} forEach _dateTime;

_dateTime;