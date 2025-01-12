// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./TransferPolicy.sol";

interface ITransferValidator {
    function applyCollectionTransferPolicy(address caller, address from, address to) external view;
}