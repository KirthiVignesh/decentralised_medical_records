const SmartContract = artifacts.require("Patient");

module.exports = function(deployer) {
  // Command Truffle to deploy the Smart Contract
  deployer.deploy(SmartContract);
};