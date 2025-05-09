// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Dummy {}

contract Test136 is Test, SymTest {
    function setUp() public {
        console2.log("Test136.setUp");

        // https://github.com/a16z/halmos/issues/338
        startHoax(address(0x123));
        new Dummy();
        vm.stopPrank();

        console.log(address(0x123).balance);
    }

    // bad:
    //     WARNING  path.append(false)
    //             (see https://github.com/a16z/halmos/wiki/warnings#internal-error)
    //     [console.log] 0x0000000000000000000000000000000100000000000000000000000000000000
    //     setup: 0.03s (decode: 0.01s, run: 0.02s)
    //     WARNING  path.append(false)
    //             (see https://github.com/a16z/halmos/wiki/warnings#internal-error)

    // good:
    //     Counterexample: ∅
    //     [FAIL] test_startHoax() (paths: 2, time: 0.11s (paths: 0.01s, models: 0.11s), bounds: [])
    function test_startHoax() external {
        assertNotEq(address(0x123).balance, 1 << 128);
    }

    function test_dealTooBig() external {
        vm.deal(address(0x123), 10 ** 75);
        assertNotEq(address(0x123).balance, 10 ** 75);
    }
}
