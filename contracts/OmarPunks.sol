// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";

contract OmarPunks is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    uint256 public maxSupply;

    // El constructor necesita dos parámetros, el nombre y la sigla del NFT.
    constructor(uint256 _maxSupply) ERC721("OmarPunks", "OMRPKS") {
        maxSupply = _maxSupply;
    }

    function mint() public {
        _idCounter.increment();
        uint256 current = _idCounter.current();
        require(current < maxSupply, "No OmarPunks left :(");

        _safeMint(msg.sender, current);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721 Metadata: URI query for nonexistent token"
        );

        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "OmarPunks #',
                tokenId,
                '", "description": "Omar Punks are randomized avataaars stored on chain to learn DApp development on Platzi", "image": "',
                "//TODO: Calculate image url",
                '", "attributes": [{ "display_type": "date", "trait_type": "birthday", "value": 1546360800},]',
                '"}'
            )
        );

        return
            string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }

    //Override requiered
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
