# Smart Contract Documentation

## AvalGestMain Contract

### Overview

The AvalGestMain contract is a Solidity smart contract designed for managing financial transactions among different wallets. It includes functionalities to send tokens to a manager, terminate the contract, and update wallet addresses and warranty amounts.

### Contract Details

- **SPDX-License-Identifier:** MIT
- **Solidity Version:** ^0.8.17
- **Contract Address MUMBAI**: [0x52d442BAb6D92DD9913DEd19CB04A321eD2925B6](https://mumbai.polygonscan.com/address/0x52d442BAb6D92DD9913DEd19CB04A321eD2925B6#code)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

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

----------------------------------------------

# AvalGestFiatLoan Smart Contract

### Contract Details

- **SPDX-License-Identifier:** MIT
- **Solidity Version:** ^0.8.17
- **Contract Address MUMBAI**: [0x2faBee9d1eA3ffBe14fbB43615A071cFe85d9404](https://mumbai.polygonscan.com/address/0x2faBee9d1eA3ffBe14fbB43615A071cFe85d9404#code)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This smart contract, **AvalGestFiatLoan**, facilitates the management of fiat loans, providing functionality for requesting, approving, canceling, and terminating contracts. It is implemented in Solidity and follows the MIT License. For more details, refer to the documentation below.

## Contract Overview

### Contract Structure

The smart contract consists of the following main components:

- **Owner:** The creator and owner of the contract.
- **Wallets:**
  - `investWallet`: Wallet for managing investments.
  - `institutionWallet`: Institutional wallet.
  - `managerWallet`: Wallet for managing the contract.
- **Contract Data:**
  - `_contract`: Struct containing information about the loan contract.
  - `_paymentReceipt`: String storing payment receipts.
- **Status Enumeration:**
  - `StatusContract`: Enum representing the status of a loan contract (Pending, Approved, Finished, Canceled).

### Events

1. **AddressUpdated:**
   - **Description:** Emitted when wallet addresses are updated.
2. **TerminationOfContract:**
   - **Description:** Emitted when a contract is terminated.
3. **CancelContract:**
   - **Description:** Emitted when a contract is canceled.
4. **ApproveContract:**
   - **Description:** Emitted when a contract is approved.
5. **RequestContract:**
   - **Description:** Emitted when a new loan contract is requested.
6. **SavePaymentReceipt:**
   - **Description:** Emitted when a payment receipt is saved.

### Modifiers

1. `onlyOwner:` Restricts access to the owner of the contract.
2. `onlyInvest:` Restricts access to the investment wallet.
3. `onlyManager:` Restricts access to the manager wallet.
4. `contractMembers:` Restricts access to authorized contract members.

### Functions

- `requestContract:` Allows the manager to request a new loan contract.
- `approveContract:` Allows the manager to approve a pending contract.
- `cancelContract:` Allows the manager to cancel a pending contract.
- `terminationOfContract:` Allows the manager to terminate an approved contract.
- `savePaymentReceipt:` Allows the manager to save payment receipts.
- `updateManagerAddr:` Allows the owner to update the manager's wallet address.
- `updateInvestAddr:` Allows the manager to update the investment wallet address.
- `updateInstitutionAddr:` Allows the manager to update the institutional wallet address.
- `readContract:` Allows reading the details of the current contract.
- `readPaymentReceipt:` Allows reading the saved payment receipt.

## Usage

### Contract Deployment

Deploy the smart contract to the Ethereum blockchain, specifying the initial wallet addresses.

### Contract Interaction

**Manager Actions:**

- Use `requestContract` to initiate a new loan contract.
- Approve or cancel pending contracts using `approveContract` or `cancelContract`.
- Terminate an approved contract with `terminationOfContract`.
- Save payment receipts using `savePaymentReceipt`.

**Wallet Address Updates:**

- Update the manager, investment, or institutional wallet addresses using the corresponding `update*Addr` functions.

**Read Contract Details:**

- Retrieve contract details with `readContract`.

**Read Payment Receipts:**

- Retrieve payment receipts with `readPaymentReceipt`.

## License

This smart contract is released under the [MIT License](https://opensource.org/licenses/MIT). See the [LICENSE](LICENSE) file for more details.
