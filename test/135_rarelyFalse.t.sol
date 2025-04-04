// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test135 is Test, SymTest {
    function setUp() public {
        console2.log("Test135.setUp");
    }

    function test_reallyEasy(uint256 _x) external pure {
        assert(_x != 580923);
    }

    function test_rarelyFalse(uint256 _x) external pure {
        // solution is x = 580923
        uint256 x = _x;
        uint256 x2 = x * x;
        // x^2 - 1161846 x + 337471531929
        uint256 z = x2 + 337471531929 - 1161846 * x;
        assert(z != 0);
    }
}
