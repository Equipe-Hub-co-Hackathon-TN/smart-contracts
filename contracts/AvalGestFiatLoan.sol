// SPDX-License-Identifier: MIT
// Documentation: https://github.com/Equipe-Hub-co-Hackathon-TN/smart-contracts

pragma solidity ^0.8.17;

contract AvalGestFiatLoan {
    
    address public owner;

    address public investWallet;
    address public institutionWallet;
    address public managerWallet;

    uint256 public warrantyAmount;

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

    string private _paymentReceipt;

    // EVENTS
    event AddressUpdated(address walletAddr, string description);
    event TerminationOfContract(uint id, StatusContract status);
    event CancelContract(uint id, StatusContract status);
    event ApproveContract(uint id, StatusContract status);
    event RequestContract(uint _id, string cnpj_institution, string investor_name, string investor_rg, string investor_cpf, string cet, string interest_rate, string payment_deadline, string value_of_installments, string loan_amount, string warranty, StatusContract _status);
    event SavePaymentReceipt(uint id, string paymentReceipt);
    

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
    function requestContract(string memory _cnpj_institution, string memory _investor_name, string memory _investor_rg, string memory _investor_cpf, string memory _cet, string memory _interest_rate, string memory _payment_deadline, string memory _value_of_installments, string memory _loan_amount, string memory _warranty) public onlyManager {
        
        uint _id = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, msg.sender)));

        _contract = Contract(_id, _cnpj_institution, _investor_name, _investor_rg, _investor_cpf, _cet, _interest_rate, _payment_deadline, _value_of_installments, _loan_amount, _warranty, StatusContract.Pending);

        emit RequestContract(_id, _cnpj_institution, _investor_name, _investor_rg, _investor_cpf, _cet, _interest_rate, _payment_deadline, _value_of_installments, _loan_amount, _warranty, StatusContract.Pending);
    }


    function approveContract() public onlyManager {    

        uint _id = _contract.id;

        _contract.contract_status = StatusContract.Approved;

        emit ApproveContract(_id, _contract.contract_status);
    }

    function cancelContract() public onlyManager {    

        uint _id = _contract.id;

        _contract.contract_status = StatusContract.Canceled;

        emit ApproveContract(_id, _contract.contract_status);
    }

    /* TERMINATION OF CONTRACT */
    function terminationOfContract() public onlyManager {    

        uint _id = _contract.id;

        _contract.contract_status = StatusContract.Finished;

        emit TerminationOfContract(_id, _contract.contract_status);
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

}