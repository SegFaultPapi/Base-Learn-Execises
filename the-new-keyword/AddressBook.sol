// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    error ContactNotFound(uint id);

    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
        bool exists;
    }

    mapping(uint => Contact) private contacts;
    uint[] private contactIds;

    constructor(address initialOwner) Ownable(initialOwner) {}

    function addContact(
        uint id, 
        string calldata firstName, 
        string calldata lastName, 
        uint[] calldata phoneNumbers
    ) external onlyOwner {
        require(!contacts[id].exists, "Contact already exists");
        contacts[id] = Contact({
            id: id,
            firstName: firstName,
            lastName: lastName,
            phoneNumbers: phoneNumbers,
            exists: true
        });
        contactIds.push(id);
    }

    function deleteContact(uint id) external onlyOwner {
        if (!contacts[id].exists) revert ContactNotFound(id);
        contacts[id].exists = false;
    }

    function getContact(uint id) external view returns (
        uint, string memory, string memory, uint[] memory
    ) {
        if (!contacts[id].exists) revert ContactNotFound(id);
        Contact storage contact = contacts[id];
        return (
            contact.id,
            contact.firstName,
            contact.lastName,
            contact.phoneNumbers
        );
    }

    function getAllContacts() external view returns (Contact[] memory) {
        uint count = 0;
        for (uint i = 0; i < contactIds.length; i++) {
            if (contacts[contactIds[i]].exists) {
                count++;
            }
        }
        Contact[] memory result = new Contact[](count);
        uint j = 0;
        for (uint i = 0; i < contactIds.length; i++) {
            if (contacts[contactIds[i]].exists) {
                result[j] = contacts[contactIds[i]];
                j++;
            }
        }
        return result;
    }
}

contract AddressBookFactory {
    event AddressBookDeployed(address indexed owner, address indexed addressBook);

    function deploy() external returns (address) {
        AddressBook addressBook = new AddressBook(msg.sender);
        emit AddressBookDeployed(msg.sender, address(addressBook));
        return address(addressBook);
    }
}