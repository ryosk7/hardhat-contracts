// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarketplace is ERC721 {
    address public owner;
    uint256 public tokenId = 1;

    struct NFT {
        address owner;
        uint256 price;
        bool isForSale;
    }

    mapping(uint256 => NFT) public nfts;

    constructor() ERC721("NFT Marketplace", "NFTM") {
        owner = msg.sender;
    }

    function buyNFT(uint256 _tokenId) external payable {
        require(nfts[_tokenId].isForSale == true, "NFT is not for sale");
        require(msg.value >= nfts[_tokenId].price, "Not enough Ether to buy NFT");
        address seller = nfts[_tokenId].owner;
        nfts[_tokenId].isForSale = false;
        nfts[_tokenId].price = 0;
        _transfer(seller, msg.sender, _tokenId);
    }
}