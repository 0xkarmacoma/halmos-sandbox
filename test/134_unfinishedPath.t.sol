// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test134 is Test, SymTest {
    function setUp() public {
        console2.log("Test134.setUp");
    }

    function foo() external {
        console.log("foo");
    }

    function test_unfinishedPath(bool x) external {
        if (x) {
            // console.log("beep boop");
        } else {
            Test134(address(this)).foo();
            vm.assume(false);
        }
    }
}
