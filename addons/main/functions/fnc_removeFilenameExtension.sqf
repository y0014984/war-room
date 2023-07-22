params ["_filename"];

_filenameSegments = _filename splitString ".";

if ((count _filenameSegments) == 1) exitWith { _filename; };

_filenameSegments deleteAt ((count _filenameSegments) - 1);

_filename = _filenameSegments joinString ".";

_filename;