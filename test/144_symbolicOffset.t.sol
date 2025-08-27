// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test144 is Test, SymTest {
    function setUp() public {
        console2.log("Test144.setUp");
    }

    // fails with NotConcreteError: symbolic memory offset
    function test_fail_symbolicOffset(uint256 x) external view {
        uint256[] memory inputs = new uint256[](1024);
        assertEq(inputs[x], 0);
    }

    function test_symbolicOffset_case_split(uint256 x) external view {
        uint256[] memory inputs = new uint256[](1024);

        // works because we constrain the symbolic input to specific values
        for (uint256 i = 0; i < 1024; i++) {
            if (i == x) {
                assertEq(inputs[x], 0);
            }
        }
    }
}
