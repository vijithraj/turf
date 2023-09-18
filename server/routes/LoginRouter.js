const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const loginSchema = require('../modals/logscheam');
const register = require('../modals/registerscheam');
const LoginRouter = express.Router();

LoginRouter.post('/', async (req, res) => {
  const { username, password } = req.body;      //destracturaring
  try {
    if (username && password) {
      const oldUser = await loginSchema.findOne({ username });
      if (!oldUser)
        return res
          .status(404)
          .json({ success: false, error: true, message: "User doesn't Exist" });
      const isPasswordCorrect = await bcrypt.compare(
        password,
        oldUser.password
      );
      if (!isPasswordCorrect)
        return res
          .status(400)
          .json({ success: false, error: true, message: 'Incorrect password' });

      const token = jwt.sign(
        {
          userId: oldUser._id,
          userRole: oldUser.role,
          userName: oldUser.username,
        },
        'secret_this_should_be_longer',
        { expiresIn: '1h' }
      );
      console.log('token', token);
      return res.status(200).json({
        success: true,
        error: false,
        token: token,
        expiresIn: 3600,
        loginId: oldUser._id,
        userRole: oldUser.role,
        userName: oldUser.username,
      });
    } else {
      return res.status(400).json({
        success: false,
        error: true,
        message: 'All fields are required!',
      });
    }
  } catch (error) {
    res.status(500).json({ message: 'Something went wrong' });
  }
});

module.exports = LoginRouter;

