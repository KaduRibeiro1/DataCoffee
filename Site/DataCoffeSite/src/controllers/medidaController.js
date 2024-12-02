var medidaModel = require("../models/medidaModel");

function buscarMedidasEmTempoReal(req, res) {
    var idPlantacao = req.params.idPlantacao;
      // Primeira busca: temperatura
   medidaModel.buscarMediaEmTempoRealTemp(idPlantacao)
   .then(function (resultadoTemp) {
       // Verifica se a primeira busca retornou dados
       if (resultadoTemp.length > 0) {
           // Segunda busca: umidade
           medidaModel.buscarMediaEmTempoRealUmi(idPlantacao)
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


    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
    
}

function buscarMedidasEmTempoRealGraficoBarras(req, res) {
    var idPlantacao = req.params.idPlantacao;
      // Primeira busca: temperatura
   medidaModel.buscarMediaDiasEmTempoRealTemp(idPlantacao)
   .then(function (resultadoTemp) {
       // Verifica se a primeira busca retornou dados
       if (resultadoTemp.length > 0) {
           // Segunda busca: umidade
           medidaModel.buscarMediaDEmTempoRealUmi(idPlantacao)
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


    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
    
}



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
                    res.status(200).json({
                        message: "Nenhum registro encontrado!",
                        MediaTemp: resultadoTemp,
                        MediaUmi: resultadoUmi
                    });                   }
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


function buscarHorasForas(req, res) {
    const idPlantacao = req.params.idPlantacao;
    const horaAtual = new Date().getHours();  // Obtém a hora atual (0-23)
    
    // Primeiro, obtemos os dados de temperatura e umidade
    medidaModel.bucasHorasForasTemp(idPlantacao)
        .then(function (horasForasTemp) {
            medidaModel.bucasHorasForasUmi(idPlantacao)
                .then(function (horasForasUmi) {
                    
                    // Filtramos os dados para o horário atual
                    const ocorrenciasTempAtual = horasForasTemp.filter(item => item.hora === horaAtual);
                    const ocorrenciasUmiAtual = horasForasUmi.filter(item => item.hora === horaAtual);

                    if (ocorrenciasTempAtual.length === 0 && ocorrenciasUmiAtual.length === 0) {
                        // Se não houver ocorrências no horário atual
                        res.status(200).json({ mensagem: "Nenhuma ocorrência no horário atual" });
                    } else {
                        // Caso haja ocorrências, retornamos os dados
                        res.status(200).json({
                            horaForasTemp: ocorrenciasTempAtual,
                            horasForasUmi: ocorrenciasUmiAtual
                        });
                    }
                })
                .catch(function (error) {
                    // Caso ocorra um erro ao buscar os dados de umidade
                    res.status(500).json({ mensagem: "Erro ao buscar dados de umidade", error: error.message });
                });
        })
        .catch(function (error) {
            // Caso ocorra um erro ao buscar os dados de temperatura
            res.status(500).json({ mensagem: "Erro ao buscar dados de temperatura", error: error.message });
        });
}


function filtrarOcorrenciasPorHora() {
    var horaAtual = obterHoraAtual();
    
    document.getElementById('hora-atual').innerText = horaAtual;
    
    var ocorrenciasNaHoraAtual = ocorrenciasPorHora.find(item => item.hora === horaAtual);
    
    if (ocorrenciasNaHoraAtual) {
        document.getElementById('ocorrencias-hora').innerText = ocorrenciasNaHoraAtual.ocorrencias_fora_intervalo;
    } else {
        document.getElementById('ocorrencias-hora').innerText = "Sem dados para esta hora";
    }
}


module.exports = {
    buscarHorasForas,
    buscarMedidasEmTempoReal,
    buscarRegistros,
    buscaMedia
}