const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// Configuração do Banco
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'root', //  senha do MySQL
    database: 'ima_conservacao',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Rota 1: Busca todas as unidades para desenhar os Cards na página inicial
app.get('/api/unidades-cards', async (req, res) => {
    try {
        const query = `
            SELECT 
                uc.id,
                uc.nome, 
                uc.imagem,
                DATE_FORMAT(uc.data_criacao, '%d/%m/%Y') AS data_criacao_formatada,
                uc.descricao,
                GROUP_CONCAT(m.nome SEPARATOR ', ') AS municipios 
            FROM 
                unidade_conservacao uc
            LEFT JOIN 
                unidade_conservacao_municipio ucm ON uc.id = ucm.unidade_conservacao_id
            LEFT JOIN 
                municipio m ON ucm.municipio_id = m.id
            GROUP BY 
                uc.id
            ORDER BY 
                uc.id ASC
        `;
        const [rows] = await pool.query(query);
        res.status(200).json(rows);
    } catch (erro) {
        console.error(erro);
        res.status(500).json({ erro: "Erro ao buscar unidades para os cards" });
    }
});

// Rota 2: Salva uma nova comunicação (Ouvidoria) no banco
app.post('/api/comunicacao', async (req, res) => {
    const { unidade_id, email, titulo, descricao } = req.body;
    try {
        const query = `INSERT INTO comunicacao (unidade_id, email, titulo, descricao) VALUES (?, ?, ?, ?)`;
        const [result] = await pool.execute(query, [unidade_id, email, titulo, descricao]);
        res.status(201).json({ mensagem: "Sucesso!", id: result.insertId });
    } catch (erro) {
        console.error(erro);
        res.status(500).json({ erro: "Erro ao salvar no banco" });
    }
});

// Rota 3: Busca o histórico formatado da Ouvidoria
app.get('/api/comunicacao', async (req, res) => {
    try {
        const query = `
            SELECT 
                titulo, 
                descricao, 
                DATE_FORMAT(data_hora_envio, '%d/%m/%Y às %H:%i') as data_formatada,
                status,
                CASE 
                    WHEN status = 0 THEN 'Em análise' 
                    WHEN status = 1 THEN 'Analisada' 
                END AS status_texto
            FROM comunicacao 
            ORDER BY data_hora_envio DESC
        `;
        const [rows] = await pool.query(query);
        res.status(200).json(rows);
    } catch (erro) {
        console.error(erro);
        res.status(500).json({ erro: "Erro ao buscar histórico" });
    }
});

// Inicia o servidor
app.listen(3000, () => {
    console.log('Servidor Back-end rodando em http://localhost:3000');
});