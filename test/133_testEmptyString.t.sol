// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test133 is Test, SymTest {
    function setUp() public {
        console2.log("Test133.setUp");
    }

    function check_emptyString() external {
        string memory str = svm.createString(0, "empty");
        console.log("str.length =", bytes(str).length);
        console.log(str);
    }

    function check_emptyBytes() external {
        bytes memory str = svm.createBytes(0, "empty");
        console.log("str.length =", str.length);
        console.logBytes(str);
    }
}
