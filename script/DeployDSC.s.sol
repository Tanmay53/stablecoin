// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import { DecentralizedStableCoin } from "../src/DecentralizedStableCoin.sol";
import { DSCEngine } from "../src/DSCEngine.sol";


contract DeployDsc is Script {
    function run() external returns(DecentralizedStableCoin dsc, DSCEngine engine) {
        vm.startBroadcast();
        dsc = new DecentralizedStableCoin();
        engine = new DSCEngine(,, dsc);
        vm.stopBroadcast();
    }
}