const ERC721Namable = artifacts.require("ERC721Namable");

module.exports = function (deployer) {
  deployer.deploy(ERC721Namable,"Metabadges","MTB");
};
