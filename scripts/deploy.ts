import { ethers } from "hardhat";

async function main() {
  const [owner, other] = await hre.ethers.getSigners();

   // UnitToken
 const UnitToken = await hre.ethers.getContractFactory("UnitToken");
 const unitToken = await UnitToken.deploy("0x826551890dc65655a0aceca109ab11abdbd7a07b");
 await unitToken.deployed();
  console.log('uint token:', unitToken.address)

   // CollateralManager
  const CollateralManager = await hre.ethers.getContractFactory("CollateralManager");
  const collateralManager = await CollateralManager.deploy("0x826551890dc65655a0aceca109ab11abdbd7a07b", "0x826551890dc65655a0aceca109ab11abdbd7a07b");
  await collateralManager.deployed();
  console.log('collateralManager:', collateralManager.address)

  // Vault
 const Vault = await hre.ethers.getContractFactory("Vault");
 const vault = await Vault.deploy(unitToken.address, collateralManager.address);
 await vault.deployed();
 console.log('vault:', vault.address)

 const UnitRouterV1 = await hre.ethers.getContractFactory("UnitRouterV1");
 const unitRouterV1 = await UnitRouterV1.deploy(vault.address);
 await unitRouterV1.deployed();
 console.log('unitRouterV1:', unitRouterV1.address)

 const TestToken = await hre.ethers.getContractFactory("TestToken");
 const usdtToken = await TestToken.deploy();
 await usdtToken.deployed();
 await usdtToken.mint( owner.address, "9999999999999999999999")
 console.log('usdt:', usdtToken.address)

 await usdtToken.approve(unitRouterV1.address, '9999999999999999999999999999999999')

 await unitRouterV1.increaseCollateral(usdtToken.address, "1000000000000000000", owner.address)

 const poolAmounts = await vault.poolAmounts(usdtToken.address)
 console.log(poolAmounts)
 const collateralAmount = await vault.collateralAmount( owner.address, usdtToken.address)
 console.log(collateralAmount)


 await unitToken.mint(owner.address, "500000000000000000", usdtToken.address)

 const balance = await unitToken.balanceOf(owner.address)
 console.log('unit balance:', balance)

 await vault.decreaseCollateral(usdtToken.address, other.address, "500000000000000000")

 const collateralAmount1 = await vault.collateralAmount( owner.address, usdtToken.address)
 console.log(collateralAmount1)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
