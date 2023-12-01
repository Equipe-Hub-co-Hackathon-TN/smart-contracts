# Smart Contract Documentation

## AvalGestMain Contract

### Overview

The AvalGestMain contract is a Solidity smart contract designed for managing financial transactions among different wallets. It includes functionalities to send tokens to a manager, terminate the contract, and update wallet addresses and warranty amounts.

### Contract Details

- **SPDX-License-Identifier:** MIT
- **Documentation:** [GitHub Repository](https://github.com/Equipe-Hub-co-Hackathon-TN/smart-contracts)
- **Solidity Version:** ^0.8.17
- **Contract Address MUMBAI: 0x52d442BAb6D92DD9913DEd19CB04A321eD2925B6

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

5. **Warranty Amount:**
   - **Type:** uint256
   - **Access:** public
   - **Description:** The amount of tokens in wei associated with the warranty for the contract.

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

3. **WarrantyAmountUpdated:**
   - **Parameters:**
     - amount (uint256): The updated warranty amount in tokens.
   - **Description:** Triggered when the warranty amount is updated.

4. **TerminationOfContract:**
   - **Parameters:**
     - invest (address): The address to which the warranty amount is sent upon contract termination.
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

- **Description:** Initializes the contract with the deploying address set as the owner and assigns the same address to the invest, institution, and manager wallets. The initial warranty amount is set to 0.

### Functions

1. **sendToManager:**
   - **Parameters:**
     - _tokenamount (uint256): The amount of tokens to send to the manager.
   - **Modifier:** onlyInvest
   - **Description:** Sends tokens to the manager's wallet. Requires the token amount to match the warranty amount.

2. **terminationOfContract:**
   - **Parameters:**
     - _terminationWallet (address): The address to which the warranty amount is sent upon contract termination.
     - _tokenamount (uint256): The amount of tokens to send for contract termination.
   - **Modifier:** onlyManager
   - **Description:** Terminates the contract and sends tokens to the specified address. Requires the termination wallet to be either the invest or institution wallet, and the token amount to match the warranty amount.

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

6. **updateWarrantyAmount:**
   - **Parameters:**
     - amount (uint256): The new warranty amount in tokens.
   - **Modifier:** onlyManager
   - **Description:** Updates the warranty amount.

### Usage Recommendations

- Ensure that the contract owner, invest wallet, institution wallet, and manager wallet are set appropriately during deployment.
- Use the provided functions to update wallet addresses and warranty amounts as needed.
- Follow the specified modifiers to control access to sensitive functions.
- Monitor emitted events for important contract actions.

### Disclaimer

This documentation provides an overview of the AvalGestMain smart contract. It is essential to review and understand the contract's functionalities, modifiers, and events before deployment. Smart contracts involve financial transactions and should be deployed with caution.