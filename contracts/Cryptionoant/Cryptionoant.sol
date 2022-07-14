pragma solidity ^0.8.0;
import '../lib/TransferHelper.sol';
import '../token/Cry.sol';

contract Cryptoant{
    address cry;
    Cry crys;
    uint private reserve;
    uint id;
    mapping (uint256 => address) private _tokenApprovals;
    uint amount;
      struct Recording{
        uint tokenId;
        uint id;
        uint amount;
        uint money;
        uint day;
        uint status;
        address owner;
        address lender;
    }
    
    Recording[] public list;
    function init(address _cry) public {
        cry=_cry;
    }
    
    function depositToken(address to,uint month,uint value) external {
        require(month==1||month==3||month==6||month==12||month==24||month==36,"Deposit month error");
        TransferHelper.safeTransferFrom(cry,to,address(this), value);

    }
    
     function withdrawa(address to,uint tokenId) external {
        uint32 blockTime = uint32(block.timestamp % 2 ** 32);
        uint value=amount;
        TransferHelper.safeTransfer(cry, to, value);
        uint balance=IERC20(cry).balanceOf(address(this)); 
        reserve =balance ;       
    }
    
      function mortgageMarket(uint tokenId,uint amount ,uint day ,uint dayRate,address owner)public{
        uint32 blockTime = uint32(block.timestamp % 2 ** 32);
        uint interest =amount*(dayRate*day); 
        uint contango=dayRate*2;
        uint id=list.length+1;
        Recording memory record=Recording({
             tokenId:tokenId,
             id:id,
             amount:amount,
             money:amount,
             day:day,
             status:0,
             owner:owner,
             lender:address(0)
         });
         list.push(record);
    }
    
      function approve(address _to, uint256 _tokenId)public  {
        require(msg.sender == list[_tokenId].owner);
        require(msg.sender != _to);
        _tokenApprovals[_tokenId] = _to;
    }
    
    function getApproved(uint256 tokenId) public view  returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");
        return _tokenApprovals[tokenId];
    }
    
     function _exists(uint256 tokenId) public view  returns (bool) {
        return list[tokenId].owner != address(0);
    }
}
