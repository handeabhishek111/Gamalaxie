//SPDX-License-Identifier:MIT
pragma solidity>=0.8.0;

contract Web3Arcade 
{
    address owner;
    //Player Info
    struct Player{
        uint256 tokenId;
        uint256 score;
        string lastBattleFought;
    }
   
    //mapping that maps an address to a player
    mapping(address => Player) addressToPlayer;

    //Match making queue
    address[] matchQueue;

constructor()
{
    //Set the deployer as the owner of the contract
    owner = msg.sender;
}

    //function to join the queue by passing address, token id and score
    function JoinQueue(address _player,uint256 _tokenId,uint256 _score) public 
    {
        //Checks if the address being passed belongs to the player or the owner if not return message
        require( msg.sender == _player || msg.sender == owner,"You are not the owner of this address");
        if(matchQueue.length == 0)
        {
        Player memory temp;
        temp.tokenId = _tokenId;
        temp.score = _score;
        if(_score < 0)
        {
        temp.lastBattleFought = "Invalid";
        }
        addressToPlayer[msg.sender] = temp;
        matchQueue.push(_player);
        }
        else
        {
            //Check if the address is already in the queue 
            require(matchQueue[0] != msg.sender,"This person is already in the queue");
            Player memory temp;
        temp.tokenId = _tokenId;
        temp.score = _score;
         if(_score < 0)
        {
        temp.lastBattleFought = "Invalid";
        }
        addressToPlayer[msg.sender] = temp;
        matchQueue.push(_player);

        //Determine result
        if(addressToPlayer[matchQueue[0]].score < addressToPlayer[matchQueue[1]].score )
        {
            //Result is stored both ways so if both of the players call the function from their own side they get correct result
            addressToPlayer[matchQueue[1]].lastBattleFought = "true";
            addressToPlayer[matchQueue[0]].lastBattleFought = "false";
        }
        else
        {
            addressToPlayer[matchQueue[0]].lastBattleFought = "true";
            addressToPlayer[matchQueue[1]].lastBattleFought = "false";
        }
        //Pop both players out of the queue as soon as a winner is decided so as not to waste any space
        matchQueue.pop();
        matchQueue.pop();

        }

    }
    
    //Checks if a person is already in queue
    function isPersonInQueue(address _player)public view returns(bool)
    {
        if(matchQueue.length !=0)
        {
            //Return true only if person is in queue in all other cases return false
            if(matchQueue[0] == _player)
            {
                return true;
            }
            else{
                return false;
            }
        }
        else
        {
            return false;
        }
    }

    //Checks the result of a match the person calling this function is msg.sender and its score is more than 0
    function checkResult() public view returns(string memory)
    {
        if(addressToPlayer[msg.sender].score < 0)
        {
            return "Invalid";
        }
        else
        {
        return addressToPlayer[msg.sender].lastBattleFought;
        }
    }
    
    //Get the stored player from the mapping
    function getPlayer(address _player) public view returns(Player memory) 
    {
        
        return addressToPlayer[_player];
    }

    //Sets the players token id and score to 0 can only be called by the owner of the address or the owner of the contract 
    function deleteUser(address _userAddress) public
    {
        require(msg.sender == _userAddress || msg.sender == owner,"You are not the owner of this address");
        {
            addressToPlayer[_userAddress].tokenId = 0;
            addressToPlayer[_userAddress].score = 0;
        }
    }


}
