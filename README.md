# Sui Smart Contract Bug Examples

This project contains five minimal Sui Move smart contract examples, each demonstrating a real-world bug commonly found in blockchain applications. Each bug is implemented in a separate `.move` file with a concise, realistic scenario, and this README provides explanations and implications for each.

## 1. Overflow Bug
**File**: `overflow_bug`

**Explanation**:  
The contract performs a bitwise left shift to calculate a reward multiplier. It uses an incorrect mask for overflow checking, allowing large inputs to pass and causing truncation during the shift operation. This can lead to incorrect reward calculations, potentially underpaying users or allowing exploits where large inputs bypass intended limits.

**Implications**:  
- Users may receive incorrect payouts, leading to financial losses.
- Attackers could exploit the overflow to manipulate contract logic.

## 2. Arithmetic Accuracy Deviation Bug
**File**: `arithmetic_bug`

**Explanation**:  
The contract calculates a percentage-based fee using integer division, which truncates decimal results. This precision loss can accumulate in high-frequency transactions, leading to incorrect fee distributions or user balances in a real-world trading or lending protocol.

**Implications**:  
- Small errors in fee calculations can compound, affecting user trust and contract integrity.
- Precision loss may lead to unfair outcomes in financial calculations.

## 3. Race Condition Bug
**File**: `race_condition_bug`

**Explanation**:  
The contract allows users to claim rewards based on a stored balance, but it assumes the balance remains unchanged between the check and update. In Sui, where validators can reorder transactions within a block, a concurrent transaction could modify the balance, allowing multiple claims for the same reward.

**Implications**:  
- Users could double-spend rewards, draining contract funds.
- Reordered transactions may lead to inconsistent state and financial losses.

## 4. Access Control Bug
**File**: `access_control_bug`

**Explanation**:  
The contract has a function to update a user’s balance that is incorrectly marked as `public`, allowing anyone to call it. In a real-world scenario, such as a wallet or vault contract, this could enable unauthorized users to manipulate balances, bypassing intended access restrictions.

**Implications**:  
- Unauthorized balance changes can lead to asset theft.
- Exposed sensitive functions undermine contract security.

## 5. Object Management Bug
**File**: `object_management_bug`

**Explanation**:  
The contract converts a private user profile object to a shared object during an update, exposing sensitive data (e.g., user balance) to public access. This mirrors real-world cases where misconfigured object permissions in DeFi protocols allow unauthorized access to user data or funds.

**Implications**:  
- Publicly shared objects can be accessed or modified by anyone, risking user privacy and funds.
- Incorrect object permissions can break business logic and trust.
