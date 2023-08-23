const Cart= require('../models/Cart')

const getcart= (req, res, next) => {
    Cart.findone(userId=req.params.user._id)
        .then((carts) => {
            res.json(carts)
        }).catch((err) => next(err))
    //res.json(books)
}

const addtocart=(req,res,next)=>{
    let cart = {
        'userID':req.body.params.userID,
        'productId': req.body.params.productId,
        'quantity':req.body.quantity    }
    Product.create(req.body)
        .then((product) => {
            res.status(201).json(product)
        }).catch((err) => next(err))
}