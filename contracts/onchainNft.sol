// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;




import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


//pseudo code 
// first of all you call all your dependency
// secondly i initialize the counter to 1 and update it to the state variable
// thirdly i will have to mint some of the token to the msg.sender
// after that i increment the nft token id 
contract OnChainNFT is ERC721 {
    using Strings for uint256;

    uint256 private _tokenIdCounter;


    function tokenIdCounter() external view returns(uint) {
        return _tokenIdCounter;
    }

    constructor () ERC721("AkpoloNft", "AkNft"){
        _tokenIdCounter = 1;
     
    }

    function mint () external {
        uint256 tokenId = _tokenIdCounter;
           _safeMint(msg.sender, tokenId);
           tokenId++;

    }
       function tokenURI(uint256 tokenId) public view override  returns (string memory) {

        _requireOwned(tokenId);

            string memory name = string(abi.encodePacked("AkpoloNFT #", tokenId.toString()));
            string memory description = "This is an on-chain NFT with metadata stored entirely on the blockchain.";
            string memory image = generateImage();

            string memory json =  Base64.encode(bytes( string(abi.encodePacked(
             
              '{"name":"', name, '",',
                            '"description":"', description, '",',
                            '"image":"data:image/svg+xml;base64,', image, '"}'      
         ))));
 
     
               return string(abi.encodePacked("data:application/json;base64,", json));
       

        // string memory baseURI = _baseURI();
        // return bytes(baseURI).length > 0 ? string.concat(baseURI, tokenId.toString()) : "";
    }

    function generateImage() public pure returns (string memory) {
        string memory image = '<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">'
  '<defs>'
    '<linearGradient id="coolGradient" x1="0%" y1="0%" x2="100%" y2="100%">'
      '<stop offset="0%" style="stop-color:#6a11cb; stop-opacity:1" />'
      '<stop offset="100%" style="stop-color:#2575fc; stop-opacity:1" />'
    '</linearGradient>'
    '<linearGradient id="goldGradient" x1="0%" y1="0%" x2="100%" y2="0%">'
      '<stop offset="0%" style="stop-color:#ffd700; stop-opacity:1" />'
      '<stop offset="100%" style="stop-color:#b8860b; stop-opacity:1" />'
    '</linearGradient>'
  '</defs>'
  '<rect width="200" height="200" rx="20" fill="url(#coolGradient)" />'
  '<ellipse cx="100" cy="50" rx="70" ry="35" fill="white" opacity="0.2"/>'
  '<polygon points="50,75 75,25 100,75 125,25 150,75" fill="url(#goldGradient)" stroke="black" stroke-width="2"/>'
  '<g>'
    '<circle cx="75" cy="25" r="3" fill="red" />'
    '<circle cx="76" cy="24" r="1" fill="white" />'
  '</g>'
  '<g>'
    '<circle cx="125" cy="25" r="3" fill="red" />'
    '<circle cx="126" cy="24" r="1" fill="white" />'
  '</g>'
  '<text x="100" y="120" text-anchor="middle" fill="black" font-size="24" font-family="Arial" font-weight="bold" transform="translate(2,2)">AkpoloNFT</text>'
  '<text x="100" y="120" text-anchor="middle" fill="white" font-size="24" font-family="Arial" font-weight="bold">AkpoloNFT</text>'
'</svg>'
;

        return Base64.encode(bytes(image));

    }

    }
