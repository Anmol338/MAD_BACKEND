// Importing the modules
const express = require('express');
const bodyParser = require('body-parser');
const helmet = require('helmet');
const morgan = require('morgan');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();

// Using the modules
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(helmet());
app.use(morgan('dev'));
app.use(cors());

// const local_DB = "mongodb://localhost:27017/ecommerce";
const remote_DB = "mongodb+srv://anmolshrestha:fAViOj6Z7JDVLjBq@ecommerce.yiui903.mongodb.net/ecommerce?retryWrites=true&w=majority";

// Connect mongoose DB
mongoose.connect(remote_DB);

// Declaring the routes
const UserRoutes = require("./src/routes/user_routes");
app.use("/api/v1/user", UserRoutes);

const CategoryRoutes = require("./src/routes/category_routes");
app.use("/api/v1/category", CategoryRoutes);

const ProductRoutes = require("./src/routes/product_routes");
app.use("/api/v1/product", ProductRoutes);

const CartRoutes = require("./src/routes/cart_routes");
app.use("/api/v1/cart", CartRoutes);

const OrderRoutes = require("./src/routes/order_routes");
app.use("/api/v1/order", OrderRoutes);

// Assigning PORT to the server
const PORT = 5000;

// Server listing
app.listen(process.env.PORT  || PORT, () => console.log(`Server start at PORT: ${PORT}`));