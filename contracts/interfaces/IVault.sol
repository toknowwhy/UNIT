// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface IVault {

    // The number of all tokens in the pool
    function poolAmounts(address _token) external view returns (uint256);
   
    function increaseCollateral(address _collateralToken, address _receiver) external returns (bool);
    
    function decreaseCollateral(
        address _collateralToken,
        address _receiver, 
        uint256 _collateralAmount
    ) external returns(bool);

    function liquidation(address _token, address _account, address _treasury) external returns (bool);
}