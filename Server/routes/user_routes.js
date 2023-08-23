const express = require('express')
const userController = require('../controller/users_controller')
const auth = require('../middleware/auth')
const uploadOptions = require('../middleware/uploaduser')
const updatePassword=require ("../controller/users_controller")
const bcrypt=require('bcryptjs')
const{check,validationResult}=require('express-validator')


const router = express.Router()
// router.put('/password', [
//     auth,
//     check('oldPassword').notEmpty().withMessage('Old password is required'),
//     check('newPassword').isLength({ min: 6 }).withMessage('New password must be at least 6 characters'),
//     check('confirmPassword').custom((value, { req }) => {
//       if (value !== req.body.newPassword) {
//         throw new Error('Passwords do not match');
//       }
//       return true;
//     }),
//   ], async (req, res) => {
//     // Validate the request
//     const errors = validationResult(req);
//     if (!errors.isEmpty()) {
//       return res.status(400).json({ errors: errors.array() });
//     }
  
//     try {
//       // Find the user by ID
//       const user = await User.findById(req.user.id);
  
//       // Check if the old password is correct
//       const isMatch = await bcrypt.compare(req.body.oldPassword, user.password);
//       if (!isMatch) {
//         return res.status(401).json({ msg: 'Invalid credentials' });
//       }
  
//       // Hash the new password
//       const salt = await bcrypt.genSalt(10);
//       user.password = await bcrypt.hash(req.body.newPassword, salt);
  
//       // Save the updated user
//       await user.save();
  
//       res.json({ msg: 'Password updated successfully' });
//     } catch (err) {
//       console.error(err.message);
//       res.status(500).send('Server error');
//     }
//   });










router.route('/login')
    .post(userController.loginuser)


router.route('/')
    .get((req, res) => {
        res.status(501).send({ "reply": "Get request not supported" })
    })
    .post(uploadOptions.single('image'), userController.registeruser)
    .put((req, res) => {
        res.status(501).send({ "reply": "Put request not supported" })
    })
    .delete(auth.verifyAdmin, userController.deleteallusers)

router.route('/:id')
    .get(userController.getUserByID)
    .post((req, res) => {
        res.status(501).send({ "reply": "Not implemented" })
    })
    .put(auth.verifyUser, userController.updateUserByID)
    .delete(auth.verifyUser, userController.deleteUserByID)

router.get('/:profile', auth.verifyUser, async (req, res) =>{
        try{
            await User.findById({_id:req.user.userId})
            .then(
                (user) => {
                    res.status(200).json({
                        success: true,
                        message: "user details",
                        data: user,
                    });
                })
        }catch(error){
            console.log(error.message)
        }
    });
    
//router.route("/users/update").put(isauth, updatePassword);
//router.route("/updates").put(auth, updatePassword);


module.exports = router;