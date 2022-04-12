const Web3 = require('web3');
const artifact = require('../build/contracts/GalazToken.json');
const web3 = new Web3('http://35.220.203.194:8545');

let GTContract;

GTContract = new web3.eth.Contract(
  artifact.abi,
  '0x9BF10db2a96435c1E678eF9CDc00112973D6aD85'
)

async function balance(address){
  const balance = await GTContract.methods.balanceOf(address).call();
  return balance
}

async function transferERC20(addressto, amount){

  var encodedABI = GTContract.methods.transfer(addressto, amount).encodeABI();

  const gas = await web3.eth.estimateGas({
    to: addressto,
    from: "0x86014da74e6dc59Aa26EDb72BbA76bcc8f923Db1",
    data: encodedABI
  })

  var signed = await web3.eth.accounts.signTransaction({
    from: "0x86014da74e6dc59Aa26EDb72BbA76bcc8f923Db1",
    to: addressto,
    value: '100',
    gas: gas,
    gasPrice: await web3.eth.getGasPrice(),
    data: encodedABI
  }, 'f531efc29f9a5dd5054f12cc455cace704c34687849a78369624be6998d40eea')


  const receipt = await web3.eth.sendSignedTransaction(signed.rawTransaction)
  console.log(receipt)

  var bal = await balance('0x86014da74e6dc59Aa26EDb72BbA76bcc8f923Db1')
  console.log(bal)
}

transferERC20('0x956652D5D775Dd638deF8bFA3192436e3D28755d', 100)
