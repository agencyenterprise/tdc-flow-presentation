pub contract DogsContract {

    pub let templates: {UInt64: DogTemplate}
    pub var totalNFTs: UInt64

    init() {
        self.totalNFTs = 0
        self.templates = {
            1: DogTemplate(name: "Bilu", age: 3, breed: "Poodle", weight: 2.50),
            2: DogTemplate(name: "Rock", age: 1, breed: "Yorkshire", weight: 2.0),
            3: DogTemplate(name: "Dexter", age: 4, breed: "German Shepherd", weight: 6.0)
        }
    }

    // Composite Type
    pub struct DogTemplate {
        pub let name: String
        pub let age: UInt8
        pub let breed: String
        pub let weight: UFix64
        
        init(name: String, age: UInt8, breed: String, weight: UFix64) {
            self.name = name
            self.age = age
            self.breed = breed
            self.weight = weight
        }
    }


    // TODO build example saving dogs without collection
    pub resource Dog {
        pub let id: UInt64
        pub let templateId: UInt64

        init(_ templateId: UInt64) {
            DogsContract.totalNFTs = DogsContract.totalNFTs + 1
            self.id = DogsContract.totalNFTs
            self.templateId = templateId
        }
    }

    // create Dog resource
    pub fun createDog(templateId: UInt64): @Dog {
        return <- create Dog(templateId)
    }

    pub resource Collection {
        pub let ownedDogs: @{UInt64: Dog}

        init() {
            self.ownedDogs <- {}
        }

        pub fun deposit(token: @Dog) {
            self.ownedDogs[token.id] <-! token
        }

        pub fun withdraw(withdrawID: UInt64): @Dog {
            let token <- self.ownedDogs.remove(key: withdrawID) 
                    ?? panic("Cannot withdraw: Moment does not exist in the collection")
            return <-token
        }

        destroy() {
            destroy self.ownedDogs
        }
    }
}
