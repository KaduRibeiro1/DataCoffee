// importando os bibliotecas necessárias
const { GoogleGenerativeAI } = require("@google/generative-ai");
const express = require("express");
const path = require("path");

// carregando as variáveis de ambiente do projeto do arquivo .env
require("dotenv").config();

// configurando o servidor express
const app = express();
const PORTA_SERVIDOR = process.env.PORTA || 3000;

// caminho absoluto para a raiz do projeto
const raizProjeto = path.resolve(__dirname, "..", "..");

// verificando as variáveis de ambiente
console.log("Porta do servidor:", PORTA_SERVIDOR);
console.log("Chave da IA:", process.env.MINHA_CHAVE ? "Definida" : "Não definida");

// configurando o gemini (IA)
const chatIA = new GoogleGenerativeAI(process.env.MINHA_CHAVE);

// configurando o servidor para receber requisições JSON
app.use(express.json());

// rota principal para servir o arquivo `BobIa.html`
app.get('/', (req, res) => {
    const filePath = path.join(raizProjeto, 'public', 'BobIa.html');
    console.log("Tentando servir o arquivo:", filePath);
    res.sendFile(filePath, (err) => {
        if (err) {
            console.error("Erro ao servir o arquivo:", err);
            res.status(500).send("Erro ao carregar a página inicial");
        }
    });
});

// configurando o servidor para servir arquivos estáticos a partir da pasta raiz/public
const staticPath = path.join(raizProjeto, "public");
console.log("Caminho dos arquivos estáticos:", staticPath);
app.use(express.static(staticPath));

// configurando CORS
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
    next();
});

// inicializando o servidor
app.listen(PORTA_SERVIDOR, () => {
    console.info(
        `
      ██████╗  ██████╗ ██████╗ ██╗ █████╗ 
      ██╔══██╗██╔═══██╗██╔══██╗██║██╔══██╗
      ██████╔╝██║   ██║██████╔╝██║███████║
      ██╔══██╗██║   ██║██╔══██╗██║██╔══██║
      ██████╔╝╚██████╔╝██████╔╝██║██║  ██║
      ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═╝
                                    
        `
    );
    console.info(`A API BobIA iniciada, acesse http://localhost:${PORTA_SERVIDOR}`);
});

// rota para receber perguntas e gerar respostas
app.post("/perguntar", async (req, res) => {
    const pergunta = req.body.pergunta;
    console.log("Recebendo pergunta:", pergunta);

    try {
        const resultado = await gerarResposta(pergunta);
        console.log("Resposta gerada:", resultado);
        res.json({ resultado });
    } catch (error) {
        console.error("Erro ao gerar resposta:", error);
        res.status(500).json({ error: 'Erro interno do servidor' });
    }
});

// função para gerar respostas usando o gemini
async function gerarResposta(mensagem) {
    console.log("Gerando resposta para a mensagem:", mensagem);
    
    // obtendo o modelo de IA
    const modeloIA = chatIA.getGenerativeModel({ model: "gemini-pro" });

    try {
        // gerando conteúdo com base na pergunta
        const resultado = await modeloIA.generateContent(`Em um paragráfo responda: ${mensagem}`);
        const resposta = await resultado.response.text();
        
        console.log("Resposta do modelo IA:", resposta);

        return resposta;
    } catch (error) {
        console.error("Erro ao gerar conteúdo com o modelo IA:", error);
        throw error;
    }
}
