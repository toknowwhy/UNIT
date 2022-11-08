// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;
import '../interfaces/IVault.sol';
import "../interfaces/IUnitToken.sol";
import '../interfaces/ICollateralManager.sol';

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault is IVault {

    event IncreaseCollateral (
        address indexed receiver,
        address collateralToken,
        uint256 amount
    );

    event DecreaseCollateral (
        address indexed receiver,
        address collateralToken,
        uint256 _collateralAmount
    );

    // IUnitToken public unitToken;
    address public priceFeed;

    address public manager;

    constructor(address _unitToken, address _manager) {
        manager = _manager;
    }
    
    mapping (address => uint256) public override poolAmounts;
    mapping (address => mapping (address => uint256) ) public collateralAmount;

    function increaseCollateral(
        address _collateralToken, 
        address _receiver
    ) external override returns (bool) {
        uint256 balance0 = poolAmounts[_collateralToken];
        uint256 balance1 = IERC20(_collateralToken).balanceOf(address(this));

        uint256 balanceDelta = balance1 - balance0;
        require(balanceDelta > 0, "no");

        collateralAmount[_receiver][_collateralToken] += balanceDelta;
        poolAmounts[_collateralToken] += balance1;
        emit IncreaseCollateral(_receiver, _collateralToken, balanceDelta);
    }

    function decreaseCollateral(
        address _collateralToken,
        address _receiver,
        uint256 _collateralAmount
    ) external override returns (bool){

        uint256 balance1 = collateralAmount[msg.sender][_collateralToken];

        require(_collateralAmount <= balance1, "UintVaultDecreaseCollateral: _collateralAmount <= balance1");

        uint256 maxDecreaseAmount = ICollateralManager(manager).getMaxDecreaseCollateralAmount(_collateralToken, msg.sender);

        require(_collateralAmount <= maxDecreaseAmount, "UintVaultDecreaseCollateral: maxDecreaseAmount");

        collateralAmount[msg.sender][_collateralToken] -= _collateralAmount;
        poolAmounts[_collateralToken] -= _collateralAmount;

        IERC20(_collateralToken).transfer(_receiver, _collateralAmount);

        emit DecreaseCollateral(_receiver, _collateralToken, _collateralAmount);
    }

    function decreaseCollateralWithPermit(address _token, uint256 _value, bytes memory v, bytes memory r, bytes memory s) external returns (bool)  {
        
    }

    // Anyone can call to complete the liquidation.
    function liquidation(address _collateralToken, address _account, address _treasury) external override returns (bool) {

        // ICollateralManager(manager).
        uint256 amount = collateralAmount[_account][_collateralToken];

        IERC20(_collateralToken).transfer(_treasury, amount);

        // collateralAmount[_account][_collateralToken] = 0;
        // IERC20(_collateralToken).transfer(_treasury, _collateralAmount);
    }
}