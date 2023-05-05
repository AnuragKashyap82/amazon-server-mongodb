
const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

const PORT = 3000;
const app = express();
const DB = "mongodb+srv://anurag:anurag123@cluster0.hpz5jqu.mongodb.net/?retryWrites=true&w=majority";

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


mongoose.connect(DB).then(()=>{
    console.log("Connection successfull");

})
.catch((e)=> {
   console.log(e);
});

app.listen(PORT, "0.0.0.0", () =>{
 console.log("connected at port " + PORT);
});