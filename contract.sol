// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./ERC721Tradable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

// import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
// import "@openzeppelin/contracts/drafts/Counters.sol";

contract CorianderRulePacketV1 is ERC721Full {
    using Counters for Counters.Counter;
    Counters.Counter private _ogTokenIds;
    Counters.Counter private _wlTokenIds;

    address public owner;
    address[3] public admin;
    
    constructor(address _proxyRegistryAddress) TradeableERC721Token("Coriander DAO ROLE Packet", "CRP", _proxyRegistryAddress) public {
        owner = msg.sender;
        admin = [
            owner,
            0x721D5A24e2526eB52B707687f404A611191d9cC9,
            0x9e4F26D923e8952Fa43540d6D203cBCD9f1E9fAB
        ];
    }

    function uri_src(bool isOG) override private view returns (string memory) {
        uint256 isOG_uint256 = uint256(isOG);
        return string(
            abi.encodePacked(
                "https://raw.githubusercontent.com/CorianderDAO/CorianderRolePacketNFT/main/",
                Strings.toString(isOG_uint256),
                ".json"
            )
        );
    }
    
    function adminVerify() private returns (bool) {
        for (uint i = 0; i < admin.length; i++) {
            if (admin[i] == msg.sender) {
                return true;
                throw;
            }
            return false;
        }
    }

    function mintPacket(address mintTo, string memory tokenURI, bool isOG, uint8 level) public returns (uint256 memory) {
        if (!adminVerify()) { throw; }
        if (isOG) {
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();
            _mint(mintTo, newItemId);
            _setTokenURI(newItemId, uri_src(0));
            return newItemId;
        }
        else if (level == 1) {
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();
            _mint(mintTo, newItemId);
            _setTokenURI(newItemId, uri_src(1));
            return newItemId;
        }
        else if (level == 2) {
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();
            _mint(mintTo, newItemId);
            _setTokenURI(newItemId, uri_src(2));
            return newItemId;
        }
    }

    function resetTokenURI(uint256 tokenId, string uriLink) public {
        if (!adminVerify()) { throw; }
        _setTokenURI(tokenId, uriLink);
    }
}