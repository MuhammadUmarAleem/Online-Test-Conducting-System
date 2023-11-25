const schema = require("../model/userSchema");
const express = require("express");
const router = express.Router();
const bCrypt = require("bcrypt");
const userController = require("../controller/userController");
const {
  tokenValidation,
  requireRoles,
} = require("../utils/authorization_middleware");

//admin account creation
router.get("/admin", async (req, res) => {
  const hashPassword = await bCrypt.hash("bilal123", 8);

  let admin = await schema.create({
    firstName: "bilal",
    lastName: "basharat",
    email: "bilalbisharat@gmail.com",
    password: hashPassword,
    role: "Admin",
  });
  res.send({ admin });
});

//teacher account creation
router.get("/teacher", async (req, res) => {
  const hashPassword = await bCrypt.hash("teacher123", 8);

  let teacher = await schema.create({
    firstName: "Laeeq",
    lastName: "Khan",
    email: "m.laeeq.niazi@gmail.com",
    password: hashPassword,
    role: "Teacher",
  });
  res.send({ teacher });
});

router.post("/user", userController.createUser);
router.get("/user", userController.getAllUsers);
router.put("/user/:id", userController.updateUser);
router.delete("/user/:id", userController.deleteUser);

//route for login
// router.post('/user/login', userController.userLoginAuthentication);
router.post("/user/jwt", userController.userLoginJsonWebToken);

router.post("/user/role", tokenValidation, async (req, res) => {
  try {
    let user = req.user;
    let newUser = await schema.findById(user.id);
    res.status(200).json({ data: newUser });

  } catch (e) {
    res.status(500).json({ error: error.message });
  }
});

// router.post('/user/welcome', tokenValidation, userController.adminDashboard);
// router.post('/user/superAdmin', tokenValidation, requireRoles(['Super Admin']), userController.superAdminDashboard);
// router.post('/user/Admin', tokenValidation, requireRoles(['Admin']), userController.adminDashboard);
// router.post('/user/AdminSuperAdmin', tokenValidation, requireRoles(['Super Admin', 'Admin']), userController.AdminSuperAdminDashboard);
// router.post('/user/public', tokenValidation, requireRoles(['Super Admin', 'Admin', 'User']), userController.userDashboard);

module.exports = router;
