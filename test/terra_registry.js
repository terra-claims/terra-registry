var TerraRegistry = artifacts.require("./TerraRegistry.sol");

function bytes32ToString (bytes) {
  return Buffer.from(bytes.slice(2).split('00')[0], 'hex').toString()
}

contract('TerraRegistry', function(accounts) {
  let terra
  const user = accounts[0]
  const property = '0x000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f'
  const claimType = 'live'
 
  before(async () => {
    terra = await TerraRegistry.new()
  })

  describe('no claims', () => {
    it('has no claim for user and claimtype', async () => {
      const value = await terra.claims(property, claimType, user)
      assert.equal(value, 0)
    })
  })

  describe('make a claim', () => {
    let tx
    before(async () => {
      tx = await terra.claim(property, claimType, 2000)
    })
    it('should change value', async () => {
      const value = await terra.claims(property, claimType, user)
      assert.equal(value.toNumber(), 2000)
    })
    it('should create AttributeClaim event', () => {
      const event = tx.logs[0]
      assert.equal(event.event, 'AttributeClaim')
      assert.equal(event.args.property, property)
      assert.equal(event.args.issuer, user)
      assert.equal(bytes32ToString(event.args.claimType), claimType)
      assert.equal(event.args.value.toNumber(), 2000)
    })
})
})
