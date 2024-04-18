// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "../src/MoodNft.sol";
contract MintBasicNft is Script {
      string public constant PUG_URI =
        "ipfs://QmW2k5J8XQx8u9Kj3oH4PXrgSfutwTNnCHhaBsm75tLf2k/?filename=ayanami.json";
    uint256 deployerKey;
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft",block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAdress) public {
        vm.startBroadcast();
        BasicNft(contractAdress).mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedBasicNft);
    }

    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNft(mostRecentlyDeployedBasicNft);
    }

    function flipMoodNft(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
