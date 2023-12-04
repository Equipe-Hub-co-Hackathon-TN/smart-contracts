// SPDX-License-Identifier: MIT
// Documentation: https://github.com/Equipe-Hub-co-Hackathon-TN/smart-contracts

pragma solidity ^0.8.17;

contract AvalGestBailInsurance.sol {
    
    address public owner;

    address public investWallet;
    address public institutionWallet;
    address public managerWallet;
    uint256 public warrantyAmount;
    string private _paymentReceipt;
    bool public _escrow_tokens_sent = false;

    enum StatusContract {
        Pending,
        Approved,
        Finished,
        Canceled
    }
    
    struct Contract {
        uint id;
        string cnpj_institution;
        string investor_name;
        string investor_rg;
        string investor_cpf;
        string cet;
        string interest_rate;
        string payment_deadline; 
        string value_of_installments;
        string loan_amount;
        string warranty;
        StatusContract contract_status;
    }

    Contract private _contract;

    // EVENTS
    event AddressUpdated(address walletAddr, string description);
    event CompletionOfContract(uint id, StatusContract status);
    event CancelContract(uint id, StatusContract status);
    event ApproveContract(uint id, StatusContract status);
    event RequestContract(uint _id, string cnpj_institution, string investor_name, string investor_rg, string investor_cpf, string cet, string interest_rate, string payment_deadline, string value_of_installments, string loan_amount, string warranty, StatusContract _status);
    event SavePaymentReceipt(uint id, string paymentReceipt);
    event WarrantyAmountUpdated(uint256 amount);
    event SentToManagerTokensInCollateral(address to, uint256 amount);    

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

    function sendToManagerTokensInCollateral(uint256 _tokenamount) public payable onlyInvest {
        require(_tokenamount == warrantyAmount, "Tokens too small");        

        payable(managerWallet).transfer(_tokenamount);

        _escrow_tokens_sent = true;

        emit SentToManagerTokensInCollateral(managerWallet, _tokenamount);
    }

    /* SEND TOKENS TO MANAGER */
    function requestContract(string memory _cnpj_institution, string memory _investor_name, string memory _investor_rg, string memory _investor_cpf, string memory _cet, string memory _interest_rate, string memory _payment_deadline, string memory _value_of_installments, string memory _loan_amount, string memory _warranty) public onlyManager {
        require(_escrow_tokens_sent == true, "Escrow tokens not yet sent");        

        uint _id = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, msg.sender)));

        _contract = Contract(_id, _cnpj_institution, _investor_name, _investor_rg, _investor_cpf, _cet, _interest_rate, _payment_deadline, _value_of_installments, _loan_amount, _warranty, StatusContract.Pending);

        emit RequestContract(_id, _cnpj_institution, _investor_name, _investor_rg, _investor_cpf, _cet, _interest_rate, _payment_deadline, _value_of_installments, _loan_amount, _warranty, StatusContract.Pending);
    }


    function approveContract() public onlyManager {
            
        require(_contract.contract_status == StatusContract.Pending, "Contract must be pending for approval");

        require(_escrow_tokens_sent == true, "Escrow tokens not yet sent");                

        uint _id = _contract.id;

        _contract.contract_status = StatusContract.Approved;

        emit ApproveContract(_id, _contract.contract_status);
    }

    function cancelContract() public payable onlyManager {    

        require(_contract.contract_status == StatusContract.Pending || _contract.contract_status == StatusContract.Approved, "Contract must be pending or approved for canceled");

        uint _id = _contract.id;

        _contract.contract_status = StatusContract.Canceled;

        if (_escrow_tokens_sent == true) {
            payable(institutionWallet).transfer(warrantyAmount);
        }

        emit ApproveContract(_id, _contract.contract_status);
    }

    /* TERMINATION OF CONTRACT */
    function completionOfContract() public payable onlyManager {    

        require(_contract.contract_status == StatusContract.Approved, "Contract must be approved for completion");

        uint _id = _contract.id;

        _contract.contract_status = StatusContract.Finished;

        if (_escrow_tokens_sent == true) {
            payable(investWallet).transfer(warrantyAmount);
        }

        emit CompletionOfContract(_id, _contract.contract_status);
    }

    function savePaymentReceipt(string memory paymentReceipt) public onlyManager {

        _paymentReceipt = paymentReceipt;

        uint _id = _contract.id;

        emit SavePaymentReceipt(_id, _paymentReceipt);

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

    function readContract() public view returns (Contract memory)  {

        Contract memory _readContract = _contract;

        return _readContract;
    }

    function readPaymentReceipt() public view returns (string memory)  {

        string memory _readPaymentReceipt = _paymentReceipt;

        return _readPaymentReceipt;
    }

    function updateWarrantyAmount(uint256 amount) external onlyManager {
        warrantyAmount = amount;
        emit WarrantyAmountUpdated(amount);
    }

}
