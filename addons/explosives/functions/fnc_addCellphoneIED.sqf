/*
 * Author: Garth 'L-H' de Wet
 * Adds an IED to the cellphone list
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Explosive <OBJECT>
 * 2: Magazine classname <STRING>
 * 3: Extra variables <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * Handled by PlaceExplosive.
 *
 * Public: No
 */
#include "script_component.hpp"
EXPLODE_4_PVT(_this,_unit,_explosive,_magazineClass,_extra);
// Config is the last item in the list of passed in items.
_config = (_this select 3) select (count (_this select 3) - 1);

_requiredItems = getArray(_config >> "requires");
_hasRequired = true;
_detonators = [_unit] call FUNC(getDetonators);
{
  if !(_x in _detonators) exitWith{
    _hasRequired = false;
  };
} count _requiredItems;
private ["_code", "_count"];
_code = str(round (random 9999));
_count = 4 - count (toArray _code);
while {_count > 0} do {
  _code = "0" + _code;
  _count = _count - 1;
};
if (isNil QGVAR(CellphoneIEDs)) then {
  GVAR(CellphoneIEDs) = [];
};
_count = GVAR(CellphoneIEDs) pushBack [_explosive,_code];
_count = _count + 1;
publicVariable QGVAR(CellphoneIEDs);
_unit sideChat format ["IED %1 code: %2", _count,_code];
if !(_hasRequired) exitWith {};
[format ["IED %1", _count],_code] call FUNC(addToSpeedDial);
