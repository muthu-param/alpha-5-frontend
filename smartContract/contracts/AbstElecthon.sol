pragma solidity ^0.4.18;

import "./IElecthon.sol";

contract AbstElecthon is IElecthon {
    event onAdded(
        address indexed owner,
        uint256 uInternalId,
        uint256 indexed userType
    );

    event onVoted(
        address indexed sender,
        string voteType,
        address indexed owner
    );

    struct UserInfo {
        string metaInfo;
        string primaryID;
        string idType;
        bool isActive;
        address owner;
        uint256 uInternalId;
        bool voteSpent;
        string voteType;
    }

    struct CandidateInfo {
        string metaInfo;
        string primaryID;
        string idType;
        bool isActive;
        address owner;
        uint256 cInternalId;
    }

    enum UserType {
        USER,
        CANDIDATE
    }


    UserInfo[] internal userInfos;
    mapping(address => uint256) usersMap;
    mapping(address => address[]) internal allUsers;

    CandidateInfo[] internal candidateInfos;
    mapping(address => uint256) candidatesMap;
    mapping(address => address[]) internal allCandidates;

    address internal owner;
    bool internal absolute;

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    function enableAbsolute() public onlyOwner {
        absolute = true;
    }

    function disableAbsolute() public onlyOwner {
        absolute = false;
    }

    function isAbsolute() external view returns (bool) {
        return absolute;
    }
}
