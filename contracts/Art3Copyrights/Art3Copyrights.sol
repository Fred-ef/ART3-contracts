// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./ExpirableTransferToken.sol";
import "./LinkableToken.sol";

contract Art3Copyrights is ERC721, ExpirableTransferToken, LinkableToken {

    error Art3Copyrights__CannotTransferExpiredToken();
    error Art3Copyrights__ExpiryDateAlreadyPassed();
    error Art3Copyrights__CallerIsNotTokenOwner();

    uint256 private nextTokenId;

    constructor(
        string memory name_, 
        string memory symbol_) 
    ERC721(name_,symbol_) {}


    function safeMint(address to, uint256 linkedTokenId, address linkedCollection, uint256 endBlock) public {
        // Check that linkedCollection is a contract and supports the ERC721 interface
        if(!(linkedCollection.code.length > 0) || !(IERC165(linkedCollection).supportsInterface(type(IERC721).interfaceId))) {
            revert LinkableToken__InvalidLinkedCollectionAddress();
        }
        // Check that the caller is the owner of the linked token
        if(IERC721(linkedCollection).ownerOf(linkedTokenId) != msg.sender) {
            revert Art3Copyrights__CallerIsNotTokenOwner();
        }
        // Check that the expiry date has not already passed, if one is specified
        if ((endBlock != 0) && (endBlock < block.number)) {
            revert Art3Copyrights__ExpiryDateAlreadyPassed();
        }

        // token minting
        uint256 tokenId = nextTokenId++;
        _safeMint(to, tokenId);

        // token linking
        _linkToken(tokenId, linkedTokenId, linkedCollection);

        // token expiration
        _startBlock[tokenId] = block.number;
        _endBlock[tokenId] = endBlock;

        // event emission
        emit ExpirationUpdated(tokenId, block.number, endBlock);
        emit TokenLinked(tokenId, linkedTokenId, linkedCollection);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 firstTokenId,
        uint256 batchSize
    ) internal view override {
        if(!(_isTokenValid(firstTokenId))) {
            revert Art3Copyrights__CannotTransferExpiredToken();
        }
    }
}