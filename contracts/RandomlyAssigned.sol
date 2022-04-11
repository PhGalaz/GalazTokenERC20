// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./WithLimitedSupply.sol";

/// @author 1001.digital
/// @title Randomly assign tokenIDs from a given set of tokens.
abstract contract RandomlyAssigned is WithLimitedSupply {
    // Used for random index assignment
    mapping(uint256 => uint256) private tokenMatrix;

    // The initial token ID
    uint256 private startFrom = 1;
    uint256 private startFromTier1 = 8501;
    uint256 private startFromTier2 = 1;

    /// Get the next token ID
    /// @dev Randomly gets a new token ID and keeps track of the ones that are still available.
    /// @return the next token ID
    function nextTokenForTier1() internal override ensureAvailabilityTier1 returns (uint256) {
        uint256 maxIndex = totalSupplyNftTier1() - tokenCountForTier1();
        uint256 random = uint256(keccak256(
            abi.encodePacked(
                msg.sender,
                block.coinbase,
                block.difficulty,
                block.gaslimit,
                block.timestamp
            )
        )) % maxIndex;

        uint256 value = 0;
        if (tokenMatrix[random] == 0) {
            // If this matrix position is empty, set the value to the generated random number.
            value = random;
        } else {
            // Otherwise, use the previously stored number from the matrix.
            value = tokenMatrix[random];
        }

        // If the last available tokenID is still unused...
        if (tokenMatrix[maxIndex - 1] == 0) {
            // ...store that ID in the current matrix position.
            tokenMatrix[random] = maxIndex - 1;
        } else {
            // ...otherwise copy over the stored number to the current matrix position.
            tokenMatrix[random] = tokenMatrix[maxIndex - 1];
        }

        // Increment counts
        super.nextTokenForTier1();

        return value + startFromTier1;
    }


    /// Get the next token ID
    /// @dev Randomly gets a new token ID and keeps track of the ones that are still available.
    /// @return the next token ID
    function nextTokenForTier2() internal override ensureAvailabilityTier2 returns (uint256) {
        uint256 maxIndex = totalSupplyNftTier2() - tokenCountForTier2();
        uint256 random = uint256(keccak256(
            abi.encodePacked(
                msg.sender,
                block.coinbase,
                block.difficulty,
                block.gaslimit,
                block.timestamp
            )
        )) % maxIndex;

        uint256 value = 0;
        if (tokenMatrix[random] == 0) {
            // If this matrix position is empty, set the value to the generated random number.
            value = random;
        } else {
            // Otherwise, use the previously stored number from the matrix.
            value = tokenMatrix[random];
        }

        // If the last available tokenID is still unused...
        if (tokenMatrix[maxIndex - 1] == 0) {
            // ...store that ID in the current matrix position.
            tokenMatrix[random] = maxIndex - 1;
        } else {
            // ...otherwise copy over the stored number to the current matrix position.
            tokenMatrix[random] = tokenMatrix[maxIndex - 1];
        }

        // Increment counts
        super.nextTokenForTier2();

        return value + startFromTier2;
    }
}
