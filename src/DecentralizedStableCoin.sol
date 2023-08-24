// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import { ERC20Burnable, ERC20 } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
/**
 * @title Decentralized Stable Coin
 * @author Tanmay Khatri
 * Collateral: Exogenours (ETH & BTC)
 * Minting: Algorithmic
 * Relative Stability: Pegged to USD
 * 
 * This is the contract mean to be governed by DSCEngine. This contract is just the ERC20 implementation of our stablecoin system.
 */
contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    error DecentralizedStableCoin_MustBeMoreThanZero();
    error DecentralizedStableCoin_BurnAmountExceedsBalance();
    error DecentralizedStableCoin_NoMintingToZeroAddress();

    constructor() ERC20("DecentralizedStableCoin", "DSC") {}

    function burn(uint amount) public override onlyOwner {
        uint balance = balanceOf(msg.sender);
        if( amount <= 0 ) {
            revert DecentralizedStableCoin_MustBeMoreThanZero();
        }
        if( balance < amount ) {
            revert DecentralizedStableCoin_BurnAmountExceedsBalance();
        }
        super.burn(amount);
    }

    function mint(address to, uint amount) external onlyOwner returns(bool) {
        if( to == address(0) ) {
            revert DecentralizedStableCoin_NoMintingToZeroAddress();
        }
        if( amount <= 0 ) {
            revert DecentralizedStableCoin_MustBeMoreThanZero();
        }
        _mint(to, amount);
        return true;
    }
}