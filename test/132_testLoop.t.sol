// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {LibString} from "solmate/utils/LibString.sol";
import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test132 is Test, SymTest {
    function setUp() public view {
        console2.log("Test132.setUp");
    }

    function binarySearch(uint256[] memory arr, uint256 target) public view returns (uint256) {
        uint256 left = 0;
        uint256 right = arr.length - 1;
        while (left <= right) {
            uint256 mid = (left + right) / 2;
            if (arr[mid] == target) {
                return mid;
            }
            if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return type(uint256).max;
    }
}

