// SPDX-License-Identifier: MIT
// Documentation: https://github.com/Equipe-Hub-co-Hackathon-TN/smart-contracts

pragma solidity ^0.8.17;

contract AvalGestMain {
    
    address public owner;

    address public investWallet;
    address public institutionWallet;
    address public managerWallet;

    uint256 public warrantyAmount;

    // EVENTS
    event AddressUpdated(address walletAddr, string description);
    event SentToManager(address to, uint256 amount);    
    event WarrantyAmountUpdated(uint256 amount);
    event TerminationOfContract(address invest, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyInvest() {
        require(msg.sender == investWallet, "Only invest can call this function");
        _;
    }

    modifier onlyManager() {
        require(
            msg.sender == managerWallet,
            "Only manager can call this function"
        );
        _;
    }

    modifier contractMembers() {
        require(
            msg.sender == owner ||
                msg.sender == institutionWallet ||
                msg.sender == managerWallet ||
                msg.sender == investWallet,
            "This info is private"
        );
        _;
    }

    constructor() {
        owner = msg.sender;

        investWallet = msg.sender;
        institutionWallet = msg.sender;
        managerWallet = msg.sender;

        // AMOUNT IN WEI
        warrantyAmount = 0;
    }

    /* SEND TOKENS TO MANAGER */
    function sendToManager(uint256 _tokenamount) public payable onlyInvest {
        require(_tokenamount == warrantyAmount, "Tokens too small");        

        payable(managerWallet).transfer(_tokenamount);
        emit SentToManager(managerWallet, _tokenamount);
    }

    /* TERMINATION OF CONTRACT */
    function terminationOfContract( address _terminationWallet, uint256 _tokenamount ) public payable onlyManager {        
        require(_terminationWallet == investWallet || _terminationWallet == institutionWallet, "Unauthorized address");
        require(_tokenamount == warrantyAmount, "Tokens too small");

        payable(_terminationWallet).transfer(_tokenamount);
        emit TerminationOfContract(_terminationWallet, _tokenamount);
    }

    /* UPDATE MANAGER WALLET ADDRESS */
    function updateManagerAddr(address wallet) external onlyOwner {
        managerWallet = wallet;
        emit AddressUpdated(wallet, "Manager wallet");
    }

    /* UPDATE INVEST WALLET ADDRESS */
    function updateInvestAddr(address wallet) external onlyManager {
        investWallet = wallet;
        emit AddressUpdated(wallet, "Invest wallet");
    }

    /* UPDATE INSTITUTION WALLET ADDRESS */
    function updateInstitutionAddr(address wallet) external onlyManager {
        institutionWallet = wallet;
        emit AddressUpdated(wallet, "Institutional wallet");
    }

    /* UPDATE AMOUNT TOKEN */
    function updateWarrantyAmount(uint256 amount) external onlyManager {
        warrantyAmount = amount;
        emit WarrantyAmountUpdated(amount);
    }
}