// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Struct to store candidate details
    struct Candidate {
        string name;
        uint voteCount;
    }

    // Mapping to track voters (prevent double voting)
    mapping(address => bool) public voters;

    // Array of candidates
    Candidate[] public candidates;

    // Admin address (deployer)
    address public admin;

    // Constructor to set candidates and admin
    constructor(string[] memory candidateNames) {
        admin = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }

    // Function to cast a vote
    function vote(uint candidateIndex) public {
        require(!voters[msg.sender], "Voter has already cast a vote.");
        require(candidateIndex < candidates.length, "Invalid candidate!");

        voters[msg.sender] = true;
        candidates[candidateIndex].voteCount += 1;
    }
    // Struct to return candidate details
    struct CandidateDetails {
        string name;
        uint voteCount;
    }

    // Function to get candidate details
    function getCandidate(uint index) public view returns (CandidateDetails memory) {
        require(index < candidates.length, "Invalid candidate index!");
        Candidate storage candidate = candidates[index];
        return CandidateDetails(candidate.name, candidate.voteCount);
    }

    // Function to get total candidates
    function getCandidateCount() public view returns (uint) {
        return candidates.length;
    }
}