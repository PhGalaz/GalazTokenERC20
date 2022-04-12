
// balance ERC20
async function balance(address){
  const balance = await GTContract.methods.balanceOf(address).call();
}

// tx
async function addOwnerAddressToWhiteListTier1(){

  var tx = {
    from: "0x86014da74e6dc59Aa26EDb72BbA76bcc8f923Db1",
    to: MBContract.options.address,
    value: '0',
    gas: 47127,
    gasPrice: await web3.eth.getGasPrice(),
    data: encodedABI
  }

  var encodedABI = MBContract.methods.addAddressToWhiteListTier1(["0x86014da74e6dc59Aa26EDb72BbA76bcc8f923Db1"]).encodeABI();

  var signed = await web3.eth.accounts.signTransaction({
    from: "0x86014da74e6dc59Aa26EDb72BbA76bcc8f923Db1",
    to: MBContract.options.address,
    value: '0',
    gas: 47127,
    gasPrice: await web3.eth.getGasPrice(),
    data: encodedABI
  }, '')

  const receipt = await web3.eth.sendSignedTransaction(signed.rawTransaction)
}



// Consult typeform
// const axios = require('axios');
// async function typeform(){
//   const resp = await axios.get("https://api.typeform.com/forms", {
//     headers: {
//       Authorization: `Bearer tfp_ARYiZQPDsypepBcrM7Egzd6TBibJNR9nqHo6wzh8Y7s6_3suGWofbwmgcAj`
//     }
//   })
//   .then((res) => {
//     console.log(res.data)
//   })
//   .catch((error) => {
//     console.error(error)
//   })
//   return resp
// }
//
// typeform()


// Estimate gas
web3.eth.estimateGas({
  to: '0x984c0572dD574033925Aa18e8662A6bddC4CFe69',
  from: "0x86014da74e6dc59Aa26EDb72BbA76bcc8f923Db1",
  data: encodedABI
})
.then(console.log);
