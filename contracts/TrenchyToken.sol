// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title TRENCHY Token
 * @dev ERC-20 Token for TrenchyBet Prediction Market
 * Total Supply: 1,000,000,000 TRENCHY (1 billion)
 * Deployed on Base Network
 */
contract TrenchyToken is ERC20, ERC20Burnable, Pausable, Ownable {
    
    /// @notice Maximum supply: 1 billion tokens with 18 decimals
    uint256 public constant MAX_SUPPLY = 1_000_000_000 * 10**18;
    
    /**
     * @dev Constructor mints entire supply to deployer for controlled distribution
     * @notice All tokens minted at deployment - no future minting possible
     */
    constructor() ERC20("Trenchy", "TRENCHY") Ownable(msg.sender) {
        _mint(msg.sender, MAX_SUPPLY);
    }
    
    /**
     * @dev Pauses all token transfers
     * @notice Emergency function - only callable by owner
     */
    function pause() public onlyOwner {
        _pause();
    }
    
    /**
     * @dev Unpauses all token transfers
     */
    function unpause() public onlyOwner {
        _unpause();
    }
    
    /**
     * @dev Override _update to add pause functionality
     * @notice Called on all transfers, mints, and burns
     */
    function _update(
        address from,
        address to,
        uint256 value
    ) internal override whenNotPaused {
        super._update(from, to, value);
    }
}