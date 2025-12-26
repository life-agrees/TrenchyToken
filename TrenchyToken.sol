// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title TRENCHY Token
 * @dev ERC-20 Token for TrenchyBet Prediction Market
 * Total Supply: 1,000,000,000 TRENCHY (1 billion)
 * Deployed on Base Network
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TrenchyToken is ERC20, ERC20Burnable, Pausable, Ownable {
    
    // Maximum supply: 1 billion tokens with 18 decimals
    uint256 public constant MAX_SUPPLY = 1_000_000_000 * 10**18;
    
    // Flag to ensure minting can only happen once
    bool private _hasInitialMintOccurred;
    
    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     */
    constructor() ERC20("Trenchy", "TRENCHY") Ownable(msg.sender) {
        // Mint the entire supply to the deployer
        _mint(msg.sender, MAX_SUPPLY);
        _hasInitialMintOccurred = true;
    }
    
    /**
     * @dev Pauses all token transfers.
     * Requirements:
     * - the caller must be the owner.
     */
    function pause() public onlyOwner {
        _pause();
    }
    
    /**
     * @dev Unpauses all token transfers.
     * Requirements:
     * - the caller must be the owner.
     */
    function unpause() public onlyOwner {
        _unpause();
    }
    
    /**
     * @dev Override _update to add pause functionality
     * This is called on all transfers, mints, and burns
     */
    function _update(
        address from,
        address to,
        uint256 value
    ) internal override whenNotPaused {
        super._update(from, to, value);
    }
    
    /**
     * @dev Returns true if initial mint has occurred
     */
    function hasInitialMintOccurred() public view returns (bool) {
        return _hasInitialMintOccurred;
    }
}