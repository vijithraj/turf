const  mongoose  = require("mongoose");

const turffscheam =new mongoose.Schema({
    Name:{type:String,require:true},
    Place:{type:String,require:true},
    Contact:{type:String,require:true},
    Image:{type:String,require:true},
})
module.exports=mongoose.model('trufs',turffscheam)
