// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

/*
FakeMarketPrice.sol

written by:
mousedev.eth

Implications of using FakeMarketPrice.sol

Any call to _convertCentsToWei will fail.

These includes:
1. modifier onlyOwnerOrAdmin
    a. This means the fake market price MUST detect if sender is an admin, and continue to work if it is.
2. createRandomizedIpc
3. createIpcSeed
4. buyIpc
5. changeIpcName
6. modifyDna
7. buyXp
8. getIpcPriceInWei

Since _convertCentsToWei is called within the onlyOwnerOrAdmin modifier, these functions are also affected:
1. setIpcPrice
2. rollAttributes
3. customizeDna
4. randomizeDna
5. changeAdminAuthorization
6. setSpecialPriceForAddress
7. changeIpcName

However, we can solve this by allowing admin accounts to call the USD function.

The side effects are that under no circumstance can a user call the included functions without admin access.
*/

interface MarketPrice {
    function USD(uint256 _id) external view returns (uint256);
}

contract FakeMarketPrice is Ownable {
    MarketPrice public OldMarketPrice;

    constructor(address marketPriceAddress) {
        OldMarketPrice = MarketPrice(marketPriceAddress);
    }
    
    uint256 public testVar;

    bool public willRevert = true;
    bool public allowAdminUsage = true;

    mapping(address => bool) public isAdmin;

    function setAdmin(address _admin, bool _isAdmin) public onlyOwner {
        isAdmin[_admin] = _isAdmin;
    }

    function toggleRevert(bool _willRevert) public onlyOwner {
        willRevert = _willRevert;
    }

    function toggleAdminUsage(bool _allowAdminUsage) public onlyOwner {
        allowAdminUsage = _allowAdminUsage;
    }

    function USD(uint256) public view returns (uint256) {
        if (willRevert) {
            //If admins are allowed and they are one, return old market price.
            if (allowAdminUsage && isAdmin[msg.sender]) return OldMarketPrice.USD(0);

            //revert.
            revert();
        }

        //If reverting it turned off, return old market price.
        return OldMarketPrice.USD(0);
    }

    function tryToReadFromUSD() public {
        testVar = USD(0);
    }
}
