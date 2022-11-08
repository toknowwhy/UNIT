// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestToken is ERC20 {
    constructor(
    ) ERC20("Test", "Test") {

    }

    function mint(address _to, uint256 value) external returns(bool) {
        _mint(_to, value);
    }

    function burn(address _to, uint256 value) external returns(bool) {
        _burn(_to, value);
    }
}