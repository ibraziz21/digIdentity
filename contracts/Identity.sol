// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

contract Identity {
    /*for a user to actually have a digital identity, 
            -Their Address
            -Proof of ID (password)
*/
    address private owner;

    struct UserDetails {
        bytes32 proof;
        bool exists;
    }

    mapping (address => UserDetails) private identities;
    mapping (address => bool) private hasAccess;
    constructor() {
        owner = msg.sender;
    }
    // Identity Creation
    //in its bare minimum, creation of identity requires a user address (unique Id) and some sort of proof
    function createIdentity(bytes32 _proof) external{
        if(_proof == 0x) revert ();
        if(identities[msg.sender].exists) revert alreadyCreated();
        identities[msg.sender] = UserDetails(_proof, true);
    }
    //to verify identity, the msg.sender has to input the same proof as stored
    function verifyIdentity(address _address,bytes32 _proof) public view returns (bool) {
        if(!identities(_address).exists) revert("Does Not Exist");
        if(identities[_address].proof != _proof) revert UnableToVerify();
        return true;
    }

//Only the msg.sender can delete their own identity
    function deleteIdentity(bytes32 _proof) external {
        require(identities[msg.sender].exists, "Identity does not exist");
        if(identities[msg.sender].proof != _proof) revert("Unauthorized")
        delete identities[msg.sender];
    }

    //Access control using the identity
    //Say, Our project has 2 other smart contracts. For a user to have access
    // This can be used as a modifier in the other smart contracts
    
    function gainAccess(bytes32 _proof) external {
        if(verifyIdentity(msg.sender, _proof)){
            hasAccess[msg.sender];
        }
    }


}