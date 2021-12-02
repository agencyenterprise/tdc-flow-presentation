import DogsContract from 0x01

transaction {

    prepare(acct: AuthAccount) {
        let dogInfo = DogsContract.DogInfo(name: "Dexter", age: 4, breed: "German Shepherd", weight: 6.0)
        let dog <- DogsContract.mintDog(dogInfo)
        
        acct.save(<- dog, to: /storage/DogDexter)
    }

}
 