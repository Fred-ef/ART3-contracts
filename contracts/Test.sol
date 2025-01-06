//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'hardhat/console.sol';

contract Test {
    uint256 public value;

    constructor() {
        console.log("Deploying a Test contract");
        value = 15;
    }

    function setValue(uint256 _value) public {
        value = _value;
    }
}