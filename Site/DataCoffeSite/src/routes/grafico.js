const express = require("express");
const router = express.Router();
const graficoController = require("../controllers/graficoController");

router.get("/buscarRegistros", function (req, res) {
    graficoController.buscarRegistros(req, res);
});

module.exports = router;
