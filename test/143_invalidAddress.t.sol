// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Foo {
    function bar(address a) public {}
}

contract Test143 is Test, SymTest {
    Foo foo;

    function setUp() public {
        foo = new Foo();
    }

    function test_invalidAddress(uint256 a) external {
        (bool succ, ) = address(foo).call(abi.encodeWithSignature("bar(address)", a));
        assert(succ);
    }
}
