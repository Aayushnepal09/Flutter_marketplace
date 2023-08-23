const mongoose = require('mongoose')
const category = require('./category')
const user=require('./User')

const CartSchema = mongoose.Schema({
    userID:{
        type:String,
        required:true
    },
    products: [
        {
            productID:{
                type:mongoose.Schema.Types.ObjectId,
                ref:'Product'
            },
            quantity:{
                type:Number,
                default:1
            }
        }
    ]
    
}, { timestamps: true })
module.exports = mongoose.model('Cart', CartSchema)
