let bodyParser = require('body-parser');
const { response } = require('express');
const { request } = require('http');
let app = require('express')();
let port = 3003;

app.use(bodyParser.json());

let todos = [
    {item: "Take out trash", priority: 0},
    {item: "Buy eggs", priority: 1},
    {item: "Clean the house", priority: 2}
]

app.get('/', (request, response) => response.send({items: todos}))

app.post('/add', (request, response) => {
    if (request.body && request.body.item != "") {
        console.log(request.body);
        todos.push(request.body);
        response.send({items: todos});
    } else {
        response.status(400).send({message: "Todo item must have a title"})

    }
});

app.listen(port, () =>  console.log(`Example app listening on port ${port}!`))