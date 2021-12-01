import DogsContract from "../contracts/DogsContract.cdc"

/// pragma arguments (acct: 0xf8d6e0586b0a20c7)
pub fun main(acct: Address): [String] {

    let dogsCollectionPublic = getAccount(acct).getCapability<&{DogsContract.CollectionPublic}>(/public/DogsCollectionPublic).borrow()
        ?? panic("Could not borrow CollectionPublic interface")
    
    let dogNames: [String] = []
    for dogInfo in dogsCollectionPublic.listDogs().values {
        dogNames.append(dogInfo.name)
    }
    return dogNames
}
 