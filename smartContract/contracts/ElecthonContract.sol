pragma solidity ^0.4.18;

import "./AbstElecthon.sol";

contract ElecthonContract is AbstElecthon {
    constructor() public {
        owner = msg.sender;
    }

    function addCandidate(
        string metaInfo,
        string primaryID,
        string idType
    ) external returns (uint256) {
        uint256 cInternalId = candidateInfos.length;

        CandidateInfo memory candidateInfo;
        candidateInfo.metaInfo = metaInfo;
        candidateInfo.primaryID = primaryID;
        candidateInfo.idType = idType;
        candidateInfo.owner = msg.sender;
        candidateInfo.isActive = true;
        candidateInfo.cInternalId = cInternalId;

        candidateInfos.push(candidateInfo);
        candidatesMap[msg.sender] = cInternalId;
        allCandidates[owner].push(msg.sender);

        emit onAdded(msg.sender, cInternalId, uint256(UserType.CANDIDATE));
        return cInternalId;
    }

    function addUsers(
        string metaInfo,
        string primaryID,
        string idType
    ) external returns (uint256) {
        uint256 uInternalId = userInfos.length;

        UserInfo memory userInfo;
        userInfo.metaInfo = metaInfo;
        userInfo.primaryID = primaryID;
        userInfo.idType = idType;
        userInfo.owner = msg.sender;
        userInfo.isActive = true;
        userInfo.uInternalId = uInternalId;
        userInfo.voteSpent = false;

        userInfos.push(userInfo);
        usersMap[msg.sender] = uInternalId;
        allUsers[owner].push(msg.sender);

        emit onAdded(msg.sender, uInternalId, uint256(UserType.USER));
        return uInternalId;
    }

    function giveVoting(address userAddress, string voteType) external {
        require(absolute == false);

        uint256 userInternal = usersMap[userAddress];

        require(userInternal == userInfos[userInternal].uInternalId);
        require(
            msg.sender == userInfos[userInternal].owner || msg.sender == owner
        );
        require(userInfos[userInternal].voteSpent == false);

        userInfos[userInternal].voteSpent = true;
        emit onVoted(msg.sender, voteType, userAddress);
        return;
    }

    function getAllUsers(
        address contractOwner
    ) external view returns (address[] memory usersAddress) {
        return allUsers[contractOwner];
    }

    function getAllCandidates(
        address contractOwner
    ) external view returns (address[] memory candidatesAddress) {
        return allCandidates[contractOwner];
    }

    function getVotingStatus(
        address owner
    ) external view returns (bool voteSpent) {
        uint256 userInternal = usersMap[owner];
        return userInfos[userInternal].voteSpent;
    }

    function getUser(
        address userID
    )
        external
        view
        returns (
            string metaInfo,
            string primaryID,
            string idType,
            bool voteSpent
        )
    {
        uint256 userInternal = usersMap[userID];
        return (
            userInfos[userInternal].metaInfo,
            userInfos[userInternal].primaryID,
            userInfos[userInternal].idType,
            userInfos[userInternal].voteSpent
        );
    }

    function getCandidate(
        address candidateID
    ) external view returns (string metaInfo, string primaryID, string idType) {
        uint256 candidateInternal = candidatesMap[candidateID];
        return (
            candidateInfos[candidateInternal].metaInfo,
            candidateInfos[candidateInternal].primaryID,
            candidateInfos[candidateInternal].idType
        );
    }
}
