

**Instituição:** UNIVALI 

**Curso:** Análise e Desenvolvimento de Sistemas

**Equipe:** Davi Ocker, Cristiano Maltauro, Guilherme Machado, João Teles, Julio Cesar Rieira e Mayra Garcia.

---

## 1. Escopo e Propósito do Sistema

O software funciona como uma ponte digital entre o **Instituto do Meio Ambiente de Santa Catarina (IMA)** e a sociedade. Ele cumpre dois papéis fundamentais:

* **Informativo:** Centraliza e expõe de forma visual e intuitiva dados sobre as 10 principais Unidades de Conservação de Proteção Integral do estado (como a Serra do Tabuleiro e o Rio Vermelho).
* **Fiscalizatório / Interativo (Ouvidoria):** Permite que cidadãos enviem comunicações, denúncias ou sugestões atreladas a uma unidade específica, criando um histórico público e transparente com acompanhamento de status (*EM ANÁLISE* ou *ANALISADA*).

---

## 2. Engenharia de Software e Arquitetura de Código

Analisando a lógica do JavaScript enviado, o projeto se destaca pela maturidade técnica em três pontos principais:

### A. Consumo Assíncrono de APIs (AJAX / Fetch API)

O sistema não depende de recarregamentos de página (`POST` tradicional) para enviar e receber dados. Ele implementa o padrão **Asynchronous JavaScript**, utilizando funções `async/await` acopladas à Fetch API para bater nos endpoints locais:

* `GET http://localhost:3000/api/unidades-cards`: Retorna as informações dinâmicas das unidades para renderizar os cards.
* `GET http://localhost:3000/api/comunicacao`: Traz o histórico de ocorrências registradas na ouvidoria.
* `POST http://localhost:3000/api/comunicacao`: Envia o formulário em formato JSON para persistência no banco de dados.

### B. Manipulação de Estado da Interface (UX Inteligente)

O código traz uma sacada de usabilidade muito boa: a **comunicação entre páginas via Query String (`URLSearchParams`)**.
Quando o usuário está na Home e clica no botão "Ouvidoria" de um card específico (ex: Parque da Serra do Tabuleiro), o sistema passa o ID da unidade via URL (`ouvidoria.html?unidade=4`). Ao abrir a página de ouvidoria, o script lê esse parâmetro e **pré-seleciona automaticamente** a unidade no campo `<select>`, poupando cliques do usuário.

### C. Tratamento de Erros e Fallbacks

O código é resiliente. Caso uma imagem de uma Unidade de Conservação falhe ou não seja encontrada no servidor, o atributo `onerror="this.src='img/placeholder.jpg'"` garante que a interface não quebre, exibindo uma imagem padrão. Além disso, os blocos `try/catch` evitam que travamentos no servidor Node.js congelem o navegador do usuário, exibindo mensagens amigáveis de erro na tela.

---

## 3. Pontos Fortes do Projeto

* **Feedback Visual em Tempo Real:** A lógica que traduz o `item.status` (0 ou 1) em badges coloridos no histórico (*badge verde* para analisada, *badge amarela* para em análise) eleva o nível visual e profissional do sistema.
* **Organização do Escopo:** O uso do evento `DOMContentLoaded` isola o escopo das variáveis e garante que as funções só rodem quando a árvore do HTML estiver 100% carregada, evitando erros de elemento "null".


