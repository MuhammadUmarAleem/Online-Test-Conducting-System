const jwt = require('jsonwebtoken');

// Middleware function to validate JWT tokens
function tokenValidation(req, res, next) {

 var token = req.headers.authorization;
 token = token.split(' ')[1]; //splitting the Bearer token 
 const secretKey = 'secret-key'
 if (!token) {
 return res.status(401).json({ message: 'No token provided' });
 }
 
 jwt.verify(token, secretKey, (err, decoded) => {
 if (err) {
 return res.status(403).json({ message: 'Failed to authenticate token' });
 }
 // If the token is valid, save the decoded information for later use
 console.log(decoded);
 req.user = decoded;
 next();
})
}

function requireRoles(roles){
    return (req, res, next) => {
        const userRole = req.user.role;
        if(roles.includes(userRole)){
            next();
        }else{
            res.status(403).json({message: 'Permission denied'});
        }
    }
}


module.exports = {
    tokenValidation,
    requireRoles,
}