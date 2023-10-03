var express=require('express');
var app=express();
const mongoose = require("mongoose")
const Turfroutes = require('./routes/turfroutes');
const RegisterRouter = require('./routes/RegisterRouter');
const cors=require('cors');
const LoginRouter = require('./routes/LoginRouter');
const ChekAuth = require('./middilewears/ChekAuth');
const verifyAccess=require('./middilewears/verifyAccess');
const BookingRouter = require('./routes/BookRouter');
app.use(express.json())
app.use(express.urlencoded({extended:true}))
app.use((req,res,next)=>{
    res.setHeader('Access-control-Allow-origin','*')
    res.setHeader('Access-control-Allow-Method','GET,POST,PUT,PATCH,DELETE')
    res.setHeader('Access-control-Allow-Method','Content-Type,Authorization')
    res.setHeader(
        "Access-Control-Allow-Headers",
        "Origin, X-Requested-With, Content-Type, Accept, Authorization"
    );
    next()
})






mongoose.connect('mongodb+srv://vijithrajmp:1dH2dmy6i7MWe61j@truff.ihv5xp2.mongodb.net/turf',
{
    useNewUrlParser:true,
    useUnifiedTopology:true
}).then(()=>{
    console.log("DATABASE CONNECTED");
}).catch((error)=>{
    console.log(error);
})
app.use('/api/turf',Turfroutes)
app.use('/api/register',RegisterRouter)
app.use('/api/login',LoginRouter)
app.use('/api/book-turf',BookingRouter)


app.get('/Home',ChekAuth,verifyAccess,function(req,res)
{
res.send('Hello World from home!');
});


PORT=3100
app.listen(PORT,function() {
    console.log("server started "+PORT);
    
});


