Markdown
# 🛡️ Sentinel: AI-Driven Security Infrastructure

**Sentinel** is an autonomous security agent built for the **Mantle Network** ecosystem. It shifts the paradigm from reactive manual audits to proactive, real-time protection. Sentinel acts as an "on-chain immune system," specifically designed to monitor, simulate, and neutralize infrastructure-level threats.

## 🚀 Overview

In the current Web3 landscape, point-in-time audits are insufficient to prevent logical errors or infrastructure exploits that emerge post-deployment. Sentinel addresses this by combining high-performance monitoring with predictive simulations.

### Key Focus Areas:
*   **Invariant Monitoring:** Real-time tracking of protocol-specific invariants (e.g., Solvency, Total Supply vs. Collateral).
*   **Exploit Prevention:** Detecting anomalies like "Permanent Bricking" or "Dust Leaks" before they impact user funds.
*   **Predictive Shielding:** Running parallel simulations in forked environments before finalizing high-value agentic actions.

## 🛠️ Tech Stack

*   **Blockchain Infrastructure:** [Mantle Network](https://www.mantle.xyz/)
*   **Security Testing & Simulation:** [Foundry](https://book.getfoundry.sh/) (Forge/Anvil)
*   **Off-chain Monitoring logic:** [Clojure](https://clojure.org/)
*   **Frameworks:** OpenZeppelin, Solady

## 🏗️ Architecture

1.  **Observer (Clojure):** Monitors Mantle RPC for specific event logs and state changes with millisecond latency.
2.  **Simulator (Foundry):** When a suspicious state change is detected, the agent triggers a `forge test` in a local fork to predict the outcome of the transaction.
3.  **Guardian (Smart Contract):** If a simulation fails or an invariant is breached, the Guardian contract triggers emergency mitigation (e.g., pausing the vault).

## 📂 Project Structure
```text
.
├── src/                # Smart contracts for Sentinel Guardian
├── test/               # Foundry security tests & invariant simulations
├── monitoring/         # Clojure scripts for real-time RPC monitoring
└── script/             # Deployment scripts for Mantle Network
🛠️ Getting Started
Prerequisites
Foundry

Clojure/Leiningen
Installation
Bash
git clone [https://github.com/rdin777/sentinel-mantle](https://github.com/rdin777/sentinel-mantle)
cd sentinel-mantle
forge install
Running Simulations
Bash
forge test --match-path test/Sentinel.t.sol
📜 License
MIT

🛡️ Security Analysis: Invariant-Based Protection
The Core Vulnerability: Mathematical Invariants
In modern DeFi protocols (like Panoptic or Autonolas), the fundamental security of a vault or pool relies on strict mathematical invariants. One of the most critical invariants is the relationship between Assets and Shares:

Total Assets≥Total Shares×Exchange Rate
As discovered in recent research regarding "dust leak" and rounding error vulnerabilities, subtle discrepancies in calculation can lead to a state where:

Total Assets<Total Shares
This creates a "ghost debt" or a deficit that can be exploited via a series of precision-loss attacks.

Sentinel Monitoring Logic
The Sentinel AI Agent (implemented in Clojure) acts as an off-chain watchdog that performs constant integrity checks:

Real-time Scanning: The agent polls the Mantle RPC to fetch the current state of the SentinelGuardian contract.

Invariant Validation: It compares the internal state against the expected mathematical model.

Automated Mitigation: If an "Invariant Deviation" is detected (as shown in 206.PNG), the agent doesn't just alert—it executes an emergency protect() transaction to pause the protocol and prevent fund drainage.

Why This Matters for Mantle Ecosystem
By deploying Sentinel, we move from reactive security (finding bugs after the exploit) to proactive autonomous defense. This approach is particularly effective against:

Rounding Error Exploits: Automated detection of precision loss.

Dust Leakage: Preventing slow drainage of protocol liquidity.

Price Manipulation: Monitoring for sudden, irrational shifts in asset/share ratios.

