// SPDX-License-Identifier: MIT
/*Your task is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming. The smart contract should have the following functionality:

Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
Transferring tokens: Players should be able to transfer their tokens to others.
Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
Checking token balance: Players should be able to check their token balance at any time.
Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/
pragma solidity ^0.8.18;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    event RedeemToken(address account, uint rewardCategory);
    event BurnToken(address account, uint amount);
    event TransferToken(address from, address to, uint amount);

    // onlyOwner modifier allows only the user to execute the function
    function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
    }

    //Wrapper function for balanceOf function of ERC20
    function getBalance() public view returns (uint){
        return balanceOf(msg.sender);
    }

    function redeem(uint rewardCategory) public {
        uint requiredAmount = rewardCategory * 10;
        require(balanceOf(msg.sender)>=requiredAmount,"Insufficient Amount");
        burn(requiredAmount);
        emit RedeemToken(msg.sender, rewardCategory);
    }

    // Wrapper function to access the private _burn function of ERC20
    function burn(uint amount) public {
        _burn(msg.sender, amount);
        emit BurnToken(msg.sender, amount);
    }
}
