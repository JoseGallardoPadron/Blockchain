// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract MultiTransaction {
    event TransactionSent(address indexed recipient, uint256 amount);

    function sendTransactions(address payable[] memory _recipients, uint256[] memory _amounts) public payable {
        require(_recipients.length == _amounts.length, "Los arrays deben tener la misma longitud");
        uint256 totalAmount = 0;

        // Calcular el total a enviar
        for (uint256 i = 0; i < _amounts.length; i++) {
            totalAmount += _amounts[i];
        }

        require(address(this).balance >= totalAmount, "Saldo insuficiente");

        // Realizar las transferencias
        for (uint256 i = 0; i < _recipients.length; i++) {
            _recipients[i].transfer(_amounts[i]);
            emit TransactionSent(_recipients[i], _amounts[i]);
        }
    }
}
