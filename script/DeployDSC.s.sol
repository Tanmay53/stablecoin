// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DecentralizedStableCoin} from "../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../src/DSCEngine.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployDsc is Script {
    address[] public tokenAddresses;
    address[] public priceFeedAddresses;

    function run() external returns (DecentralizedStableCoin dsc, DSCEngine engine) {
        HelperConfig config = new HelperConfig();

        (address wethUsdPriceFeed, address, address weth, address wbtc, uint256 deployerKey) =
            config.s_activeNetworkConfig();

        tokenAddresses = [weth, wbtc];

        priceFeedAddresses = [wethUsdPriceFeed, wbtcUsdPriceFeed];

        vm.startBroadcast();
        dsc = new DecentralizedStableCoin();
        engine = new DSCEngine(tokenAddresses, priceFeedAddresses, address(dsc));

        dsc.tranferOwnership(address(engine));
        vm.stopBroadcast();
    }
}
