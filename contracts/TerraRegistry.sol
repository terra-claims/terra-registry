pragma solidity ^0.4.19;

contract TerraRegistry {

  mapping(bytes32 => mapping(bytes32 => mapping(address => uint256))) public claims;
  // mapping(bytes32 => mapping(bytes32 => mapping(address => mapping(address => Validity)))) public relationships;

  event AttributeClaim(
    bytes32 indexed property,
    bytes32 indexed claimType,
    address issuer,
    uint256 value
  );
  
  function claim(bytes32 property, bytes32 claimType, uint256 value) public {
    emit AttributeClaim(property, claimType, msg.sender, value);
    claims[property][claimType][msg.sender] = value;
  }


  // struct Validity {
  //   uint expires;
  //   bool transferable;
  // }


  // event RelationshipClaim(
  //   bytes32 indexed property,
  //   bytes32 indexed relationship,
  //   address indexed subject,
  //   address issuer,
  //   uint expires
  // );
  
  // function relate(bytes32 property, bytes32 relationship, address subject, bool transferable, uint expires) public {
  //   emit RelationshipClaim(property, relationship,subject, msg.sender, expires);
  //   relationships[property][relationship][subject][msg.sender] = Validity(expires, transferable);
  // }

  // function related(bytes32 property, bytes32 relationship, address subject, address issuer) public constant returns(bool) {
  //   return (relationships[property][relationship][subject][issuer].expires > now);
  // }

  // // Update to use ERC721
  // function transfer(bytes32 property, bytes32 relationship, address issuer, address recipient) public returns(bool) {
  //   Validity storage validity = relationships[property][relationship][msg.sender][issuer];
  //   if (validity.expires > block.timestamp && validity.transferable && relationships[property][relationship][recipient][issuer].expires < block.timestamp ) {
  //     delete relationships[property][relationship][msg.sender][issuer];
  //     relationships[property][relationship][recipient][issuer] = validity;
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
