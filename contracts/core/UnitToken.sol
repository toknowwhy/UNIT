// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../interfaces/IUnitToken.sol";

contract UnitToken is ERC20, IUnitToken {

    mapping (address => bool) public minter;

    constructor() ERC20("The Unit Token", "UNIT") {
    }

    function mint(address _to, uint256 value) public override returns(bool) {
        
    }

    function burn(address _to, uint256 value) public override returns(bool) {
        
    }
}