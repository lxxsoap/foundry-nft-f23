import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract BasicNftTest is StdCheats, Test {
    BasicNft public basicNft;
    DeployBasicNft public deployer;
    address public deployerAddress;

 string public constant PUG_URI =
        "ipfs://QmW2k5J8XQx8u9Kj3oH4PXrgSfutwTNnCHhaBsm75tLf2k/?filename=ayanami.json";
    address public constant USER = address(1);
    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Eva";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }
       function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_URI);

        assert(basicNft.balanceOf(USER) == 1);
    }
}
