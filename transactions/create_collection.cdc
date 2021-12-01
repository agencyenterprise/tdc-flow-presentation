import DogsContract from "../contracts/DogsContract.cdc"

transaction {

    prepare(acct: AuthAccount) {
        let collection <- DogsContract.createCollection()
        acct.save(<- collection, to: /storage/DogsCollection)
        acct.link<&{DogsContract.CollectionPublic}>(/public/DogsCollectionPublic, target: /storage/DogsCollection)
    }

}