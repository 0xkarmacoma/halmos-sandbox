// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

interface A {
    function a() external;
}

interface B {
    function b() external;
}

interface AB is A, B {}

contract ExplicitlyAB is A, B {
    function a() external {
        console2.log("a()");
    }

    function b() external {
        console2.log("b()");
    }
}

contract ImplicitlyAB is A {
    function a() external {
        console2.log("a()");
    }

    // implements b, but does not explicitly inherit from B
    function b() external {
        console2.log("b()");
    }
}

contract Test122 is Test, SymTest {
    ExplicitlyAB public explicitlyAB;
    ImplicitlyAB public implicitlyAB;

    function setUp() public {
        explicitlyAB = new ExplicitlyAB();
        implicitlyAB = new ImplicitlyAB();
    }


    // output:
    // [console.log] b()
    // [console.log] a()
    // [PASS] test_explicitAB() (paths: 2, time: 0.09s (paths: 0.09s, models: 0.00s), bounds: [])
    function test_explicitAB() external {
        (bool succ, ) = address(explicitlyAB).call(svm.createCalldata("ExplicitlyAB"));
        vm.assume(succ);
    }


    // output is also:
    // [console.log] a()
    // [console.log] b()
    // [PASS] test_implicitAB_single_interface() (paths: 2, time: 0.08s (paths: 0.08s, models: 0.00s), bounds: [])
    //
    // the call to b() comes from fallback_selector
    function test_implicitAB_single_interface() external {
        bytes memory data = svm.createCalldata("122_interfaces.t.sol", "A");
        (bool succ, ) = address(implicitlyAB).call(data);
        vm.assume(succ);
    }

    function test_implicitAB_union_interface() external {
        (bool succ, ) = address(explicitlyAB).call(svm.createCalldata("AB"));
        vm.assume(succ);
    }
}
