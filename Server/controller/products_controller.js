const Product = require('../models/Product')
const category = require('../models/category')

const getallproducts = (req, res, next) => {
    Product.find()
        .populate('category')
        .then((products) => {
            res.status(200).json({
                success: true,
                message: "List of products",
                data: products
            });
        }).catch((err) => next(err))
    //res.json(books)
}
const createproducts = (req, res, next) => {
    let product = {
        ...req.body,
        user: req.user.userId
    }

    const file = req.file;
    if (file) {
        const fileName = req.file.filename;
        product.image = '/images/product_image/' + fileName;
    }

    Product.create(product).then(product => {
        res.status(201).json({
            message: 'Product added successfully',
            data: product
        })
    }).catch(next)

    // let newbook = {
    //     'id': books[books.length - 1].id + 1,
    //     'title': req.body.title,
    //     'author': req.body.author
    // }
    // books.push(newbook)
    // res.status(201).send(books)
}
const deleteallproducts = (req, res) => {
    Product.deleteMany()
        .then((reply) => {
            res.json(reply)
        }).catch(console.log)
}
const getProductByID = (req, res, next) => {
    Product.findById(req.params.id)
        .populate('category')
        .then((book) => {
            res.json(book)
        }
        ).catch(next)
    // the_book = books.find((item) => item.id == req.params.id)
    // if (!the_book) res.status(404).json({ "reply": "Book not found" })
    // res.json(the_book)
}
const updateProductByID = (req, res, next) => {
    Product.findByIdAndUpdate(req.params.id, { $set: req.body }, { new: true })
        .then((product) => {
            res.json(product)
        }
        ).catch(next)
    // let updatedBooks = books.map((item) => {
    //     if (item.id == req.params.id) {
    //         item.title = req.body.title
    //         item.author = req.body.author
    //     }
    //     return item
    // })
    // res.json(updatedBooks)
}
const deleteProductByID = (req, res, next) => {
    Product.findByIdAndDelete(req.params.id)
        .then((reply) => {
            res.json(reply)
        }).catch(next)
    // deletedbooks = books.filter(item => item.id != req.params.id);
    // res.json(deletedbooks)
}
const searchProductByCategory = (req, res, next) => {
    const categoryId = req.query.categoryId;
    Product.find({ category: categoryId })
        .populate("category", "-__v")
        .then(
            (product) => {
                res.status(201).json({
                    success: true,
                    message: "List of products by category",
                    data: product,
                });
            }
        ).catch(
            (err) => {
                res.status(500).json({
                    success: false,
                    message: err,
                });
            }
        );
}

module.exports = {
    getallproducts,
    createproducts,
    deleteallproducts,
    getProductByID,
    updateProductByID,
    deleteProductByID,
    searchProductByCategory,
}

