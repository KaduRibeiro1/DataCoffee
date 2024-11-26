const database = require("../database/config");

function buscarRegistros() {
    const instrucaoSql = `
        SELECT 
            fkSensor, 
            registro, 
            dtRegistro 
        FROM Registro 
        ORDER BY dtRegistro;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarRegistros
};
