pub contract DogsContract {
    pub var totalDogs: UInt64

    pub struct DogInfo {
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

    pub resource Dog {
        pub let id: UInt64
        pub let dogInfo: DogInfo

        init(_ dogInfo: DogInfo) {
            DogsContract.totalDogs = DogsContract.totalDogs + 1
            self.id = DogsContract.totalDogs
            self.dogInfo = dogInfo
        }
    }

    pub fun mintDog(_ dogInfo: DogInfo): @Dog {
        return <- create Dog(dogInfo)
    }
    pub resource interface CollectionPublic {
        pub fun listDogs(): {UInt64: DogInfo}
        pub fun deposit(token: @Dog)
    }

    pub resource Collection: CollectionPublic {
        pub let ownedDogs: @{UInt64: Dog}

        init() {
            self.ownedDogs <- {}
        }

        pub fun deposit(token: @Dog) {
            self.ownedDogs[token.id] <-! token
        }

        pub fun withdraw(withdrawID: UInt64): @Dog {
            let token <- self.ownedDogs.remove(key: withdrawID) 
                    ?? panic("This dog was not found in the collection")
            return <-token
        }

        pub fun listDogs(): {UInt64: DogInfo} {
            let dogs: {UInt64: DogInfo} = {}
            for key in self.ownedDogs.keys {
                let dog = &self.ownedDogs[key] as &Dog
                dogs[key] = dog.dogInfo
            }
            return dogs
        }

        destroy() {
            destroy self.ownedDogs
        }
    }

    pub fun createCollection(): @Collection {
        return <- create Collection()
    }
    
    init() {
        self.totalDogs = 0
        
        let collection <- DogsContract.createCollection()
        self.account.save(<- collection, to: /storage/DogsCollection)
        self.account.link<&{DogsContract.CollectionPublic}>(/public/DogsCollectionPublic, target: /storage/DogsCollection)
    }
}
 