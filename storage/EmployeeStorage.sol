// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeStorage {
    error TooManyShares(uint256 totalShares);
    
    uint16 private shares;      // Max 65,535 (sufficient for max 5,000)
    uint24 private salary;      // Max 16,777,215 (sufficient for max 1,000,000)
    
    string public name;
    
    //idNumber (uint256) - requires full slot for up to 2^256-1
    uint256 public idNumber;
    
    // Constructor to initialize all state variables
    constructor(
        uint16 _shares, 
        string memory _name, 
        uint24 _salary,
        uint256 _idNumber
    ) {
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }
    
    // View function to return salary
    function viewSalary() public view returns (uint24) {
        return salary;
    }
    
    // View function to return shares
    function viewShares() public view returns (uint16) {
        return shares;
    }
    
    // Function to grant additional shares with validation
    function grantShares(uint16 _newShares) public {
        // Check if _newShares itself is greater than 5000
        if (_newShares > 5000) {
            revert("Too many shares");
        }
        
        // Calculate total shares after adding new shares
        uint256 totalShares = uint256(shares) + uint256(_newShares);
        
        // Check if total would exceed 5000
        if (totalShares > 5000) {
            revert TooManyShares(totalShares);
        }
        
        // Add the new shares
        shares = uint16(totalShares);
    }
    
    /**
     * Do not modify this function.  It is used to enable the unit test for this pin
     * to check whether or not you have configured your storage variables to make
     * use of packing.
     *
     * If you wish to cheat, simply modify this function to always return `0`
     * I'm not your boss ¯\_(ツ)_/¯
     *
     * Fair warning though, if you do cheat, it will be on the blockchain having been
     * deployed by your wallet....FOREVER!
     */
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload (_slot)
        }
    }

    /**
     * Warning: Anyone can use this function at any time!
     */
    function debugResetShares() public {
        shares = 1000;
    }
}