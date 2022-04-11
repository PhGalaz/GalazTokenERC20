// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity >=0.8.6;

import "./ERC721Namable.sol";
import "./libraries/SafeMath.sol";
import "./interfaces/IERC1155.sol";
import "./Ownable.sol";
import "./libraries/Strings.sol";
import "./RandomlyAssigned.sol";

contract MetaBadge is ERC721Namable, Ownable, RandomlyAssigned {
    using SafeMath for uint256;
    using Strings for uint256;


    uint256 private PRICEWHITELIST = 0 ether;
    uint256 private PRICETIER1 = 900 ether;
    uint256 private PRICETIER2 = 450 ether;


    uint256 constant MAX_NFT = 10000;

   mapping(address => bool) whiteListTier1;
   mapping(address => bool) whiteListTier2;

    receive() external payable {}
    fallback() external payable {}

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseURI,
        string memory _hiddenURI
    )
        ERC721Namable(_name, _symbol)
    {
        _setBaseURI(_baseURI);
        _setTrueURI(_baseURI);
        _setHiddenURI(_hiddenURI);
    }


    function setReveal(bool value) public onlyOwner virtual{
        _setReveal(value);
    }


    //Withdraw tokens from contract
    function withdraw() public onlyOwner {
        address _this = address(this);
        payable(owner()).transfer(_this.balance);
    }

    //Update URI for Metadata
	function updateURI(string memory _newURI) public onlyOwner {
		_setBaseURI(_newURI);
	}

    //Return count of tokens on balance of msg.sender.
    function getBalance() public view returns(uint256) {
        address _self = address(this);
        uint256 _balance = _self.balance;
        return _balance;
    }

     //Return price of Tier1 NFT.
    function getTier1Price() public view returns(uint256){
        return PRICETIER1;
    }

    //Return price of Tier2 NFT.
    function getTier2Price() public view returns(uint256){
        return PRICETIER2;
    }

    //Return price of whitelist address.
    function getWhitelistPrice() public view returns(uint256){
        return PRICEWHITELIST;
    }

    //Change price of Tier 1 NFT
    function changePriceTier1(uint256 newPrice) public onlyOwner {
        PRICETIER1 = newPrice;
    }

    //Change price of Tier 2 NFT
    function changePriceTier2(uint256 newPrice) public onlyOwner {
        PRICETIER2 = newPrice;
    }

    //Change price of whitelist
    function changePriceWhitelist(uint256 newPrice) public onlyOwner {
        PRICEWHITELIST = newPrice;
    }

    //Add adresses to whiteListTier1
    function addAddressToWhiteListTier1(address[] memory _members) public onlyOwner{
            for (uint256 i = 0; i < _members.length; i++) {
                whiteListTier1[_members[i]] = true;
            }
    }

    //Add adresses to whiteListTier2
    function addAddressToWhiteListTier2(address[] memory _members) public onlyOwner{
            for (uint256 i = 0; i < _members.length; i++) {
                whiteListTier2[_members[i]] = true;
            }
    }

    //Check contains of wallet in WhiteListTier12
    function walletIsInWhiteListTier1(address wallet) public view returns(bool){
        return whiteListTier1[wallet];
    }

    //Check contains of wallet in WhiteListTier2
    function walletIsInWhiteListTier2(address wallet) public view returns(bool){
        return whiteListTier2[wallet];
    }


     function mintTier1() public payable {
        uint256 _idTier1 = nextTokenForTier1();
        require(MAX_NFT != totalSupply(), "NFT are over! Sorry :(");
        require(balanceOf(msg.sender) + 1 <= 5, "More than 5 NFTs");

       if( walletIsInWhiteListTier1(msg.sender)){
           require(_idTier1 >= 8501 || _idTier1 <= 10000, "Token id is not a Tier1 NFT");
           require(PRICEWHITELIST == msg.value, "Value isn't correct");
           whiteListTier1[msg.sender] = false;
        }
        else{
            require(_idTier1 >= 8501 || _idTier1 <= 10000, "Token id is not a Tier1 NFT");
            require(PRICETIER1 == msg.value, "Value isn't correct");
        }
        _mint(msg.sender, _idTier1);
     }

      function mintTier2() public payable {
        uint256 _idTier2 = nextTokenForTier2();
        require(MAX_NFT != totalSupply(), "NFT are over! Sorry :(");
        require(balanceOf(msg.sender) + 1 <= 5, "More than 5 NFTs");

       if( walletIsInWhiteListTier2(msg.sender)){
           require(_idTier2 >= 1 || _idTier2 <= 8500, "Token id is not a Tier1 NFT");
           require(PRICEWHITELIST == msg.value, "Value isn't correct");
           whiteListTier2[msg.sender] = false;
        }
        else{
            require(_idTier2 >= 1 || _idTier2 <= 8500, "Token id is not a Tier1 NFT");
            require(PRICETIER2 == msg.value, "Value isn't correct");
        }
        _mint(msg.sender, _idTier2);
     }


}
