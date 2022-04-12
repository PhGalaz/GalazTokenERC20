const Web3 = require('web3');
const artifact = require('../build/contracts/MetaBadge.json');
const web3 = new Web3('');

var account = web3.eth.accounts.wallet.add('')


let MBContract;

MBContract = new web3.eth.Contract(
  artifact.abi,
  '0x984c0572dD574033925Aa18e8662A6bddC4CFe69'
)


// async function test(){
//   const balance = await MBContract.methods.availableTokenCountTier1().call();
//   console.log(balance)
// }
//
// // test()
