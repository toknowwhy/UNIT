// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import '../interfaces/IVault.sol';
contract UnitRouterV1 {
    
    address public vault;

    constructor (address _vault) {
        vault = _vault;
    }

    function increaseCollateral(address _collateralToken, uint256 tokenAmount, address _receiver) public returns(bool) {  
        require( IERC20(_collateralToken).balanceOf(msg.sender) >= tokenAmount, "in");
        IERC20(_collateralToken).transferFrom(msg.sender, vault, tokenAmount);
        
        IVault(vault).increaseCollateral(_collateralToken, _receiver);
    }

    function getCollateral(address _token) public returns(uint256) {
   
    }
}