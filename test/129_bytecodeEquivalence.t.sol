// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";

import {SymTest} from "halmos-cheatcodes/SymTest.sol";

contract Test129 is Test, SymTest {
    function setUp() public {
        console2.log("Test129.setUp");
    }

    /// @dev reading a file that contains a hex string should return the decoded bytes
    function load_bytecode(string memory filename) internal returns (bytes memory) {
        console2.log("loading bytecode from", filename);
        string[] memory command = new string[](2);
        command[0] = "cat";
        command[1] = filename;

        bytes memory result = vm.ffi(command);
        console2.log("# bytes read: ", result.length);
        return result;
    }

    function deploy_contract(bytes memory code, uint256 args_length) internal returns (address deploy_addr) {
        bytes memory initcode;

        if (args_length > 0) {
            bytes memory args = svm.createBytes(args_length, "args");
            initcode = bytes.concat(code, args);
        } else {
            initcode = code;
        }

        assembly {
            deploy_addr := create(0, add(initcode, 0x20), mload(initcode))
        }
    }

    function check_bytecode_equivalence_runtime() external {
        bytes memory a = load_bytecode("a.txt");
        bytes memory b = load_bytecode("b.txt");

        address a_addr = address(0xaaaaaaaa);
        address b_addr = address(0xbbbbbbbb);

        vm.etch(a_addr, a);
        vm.etch(b_addr, b);

        bytes memory data = svm.createBytes(1024, "calldata");

        assertEqCall(a_addr, data, b_addr, data);
    }

    /// @custom:halmos --ffi --symbolic-jump
    function check_bytecode_equivalence_deploy() external {
        bytes memory a = load_bytecode("a.txt");
        bytes memory b = load_bytecode("b.txt");

        address a_addr = deploy_contract(a, 0);
        console2.log("a_addr =", a_addr);

        address b_addr = deploy_contract(b, 0);
        console2.log("b_addr =", b_addr);

        bytes memory data = svm.createBytes(1024, "calldata");

        // TODO: this is the correct check for equivalence, but doesn't work great
        // with the way we handle vyper jump tables atm
        // assertEqCall(a_addr, data, b_addr, data);

        (bool success1, bytes memory result1) = a_addr.call(data);
        (bool success2, bytes memory result2) = b_addr.call(data);
        if (result1.length > 0 && result2.length > 0) {
            assertEq(result1, result2);
        }
    }
}
