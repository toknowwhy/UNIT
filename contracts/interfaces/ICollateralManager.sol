
// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface ICollateralManager {
    function liquidationFee(address) external view returns(uint256);
}