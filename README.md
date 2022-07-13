IPC Fake Market Price Contract

This contract is a proposed solution to the issue found within the IPC contract

Details about the issue can be found here:
https://twitter.com/_MouseDev/status/1546612501231566848

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