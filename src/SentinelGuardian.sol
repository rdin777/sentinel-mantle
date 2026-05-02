// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title SentinelGuardian
 * @dev Реализует защиту от накопления "пыли" (Dust Leaks) и нарушения инвариантов.
 */
contract SentinelGuardian is Pausable, AccessControl {
    bytes32 public constant AGENT_ROLE = keccak256("AGENT_ROLE");
    
    // Максимально допустимое отклонение (пыль) в вад (1e18)
    uint256 public maxDustThreshold;
    address public targetVault;

    event InvariantBreached(uint256 totalAssets, uint256 totalShares, uint256 difference);
    event ThresholdUpdated(uint256 newThreshold);

    constructor(address _targetVault, uint256 _initialThreshold) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        targetVault = _targetVault;
        maxDustThreshold = _initialThreshold;
    }

    /**
     * @dev Проверка инварианта: активы должны соответствовать долям с учетом порога "пыли".
     * Основано на опыте поиска Dust Leaks в DeFi протоколах.
     */
    function checkInvariant(uint256 totalAssets, uint256 totalShares) external onlyRole(AGENT_ROLE) {
        // Упрощенный пример инварианта (1:1 для примера)
        if (totalAssets < totalShares) {
            uint256 diff = totalShares - totalAssets;
            if (diff > maxDustThreshold) {
                _pause();
                emit InvariantBreached(totalAssets, totalShares, diff);
            }
        }
    }

    function setThreshold(uint256 _newThreshold) external onlyRole(DEFAULT_ADMIN_ROLE) {
        maxDustThreshold = _newThreshold;
        emit ThresholdUpdated(_newThreshold);
    }

    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _unpause();
    }
}
