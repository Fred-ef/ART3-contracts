// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface ILinkableToken {

    event TokenLinked(
        uint256 indexed tokenId,
        uint256 indexed linkedTokenId,
        address indexed linkedCollection
    );

    /**
     * @dev Checks which external token is linked to THIS token
     * @param Id The identifier representing the token type `Id` (ERC1155) or `tokenId` (ERC721).
     * @return (tokenId, collectionAddress) of the external token linked to THIS token
     */
    function getLinkedToken(uint256 Id) external view returns (uint256, address);
}