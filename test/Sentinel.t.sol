// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {SentinelGuardian} from "../src/SentinelGuardian.sol";

contract SentinelTest is Test {
    SentinelGuardian public guardian;
    address public admin = address(0x1);
    address public aiAgent = address(0x2);
    address public mockVault = address(0x3);

    function setUp() public {
        vm.startPrank(admin);
        // Устанавливаем порог пыли в 10 wei (для наглядности)
        guardian = new SentinelGuardian(mockVault, 10);
        guardian.grantRole(guardian.AGENT_ROLE(), aiAgent);
        vm.stopPrank();
    }

    function test_Audit_DustLeakMitigation() public {
        // Симулируем состояние, где "пыль" накопилась (разница 100 wei)
        // Инвариант: assets (1000) vs shares (1100)
        uint256 totalAssets = 1000;
        uint256 totalShares = 1100; // Разница 100 > порога 10

        console.log("Starting invariant check...");
        console.log("Current Dust Delta:", totalShares - totalAssets);

        vm.prank(aiAgent);
        guardian.checkInvariant(totalAssets, totalShares);

        // Проверяем, что контракт Sentinel встал на паузу
        assertTrue(guardian.paused(), "Guardian should be paused due to dust leak");
        console.log("Sentinel successfully paused the protocol.");
    }
}
