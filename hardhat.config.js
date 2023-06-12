require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config()

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: '0.8.18',
  networks: {
    goerli: {
      url: process.env.GOERLI_QUICKNODE_URL,
      accounts: [process.env.GOERLI_PRIVATE_KEY],
    },
    sepolia: {
      url: process.env.SEPOLIA_QUICKNODE_URL,
      accounts: [process.env.SEPOLIA_PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
}
