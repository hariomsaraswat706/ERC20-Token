// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC20 {

string public _name ="Hariom Token "  ; 
string public _symbol ="HT"; 
uint256  public _totalsupply ;
uint8  public constant  decimals = 18 ;
address public owner ; 

//mapping 
mapping(address => uint256 ) public balances ;
mapping (address => mapping ( address => uint256 )) public allowances ;

//event 
event Approval (address indexed _owner , address indexed  _spender  , uint256 _amount  ) ;
event Transfer(address indexed _from , address indexed  _to , uint256 _amount ) ; 
//constructor
constructor(uint256 _intialsupply ) {
    _totalsupply =  _intialsupply *10** uint256 ( decimals )  ;
    balances[msg.sender ] = _totalsupply ;
    owner = msg.sender ;
}

function name () public view returns (string memory ) {
    return  _name  ; 
}

function symbol () public view returns  (string memory ) {
    return _symbol ;
}
 function  totalSupply () public view returns (uint256 balance  ) {
    return  _totalsupply ;
 }
 

 function balanceOf (address _user) public view returns (uint256) {
 return  balances[_user] ;
 }
  
  // Mint function 

  function mint (address _to , uint256 _amount ) public {
    require(msg.sender == owner , " only owner  call this function "); 
    require( _to != address(0), " zero address ");
    balances[_to] += _amount ;
    _totalsupply += _amount ;
    emit Transfer(address(0), _to, _amount);
  }

  function burn (address _to , uint256 _amount ) public {
    require(msg.sender == owner , " only owner  call this function "); 
    require( _to != address(0), " zero address ");
    require(balances[_to] >= _amount , "insufficient  balance ");
    balances[_to] -= _amount ;
    _totalsupply -= _amount ;
    emit Transfer(_to, address(0), _amount);
  }
//Transfer function 

function  transfer (address _to , uint256 _amount  ) public returns (bool success) {
    require(balances[msg.sender] >= _amount , " insufficient balance ");
    require(_to != address (0) , "you are send token to address Zero "); 
balances[msg.sender] -= _amount ;
balances[_to]   += _amount ;
emit Transfer  ((msg.sender) , _to , _amount ) ;
return true ; 

}

function approve (address _spender , uint256 _amount ) public returns  (bool sccuess ) {
   require( _spender != address (0) , "Address zero" ); 
    allowances [msg.sender ] [_spender]  =_amount  ;
emit Approval (msg.sender , _spender ,  _amount ) ;
    return true ; 
}

function allowance(address  _owner , address _spender ) public view returns  (uint ) {
return        allowances  [_owner ] [_spender ] ; 

}

function transferFrom (address from  , address _to , uint256 _amount   ) public returns (bool success ) {
    require(balances[from] >= _amount , " insufficient balance ");
    require(allowances[from][msg.sender] >= _amount, "insufficient allowance") ;
    require(_to != address (0) , "you are send token to address Zero ");
    balances[from] -= _amount ;
    balances [_to] += _amount ;                                  
    allowances [from] [msg.sender] -= _amount ;
    emit Transfer (from , _to , _amount ) ;
    return true ; 
}
}
