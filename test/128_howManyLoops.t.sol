// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test128 is Test, SymTest {
    function setUp() public {
        console2.log("Test128.setUp");
    }

    function test_howManyLoops(uint256 n) external {
        vm.assume(n < 10000);

        uint256 i = 0;
        while (i < n) {
            i++;
        }

        console.log("i is", i);
    }
}
