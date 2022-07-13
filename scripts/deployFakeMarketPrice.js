const { ethers, waffle } = require("hardhat");


const testnet = "0x97d63Fe27cA359422C10b25206346B9e24A676Ca"
const mainnet = "0x2138FfE292fd0953f7fe2569111246E4DE9ff1DC"

async function main() {
  _FakeMarketPrice = await ethers.getContractFactory("FakeMarketPrice");
  FakeMarketPrice = await _FakeMarketPrice.deploy(testnet);

  console.log(`Deployed FakeMarketPrice at address: ${FakeMarketPrice.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });