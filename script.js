document.addEventListener('DOMContentLoaded', () => {
    
    
    const gridUnidades = document.getElementById('grid-unidades');

   
    const formComunicacao = document.getElementById('form-comunicacao');
    const historicoContainer = document.getElementById('historico-container');
    const selectUnidade = document.getElementById('unidade'); 

    
    if (selectUnidade) {
        
        const parametrosUrl = new URLSearchParams(window.location.search);
        const idDaUnidade = parametrosUrl.get('unidade');

        
        if (idDaUnidade) {
            selectUnidade.value = idDaUnidade;
        }
    }


   
    async function carregarCardsUnidades() {
        if (!gridUnidades) return; 

        try {
            const resposta = await fetch('http://localhost:3000/api/unidades-cards');
            const unidades = await resposta.json();

            gridUnidades.innerHTML = '';

            if (unidades.length === 0) {
                gridUnidades.innerHTML = '<p style="text-align: center; width: 100%;">Nenhuma unidade cadastrada no banco.</p>';
                return;
            }

            unidades.forEach(unidade => {
                const imagemSrc = unidade.imagem ? unidade.imagem : 'img/placeholder.jpg';
                const listaMunicipios = unidade.municipios ? unidade.municipios : 'Não definido';

                const cardHTML = `
                    <div class="card">
                        <div class="card-title">${unidade.nome}</div>
                        <img src="${imagemSrc}" alt="${unidade.nome}" class="card-img" onerror="this.src='img/placeholder.jpg'">
                        <div class="card-content">
                            <p><strong>Data de Criação:</strong> ${unidade.data_criacao_formatada}</p>
                            <p><strong>Instituição Responsável:</strong> IMA - Instituto do Meio Ambiente de Santa Catarina</p>
                            <p><strong>Municípios:</strong> ${listaMunicipios}</p>
                            <p><strong>Descrição:</strong> ${unidade.descricao}</p>
                        </div>
                        <div class="card-footer">
                            <a href="ouvidoria.html?unidade=${unidade.id}" class="btn-ouvidoria">Ouvidoria</a>
                        </div>
                    </div>
                `;
                gridUnidades.innerHTML += cardHTML;
            });

        } catch (erro) {
            console.error('Erro ao carregar os cards:', erro);
            gridUnidades.innerHTML = '<p style="color:red; text-align:center; width:100%;">Erro ao conectar com o banco de dados.</p>';
        }
    }


    
    async function carregarHistorico() {
        if (!historicoContainer) return; 

        try {
            const resposta = await fetch('http://localhost:3000/api/comunicacao');
            const comunicacoes = await resposta.json();
            
            historicoContainer.innerHTML = '';
            
            if (comunicacoes.length === 0) {
                historicoContainer.innerHTML = '<p style="font-size:14px; color:#666;">Nenhuma comunicação encontrada.</p>';
                return;
            }

            comunicacoes.forEach(item => {
                historicoContainer.innerHTML += `
                    <div class="historico-card">
                        <div class="historico-card-titulo">${item.titulo}</div>
                        <span class="historico-card-data">${item.data_formatada}</span>
                        <div class="historico-card-desc">
                            <strong>Descrição:</strong> ${item.descricao}
                        </div>
                    </div>
                `;
            });
        } catch (erro) {
            historicoContainer.innerHTML = '<p style="color:red; font-size:14px;">Erro ao carregar o histórico do banco de dados.</p>';
        }
    }


    
    if (formComunicacao) {
        formComunicacao.addEventListener('submit', async function(event) {
            event.preventDefault(); // Evita recarregar a página
            
            const dados = {
                unidade_id: document.getElementById('unidade').value,
                email: document.getElementById('email').value,
                titulo: document.getElementById('titulo').value,
                descricao: document.getElementById('descricao').value
            };

            try {
                const resposta = await fetch('http://localhost:3000/api/comunicacao', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(dados)
                });

                if (resposta.ok) {
                    formComunicacao.reset(); 
                    carregarHistorico();   
                } else {
                    alert('Erro ao salvar no banco. Verifique o servidor.');
                }
            } catch (erro) {
                alert('Erro ao conectar com o servidor Node.js');
            }
        });
    }

    //INICIALIZAÇÃO DAS FUNÇÕES QUANDO A PÁGINA ABRE:
    carregarCardsUnidades(); 
    carregarHistorico();
});

comunicacoes.forEach(item => {
                
                const statusNumero = (item.status == 1) ? 1 : 0;
                
              
                const textoStatus = statusNumero === 1 ? 'ANALISADA' : 'EM ANÁLISE';
                const corFundo = statusNumero === 1 ? '#bbf7d0' : '#fef08a';
                const corTexto = statusNumero === 1 ? '#166534' : '#854d0e';
                const corBorda = statusNumero === 1 ? '#86efac' : '#fde047';

                historicoContainer.innerHTML += `
                    <div class="historico-card">
                        <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 4px;">
                            <div class="historico-card-titulo">${item.titulo}</div>
                            
                            <span style="background-color: ${corFundo}; color: ${corTexto}; border: 1px solid ${corBorda}; padding: 4px 10px; border-radius: 12px; font-size: 10px; font-weight: bold;">
                                ${textoStatus}
                            </span>
                            
                        </div>
                        <span class="historico-card-data">${item.data_formatada}</span>
                        <div class="historico-card-desc">
                            <strong>Descrição:</strong> ${item.descricao}
                        </div>
                    </div>
                `;
            });