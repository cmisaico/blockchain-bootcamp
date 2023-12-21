// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.5.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.5.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.5.0/access/Ownable.sol";

contract loteria is ERC20, Ownable {

    address public nft;

    constructor() ERC20("Loteria", "JA"){
        _mint(address(this), 1000);
        nft = address(new mainERC721());
    }

    address public ganador;

    mapping(address => address) public usuario_contract;

    function precioToken(uint256 _numTokens) internal pure returns (uint256){
        return _numTokens * (1 ether);
    }

    function balanceTokens(address _account) public view returns (uint256){
        return balanceOf(_account);
    }

    function balanceTokensSC() public view returns (uint256){
        return balanceOf(address(this));
    }

    function balanceEthersSC() public view returns (uint256){
        return address(this).balance / 10**10;
    }

    function registrar() internal {
        address addr_personal_contract = address(new boletosNFTs(msg.sender,
            address(this), nft));
        usuario_contract[msg.sender] = addr_personal_contract;
    }

    function usersInfo(address _account) public view returns (address){
        return usuario_contract[_account];
    }

    function compraTokens(uint256 _numTokens) public payable {
        if(usuario_contract[msg.sender] == address(0)){
            registrar();
        }
        uint256 coste = precioToken(_numTokens);
        require(msg.value >= coste, "Cimpra menos tokens o paga con mas thers");
        uint256 balance = balanceTokensSC();
        require(_numTokens <= balance, "Compra un numero menor de tokens");
        uint256 returnValue = msg.value - coste;
        payable(msg.sender).transfer(returnValue);
        _transfer(address(this), msg.sender, _numTokens);
    }




}

contract mainERC721 is ERC721 {
    address public direccionLoteria;
    constructor() ERC721("Loteria", "STE"){
        direccionLoteria = msg.sender;
    }

    function safeMint(address _propietario, uint256 _boleto) public {
        require(msg.sender == loteria(direccionLoteria).usersInfo(_propietario),
            "Notienes permisos para ejcutar esta funcion");
        _safeMint(_propietario, _boleto);
    }

}

contract boletosNFTs {
    struct Owner {
        address direccionPropietario;
        address contratoPadre;
        address contratoNFT;
        address contratoUsuario;
    }

    Owner public propietario;

    constructor(address _propietario, address _contratoPadre, address _contratoNFT){
        propietario = Owner(_propietario,
                            _contratoPadre,
                            _contratoNFT,
                            address(this));
    }

    function mintBoleto(address _propietario, uint _boleto) public {
        require(msg.sender == propietario.contratoPadre,
            "No tienes permisos para ejecutar esta funcion");
        mainERC721(propietario.contratoNFT).safeMint(_propietario, _boleto);
    }
}