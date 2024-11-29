var database = require("../database/config");

function buscarPlantacoesPorEmpresa(empresaId) {

  var instrucaoSql = `SELECT idPlantacao,razao_social FROM plantacao JOIN empresa ON idEmpresa=fkEmpresa WHERE fkEmpresa = ${empresaId};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


function cadastrar(empresaId, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) aquario VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


function buscarSensorDeUmimidadeInadequados(){
  var instrucaoSql=``

  return database.executar(instrucaoSql);

}

function buscarSensorDeTemeperaturaInadequados(){
  var instrucaoSql=``

  return database.executar(instrucaoSql);
}

module.exports = {
  buscarPlantacoesPorEmpresa,
  cadastrar
}
