const express = require('express')
const app = express()
const port = 3000

app.use(express.json())

app.get('/api/profile', (req, res) => {
  res.json({
    name:"Test Name", 
    email: "test@test.com",
    about: "test about"
  })
})

app.get('/api/experience', (req, res) => {
  res.json([
    { company: "testcompany1", role: "Test Engineer", years: "2020-2023" },
    { company: "testcompany2", role: "Test Engineer", years: "2018-2020" }
  ])
})

app.post('/api/contact', (req, res) => {
  const { name, email, message } = req.body;

  if (!name || !email || !message) {
    return res.status(400).json({ error: 'All fields required'});
  }

  res.status(201).json({
    status: "success"
  })
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})