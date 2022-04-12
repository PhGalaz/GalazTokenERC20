const Migrations = artifacts.require("Migrations");
const GalazToken = artifacts.require('GalazToken');

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(GalazToken, "GalazToken", "GLZ", 2, 100000000);
};
