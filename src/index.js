const Web3 = require('web3');
const artifact = require('../build/contracts/MetaBadge.json');
const web3 = new Web3('https://polygon-mumbai.infura.io/v3/3aa351ba6f094aba806c4b355f6ab059');



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



const form = {
  name: "",
  email: "",
  osis_range: "",
  combination: "",
  type: "",
  address: ""
}

let MBContract;

MBContract = new web3.eth.Contract(
  artifact.abi,
  '0x984c0572dD574033925Aa18e8662A6bddC4CFe69'
);


function init(form){


}



// async function mintTier1(){
//   const balance = await MBContract.methods.mintTier1().call();
//   console.log(balance)
// }
//
// mintTier1()







async function addOwnerAddressToWhiteListTier1(){
  let accounts = await web3.eth.getAccounts()
  console.log(accounts)
  // const addWLT1 = await MBContract.methods.addAddressToWhiteListTier1(["0x86014da74e6dc59Aa26EDb72BbA76bcc8f923Db1"]).send({from:"0x86014da74e6dc59Aa26EDb72BbA76bcc8f923Db1"});
  // console.log(addWLT1)
}

addOwnerAddressToWhiteListTier1();

async function test(){
  const balance = await MBContract.methods.availableTokenCountTier1().call();
  console.log(balance)
}

// test()
