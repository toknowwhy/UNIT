
// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import '../interfaces/ICollateralManager.sol';
import "../interfaces/IUnitToken.sol";

contract CollateralManager is ICollateralManager {

    struct CollateralDetail{
        uint256 marginRate;
        uint256 maintenanceMarginRate;
    }

    mapping (address => CollateralDetail) public collateralsDetail;
    address public priceFeed;
    address public unitToken;

    constructor(address _priceFeed, address _unitToken) {
        priceFeed = _priceFeed;
        unitToken = _unitToken;
    }

    mapping (address => uint256) public override liquidationFee;

    mapping (address => bool) public tokenList;

    function addCollateral(address _token, CollateralDetail memory cd) public {
        collateralsDetail[_token] = cd;
    }

    function liquidationPrice(address token) public returns(uint256) {
        
    }

    function getMaxDecreaseCollateralAmount(address _token, address _account) external view returns(uint256) {
    //     uint256 _unitAmount = IUnitToken(unitToken).unitMintAmount(_account, _token);
    //     if(_unitAmount == 0) {
    //         return uint256(2**256) -1;
    //     }

    //    CollateralDetail memory cd = collateralsDetail[_token];

    //    calculate();
        // _amount
        return 100000000000000000000000000;
    }

    function calculate(uint256 name) internal pure {
        
    }

    // Only Updater
    function liquidation(address _token, address _account) external returns(bool) {
        
    }
}