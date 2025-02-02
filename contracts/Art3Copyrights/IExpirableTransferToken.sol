// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IExpirableTransferToken {

    event ExpirationUpdated(
        uint256 indexed tokenId,
        uint256 indexed startTime,
        uint256 indexed endTime
    );

    /**
     * @dev Checks whether a specific token is expired.
     * @param Id The identifier representing the token type `Id` (ERC1155) or `tokenId` (ERC721).
     * @return bool True if the token is expired, false otherwise.
     */
    function isTokenValid(uint256 Id) external view returns (bool);

    // inherit from ERC-5007 return depends on the type `block.timestamp` or `block.number`
    // {ERC-5007} return in uint64 MAY not suitable for `block.number` based.
    function startTime(uint256 tokenId) external view returns (uint256);
    function endTime(uint256 tokenId) external view returns (uint256);
}