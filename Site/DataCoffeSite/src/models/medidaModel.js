var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM medida
                    WHERE fk_aquario = ${idAquario}
                    ORDER BY id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {
    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        FROM medida WHERE fk_aquario = ${idAquario} 
                    ORDER BY id DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarRegistrosTemp(idPlantacao) {
    const instrucaoSql1 = `
    SELECT 
    sensor.modelo, 
    registro,
    dtRegistro
        FROM Registro join sensor
        on registro.fkSensor = sensor.idSensor
        join plantacao 
        on fkPlantacao = idPlantacao
        where sensor.modelo = 'LM35' and fkPlantacao = ${idPlantacao}
        ORDER BY  dtRegistro desc
    limit 7;
    `;
    return database.executar(instrucaoSql1);  // Retorna a Promise
}


function buscarRegistrosUmi(idPlantacao) {
    const instrucaoSql2 = `
        SELECT 
            sensor.modelo, 
            registro,
            dtRegistro
        FROM Registro 
        JOIN sensor ON registro.fkSensor = sensor.idSensor
        WHERE sensor.modelo = 'Sensor de Umidade' and fkPlantacao = ${idPlantacao}
        ORDER BY dtRegistro DESC
        limit 7;
    `;
    return database.executar(instrucaoSql2);  // Retorna a Promise
}


module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarRegistrosUmi,
    buscarRegistrosTemp

}
