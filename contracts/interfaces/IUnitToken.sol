// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface IUnitToken {
    function mint(address _to, uint256 value) external returns(bool);
    function burn(address _to, uint256 value) external returns(bool);
}