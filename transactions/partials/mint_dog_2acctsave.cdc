import DogsContract from 0x01

transaction {

    prepare(acct: AuthAccount) {
        let dogInfo = DogsContract.DogInfo(name: "Bilu", age: 3, breed: "Poodle", weight: 2.50)
        let dog <- DogsContract.mintDog(dogInfo)
        
        acct.save(<- dog, to: /storage/DogBilu)
    }

}
 