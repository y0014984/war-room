params ["_horizontalResolution", "_verticalResolution"];

private _resolutionSettings = [256, 512, 1024, 2048, 4096];

systemChat format ["Set screen resolution to %1x%2", _resolutionSettings select _horizontalResolution, _resolutionSettings select _verticalResolution];

true;