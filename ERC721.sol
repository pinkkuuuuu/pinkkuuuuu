// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Gold is ERC20{                            
  constructor() ERC20("Gold","GLD"){}

    function mint(uint256 _amount)public payable{
        _mint(msg.sender , _amount);
 }
}

contract Pokemon is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address marketplace;

    constructor(address _marketplace) ERC721("Pokemon Cards", "PKM"){
        marketplace = _marketplace;
    }

    function mint(string memory tokenURI) public {
        uint tokenId = _tokenIds.current();

        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        setApprovalForAll(marketplace, true);

        _tokenIds.increment();
    }
}

contract OLX {
    using Counters for Counters.Counter;
    Counters.Counter private _itemIds;
    Counters.Counter private _itemsSold;

    address token;
    address payable owner;
   
    constructor(address _token){
        owner = payable(msg.sender);
        token = _token;

    }

    struct OLXItem {
        uint itemId;
        address nftContract;
        uint tokenId;
        address payable seller;
        address payable owner;
        uint price;
        uint256 tokenPrice;
    }

    mapping(uint => OLXItem) private idToOLXItem;

    event OLXItemCreated (
        uint indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        uint256 tokenPrice
  );

  function createOLXItem(
      address nftContract,
      uint256 tokenId,
      uint256 price,
      uint256 tokenPrice
  ) public payable {
      require(price > 0, "Price must be at least 1 wei");

        

      uint256 itemId = _itemIds.current();

      idToOLXItem[itemId] = OLXItem(
          itemId,
          nftContract,
          tokenId,
          payable(msg.sender),
          payable(address(0)),
          price,
          tokenPrice
      );
      IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);

      emit OLXItemCreated(
        itemId,
        nftContract,
        tokenId,
        msg.sender,
        address(0),
        price,
        tokenPrice
    );

    _itemIds.increment();
  }

    function createOLXSale(uint256 itemId) public payable{

        if(msg.value != idToOLXItem[itemId].price){
       bool success = Gold(token).transferFrom(msg.sender,owner,idToOLXItem[itemId].tokenPrice);
       require(success == true,"error tranfer in tokens");
        }

        idToOLXItem[itemId].owner = payable(msg.sender);

        IERC721(idToOLXItem[itemId].nftContract).transferFrom(address(this), msg.sender, idToOLXItem[itemId].tokenId);

        idToOLXItem[itemId].seller.transfer(msg.value);

        _itemsSold.increment();
  }

  function getOLXItem(uint256 itemId) public view returns (OLXItem memory){
      return idToOLXItem[itemId];
  }

  function fetchOLXItems() public view returns (OLXItem[] memory){
      uint totalItemCount = _itemIds.current();
      uint unsoldItemCount = _itemIds.current() - _itemsSold.current();
      uint currentIndex = 0;

      OLXItem[] memory olxItems = new OLXItem[](unsoldItemCount);

      for(uint i = 0; i < totalItemCount; i++) {
          if(idToOLXItem[i].owner == address(0)){
              olxItems[currentIndex] = idToOLXItem[i];
              currentIndex += 1;
          }
      }

      return olxItems;
  }
}
