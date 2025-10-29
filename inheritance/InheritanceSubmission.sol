// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ------- Contrato base abstracto -------
abstract contract Employee {
    uint public idNumber;
    uint public managerId;

    constructor(uint _idNumber, uint _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    function getAnnualCost() public view virtual returns (uint);
}

// ------- Contrato Salaried -------
contract Salaried is Employee {
    uint public annualSalary;

    constructor(uint _idNumber, uint _managerId, uint _annualSalary)
        Employee(_idNumber, _managerId)
    {
        annualSalary = _annualSalary;
    }

    function getAnnualCost() public view override returns (uint) {
        return annualSalary;
    }
}

// ------- Contrato Hourly -------
contract Hourly is Employee {
    uint public hourlyRate;

    constructor(uint _idNumber, uint _managerId, uint _hourlyRate)
        Employee(_idNumber, _managerId)
    {
        hourlyRate = _hourlyRate;
    }

    function getAnnualCost() public view override returns (uint) {
        return hourlyRate * 2080;
    }
}

// ------- Contrato Manager -------
contract Manager {
    uint[] public reportIds;

    function addReport(uint employeeId) public {
        reportIds.push(employeeId);
    }

    function resetReports() public {
        delete reportIds;
    }
}

// ------- Contrato Salesperson (Hereda de Hourly) -------
contract Salesperson is Hourly {
    constructor() Hourly(55555, 12345, 20) {}
}

// ------- Contrato EngineeringManager (Herencia múltiple) -------
// Salaried primero porque la herencia múltiple en Solidity requiere que los contratos
// con constructor se pongan primero en la lista de herencia.
contract EngineeringManager is Salaried, Manager {
    constructor()
        Salaried(54321, 11111, 200000)
    {}
}

// ------- Contrato de submission -------
contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}