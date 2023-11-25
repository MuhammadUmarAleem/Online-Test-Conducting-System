const bCrypt = require('bcrypt');

const userLogin = require('../model/userSchema');

//create user API
async function createUser(){
    try{
            const {password} = req.body;
            const hashPassword = await bCrypt.hash(password, 8);
            let data = {
                firstName : req.body.firstName,
                lastName : req.body.lastName,
                email : req.body.email,
                password: hashPassword,
                role: req.body.role,
            }
            const user = await userLogin.create(data);
            res.status(201).json({ message: "User created successfully", user });

    }catch(err){
    res.status(500).json({ error: error.message });
    }
}

//API for getting all the users
async function getAllUsers(){
    try{
        const getAllUsers = await userLogin.find();
        res.json(getAllUsers);
    }catch(err){
        res.status(500).json({ error: err.message });
    }
}

//updating  API
async function updateUser(req, res) {
    try {
      const { id } = req.params;
      const { password } = req.body;
      const hashPassword = await bCrypt.hash(password, 8);
      let updatedData = {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        email: req.body.email,
        password: hashPassword,
      };
      const updateUser = await UserLogin.findByIdAndUpdate(id, updatedData, {
        new: true,
      });
      res.json(updateUser);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
  

  //deleting user API
async function deleteUser(req, res) {
    try {
      const { id } = req.params;
      const deleteaUser = await UserLogin.findByIdAndDelete(id);
      res.json(deleteaUser);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
  
  //Authenticating user login
async function userLoginAuthentication(req, res) {
    try {
      const { email, password } = req.body;
      const user = await UserLogin.findOne({ email });
      if (user) {
        const matchPassword = await bCrypt.compare(password, user.password);        

        if (matchPassword) {
          res.status(200).json("User Found");
        } else {
          res.status(302).json("Password does not match");
        }
      } else {
        res.status(404).json("User not found");
      }
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  //Authenticating user login
async function userLoginJsonWebToken(req, res, next) {
    try {
      const { email, password } = req.body;
    //   ;console.log(req.body)
      const user = await userLogin.findOne({ email });
        console.log(user.password); 
      if (!user) return res.status(404).json({ error: "User not found" });
      const matchPassword = await bCrypt.compare(password, user.password);
      
      console.log(matchPassword);
      if (matchPassword) {
        var token = generateToken(user);
        return res.status(200).json({
          message: "Logged in Successfully",
          email: email,
          name: user.firstName,
          userId: user.id,
          token: token,
        });
      } else {
        return res.status(401).json({ error: "password does not match" });
      }
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  //helping functions
const jwt = require("jsonwebtoken");

function generateToken(user) {
  const payLoad = {
    role: user.role,
    id: user.id,
  };
//   console.log(user);
//   console.log(payLoad);
  const secretKey = "secret-key";

  const token = jwt.sign(payLoad, secretKey);
  return token;
}

  
  module.exports = {
    createUser,
    getAllUsers,
    updateUser,
    deleteUser,
    userLoginAuthentication,
    userLoginJsonWebToken,
  };
  