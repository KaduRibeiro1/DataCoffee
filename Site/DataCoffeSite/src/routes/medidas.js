var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idAquario", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idAquario", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/buscarRegistros/:idPlantacao", function (req, res) {
    medidaController.buscarRegistros(req, res);
});

router.get("/buscarMedia/:idPlantacao", function (req, res) {
    medidaController.buscaMedia(req, res);
});
module.exports = router;