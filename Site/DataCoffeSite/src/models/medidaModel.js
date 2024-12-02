var database = require("../database/config");

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

    console.log("Executando a instrução SQL: \n" + instrucaoSql1);
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

    console.log("Executando a instrução SQL: \n" + instrucaoSql2);
    return database.executar(instrucaoSql2);  // Retorna a Promise
}


function buscaMediaTemp(idPlantacao){
    const instrucaoSql1 = `
            SELECT 
            sensor.modelo, 
            ROUND (AVG(registro), 2) AS media_registro, 
            DATE(dtRegistro) AS data_registro
        FROM    
            registro
        JOIN 
            sensor ON registro.fkSensor = sensor.idSensor
        JOIN 
            plantacao ON fkPlantacao = idPlantacao
        WHERE 
            sensor.modelo = 'lm35' 
            AND fkPlantacao = ${idPlantacao}
        GROUP BY 
            data_registro, sensor.modelo
        ORDER BY 
            data_registro DESC
        LIMIT 7;
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql1);
    return database.executar(instrucaoSql1); 
}


function buscaMediaUmi(idPlantacao){
    const instrucaoSql2 = `
            SELECT 
            sensor.modelo, 
            ROUND (AVG(registro), 2) AS media_registro, 
            DATE(dtRegistro) AS data_registro
        FROM 
            registro
        JOIN 
            sensor ON registro.fkSensor = sensor.idSensor
        JOIN 
            plantacao ON fkPlantacao = idPlantacao
        WHERE 
            sensor.modelo = 'Sensor de Umidade' 
            AND fkPlantacao = ${idPlantacao}
        GROUP BY 
            data_registro, sensor.modelo
        ORDER BY 
            data_registro DESC
        LIMIT 7;
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql2);
    return database.executar(instrucaoSql2); 
}






function buscarMedidaEmTempoRealTemp(idPlantacao){
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
    limit 1;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql1);
    return database.executar(instrucaoSql1);  // Retorna a Promise
}


function buscarMedidaEmTempoRealUmi(idPlantacao) {
    const instrucaoSql2 = `
        SELECT 
            sensor.modelo, 
            registro,
            dtRegistro
        FROM Registro 
        JOIN sensor ON registro.fkSensor = sensor.idSensor
        WHERE sensor.modelo = 'Sensor de Umidade' and fkPlantacao = ${idPlantacao}
        ORDER BY dtRegistro DESC
        limit 1;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql2);
    return database.executar(instrucaoSql2);  // Retorna a Promise
}



 function buscarMediaDiasEmTempoRealTemp(idPlantacao){
     const instrucaoSql1 = `
      SELECT 
            sensor.modelo, 
            ROUND (AVG(registro), 2) AS media_registro, 
            DATE(dtRegistro) AS data_registro
        FROM    
            registro
        JOIN 
            sensor ON registro.fkSensor = sensor.idSensor
        JOIN 
            plantacao ON fkPlantacao = idPlantacao
        WHERE 
            sensor.modelo = 'lm35' 
            AND fkPlantacao = ${idPlantacao}
        GROUP BY 
            data_registro, sensor.modelo
        ORDER BY 
            data_registro DESC
        LIMIT 1;`

     console.log("Executando a instrução SQL: \n" + instrucaoSql1);
     return database.executar(instrucaoSql1);  // Retorna a Promise
 }


 function buscarMediaDiasEmTempoRealUmi(idPlantacao) {
     const instrucaoSql2 = `
    SELECT 
            sensor.modelo, 
            ROUND (AVG(registro), 2) AS media_registro, 
            DATE(dtRegistro) AS data_registro
        FROM    
            registro
        JOIN 
            sensor ON registro.fkSensor = sensor.idSensor
        JOIN 
            plantacao ON fkPlantacao = idPlantacao
        WHERE 
            sensor.modelo = 'Sensor de Umidade' 
            AND fkPlantacao = ${idPlantacao}
        GROUP BY 
            data_registro, sensor.modelo
        ORDER BY 
            data_registro DESC
        LIMIT 1;

     `;

     console.log("Executando a instrução SQL: \n" + instrucaoSql2);
     return database.executar(instrucaoSql2);  // Retorna a Promise
 }







    function bucasHorasForasTemp(idPlantacao){
        const instrucaoSql = `
        SELECT HOUR(r.dtRegistro) AS hora, 
        COUNT(*) AS ocorrencias_fora_intervalo
        FROM registro r
        JOIN sensor s ON r.fkSensor = s.idSensor
            WHERE s.fkPlantacao = ${idPlantacao}
            AND s.idSensor = 1    
            AND (r.registro < 20 OR r.registro > 25)
            AND DATE(r.dtRegistro) = CURDATE()  
        GROUP BY hora
        ORDER BY hora;

    `;

    return database.executar(instrucaoSql);  // Retorna a Promise

    }

    
    function bucasHorasForasUmi(idPlantacao){
    const instrucaoSql = `
    SELECT HOUR(r.dtRegistro) AS hora, 
       COUNT(*) AS ocorrencias_fora_intervalo
    FROM registro r
    JOIN sensor s ON r.fkSensor = s.idSensor
        WHERE s.fkPlantacao = ${idPlantacao}
        AND s.idSensor = 2 
        AND (r.registro < 10 OR r.registro > 15)
        AND DATE(r.dtRegistro) = CURDATE()  
    GROUP BY hora
    ORDER BY hora;
    `;

    return database.executar(instrucaoSql);  // Retorna a Promise

    }


module.exports = {
    bucasHorasForasUmi,
    bucasHorasForasTemp,
    buscarRegistrosUmi,
    buscarRegistrosTemp,
    buscaMediaTemp,
    buscaMediaUmi,
    buscarMedidaEmTempoRealTemp,
    buscarMedidaEmTempoRealUmi,
    buscarMediaDiasEmTempoRealTemp,
    buscarMediaDiasEmTempoRealUmi
    
}









