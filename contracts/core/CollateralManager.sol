
// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import '../interfaces/ICollateralManager.sol';

contract CollateralManager is ICollateralManager {
    struct CollateralDetail{

    }

    mapping (address => uint256) public override liquidationFee;

    mapping (address => bool) public tokenList;

    function addToken(address _token) public {
        tokenList[_token] = true;
    }

    function liquidationPrice(address token) public returns(uint256) {
        
    }

    function getMaxDecreaseAmount(address _token, address _account) external returns(uint256) {
        
    }

    // Only Updater
    function liquidation(address _token, address _account) external returns(bool) {
        
    }
}