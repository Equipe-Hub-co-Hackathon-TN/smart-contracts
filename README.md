# Smart Contract Documentation

## AvalGest Main  Contract

### Overview

The AvalGest Main  contract is a Solidity smart contract designed to manage and facilitate financial transactions between different wallets. It includes functionalities to send tokens to a manager, terminate the contract, and update wallet addresses and contract amounts.

### Contract Details

- **SPDX-License-Identifier:** MIT
- **Solidity Version:** ^0.8.17

### Contract Variables

1. **Owner:**
   - **Type:** address
   - **Access:** public
   - **Description:** The address of the contract owner, who has overall control and authority over the contract.

2. **Investment Wallet:**
   - **Type:** address
   - **Access:** public
   - **Description:** The wallet address dedicated to investments.

3. **Institution Wallet:**
   - **Type:** address
   - **Access:** public
   - **Description:** The wallet address associated with institutional funds.

4. **Manager Wallet:**
   - **Type:** address
   - **Access:** public
   - **Description:** The wallet address assigned to the manager for handling transactions.

5. **Contract Amount:**
   - **Type:** uint256
   - **Access:** public
   - **Description:** The amount of tokens in wei associated with the contract.

### Events

1. **AddressUpdated:**
   - **Parameters:**
     - walletAddr (address): The updated wallet address.
     - description (string): Description of the updated wallet (e.g., "Manager wallet").
   - **Description:** Triggered when a wallet address is updated.

2. **SentToManager:**
   - **Parameters:**
     - to (address): The manager's wallet address.
     - amount (uint256): The amount of tokens sent to the manager.
   - **Description:** Triggered when tokens are sent to the manager.

3. **ContractCancelled:**
   - **Parameters:**
     - to (address): The address to which the contract amount is sent.
     - amount (uint256): The amount of tokens sent to cancel the contract.
   - **Description:** Triggered when the contract is canceled, and tokens are sent to a specified address.

4. **ContractAmount:**
   - **Parameters:**
     - amount (uint256): The updated contract amount in tokens.
   - **Description:** Triggered when the contract amount is updated.

5. **TerminationOfContract:**
   - **Parameters:**
     - invest (address): The address to which the contract amount is sent upon termination.
     - amount (uint256): The amount of tokens sent to terminate the contract.
   - **Description:** Triggered when the contract is terminated, and tokens are sent to a specified address.

### Modifiers

1. **onlyOwner:**
   - **Description:** Ensures that only the contract owner can call the associated function.

2. **onlyInvest:**
   - **Description:** Ensures that only the investment wallet can call the associated function.

3. **onlyManager:**
   - **Description:** Ensures that only the manager can call the associated function.

4. **contractMembers:**
   - **Description:** Ensures that only authorized members (owner, institution wallet, manager wallet, and invest wallet) can access certain information.

### Constructor

- **Description:** Initializes the contract with the deploying address set as the owner and assigns the same address to the invest, institution, and manager wallets. The initial contract amount is set to 0.

### Functions

1. **sendToManager:**
   - **Parameters:**
     - _tokenamount (uint256): The amount of tokens to send to the manager.
   - **Modifier:** onlyInvest
   - **Description:** Sends tokens to the manager's wallet. Requires the token amount to match the contract amount.

2. **terminationOfContract:**
   - **Parameters:**
     - _terminationWallet (address): The address to which the contract amount is sent upon termination.
     - _tokenamount (uint256): The amount of tokens to send for contract termination.
   - **Modifier:** onlyManager
   - **Description:** Terminates the contract and sends tokens to the specified address. Requires the termination wallet to be either the invest or institution wallet, and the token amount to match the contract amount.

3. **updateManagerAddr:**
   - **Parameters:**
     - wallet (address): The new manager wallet address.
   - **Modifier:** onlyOwner
   - **Description:** Updates the manager wallet address.

4. **updateInvestAddr:**
   - **Parameters:**
     - wallet (address): The new invest wallet address.
   - **Modifier:** onlyManager
   - **Description:** Updates the invest wallet address.

5. **updateInstitutionAddr:**
   - **Parameters:**
     - wallet (address): The new institutional wallet address.
   - **Modifier:** onlyManager
   - **Description:** Updates the institutional wallet address.

6. **updateAmountToken:**
   - **Parameters:**
     - amount (uint256): The new contract amount in tokens.
   - **Modifier:** onlyManager
   - **Description:** Updates the contract amount.

### Usage Recommendations

- Ensure that the contract owner, invest wallet, institution wallet, and manager wallet are set appropriately during deployment.
- Use the provided functions to update wallet addresses and contract amounts as needed.
- Follow the specified modifiers to control access to sensitive functions.
- Monitor emitted events for important contract actions.

### Disclaimer

This documentation provides an overview of the AvalGest Main  smart contract. It is essential to review and understand the contract's functionalities, modifiers, and events before deployment. Smart contracts involve financial transactions and should be deployed with caution.