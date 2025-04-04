// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test125 {
    // function setUp() public {
    //     console2.log("Test125.setUp");
    // }

    function slow_fibonacci(uint256 n) internal returns (uint256) {
        if (n <= 1) return n;
        return slow_fibonacci(n - 1) + slow_fibonacci(n - 2);
    }

    function fast_fibonacci(uint256 n) internal returns (uint256) {
        if (n <= 1) return n;
        uint256 a = 0;
        uint256 b = 1;
        for (uint256 i = 2; i <= n; i++) {
            uint256 next = a + b;
            a = b;
            b = next;
        }
        return b;
    }

    function test_nothing() external {}

    function test_slow_fibonacci_light() external {
        assert(slow_fibonacci(2) == 1);
    }

    function test_slow_fibonacci_heavy() external {
        assert(slow_fibonacci(0) == 0);
        assert(slow_fibonacci(1) == 1);
        assert(slow_fibonacci(2) == 1);
        assert(slow_fibonacci(3) == 2);
        // ...
        assert(slow_fibonacci(25) == 75025);
    }

    function test_fast_fibonacci() external {
        assert(fast_fibonacci(0) == 0);
        assert(fast_fibonacci(1) == 1);
        assert(fast_fibonacci(2) == 1);
        assert(fast_fibonacci(3) == 2);
        // ...
        assert(fast_fibonacci(25) == 75025);
    }

    // function test_fibonacci_equivalence(uint256 n) external {
    //     vm.assume(n < 256);
    //     assertEq(slow_fibonacci(n), fast_fibonacci(n));
    // }
}
