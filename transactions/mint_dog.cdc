import DogsContract from "../contracts/DogsContract.cdc"

transaction {

    let collection: &DogsContract.Collection

    prepare(acct: AuthAccount) {
        self.collection = acct.borrow<&DogsContract.Collection>(from: /storage/DogsCollection)
            ?? panic("Could not borrow DogsCollection")   
    }

    execute {
        // choose a dog:
        let dogInfo = DogsContract.DogInfo(name: "Bilu", age: 3, breed: "Poodle", weight: 2.50)
        // let dogInfo = DogsContract.DogInfo(name: "Rock", age: 1, breed: "Yorkshire", weight: 2.0)
        // let dogInfo = DogsContract.DogInfo(name: "Dexter", age: 4, breed: "German Shepherd", weight: 6.0)

        // acct.save(<- dog, to: /storage/Dog)        

        let dog <- DogsContract.mintDog(dogInfo)
        
        // log(&dog as &DogsContract.Dog)
        // destroy dog
        
        self.collection.deposit(token: <- dog)
    }


}
 