// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import { DecentralizedStableCoin } from "./DecentralizedStableCoin.sol";
import { ReentrancyGuard } from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
 * @title DSCEngine
 * @author Tanmay Khatri
 *
 * The system is designed to be as minimal as possible, and have the tokens maintain a 1 token == $1 peg at all times.
 * This is a stablecoin with the properties:
 * - Exogenously Collateralized
 * - Dollar Pegged
 * - Algorithmically Stable
 *
 * It is similar to DAI if DAI had no governance, no fees, and was backed by only WETH and WBTC.
 *
 * @notice This contract is the core of the Decentralized Stablecoin system. It handles all the logic
 * for minting and redeeming DSC, as well as depositing and withdrawing collateral.
 * @notice This contract is based on the MakerDAO DSS system
 */
contract DSCEngine is ReentrancyGuard {
    error DSCEngine_NeedsMoreThanZero();
    error DSCEngine_TokenAndPriceFeedLengthShouldMatch();
    error DSCEngine_TokenDoesntExists();

    mapping(address token => address priceFeed) private s_priceFeeds;

    DecentralizedStableCoin private immutable i_dsc;

    modifier moreThanZero(uint amount) {
        if( amount == 0 ) {
            revert DSCEngine_NeedsMoreThanZero();
        }
        _;
    }

    modifier isAllowedToken(address token) {
        if( s_priceFeeds[token] == address(0) ) {
            revert DSCEngine_TokenDoesntExists();
        }
        _;
    }

    constructor(address[] memory tokenAddresses, address[] memory priceFeedAddresses, address dscAddress) {
        if( tokenAddresses.length != priceFeedAddresses.length ) {
            revert DSCEngine_TokenAndPriceFeedLengthShouldMatch();
        }

        for( uint index; index < tokenAddresses.length; index++ ) {
            s_priceFeeds[tokenAddresses[index]] = priceFeedAddresses[index];
        }

        i_dsc = DecentralizedStableCoin(dscAddress);
    }

    function depositCollateral(address tokenCollateralAddress, uint amountCollateral) external isAllowedToken(tokenCollateralAddress) nonReentrant {

    }
}