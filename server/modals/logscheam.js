const mongoose=require("mongoose");
const Scheam=mongoose.Schema;
const Logischema=new Scheam({
    username:String,
    password:String,
    role:Number,
});
var LoginModel=mongoose.model('login_tb',Logischema);
module.exports=LoginModel;