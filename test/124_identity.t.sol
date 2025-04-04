// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test124 is Test, SymTest {
    address constant IDENTITY_PRECOMPILE = address(4);

    function test_new_identity_contract(bytes memory input) external {
        // https://eips.ethereum.org/EIPS/eip-7666
        vm.etch(address(42), hex"365f5f37365ff3");

        assertEqCall({
            targetA: IDENTITY_PRECOMPILE,
            callDataA: input,
            targetB: address(42),
            callDataB: input,
            strictRevertData: true
        });
    }
}
