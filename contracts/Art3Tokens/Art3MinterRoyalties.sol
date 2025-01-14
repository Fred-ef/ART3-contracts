// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/interfaces/IERC2981.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

/**
 * @title Art3MinterRoyalties
 * @author Limit Break, Inc.
 * @dev Base functionality of an NFT mix-in contract implementing programmable royalties for minters
 */
abstract contract Art3MinterRoyalties is IERC2981, ERC165 {

    error Art3MinterRoyalties__MinterCannotBeZeroAddress();
    error Art3MinterRoyalties__MinterHasAlreadyBeenAssignedToTokenId();

    uint256 public constant FEE_DENOMINATOR = 10_000;

    uint256[] public FEE_THRESHOLDS = [
        50000,  // up to 50.000 €
        200000, // up to 200.000 €
        350000, // up to 350.000 €
        500000  // up to 500.000 €
    ];

    uint256[] public FEE_NUMERATORS = [
        400, // 4%
        300, // 3%
        100, // 1%
        50,  // 0.5%
        25   // 0.25%
    ];

    mapping (uint256 => address) private _minters;
    

    /**
     * @notice Indicates whether the contract implements the specified interface.
     * @dev Overrides supportsInterface in ERC165.
     * @param interfaceId The interface id
     * @return true if the contract implements the specified interface, false otherwise
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return interfaceId == type(IERC2981).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @notice Computes the royalty amount for a given sale price.
     * @dev Is used by functions that calculate the royalty persentage or that return info on royalties
     * @param salePrice The sale price
     * @return royaltyAmount The royalty amount based on the sale price
     */
    function computeRoyalty(uint256 salePrice) internal view returns (uint256 royaltyAmount) {
        uint256 remainingPrice = salePrice;
        uint256 processedAmount = 0;
        uint256 currentThreshold = 0;

        for (uint256 i = 0; i < FEE_THRESHOLDS.length;) {
            if (remainingPrice == 0) {
                break; // All parts of the sale price are processed
            }

            currentThreshold = FEE_THRESHOLDS[i] - processedAmount;

            uint256 applicablePrice = (remainingPrice <= currentThreshold)
                ? remainingPrice
                : currentThreshold;

            royaltyAmount += (applicablePrice * FEE_NUMERATORS[i]) / FEE_DENOMINATOR;
            remainingPrice -= applicablePrice;
            processedAmount += applicablePrice;

            unchecked {
                ++i;
            }
        }

        // Handle the remaining price for the final threshold (above 500,000 €)
        if (remainingPrice > 0) {
            royaltyAmount += (remainingPrice * FEE_NUMERATORS[FEE_NUMERATORS.length - 1]) / FEE_DENOMINATOR;
        }

        return royaltyAmount;
    }

    /**
     * @notice Computes the royalty, as a percentage in basis points, applicable to the given sale price.
     * @dev Uses the computeRoyalty function to calculate the royalty amount and then converts it to a percentage.
     * @param salePrice The sale price
     * @return royaltyFeeNumerator The percentage, in basis points, of the royalty fee based on the sale price
     */
    function royaltyFeeNumerator(uint256 salePrice) public virtual view returns (uint16) {
        uint256 royaltyAmount = computeRoyalty(salePrice);
        return uint16((royaltyAmount * FEE_DENOMINATOR) / salePrice);
    }

    /**
     * @notice Returns the royalty info for a given token ID and sale price.
     * @dev Implements the IERC2981 interface.
     * @param tokenId The token ID
     * @param salePrice The sale price
     * @return receiver The minter's address
     * @return royaltyAmount The royalty amount
     */
    function royaltyInfo(
        uint256 tokenId,
        uint256 salePrice
    ) external view override returns (address receiver, uint256 royaltyAmount) {
        return (_minters[tokenId], computeRoyalty(salePrice));
    }

    /**
     * @dev Internal function to be called when a new token is minted.
     *
     * @dev Throws when the minter is the zero address.
     * @dev Throws when a minter has already been assigned to the specified token ID.
     * @param minter The minter's address
     * @param tokenId The token ID
     */
    function _onMinted(address minter, uint256 tokenId) internal {
        if (minter == address(0)) {
            revert Art3MinterRoyalties__MinterCannotBeZeroAddress();
        }

        if (_minters[tokenId] != address(0)) {
            revert Art3MinterRoyalties__MinterHasAlreadyBeenAssignedToTokenId();
        }

        _minters[tokenId] = minter;
    }

    /**
     * @dev Internal function to be called when a token is burned.  Clears the minter's address.
     * @param tokenId The token ID
     */
    function _onBurned(uint256 tokenId) internal {
        delete _minters[tokenId];
    }
}