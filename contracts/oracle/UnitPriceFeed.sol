// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import '../interfaces/IPriceFeed.sol';

contract UnitPriceFeed is IPriceFeed {
    mapping (address => bool) public isUpdater;

    modifier onlyUpdater() {
        require(isUpdater[msg.sender], "UnitPriceFeed: forbidden");
        _;
    }

    function getPriceData(address _token) public view returns (uint256, uint256, uint256, uint256) {
      
    }

    function setPrices(address[] memory _tokens, uint256[] memory _prices, uint256 _timestamp) external onlyUpdater {
       
    }
}
