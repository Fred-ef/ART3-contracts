// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./IExpirableTransferToken.sol";

abstract contract ExpirableTransferToken is IExpirableTransferToken {

    // mapping variable
    mapping(uint256 => uint256) internal _startBlock;
    mapping(uint256 => uint256) internal _endBlock;

    function startTime(uint256 tokenId) public view returns (uint256) {
        return _startBlock[tokenId];
    }

    function endTime(uint256 tokenId) public view returns (uint256) {
        return _endBlock[tokenId];
    }

    function isTokenValid(uint256 tokenId) external view returns (bool) {
        return _isTokenValid(tokenId);
    }

    function _isTokenValid(uint256 tokenId) internal view returns (bool) {
        uint256 endTimeCache = endTime(tokenId);
        if (endTimeCache == 0) {
            return true;
        } else {
            return block.number <= endTimeCache;
        }
    }
}