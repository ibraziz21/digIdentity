// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

contract Identity {
    /*for a user to actually have a digital identity, 
            -Their Address
            -Proof of ID (password)
*/
    struct UserDetails {
        bytes32 proof;
        bool exists;
    }

    mapping (address => UserDetails) public identities;
    constructor() {
        
    }
    // Identity Creation
    //in its bare minimum, creation of identity requires a user address (unique Id) and some sort of proof
    function createIdentity(bytes32 _proof) external{
        if(_proof == 0x) revert ();
        if(identities[msg.sender].exists) revert alreadyCreated();
        identities[msg.sender] = UserDetails(_proof, true);
    }

}