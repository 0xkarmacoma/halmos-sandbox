// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract StateChangeTarget {
    uint256 public x;

    function setX(uint256 _x) external {
        if (_x != 0) {
            x = _x;
        }
    }
}

contract Test126 is Test, SymTest {
    address target;

    function setUp() public {
        target = address(new StateChangeTarget());
    }

    function test_stateChange() external {
        // snapshot the target contract storage before the call
        uint256 prevSnapshot = svm.snapshotStorage(target);

        // call any function with arbitrary arguments
        (bool success, ) = target.call(svm.createCalldata("StateChangeTarget"));

        // ignore reverts
        vm.assume(success);

        // snapshot the target contract storage after the call
        uint256 currSnapshot = svm.snapshotStorage(target);

        // assert that the storage has been modified
        assert(currSnapshot != prevSnapshot);
    }



}

