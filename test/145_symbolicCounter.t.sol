// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Counter {
    uint256 public number;

    function increment() public {
        number++;
    }
}

contract CounterHalmosTest is Test, SymTest {
    Counter public counter;

    function setUp () public {
        counter = new Counter();
        svm.enableSymbolicStorage(address(counter));
    }


    function check_isIncrementFeasible() public {
        vm.assume(counter.number() != 2);
        counter.increment();
        assertTrue(!(counter.number() == 2), "number is 2");
    }
}
