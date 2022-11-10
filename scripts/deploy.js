const { ethers } = require("hardhat");

const deploy = async () => {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contract with the account: ", deployer.address);

  const OmarPunks = await ethers.getContractFactory("OmarPunks");
  const deployed = await OmarPunks.deploy();

  console.log("Omar Punks is deployed at: ", deployed.address);
};

deploy()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
