const express = require('express')
const turffscheam = require('../modals/turffscheam');
const ChekAuth = require('../middilewears/ChekAuth');
const TurfRouter = express.Router();
const multer=require('multer');

var storage=multer.diskStorage({
    destination:function(req,file,cb){
        cb(null,"./public/images/")
    },
    filename:function(req,file,cb){
        cb(null,file.originalname)
    }
})
var upload=multer({storage:storage})
TurfRouter.post('/upload-image',upload.single("file"),(req,res)=>{
    console.log("jh",req.file.filename);
    return res.json("file uploaded")
})

TurfRouter.post('/add-turf', (req, res) => {
    const Data = new turffscheam({
        Name: req.body.Name,
        Place: req.body.Place,
        Contact: req.body.Contact,
        Image:req.body.Image,
        // Image:req.body.filename,
    });
    console.log(req);
    Data.save()
        .then((data) => {
            res.status(200).json({
                success: true,
                error: false,
                message: "data add succesfully completed",
                data: data
            })
        }).catch((err) => console.log(err))
});

TurfRouter.get('/view-turf/:id',
(req,res)=>{
    turffscheam.findOne({
        _id:req.params.id,
    })
    .then((data)=>{
        res.status(200).json({
            success:true,
            error:false,
            data:data,
        });
        res.send(data)
    }).catch((err)=>console.log(err))
});




TurfRouter.get('/view-Turf',ChekAuth, (req, res) => {
    turffscheam.find()
        .then((data) => {
            res.status(200).json({
                success: true,
                error: false,
                data: data,
            });
        }).catch((err) => console.log(err))
});
TurfRouter.put(
    '/update-turf/:id',
    (req, res) => {
        turffscheam.findOne({
            _id: req.params.id,
        })
            .then((data) => {
                data.Name = req.body.Name,
                    data.Place = req.body.Place,
                    data.Contact = req.body.Contact,
                    data
                        .save()
                        .then((data) => {
                            res.status(200).json({
                                success: true,
                                error: false,
                                data: data,
                                message: 'updated successfully'
                            });
                        })
                        .catch((err) => console.log(err));
            })
            .catch((err) => console.log(err));
    });

TurfRouter.delete('/delete-turf/:id', (req, res) => {
    turffscheam.deleteOne({
        _id: req.params.id,

    })
        .then(() => {
            res.status(200).json({
                success: true,
                error: false,
                message: 'Delete successfully',
            });
        })
        .catch((err) => console.log(err));
});



module.exports= TurfRouter;






