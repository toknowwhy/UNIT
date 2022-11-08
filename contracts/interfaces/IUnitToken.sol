// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface IUnitToken {
    function mint(address _to, uint256 value, address _collateralToken) external returns(bool);
    function burn(address _to, uint256 value, address _collateralToken) external returns(bool);
    function unitMintAmount(address _account, address _collateralToken) external returns( uint256);
        
    
}