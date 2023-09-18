const mongoose=require("mongoose");
const { schema } = require("./turffscheam");
const Schema=mongoose.Schema;
const registerModels=new Schema({
login_id:{type:Schema.Types.ObjectId,ref:'login',required:true},
Name:{type:String,required:true},
Place:{type:String,required:true},
Adress:{type:String,required:true},
Contact:{type:String,required:true},

})
const registerscheam=mongoose.model('register',registerModels)
module.exports=registerscheam