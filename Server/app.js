require('dotenv').config()
const express = require('express')
const app = express()
const mongoose = require('mongoose')//
const port = 3000
const path = require('path')
const auth = require('./middleware/auth')
const user_routes = require('./routes/user_routes')
const category_routes = require('./routes/category_routes')
const product_routes = require('./routes/product_routes')



mongoose.connect('mongodb://127.0.0.1:27017/kinbech')
    .then(() => {
        console.log('connected to mongodb server')
        app.listen(port, () => {
            console.log(`App is running on port: ${port} `)
        })
    }).catch((err) => console.log(err))

// application level middleware
app.use((req, res, next) => {
    console.log(`${req.method} ${req.path}`)
    next()
})

app.use(
    "/images",
    express.static(path.join(__dirname, "/images"))
);

// starts with(^) / or ends with($) / or is index or index.html then 
app.get('^/$|index(.html)?', (req, res) => {
    res.sendFile(path.join(__dirname, 'views', 'index.html'))
})

//express defined middleware
app.use(express.json())


app.use('/users', user_routes)
// app.use(auth.verifyUser)
app.use('/category', category_routes)
app.use('/products', product_routes)

// error handling middleware
// when there is value in err parameter then it gets executed

app.use((err, req, res, next) => {
    console.log(err.stack)
    if (res.statusCode == 200) res.status(500)
    res.json({ "err": err.message })
})
