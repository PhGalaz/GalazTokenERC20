// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/utils/Counters.sol";

/// @title A token tracker that limits the token supply and increments token IDs on each new mint.
abstract contract WithLimitedSupply {
    using Counters for Counters.Counter;

    // Keeps track of how many we have minted
    Counters.Counter private _tokenCount;
    Counters.Counter private _tokenCountTier1;
    Counters.Counter private _tokenCountTier2;

    /// @dev The maximum count of tokens this token tracker will hold.
    uint256 private _totalSupply;
    uint256 private _totalSupplyTier1;
    uint256 private _totalSupplyTier2;

    /// Instanciate the contract
    ///param totalSupply_ how many tokens this collection should hold
    constructor () {

        _totalSupply = 10000;
        _totalSupplyTier1 = 1500;
        _totalSupplyTier2 = 8500;
    }

     /// @dev Get the max Supply
    /// @return the maximum token count
    function totalSupplyNftTier1() public view returns (uint256) {
        return _totalSupplyTier1;
    }

    /// @dev Get the max Supply
    /// @return the maximum token count
    function totalSupplyNftTier2() public view returns (uint256) {
        return _totalSupplyTier2;
    }

    /// @dev Get the current token count
    /// @return the created token count
    function tokenCountForTier1() public view returns (uint256) {
        return _tokenCountTier1.current();
    }

    /// @dev Get the current token count
    /// @return the created token count
    function tokenCountForTier2() public view returns (uint256) {
        return _tokenCountTier2.current();
    }

    /// @dev Check whether tokens are still available
    /// @return the available token count
    function availableTokenCountTier1() public view returns (uint256) {
        return (totalSupplyNftTier1() - tokenCountForTier1());
    }

    /// @dev Check whether tokens are still available
    /// @return the available token count
    function availableTokenCountTier2() public view returns (uint256) {
        return (totalSupplyNftTier2() - tokenCountForTier2());
    }



    /// @dev Increment the token count and fetch the latest count
    /// @return the next token id
    function nextTokenForTier2() internal virtual ensureAvailabilityTier2 returns (uint256) {
        uint256 token = _tokenCountTier2.current();

        _tokenCountTier2.increment();

        return token;
    }

    /// @dev Increment the token count and fetch the latest count
    /// @return the next token id
    function nextTokenForTier1() internal virtual ensureAvailabilityTier1 returns (uint256) {
        uint256 token = _tokenCountTier1.current();

        _tokenCountTier1.increment();

        return token;
    }



    /// @dev Check whether another token is still available
    modifier ensureAvailabilityTier2() {
        require(availableTokenCountTier2() > 0, "No more tokens available");
        _;
    }
    /// @dev Check whether another token is still available
    modifier ensureAvailabilityTier1() {
        require(availableTokenCountTier1() > 0, "No more tokens available");
        _;
    }

    /// @param amount Check whether number of tokens are still available
    /// @dev Check whether tokens are still available
    modifier ensureAvailabilityForTier1(uint256 amount) {
        require(availableTokenCountTier1() >= amount, "Requested number of tokens not available");
        _;
    }

    /// @param amount Check whether number of tokens are still available
    /// @dev Check whether tokens are still available
    modifier ensureAvailabilityForTier2(uint256 amount) {
        require(availableTokenCountTier2() >= amount, "Requested number of tokens not available");
        _;
    }
}
