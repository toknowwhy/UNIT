// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../interfaces/IUnitToken.sol";
import '../interfaces/ICollateralManager.sol';

// Everyone can mint, as long as there is enough collateral.
contract UnitToken is ERC20, IUnitToken {

    address public collateralMananger;
    
    // [user][collateral] => amount
    mapping (address => mapping (address => uint256)) public override unitMintAmount;
    
    constructor(
        address _collateralMananger
    ) ERC20("The Unit Token", "UNIT") {
        collateralMananger = _collateralMananger;
    }

    function mint(address _to, uint256 value, address _collateralToken) external override returns(bool) {
        // ICollateralManager(collateralMananger).mintUnit();
        unitMintAmount[msg.sender][_collateralToken] += value;
        _mint(_to, value);
    }

    function burn(address _to, uint256 value,  address _collateralToken) external override returns(bool) {
        unitMintAmount[msg.sender][_collateralToken] -= value;
        _burn(_to, value);
    }
    
    function liquidation(address _token, address _account) external returns(bool) {
        
    }
}