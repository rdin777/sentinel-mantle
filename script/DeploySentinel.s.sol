// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {SentinelGuardian} from "../src/SentinelGuardian.sol";

contract DeploySentinel is Script {
    function run() external {
        // Получаем приватный ключ из переменных окружения
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        // Адрес целевого ваульта на Mantle (пока заглушка)
        address targetVault = 0x1234567890123456789012345678901234567890;
        uint256 initialThreshold = 10; // Тот самый порог пыли из теста

        vm.startBroadcast(deployerPrivateKey);

        SentinelGuardian guardian = new SentinelGuardian(
            targetVault,
            initialThreshold
        );

        console.log("SentinelGuardian deployed to:", address(guardian));

        vm.stopBroadcast();
    }
}
