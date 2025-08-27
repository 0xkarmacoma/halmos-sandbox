// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Minty {
    uint256 public totalSupply;

    function mint(address to, string calldata cid) public {
        require(to != address(0), "nope");

        totalSupply++;
    }
}

contract Test142 is Test, SymTest {
    Minty m;

    function setUp() public {
        m = new Minty();
    }

    function check_mint(address caller, address to, string calldata cid) public {
        // vm.assume(caller != address(0) && to != address(0));
        vm.prank(caller);
        try m.mint(to, cid) {
            assert(m.totalSupply() == 1);
        } catch {
            assert(to == address(0));
        }
    }
}
