import DogsContract from "../contracts/DogsContract.cdc"

/// pragma arguments (acct: 0xf8d6e0586b0a20c7)
pub fun main(acct: Address): {UInt64: DogsContract.DogInfo} {

    let dogsCollectionPublic = getAccount(acct).getCapability<&{DogsContract.CollectionPublic}>(/public/DogsCollectionPublic).borrow()
        ?? panic("Could not borrow CollectionPublic interface")
    
    return dogsCollectionPublic.listDogs()
}
 