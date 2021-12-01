import DogsContract from "../contracts/DogsContract.cdc"

transaction(target: Address, dogId: UInt64) {

    let ownerCollection: &DogsContract.Collection
    let targetCollection: &{DogsContract.CollectionPublic}

    prepare(acct: AuthAccount) {
        self.ownerCollection = acct.borrow<&DogsContract.Collection>(from: /storage/DogsCollection)
            ?? panic("Could not get owner collection capability")
        self.targetCollection = getAccount(target).getCapability<&{DogsContract.CollectionPublic}>(/public/DogsCollectionPublic).borrow()
            ?? panic("Could not get target collection capability")
    }

    execute {
        let ownerDog <- self.ownerCollection.withdraw(withdrawID: dogId)
        self.targetCollection.deposit(token: <- ownerDog)
    }

}
