// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Target {
    address excludedSender;

    constructor(address _excludedSender) {
        excludedSender = _excludedSender;
    }

    function rejectsExcludedSender() external {
        assert(msg.sender != excludedSender);
    }
}

contract Test138 is Test, SymTest {
    Target target;

    function setUp() public {
        address excludedSender = svm.createAddress("excluded");

        target = new Target(excludedSender);

        // excludeSender(excludedSender);
    }

    function invariant_excludeSender() external {
        // nothing to do
    }
}
