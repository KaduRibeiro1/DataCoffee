var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idAquario", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idPlantacao", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/buscarRegistros/:idPlantacao", function (req, res) {
    medidaController.buscarRegistros(req, res);
});

router.get("/buscarMedia/:idPlantacao", function (req, res) {
    medidaController.buscaMedia(req, res);
});

router.get("/buscarHorasForas/:idPlantacao", function (req, res) {
    medidaController.buscarHorasForas(req, res);
});

router.get("/tempo-real-grafico-barras/:idPlantacao", function (req, res) {
    medidaController.buscarMedidasEmTempoRealGraficoBarras(req, res);
})

module.exports = router;