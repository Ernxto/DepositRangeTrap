// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RefundContract {
    address public drosera;

    constructor(address _drosera) {
        drosera = _drosera;
    }

    modifier onlyDrosera() {
        require(msg.sender == drosera, "Only Drosera can trigger this");
        _;
    }

    function refund(address payable user, uint256 amount) external onlyDrosera {
        require(address(this).balance >= amount, "Insufficient funds");
        (bool sent, ) = user.call{value: amount}("");
        require(sent, "Refund failed");
    }

    receive() external payable {}
}