const MetaBadge = artifacts.require("MetaBadge");
const SafeMath = artifacts.require("./libraries/SafeMath.sol");
const Strings = artifacts.require("./libraries/Strings.sol");

module.exports = function (deployer) {
  deployer.link(SafeMath, MetaBadge);
  deployer.link(Strings, MetaBadge);
  deployer.deploy(
      MetaBadge,
      "Metabadges",
      "MTB",
      "https://metabadges.mypinata.cloud/ipfs/QmUXjBXuqDsKugoHt89MSThihQkT3JcuA5BbDCkkBNqzZc",
      "https://metabadges.mypinata.cloud/ipfs/QmUXjBXuqDsKugoHt89MSThihQkT3JcuA5BbDCkkBNqzZc"
  );
};
