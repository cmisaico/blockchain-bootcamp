// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract EthSend {

    constructor() payable {}
    receive() external payable { }

    // eventos
    event sendStatus(bool);
    event callStatus(bool, bytes);

    // Transfer
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(1 ether);
    }
    // Send
    function sendViaSend(address payable _to) public payable {
        bool sent = _to.send(1 ether);
        emit sendStatus(sent);
        require(sent == true, "El envio ha fallado");
    }
    //Call
    function sendViaCall(address payable _to) public payable {
        (bool success, bytes memory data) =_to.call{value: 1 ether}("");
        emit callStatus(success, data);
        require(success == true, "El envio ha fallado");
    }
}

contract EthReceiver {
    event log(uint amount, uint);

    receive() external payable {
        emit log(address(this).balance, gasleft());
    }
}


contract functions {
    function getName() public pure returns(string memory) {
        return "Joan";
    }

    uint256 x = 100;
    function getNumber() public view returns (uint256) {
        return x*2;
    }
    

}