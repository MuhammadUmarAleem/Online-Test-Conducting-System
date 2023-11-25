const mongoose = require('mongoose');
const userSchema = new mongoose.Schema({
    firstName : {
        type: String,
        required : true,
    },    
    lastName : {
        type: String,
        required : true,
    },
    email : {
        type: String,
        required : true,
        isUnique: true,
    },
    password : {
        type: String,
        required : true,
    },
    role : {
        type: String,
        required : true,
        enum: ["Admin", "Student", "Teacher"],
    },
    isVerified : {
        type: Boolean,
        required : true,
        default: false,
    },
},    {    timestamps: true,} );

module.exports = mongoose.model('userLogin', userSchema)
// Compare this snippet from routes/userRoutes.js: