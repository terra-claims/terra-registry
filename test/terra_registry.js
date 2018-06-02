var TerraRegistry = artifacts.require("./TerraRegistry.sol");

contract('TerraRegistry', function(accounts) {
  let terra
  const identity = accounts[0]
  let owner
  let previousChange
  const identity2 = accounts[1]
  const delegate = accounts[2]
  const delegate2 = accounts[3]
  const delegate3 = accounts[4]
  const badboy = accounts[9]

  before(async () => {
    terra = await EthereumDIDRegistry.deployed()
  })

})
