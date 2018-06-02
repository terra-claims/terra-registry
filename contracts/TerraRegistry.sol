pragma solidity ^0.4.19;

contract TerraRegistry {
  uint public version;
  address public previousPublishedVersion;

  mapping(bytes32 => mapping(bytes32 => mapping(address => bytes32))) public attributes;
  mapping(bytes32 => mapping(bytes32 => mapping(address => mapping(address => Validity)))) public relationships;

  constructor(address _previousPublishedVersion) public {
    version = 1;
    previousPublishedVersion = _previousPublishedVersion;
  }

  event AttributeClaim(
    bytes32 indexed property,
    bytes32 indexed name,
    address issuer,
    bytes32 value
  );
  
  function set(bytes32 property, bytes32 name, bytes32 value) public {
    emit AttributeClaim(property, name, msg.sender, value);
    attributes[property][name][msg.sender] = value;
  }


  struct Validity {
    uint expires;
    bool transferable;
  }


  event RelationshipClaim(
    bytes32 indexed property,
    bytes32 indexed relationship,
    address indexed subject,
    address issuer,
    uint expires
  );
  
  function relate(bytes32 property, bytes32 relationship, address subject, bool transferable, uint expires) public {
    emit RelationshipClaim(property, relationship,subject, msg.sender, expires);
    relationships[property][relationship][subject][msg.sender] = Validity(expires, transferable);
  }

  function related(bytes32 property, bytes32 relationship, address subject, address issuer) public constant returns(bool) {
    return (relationships[property][relationship][subject][issuer].expires > now);
  }

  // Update to use ERC721
  function transfer(bytes32 property, bytes32 relationship, address issuer, address recipient) public returns(bool) {
    Validity storage validity = relationships[property][relationship][msg.sender][issuer];
    if (validity.expires > block.timestamp && validity.transferable && relationships[property][relationship][recipient][issuer].expires < block.timestamp ) {
      delete relationships[property][relationship][msg.sender][issuer];
      relationships[property][relationship][recipient][issuer] = validity;
      return true;
    } else {
      return false;
    }
  }
}
