// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../contracts/RefundContract.sol";

contract DeployRefund is Script {
    function run() external {
        address droseraOperator = address(0x7444c52B50011E37d9f516d25Ee51A33309e6A4b);

        vm.startBroadcast();
        RefundContract refund = new RefundContract(droseraOperator);
        vm.stopBroadcast();

        console.log("RefundContract deployed at:", address(refund));
    }
}