// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../contracts/RefundContract.sol";

contract DeployRefund is Script {
    function run() external {
        address droseraOperator = vm.envAddress("DROSERA_OPERATOR");

        vm.startBroadcast();
        RefundContract refund = new RefundContract(droseraOperator);
        vm.stopBroadcast();

        console.log("RefundContract deployed at:", address(refund));
    }
}