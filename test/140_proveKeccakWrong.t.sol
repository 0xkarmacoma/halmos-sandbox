// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract MyContract is Test {
  mapping (uint => uint) balances;
  function setUp() public {
    balances[0xfaaaaaffafafafafaaaaa472134] = 50;
  }
  function prove_keccak_wrong(uint amt) public view {
    bytes32 hash = keccak256(abi.encodePacked(amt));
    uint balance = balances[uint(hash)];
    assert(balance != 50);
  }
}
