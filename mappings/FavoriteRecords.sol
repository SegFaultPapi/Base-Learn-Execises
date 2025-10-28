// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FavoriteRecords {
    // State Variables
    mapping(string => bool) public approvedRecords;
    mapping(address => mapping(string => bool)) public userFavorites;
    string[] private approvedRecordNames;

    // Custom Errors
    error NotApproved(string albumName);

    // Constructor: load approved albums
    constructor() {
        string[9] memory albums = [
            "Thriller",
            "Back in Black",
            "The Bodyguard",
            "The Dark Side of the Moon",
            "Their Greatest Hits (1971-1975)",
            "Hotel California",
            "Come On Over",
            "Rumours",
            "Saturday Night Fever"
        ];
        for (uint256 i = 0; i < albums.length; i++) {
            approvedRecords[albums[i]] = true;
            approvedRecordNames.push(albums[i]);
        }
    }

    // Get Approved Records
    function getApprovedRecords() external view returns (string[] memory) {
        return approvedRecordNames;
    }

    // Add Record to Favorites
    function addRecord(string calldata albumName) external {
        if (!approvedRecords[albumName]) {
            revert NotApproved(albumName);
        }
        userFavorites[msg.sender][albumName] = true;
    }

    // Get User Favorites
    function getUserFavorites(address user) external view returns (string[] memory) {
        uint256 count = 0;
        // Count favorites
        for (uint256 i = 0; i < approvedRecordNames.length; i++) {
            if (userFavorites[user][approvedRecordNames[i]]) {
                count++;
            }
        }
        string[] memory favorites = new string[](count);
        uint256 idx = 0;
        for (uint256 i = 0; i < approvedRecordNames.length; i++) {
            if (userFavorites[user][approvedRecordNames[i]]) {
                favorites[idx] = approvedRecordNames[i];
                idx++;
            }
        }
        return favorites;
    }

    // Reset My Favorites
    function resetUserFavorites() external {
        for (uint256 i = 0; i < approvedRecordNames.length; i++) {
            userFavorites[msg.sender][approvedRecordNames[i]] = false;
        }
    }
}
