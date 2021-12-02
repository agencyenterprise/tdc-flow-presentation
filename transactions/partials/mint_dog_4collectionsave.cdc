import DogsContract from 0x01

transaction {

    let collection: &DogsContract.Collection

    prepare(acct: AuthAccount) {
        self.collection = acct.borrow<&DogsContract.Collection>(from: /storage/DogsCollection)
            ?? panic("Could not borrow DogsCollection")   
    }

    execute {
        let dogInfo = DogsContract.DogInfo(name: "Bilu", age: 3, breed: "Poodle", weight: 2.50)
        let dog <- DogsContract.mintDog(dogInfo)       
        self.collection.deposit(token: <- dog)
    }


}
 