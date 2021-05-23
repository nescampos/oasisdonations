pragma solidity ^0.4.0;

contract OasisDonations {

    address owner;
    string public title;
    string public description;
    string public website;
    uint256 public price;
    struct Donation {
        string campaign;
        uint256 ammount;
        bool isValue;
    }
    struct Campaign {
        string title;
        string description;
        string website;
        bool isValue;
    }
    mapping (address => Donation) donations;
    mapping (address => Campaign) campaigns;
    address [] addrs;

    function OasisDonations (string _title,string _description,string _website,uint256 _price) public {
        owner = msg.sender;
        title = _title;
        price = _price;
        description = _description;
        website = _website;
    }

    function setTitle (string _title) public {
        require (msg.sender == owner);
        title = _title;
    }

    function setDescription (string _description) public {
        require (msg.sender == owner);
        description = _description;
    }

    function setWebsite (string _website) public {
        require (msg.sender == owner);
        website = _website;
    }

    function setPrice (uint256 _price) public {
        require (msg.sender == owner);
        price = _price;
    }

    function addDonation (string _campaign, uint256 _ammount) public payable {
        require(msg.value >= price);
        if (!donations[msg.sender].isValue) {
            addrs.push(msg.sender);
        }
        donations[msg.sender] = Donation(_campaign, _ammount, true);
    }

    function addCampaign (string _title, string _description, string _website) public payable {
        require(msg.value >= price);
        if (!campaigns[msg.sender].isValue) {
            addrs.push(msg.sender);
        }
        campaigns[msg.sender] = Campaign(_title, _description, _website, true);
    }

    function getDonation(address _addr) public constant returns(string, uint256) {
        return (donations[_addr].campaign, donations[_addr].ammount);
    }

    function getAddrs () public constant returns (address []) {
        return addrs;
    }


    function withdraw () public {
        require (msg.sender == owner);
        owner.transfer(this.balance);
    }
}