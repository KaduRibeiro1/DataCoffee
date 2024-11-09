// var ambiente_processo = 'producao';
var ambiente_processo = 'desenvolvimento';

var caminho_env = ambiente_processo === 'producao' ? '.env' : '.env.dev';
// Acima, temos o uso do operador ternário para definir o caminho do arquivo .env
// A sintaxe do operador ternário é: condição ? valor_se_verdadeiro : valor_se_falso

require("dotenv").config({ path: caminho_env });

var express = require("express");
var cors = require("cors");
var path = require("path");
var PORTA_APP = process.env.APP_PORT;
var HOST_APP = process.env.APP_HOST;

var app = express();

var indexRouter = require("./src/routes/index");
var usuarioRouter = require("./src/routes/usuarios");
var avisosRouter = require("./src/routes/avisos");
var medidasRouter = require("./src/routes/medidas");
var aquariosRouter = require("./src/routes/aquarios");
var empresasRouter = require("./src/routes/empresas");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use(cors());

app.use("/", indexRouter);
app.use("/usuarios", usuarioRouter);
app.use("/avisos", avisosRouter);
app.use("/medidas", medidasRouter);
app.use("/aquarios", aquariosRouter);
app.use("/empresas", empresasRouter);

app.listen(PORTA_APP, function () {
    console.log(`
 

    ██████   █████  ████████  █████       ██████  ██████  ███████ ███████ ███████ ███████ 
    ██   ██ ██   ██    ██    ██   ██     ██      ██    ██ ██      ██      ██      ██      
    ██   ██ ███████    ██    ███████     ██      ██    ██ █████   █████   █████   █████   
    ██   ██ ██   ██    ██    ██   ██     ██      ██    ██ ██      ██      ██      ██      
    ██████  ██   ██    ██    ██   ██      ██████  ██████  ██      ██      ███████ ███████ 
                                                                                                                                                               
    \n
    ☕️ Servidor iniciado com sucesso! Seu cafezinho está pronto para ser servido! ☕️
    ☕ Saboreie sua experiência Data Coffee! Acesse agora e descubra os melhores grãos: http://${HOST_APP}:${PORTA_APP} ☕\n\n 
    Você está operando em um ambiente: ${process.env.AMBIENTE_PROCESSO}.\n\n
    - 🟢 Se for desenvolvimento, você está moendo os grãos localmente. 
    - 🔴 Se for produção, é hora de levar seu café para o mundo! 
    Para ajustar seu ambiente, edite o arquivo 'app.js'.\n\n
    Vamos juntos criar a melhor experiência para os amantes de café! ☕\n\n`);
});





    
                                        

