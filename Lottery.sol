// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

// moonbeam课程第四课作业，很可能有错误，没有时间完善。

contract Lottery {
    address[] addresses;

    uint256 startTime;

    // uint256 totalMoney;

    address theLucky;

    function buyTicket() public payable {
        require(msg.value == 1 ether, "please send 1 ether to buy the lottery");

        if (addresses.length == 0) {
            startTime = block.timestamp;
            payable(address(this)).transfer(1 * 10**18);
            addresses.push(msg.sender);
        } else if (
            ((startTime != 0) && (block.timestamp - startTime) > 3600) ||
            (addresses.length > 9)
        ) {
            addresses.push(msg.sender);
            payable(theLucky).transfer(address(this).balance);
            addresses = [];
            payable(address(this)).transfer(1 * 10**18);
            startTime = block.timestamp;
        }
        addresses.push(msg.sender);
    }

    function setTheLucky() public {
        if (addresses.length == 1) {
            theLucky = addresses[0];
        } else {
            theLucky = addresses[1];
        }
    }
}
