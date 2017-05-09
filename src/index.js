import firebaseConfig from './firebase.config.js'
// Require index.html so it gets copied to dist
import index from './index.html'


var Elm = require('./Main.elm')
var mountNode = document.getElementById('main')
var app = Elm.Main.embed(mountNode)

firebase.initializeApp(firebaseConfig)

app.ports.fetchList.subscribe(_ => {
    firebase.database().ref('lists/recipes').once('value', snapshot => {
        app.ports.receiveList.send(JSON.stringify(snapshot.val()))
    })
})

app.ports.saveItem.subscribe(function(itemData) {
    const newKey = firebase.database().ref().child('lists/recipes').push().key

    if(itemData.id === "") {
        itemData.id = newKey
    }

    firebase.database()
        .ref('lists/recipes/' + itemData.id)
        .set(itemData)
        .then(_ => app.ports.afterSaveItem.send(itemData))
})

app.ports.removeItem.subscribe(function(itemId) {

    firebase.database()
        .ref('lists/recipes/' + itemId)
        .remove()
})
