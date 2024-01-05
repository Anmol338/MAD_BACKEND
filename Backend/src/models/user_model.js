// Importing only Schema and model from mongoose
const {Schema, model} = require('mongoose');

// Import uuid for the unique Id auto generate
const uuid = require('uuid');

// Import bcrypt for password encription
const bcrypt = require('bcrypt');

// Creating user schema
const userSchema = new Schema({
    id:{ type: String, unique: true },
    fullName: { type: String, default: "" },
    email: { type: String, required: true, unique: true},
    password: { type: String, required: true},
    phoneNumber: { type: String, default: ""},
    address: { type: String, default: ""},
    city: { type: String, default: ""},
    state: { type: String, default: ""},
    profileProgress: { type: Number, default: 0 },
    updateOn: { type: Date },
    createdOn: { type: Date }
});

// Created pre function to auto update details ike id and dates while saving the user data
userSchema.pre('save', function(next) {
    this.id = uuid.v1();
    this.updateOn = new Date();
    this.createdOn = new Date();

    // Hashing the password using bcrypt
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(this.password, salt);
    this.password = hash;

    next();
});

userSchema.pre(['update', 'findOneAndUpdate', 'updateOne'], function(next){
    const update = this.getUpdate();
    delete update._id;
    delete update.id;

    this.updateOn = new Date();

    next();
});

// Creating the model userModel of userSchema
const UserModel = model('User', userSchema);

// Exporting the userModel module
module.exports = UserModel;