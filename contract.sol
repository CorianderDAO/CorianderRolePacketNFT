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
    address[4] public admin;
    struct Role {
        string roleType;
        uint8 roleCode;
        uint256 roleCount;
    }
    uint256[3] public totalSupply;
    Role og;
    Role wl1;
    Role wl2;
    
    constructor() ERC721("CorianderRolePacketV1", "CRP") {
        contractOwner = msg.sender;
        admin = [
            contractOwner,
            0x721D5A24e2526eB52B707687f404A611191d9cC9,
            0x9e4F26D923e8952Fa43540d6D203cBCD9f1E9fAB,
            0xB457178C9091EDe6ce5b42ABE8D93F88Ef75a9b1
        ];
        totalSupply = [88, 800, 1000];
        og = Role('OG', 0, 0);
        wl1 = Role('WL1', 1, 0);
        wl2 = Role('WL2', 2, 0);
    }
    
    function adminVerify() private view returns (bool) {
        for (uint i = 0; i < admin.length; i++) {
            if (admin[i] == msg.sender) {
                return true;
            }
        }
        return false;
    }

    function mintItem(address mintTo, uint8 roleCode) public {
        if (roleCode == og.roleCode) {
            require(og.roleCount<=totalSupply[0], "OG ROLE Packet was ALL Minted");
            mintItemAttachOtherURI(mintTo, "https://raw.githubusercontent.com/CorianderDAO/CorianderRolePacketNFT/master/0.json");
            og.roleCount++;
        }
        else if (roleCode == wl1.roleCode) {
            require(og.roleCount<=totalSupply[1], "WL1 ROLE Packet was ALL Minted");
            mintItemAttachOtherURI(mintTo, "https://raw.githubusercontent.com/CorianderDAO/CorianderRolePacketNFT/master/1.json");
            wl1.roleCount++;
        }
        else if (roleCode == wl2.roleCode) {
            require(og.roleCount<=totalSupply[2], "WL2 ROLE Packet was ALL Minted");
            mintItemAttachOtherURI(mintTo, "https://raw.githubusercontent.com/CorianderDAO/CorianderRolePacketNFT/master/2.json");
            wl2.roleCount++;
        }
    }

    function inquireRoleCirculation(uint roleCode) view public returns (uint256) {
        if (roleCode == og.roleCode) {
            return og.roleCount;
        }
        else if (roleCode == wl1.roleCode) {
            return wl1.roleCount;
        }
        else if (roleCode == wl2.roleCode) {
            return wl2.roleCount;
        }
        else {
            return 88888;
        }
    }

    function inquireRoleType(uint roleCode) view public returns (string memory) {
        if (roleCode == og.roleCode) {
            return og.roleType;
        }
        else if (roleCode == wl1.roleCode) {
            return wl1.roleType;
        }
        else if (roleCode == wl2.roleCode) {
            return wl2.roleType;
        }
        else {
            return "ROLE NOT DEFINED";
        }
    }

    function mintItemAttachOtherURI(address mintTo, string memory tokenURI) public returns (uint256) {
        require (adminVerify(), "You are not Admin");
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(mintTo, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }
}