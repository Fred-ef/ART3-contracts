// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@limitbreak/creator-token-contracts/contracts/access/OwnableBasic.sol";
import "@limitbreak/creator-token-contracts/contracts/erc721c/ERC721C.sol";
import "./Art3MinterRoyalties.sol";

/**
 * @title Art3Tokens
 * @author Fred.ef
 * @notice Instantiation of the ERC721C standard with customized minter royalties that enables minters
 *         to receive royalties on the tokens they mint, according to the Art3 platform's royalty regulations.
 */
contract Art3Tokens is OwnableBasic, ERC721C, Art3MinterRoyalties {

    constructor(
        string memory name_,
        string memory symbol_) 
        ERC721OpenZeppelin(name_, symbol_)  {
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721C, Art3MinterRoyalties) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

    function safeMint(address to, uint256 tokenId) external {
        _safeMint(to, tokenId);
    }

    function burn(uint256 tokenId) external {
        _burn(tokenId);
    }

    function _mint(address to, uint256 tokenId) internal virtual override {
        _onMinted(to, tokenId);
        super._mint(to, tokenId);
    }

    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);
        _onBurned(tokenId);
    }
}