pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";

contract YouTubeThumbnailToken is ERC721Full {

    struct YouTubeThumbnail {
        string author;
        string dateCreated;
    }

    mapping (uint256 => YouTubeThumbnail) youTubeThumbnails;
    mapping (string => uint256) videoIdsCreated;

    constructer(String memory name, String memory symbol) ERC721Full(name, symbol) public {}

    function mintYTT(
        string memory _videoId,
        string memory _author,
        string memory _dateCreated,
        string memory _tokenURI
    )
    public
    {
        require(videoIdsCreated[_videoId] == 0, "videoId has already been created");
        uint tokenId = totalSupply().add(1);
        youTubeThumbnails[tokenId] = YouTubeThumbnail(_author, _dateCreated);
        videoIdCreated[_videoId] = tokenId;

        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, _tokenURI);
    }
}