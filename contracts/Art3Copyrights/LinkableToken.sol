// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./ILinkableToken.sol";

abstract contract LinkableToken is ILinkableToken {

    error LinkableToken__InvalidLinkedCollectionAddress();

    struct LinkedToken {
        uint256 linkedTokenId;
        address linkedCollection;
    }

    mapping(uint256 => LinkedToken) internal _linkedTokens;

    function _linkToken(uint256 tokenId, uint256 linkedTokenId, address linkedCollection) internal {
        _linkedTokens[tokenId] = LinkedToken(linkedTokenId, linkedCollection);
        emit TokenLinked(tokenId, linkedTokenId, linkedCollection);
    }

    function getLinkedToken(uint256 Id) external view returns (uint256, address) {
        LinkedToken memory linkedToken = _linkedTokens[Id];
        return (linkedToken.linkedTokenId, linkedToken.linkedCollection);
    }
}