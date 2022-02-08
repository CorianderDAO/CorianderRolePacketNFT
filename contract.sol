// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract CorianderRulePacketV1 is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping (uint256 => string) private _tokenURIs;

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

    function uri_src(uint8 roleType) private view returns (string memory) {
        return string(
            abi.encodePacked(
                "https://raw.githubusercontent.com/CorianderDAO/CorianderRolePacketNFT/main/",
                Strings.toString(roleType),
                ".json"
            )
        );
    }
    
    function adminVerify() private returns (bool) {
        for (uint i = 0; i < admin.length; i++) {
            if (admin[i] == msg.sender) {
                return true;
            }
            return false;
        }
    }

    function mintPacket(address mintTo, string memory tokenURI, uint256 roleType) public returns (uint256) {
        require (!adminVerify());
        if (roleType == 0) {
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();
            _mint(mintTo, newItemId);
            _setTokenURI(newItemId, uri_src(0));
            return newItemId;
        }
        else if (roleType == 1) {
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();
            _mint(mintTo, newItemId);
            _setTokenURI(newItemId, uri_src(1));
            return newItemId;
        }
        else if (roleType == 2) {
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();
            _mint(mintTo, newItemId);
            _setTokenURI(newItemId, uri_src(2));
            return newItemId;
        }
        else {
            return 88888;
        }
    }
}