// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PharmaTrack {

    struct Medicine {
        uint id;
        string name;
        address owner;
        string status;
    }

    uint public medicineCount = 0;

    mapping(uint => Medicine) public medicines;

    event MedicineAdded(uint id, string name, address owner);
    event OwnershipTransferred(uint id, address newOwner, string status);

    function addMedicine(string memory _name) public {
        medicineCount++;
        medicines[medicineCount] = Medicine(
            medicineCount,
            _name,
            msg.sender,
            "Manufactured"
        );

        emit MedicineAdded(medicineCount, _name, msg.sender);
    }

    function transferOwnership(uint _id, address _newOwner, string memory _status) public {
        require(medicines[_id].owner == msg.sender, "Not owner");

        medicines[_id].owner = _newOwner;
        medicines[_id].status = _status;

        emit OwnershipTransferred(_id, _newOwner, _status);
    }

    function getMedicine(uint _id) public view returns (Medicine memory) {
        return medicines[_id];
    }
}
