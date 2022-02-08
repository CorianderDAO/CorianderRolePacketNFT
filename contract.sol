// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract CorianderRulePacketV1 is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address public contractOwner;
    address[3] public admin;
    
    constructor() ERC721("CorianderRolePacketV1", "CRP") {
        contractOwner = msg.sender;
        admin = [
            contractOwner,
            0x721D5A24e2526eB52B707687f404A611191d9cC9,
            0x9e4F26D923e8952Fa43540d6D203cBCD9f1E9fAB
        ]; 
    }
    
    function adminVerify() private view returns (bool) {
        for (uint i = 0; i < admin.length; i++) {
            if (admin[i] == msg.sender) {
                return true;
            }
        }
        return false;
    }

    function mintItem(address mintTo, uint8 roleType) public {
        require (adminVerify(), "You are not Admin");
        if (roleType == 0) {
            awardItem(mintTo, "https://raw.githubusercontent.com/CorianderDAO/CorianderRolePacketNFT/master/0.json");
        }
        else if (roleType == 1) {
            awardItem(mintTo, "https://raw.githubusercontent.com/CorianderDAO/CorianderRolePacketNFT/master/1.json");
        }
        else if (roleType == 2) {
            awardItem(mintTo, "https://raw.githubusercontent.com/CorianderDAO/CorianderRolePacketNFT/master/2.json");
        }
    }

    function awardItem(address mintTo, string memory tokenURI) public returns (uint256) {
        require (adminVerify(), "You are not Admin");
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(mintTo, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }
}