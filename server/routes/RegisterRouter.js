const express = require('express');
const RegisterRouter = express.Router();
const bcrypt = require('bcryptjs');
const registerscheam = require('../modals/registerscheam');
const LoginModel = require('../modals/logscheam');



RegisterRouter.post('/user', async (req, res) => {
  try {
    const oldUser = await LoginModel.findOne({ username: req.body.username });
    if (oldUser) {
      return res
        .status(400)
        .json({ success: false, error: true, message: 'User already exists' });
    }
    // const { firstName, lastName, email, password, role } = req.body;

    const oldphone = await registerscheam.findOne({ phone: req.body.phone });
    const hashedPassword = await bcrypt.hash(req.body.password, 12);
    if (oldphone) {
      return res.status(400).json({
        success: false,
        error: true,
        message: 'Phone number already exists',
      });
    }
    let log = {
      username: req.body.username,
      password: hashedPassword,
      role: 2,
    };
    const result = await LoginModel(log).save();
    let reg = {
      login_id: result._id,
      Place:req.body.Place,
      Name: req.body.name,
      Adress: req.body.address,
      Contact: req.body.phone,
    };
    const result2 = await registerscheam(reg).save();
    if (result2) {
      res.status(201).json({
        success: true,
        error: false,
        message: 'Registration completed',
        details: result2,
      });
    }
  } catch (error) {
    res
      .status(500)
      .json({ success: false, error: true, message: 'Something went wrong' });
    console.log(error);
  }
});

module.exports = RegisterRouter;

