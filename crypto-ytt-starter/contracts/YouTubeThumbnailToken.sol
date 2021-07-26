pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";

contract YouTubeThumbnailToken is ERC721Full {
  // 생성자
  constructor(string memory name, string memory symbol) ERC721Full(name, symbol) public {}

  // 유튜브 썸네일의 작가와 생성일 정보 구조체
  struct YouTubeThumbnail {
      string author;
      string dateCreated;
  }

  // 토큰Id에 대한 구조체 정보를 저장하는 매핑 정보
  mapping (uint256 => YouTubeThumbnail) YouTubeThumbnails;
  
  // videoId에 대한 토큰Id 매핑 정보 
  // (해당 videoId가 이미 존재하는지 확인하기 위함)
  mapping (string => uint256) videoIdsCreated;

  // 토큰 생성하는 함수
  function mintYTT( 
      string memory _videoId,
      string memory _author,
      string memory _dateCreated,
      string memory _tokenURI // 썸네일의 메타데이터를 저장하는 웹 주소 (길이가 예측 불가능한 데이터들을 따로 저장)
  )
  public
  {
      // videoId에 대한 토큰이 존재하지 않는 경우에만
      require(videoIdsCreated[_videoId] == 0, "videoId has already been created");
      // totalSupply()함수를 통해 전체 토큰 개수를 받고
      // 거기에 하나를 더한 것이 새로 생성하는 토큰Id가 된다.
      uint256 tokenId = totalSupply().add(1);
      // 새로운 tokendId에 대하여 썸네일 구조체를 매핑
      YouTubeThumbnails[tokenId] = YouTubeThumbnail(_author, _dateCreated);
      // videoId에 대하여 해당 tokenId 매핑
      videoIdsCreated[_videoId] = tokenId;

      // 토큰 발행 (해당 계정에게 tokenId 할당)
      _mint(msg.sender, tokenId);
      // 토큰에 대한 웹 주소 매핑
      _setTokenURI(tokenId, _tokenURI);
  }

}