const graficoModel = require("../models/graficoModel");

function buscarRegistros(req, res) {
    graficoModel.buscarRegistros().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);  
        } else {
            res.status(204).send("Nenhum registro encontrado!");  
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os registros.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);  
    });
}


module.exports = {
    buscarRegistros
};
