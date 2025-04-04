// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test127 is Test, SymTest {
    function setUp() public {
        // nothing
    }

    function test_trueOrFalse(bool x) external pure {
        if (x) {
            console.log("x is true");
        } else {
            console.log("x is false");
        }
    }

    function test_badEncoding() external view {
        (bool succ, ) = address(this).staticcall(abi.encodeWithSignature("test_trueOrFalse(uint)", 42));
        require(!succ, "should fail");
    }
}
