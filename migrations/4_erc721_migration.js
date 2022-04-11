const ERC721 = artifacts.require("ERC721");
const SafeMath = artifacts.require("./libraries/SafeMath.sol");
const Address = artifacts.require("./libraries/Address.sol");
const EnumerableSet = artifacts.require("./libraries/EnumerableSet.sol");
const EnumerableMap = artifacts.require("./libraries/EnumerableMap.sol");
const Strings = artifacts.require("./libraries/Strings.sol");

module.exports = function (deployer) {
  deployer.deploy(SafeMath);
  deployer.link(SafeMath, ERC721);
  deployer.deploy(Address);
  deployer.link(Address, ERC721);
  deployer.deploy(EnumerableSet);
  deployer.link(EnumerableSet, ERC721);
  deployer.deploy(EnumerableMap);
  deployer.link(EnumerableMap, ERC721);
  deployer.deploy(Strings);
  deployer.link(Strings, ERC721);
  deployer.deploy(ERC721,"Metabadges","MTB");
};
