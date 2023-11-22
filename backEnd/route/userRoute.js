const express = require('express')
const router = express.Router();

const userController = require('../controller/userController')
const {tokenValidation, requireRoles} = require('../utils/authorization_middleware')


router.post('/user', userController.createUser);
router.get('/user', userController.getAllUsers);
router.put('/user/:id', userController.updateUser);
router.delete('/user/:id', userController.deleteUser);

//route for login
// router.post('/user/login', userController.userLoginAuthentication);
router.post('/user/jwt', userController.userLoginJsonWebToken);

// router.post('/user/welcome', tokenValidation, userController.adminDashboard);
// router.post('/user/superAdmin', tokenValidation, requireRoles(['Super Admin']), userController.superAdminDashboard);
// router.post('/user/Admin', tokenValidation, requireRoles(['Admin']), userController.adminDashboard);
// router.post('/user/AdminSuperAdmin', tokenValidation, requireRoles(['Super Admin', 'Admin']), userController.AdminSuperAdminDashboard);
// router.post('/user/public', tokenValidation, requireRoles(['Super Admin', 'Admin', 'User']), userController.userDashboard);

module.exports = router;
