// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicMath {

    function adder(uint _a, uint _b) public pure returns (uint sum, bool error) {
        unchecked {
            uint result = _a + _b;
            if (result < _a) {
                return (0, true);
            }
            return (result, false);
        }
    }

    function subtractor(uint _a, uint _b) public pure returns (uint difference, bool error) {
        if (_b > _a) {
            return (0, true);
        }
        return (_a - _b, false);
    }
}
