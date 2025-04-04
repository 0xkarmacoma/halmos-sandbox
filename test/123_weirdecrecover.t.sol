// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test123 is Test, SymTest {
    function setUp() public {
        console2.log("Test123.setUp");
    }

    function test_weirdecrecover() external {
        address addr = ecrecover(0, 0, 0, 0);
        assertEq(addr, address(0));
    }
}
