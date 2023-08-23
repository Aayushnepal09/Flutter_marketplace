const mongoose = require('mongoose')
const category = require('./category')
const user=require('./User')

const OrderSchema = mongoose.Schema({
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
    ],
    amount:{
        type:Number,required:true
    },
    address:{
        type:Object,
        required:true
    },
    status:{
        type:String,
        default:"pending"
    }

    
}, { timestamps: true })
module.exports = mongoose.model('Order', OrderSchema)
