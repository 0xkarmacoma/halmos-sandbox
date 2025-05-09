// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

import {IERC20Like, Basic4626Deposit} from "src/BasicERC4626.sol";

contract ERC20Like is IERC20Like {
    mapping(address => uint256) public balanceOf;

    function mint(address to, uint256 amount) external {
        balanceOf[to] += amount;
    }

    function approve(address spender, uint256 amount) external {
        // do nothing
    }

    function transferFrom(
        address owner_,
        address recipient_,
        uint256 amount_
    ) external returns (bool success_) {
        require(balanceOf[owner_] >= amount_, "Insufficient balance");
        balanceOf[owner_] -= amount_;
        balanceOf[recipient_] += amount_;
        return true;
    }
}

contract Test137 is Test, SymTest {
    ERC20Like asset;
    Basic4626Deposit vault;
    uint256 sumShares;

    function setUp() public {
        asset = new ERC20Like();
        vault = new Basic4626Deposit(address(asset), "Basic4626Deposit", "BASIC", 18);

        bytes4[] memory selectors = new bytes4[](1);
        selectors[0] = this.handler_deposit.selector;
        targetSelector(FuzzSelector({
            addr: address(this),
            selectors: selectors
        }));

        targetContract(address(this));
    }


    function handler_deposit(uint256 assets) public {
        asset.mint(address(this), assets);
        asset.approve(address(vault), assets);

        uint256 balanceBefore = asset.balanceOf(address(this));

        uint256 shares = vault.deposit(assets, address(this));

        uint256 balanceAfter = asset.balanceOf(address(this));

        // wrong, should be `balanceBefore - assets`
        // does *not* result in an assertion failure (why?)
        assertEq(balanceAfter, balanceBefore);

        // also wrong
        // does result in an assertion failure, but no counterexample (treated as a probe)
        assert(balanceAfter == balanceBefore);

        sumShares += shares;
    }


    // function invariant_balanceOf() public view {
    //     assertEq(vault.balanceOf(address(this)), sumShares);
    // }

    function invariant_happy() public view {
        assert(true);
    }

    function invariant_unhappy() public view {
        assert(false);
    }
}
