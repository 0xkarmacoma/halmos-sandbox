// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract ByggyPoC is SymTest, Test {
    address _myaddr;

    function setUp() public {
        (_myaddr,) = makeAddrAndKey2("alice");
    }

    function test_makeAddrAndKey2() public {
        console.log("hm", _myaddr);
    }

    function makeAddrAndKey2(string memory name) internal returns (address addr, uint256 privateKey) {
        bytes32 notHash;
        assembly {
            notHash := mload(add(name, 32))
        }
        notHash = notHash >> (256 - bytes(name).length * 8);

        privateKey = uint256(notHash);
        // addr = vm.addr(privateKey);

        addr = address(uint160(uint256(notHash)));
        vm.label(addr, name);
    }
}
