// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint256 private constant MAX_VALUE = 50;
    string[] ipfsLinks = ["https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/1.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/2.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/3.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/4.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/5.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/6.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/7.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/8.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/9.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/10.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/11.json",
                          "https://ipfs.io/ipfs/QmdJjuZQuVbn8thsaeyFZat2DAz5A5MUheKXwaF8w7rg6u/12.json"];

  event NewEpicNFTMinted(address sender, uint256 tokenId, uint256 rand);
  constructor() ERC721 ("EPICANIMAL", "EPAM") {
    console.log("This is my NFT contract. Woah!");
  }

  function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }

  function pickRandomIpfsLinks(uint256 tokenId) public view returns (string memory, uint256) {
    uint256 rand = random(string(abi.encodePacked("IPFS_LINK", Strings.toString(tokenId))));
    rand = rand % ipfsLinks.length;
    return (ipfsLinks[rand], rand);
  }

  function getCurrentTokenId() public view returns(uint256) {
    uint256 currentId = _tokenIds.current();
    return currentId;
  }

  function makeAnEpicNFT() public {
    uint256 newItemId = _tokenIds.current();
    if(newItemId <= MAX_VALUE) {
        string memory finalTokenUri;
        uint256 rand;
        (finalTokenUri, rand)= pickRandomIpfsLinks(newItemId);

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);
        
        // Update your URI!!!
        _setTokenURI(newItemId, finalTokenUri);

        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
        emit NewEpicNFTMinted(msg.sender, newItemId, rand);
    }
  }
}