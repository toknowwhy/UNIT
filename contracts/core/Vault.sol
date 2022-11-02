// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;
import '../interfaces/IVault.sol';
import "../interfaces/IUnitToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault is IVault {

    IUnitToken public unitToken;

    address public priceFeed;

    address public manager;

    constructor(address _unitToken, address _manager) {
        unitToken = IUnitToken(_unitToken);
        manager = _manager;
    }
    
    mapping (address => uint256) public override poolAmounts;

    mapping (address => bool) tokenList;

    mapping (address => mapping (address => uint256) ) public collateralAmount;


    function increaseCollateral(
        address _collateralToken, 
        address _receiver
    ) external returns (bool) {
        require(ICollateralManager(manager).tokenList(_collateralToken), "UintVault: no");
   
        uint256 balance0 = poolAmounts[_collateralToken];
        uint256 balance1 = IERC20(_collateralToken).balanceOf(address(this));

        uint256 balanceDelta = balance1 - balance0;
        require(balanceDelta > 0, "no");

        collateralAmount[_receiver][_collateralToken] += balanceDelta;

        poolAmounts[_collateralToken] += balance1;
        // TODO: Event
    }

    function decreaseCollateral(
        address _collateralToken,
        address _receiver, 
        uint256 _collateralAmount
    ) external returns (bool){

        uint256 balance1 = collateralAmount[msg.sender][_collateralToken];

        require(_collateralAmount <= balance1, "UintVaultDecreaseCollateral: ");

        uint256 maxDecreaseAmount = ICollateralManager(manager).getMaxDecreaseAmount(_collateralToken, msg.sender);

        require(_collateralAmount <= maxDecreaseAmount, "UintVaultDecreaseCollateral: ");

        IERC20(_collateralToken).transfer(_receiver, _collateralAmount);

        collateralAmount[msg.sender][_collateralToken] -= _collateralAmount;
        poolAmounts[_collateralToken] -= _collateralAmount;
    }

    function decreaseCollateralWithPermit(address _token, uint256 _value, bytes memory v, bytes memory r, bytes memory s) external returns (bool)  {
        
    }

    // Anyone can call to complete the liquidation.
    function liquidation(address _token, address _account, address _treasury) external override returns (bool) {

        // ICollateralManager(manager).
        collateralAmount[_account][_collateralToken] = 0;

        IERC20(_collateralToken).transfer(_treasury, _collateralAmount);
    }
}