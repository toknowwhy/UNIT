import { ethers } from "hardhat";

import rp from 'request-promise';
async function main() {
    // https://graph.theunit.one/graphql?query=%7BunitHourlyData%28limit%3A1%2Ccurrency%3A%22usd%22%29%7Bvalue%7D%7D

    const jsonData = await rp({
        uri: 'https://graph.theunit.one/graphql?query=%7BunitHourlyData%28limit%3A1%2Ccurrency%3A%22usd%22%29%7Bvalue%7D%7D',
        json: true
    })

    
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
