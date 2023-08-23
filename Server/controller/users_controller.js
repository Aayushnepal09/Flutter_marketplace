const bcrypt = require('bcryptjs')
const User = require('../models/User')
const jwt = require('jsonwebtoken')
const catchAsyncErrors=require('../middleware/catchAyncErrors')



const registeruser = ((req, res, next) => {
    User.findOne({ username: req.body.username })
        .then(user => {
            if (user != null) {
                let err = new Error(`User ${req.body.username} already exists.`)
                res.status(400)
                return next(err)
            }
            bcrypt.hash(req.body.password, 10, (err, hash) => {
                if (err) return next(err)
                user = new User({
                    fname: req.body.fname,
                    lname: req.body.lname,
                    username: req.body.username,
                    email: req.body.email,
                    password: hash
                })
                const file = req.file;
                if (file) {
                    const fileName = req.file.filename;
                    user.image = '/images/user_image/' + fileName;
                }
                if (req.body.role) user.role=req.body.role
                
                user.save().then(user => {
                    res.status(201).json({
                        'status': 'User registered successfully',
                        userId: user._id,
                        username: user.username,
                        role:user.role
                    })
                }).catch(next)
            })
        }).catch(next)
})

const deleteallusers = (req, res) => {
    User.deleteMany()
        .then((reply) => {
            res.json(reply)
        }).catch(console.log)
}

const getUserByID = (req, res, next) => {
    User.findById(req.params.id)
        .then((user) => {
            const { password, ...others } = user._doc;
            res.json(others)
        }
        ).catch(next)
    
}
const updateUserByID = (req, res, next) => {
    if (req.body.password) {
        req.body.password = bcrypt.hash(req.body.password, 10, (err, hash) => {
            if (err) return next(err)
            req.body.password = hash
            User.findByIdAndUpdate(req.params.id, { $set: req.body }, { new: true })
                .then((user) => {
                    res.json(user)
                }).catch(next)

        }
        )
    }
}


const deleteUserByID = (req, res, next) => {
    User.findByIdAndDelete(req.params.id)
        .then((reply) => {
            res.json(reply)
        }).catch(next)
    
}


const loginuser = (req, res, next) => {
    User.findOne({ username: req.body.username })
        .then(user => {
            if (user == null) {
                let err = new Error(`User ${req.body.username} has not been registered yet`)
                res.status(404)
                return next(err)
            }
            bcrypt.compare(req.body.password, user.password, (err, status) => {
                if (err) return next(err)
                if (!status) {
                    let err = new Error('Password does not match.')
                    res.status(401)
                    return next(err)
                }
                let data = {
                    userId: user._id,
                    username: user.username,
                    role:user.role
                }
                jwt.sign(data, process.env.SECRET,
                    { 'expiresIn': '1d' }, (err, token) => {
                        if (err) return next(err)
                        res.json({
                            success:true,
                            status: 'Login success',
                            token: token
                        })
                    })
            })

        }).catch(next)
}


exports.updatePassword = catchAsyncErrors(async(req, res, next) => {
    const user = await User.findById(req.user.id).select("+password");

    const isPasswordMatched = await user.comparePassword(req.body.oldPassword);

    if (!isPasswordMatched) {
        return next(
            new ErrorHandler("Old password is not matched or incorrect", 400)
        );
    }

    if (req.body.newPassword !== req.body.passwordConfirm) {
        return next(new ErrorHandler("Passwords are not matched", 400));
    }

    user.password = req.body.newPassword;
    await user.save();

    sendToken(user, 200, res);
});



module.exports = {
    registeruser,
    loginuser,
    getUserByID,
    updateUserByID,
    deleteUserByID,
    deleteallusers
}