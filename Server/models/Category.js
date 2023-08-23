const mongoose = require('mongoose')


const categorySchema = mongoose.Schema({
    categoryName: {
        type: String,
        required: [true, 'Category name is required']
    },
    image: {
        type: String
    }

})
module.exports = mongoose.model('Category', categorySchema)
