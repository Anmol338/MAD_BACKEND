// Importing the userModel module
const UserModel = require('./../models/user_model');

// Importing the bcrypt module
const bcrypt = require('bcrypt');

// Creating the UserController module
const UserController = {

    // Async function to create user account 
    createAccount: async function(req, res){
        try{
            const UserData = req.body;
            const newUser = new UserModel(UserData);
            await newUser.save();

            return res.json({ success: true, data: newUser, message: "Account Created!"});
        }
        catch (ex){
            return res.json({ success: false, message: ex });
        }
    },

    signIn: async function(req, res){
        try{
            // Decryting the email and password from request body
            const {email, password} = req.body;
            
            // Searching the user using email from using user model
            const foundUser = await UserModel.findOne({ email: email });

            // Incase user not found this function is executed
            if(!foundUser){
                // return data in from of json
                return res.json({ success: false, message: "User not found!"});
            }

            // Comparing the request body user input password with the found user password in hash format using bcrypt
            const passwordMatch = bcrypt.compareSync(password, foundUser.password);

            // If the user input password doesnot match with database password the blow function executed
            if(!passwordMatch){
                return res.json({ success: false, message: "Incorrect Password"});
            }

            // All the user credentials are true then we will return success as below
            return res.json({ success: true, data: foundUser, message: "User SignIn successfully"});
        }
        catch (ex){
            return res.json({ success: false, message: ex });
        }
    },

    updateUser: async function(req, res){
        try{
            const userId = req.params.id;
            const updateData = req.body;

            const updateUser = await UserModel.findOneAndUpdate(
                { _id: userId },
                updateData,
                { new: true }
            );

            if(!updateUser){
                throw "User nor found!";
            }

            return res.json({ success: true, data: updateData, message: "User updated successfully!" });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    }

}

// Exporting the UserController module
module.exports = UserController;