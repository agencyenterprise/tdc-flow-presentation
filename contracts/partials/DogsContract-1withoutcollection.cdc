pub contract DogsContract {
    pub var totalDogs: UInt64

    init() {
        self.totalDogs = 0
    }

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

}
 