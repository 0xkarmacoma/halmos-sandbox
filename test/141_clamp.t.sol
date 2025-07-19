// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

error InvalidRange(uint256 low, uint256 high);
event Clamp(uint256, uint256);

contract Test141 is Test, SymTest {
    function setUp() public {
        console2.log("Test141.setUp");
    }

    // cvc5-int can solve this in <1s
    function check_clampUint(
        uint256 value,
        uint256 min,
        uint256 max
    ) public {
        vm.assume(min < max);
        try this.clamp(value, min, max, true) returns (uint256 res) {
            assert(res >= min && res <= max);
        } catch (bytes memory) {
            assertTrue(false);
        }
    }

    function clamp(uint256 value, uint256 low, uint256 high, bool enableLogs) public returns (uint256) {
        // Input validation: Ensure low <= high to prevent overflow
        // Without this check, (high - low + 1) could wrap around if low > high
        if (low > high) revert InvalidRange(low, high);

        // Return values already in range without modification.
        // This optimization also handles the full uint256 range [0, type(uint256).max]
        // where every possible value would pass this check
        if (value >= low && value <= high) {
            return value;
        }

        // Wrap out-of-range values using modular arithmetic
        //
        // The formula: ans = low + (value % range_size)
        // Where range_size = (high - low + 1) = total valid values in range
        //
        // Example:
        // clamp(17, 5, 9) with range [5,6,7,8,9] (size=5)
        // → 17 % 5 = 2, so 5 + 2 = 7 ✓ (wraps to position 2 in range)
        uint256 ans = low + (value % (high - low + 1));

        // Optional logging: Record when values were actually clamped
        if (enableLogs) {
            logClamp(value, ans);
        }

        return ans;
    }

    function logClamp(uint256 value, uint256 ans) internal {
        emit Clamp(value, ans);
    }
}
