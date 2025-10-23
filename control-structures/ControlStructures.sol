// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ControlStructures {

    error AfterHours(uint _time);

    function fizzBuzz(uint _number) public pure returns (string memory) {
        if (_number % 3 == 0 && _number % 5 == 0) {
            return "FizzBuzz";
        } else if (_number % 3 == 0) {
            return "Fizz";
        } else if (_number % 5 == 0) {
            return "Buzz";
        } else {
            return "Splat";
        }
    }

    // Do Not Disturb Function
    function doNotDisturb(uint _time) public pure returns (string memory) {
        if (_time >= 2400) {
            // Trigger a panic condition using assert
            assert(_time < 2400);
        } else if (_time > 2200 || _time < 800) {
            // Use custom error for after-hours times
            revert AfterHours(_time);
        } else if (_time >= 1200 && _time <= 1259) {
            // Use revert with a string message
            revert("At lunch!");
        } else if (_time >= 800 && _time <= 1199) {
            return "Morning!";
        } else if (_time >= 1300 && _time <= 1799) {
            return "Afternoon!";
        } else if (_time >= 1800 && _time <= 2200) {
            return "Evening!";
        } else {
            // Should never reach here if conditions are complete
            return "Unknown time range.";
        } 
        revert("Invalid time"); // Force termination if no condition matches
    }
}
