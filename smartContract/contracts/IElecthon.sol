pragma solidity ^0.4.18;

interface IElecthon {
    function addCandidate (string metaInfo, string primaryID, string idType) external returns (uint256);

    function addUsers(string metaInfo, string primaryID, string idType) external returns (uint256);

    function giveVoting(address userId, string voteType) external;

    function getAllUsers(address contractOwner) external view returns (address[] memory);

    function getUser(address userID) external view returns (string metaInfo, string primaryID, string idType, bool voteSpent);

    function getAllCandidates(address contractOwner) external view returns (address[] memory);

    function getCandidate(address candidateID) external view returns (string metaInfo, string primaryID, string idType);

    function getVotingStatus(address userId) external view returns (bool voteSpent);
}