var medidaModel = require("../models/medidaModel");

// function buscarMedidasEmTempoReal(req, res) {

//     var idAquario = req.params.idAquario;

//     console.log(`Recuperando medidas em tempo real`);

//     medidaModel.buscarMedidasEmTempoReal(idAquario).then(function (resultado) {
//         if (resultado.length > 0) {
//             res.status(200).json(resultado);
//         } else {
//             res.status(204).send("Nenhum resultado encontrado!")
//         }
//     }).catch(function (erro) {
//         console.log(erro);
//         console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
//         res.status(500).json(erro.sqlMessage);
//     });
// }



function buscarRegistros(req, res) {

    var idPlantacao = req.params.idPlantacao;
  
   // Primeira busca: temperatura
   medidaModel.buscarRegistrosTemp(idPlantacao)
   .then(function (resultadoTemp) {
       // Verifica se a primeira busca retornou dados
       if (resultadoTemp.length > 0) {
           // Segunda busca: umidade
           medidaModel.buscarRegistrosUmi(idPlantacao)
               .then(function (resultadoUmi) {
                   // Verifica se a segunda busca também retornou dados
                   if (resultadoUmi.length > 0) {
                       // Se ambos os resultados tiverem dados, envia-os
                       res.status(200).json({
                           temp: resultadoTemp,
                           umi: resultadoUmi
                       });
                   } else {
                       res.status(204).send("Nenhum registro de umidade encontrado!");
                   }
               })
               .catch(function (erro) {
                   // Caso ocorra erro na segunda busca
                   console.log("Erro ao buscar dados de umidade:", erro.sqlMessage || erro.message);
                   res.status(500).json({ error: erro.sqlMessage || erro.message });
               });
       } else {
           res.status(204).send("Nenhum registro de temperatura encontrado!");
       }
   })
   .catch(function (erro) {
       // Caso ocorra erro na primeira busca
       console.log("Erro ao buscar dados de temperatura:", erro.sqlMessage || erro.message);
       res.status(500).json({ error: erro.sqlMessage || erro.message });
   });

}


function buscaMedia(req, res){
    var idPlantacao = req.params.idPlantacao;


     // Primeira busca: temperatura
   medidaModel.buscaMediaTemp(idPlantacao)
   .then(function (resultadoTemp) {
       // Verifica se a primeira busca retornou dados
       if (resultadoTemp.length > 0) {
           // Segunda busca: umidade
           medidaModel.buscaMediaUmi(idPlantacao)
               .then(function (resultadoUmi) {
                   // Verifica se a segunda busca também retornou dados
                   if (resultadoUmi.length > 0) {
                       // Se ambos os resultados tiverem dados, envia-os

                       res.status(200).json({
                           MediaTemp: resultadoTemp,
                           MediaUmi: resultadoUmi
                       });
                   } else {
                       res.status(204).send("Nenhum registro de umidade encontrado!");
                   }
               })
               .catch(function (erro) {
                   // Caso ocorra erro na segunda busca
                   console.log("Erro ao buscar dados de umidade:", erro.sqlMessage || erro.message);
                   res.status(500).json({ error: erro.sqlMessage || erro.message });
               });
       } else {
           res.status(204).send("Nenhum registro de temperatura encontrado!");
       }
   })
   .catch(function (erro) {
       // Caso ocorra erro na primeira busca
       console.log("Erro ao buscar dados de temperatura:", erro.sqlMessage || erro.message);
       res.status(500).json({ error: erro.sqlMessage || erro.message });
   });
}




module.exports = {
    // buscarMedidasEmTempoReal,
    buscarRegistros,
    buscaMedia
}