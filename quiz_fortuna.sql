CREATE DATABASE quiz_fortuna;

USE quiz_fortuna;

CREATE TABLE aluno(
	id_aluno INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	login VARCHAR(50) NOT NULL,
	senha VARCHAR(50) NOT NULL,
	ano_letivo INT NOT NULL
);

CREATE TABLE professor_administrador(
  id_professor INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  login VARCHAR(50) NOT NULL,
  senha VARCHAR(50) NOT NULL
);

CREATE TABLE nivel_dificuldade(
	id_nivel INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(100)
);

CREATE TABLE materia(
	id_materia INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100)
);

CREATE TABLE questao(
	id_questao INT PRIMARY KEY AUTO_INCREMENT,
	enunciado VARCHAR(200) NOT NULL,
	explicacao_erro VARCHAR(200),
	resposta_correta CHAR(1) NOT NULL,
	ano_letivo INT NOT NULL,
	nivel_id INT,
	materia_id INT,
	FOREIGN KEY (nivel_id) REFERENCES nivel_dificuldade(id_nivel),
	FOREIGN KEY (materia_id) REFERENCES materia(id_materia)
);

CREATE TABLE alternativa(
	id_alternativa INT PRIMARY KEY AUTO_INCREMENT,
	letra CHAR(1) NOT NULL,
	texto VARCHAR(100) NOT NULL,
	questao_id INT,
	FOREIGN KEY (questao_id) REFERENCES questao(id_questao)
);

CREATE TABLE ranking(
	id_ranking INT PRIMARY KEY AUTO_INCREMENT,
	aluno_id INT,
	pontuacao DOUBLE, 
	ultima_atualizacao DATE,
	FOREIGN KEY (aluno_id) REFERENCES aluno(id_aluno)
);

CREATE TABLE premio(
	id_premio INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(200),
	faixas_acertos INT NOT NULL,
	valor_simbolico DOUBLE
);

CREATE TABLE historico_jogo(
	id_historico INT PRIMARY KEY AUTO_INCREMENT,
	data_partida DATE,
	acertos INT NOT NULL,
	erros INT NOT NULL,
	checkpoint_alcancado VARCHAR(100),
	pontuacao_total DOUBLE,
	aluno_id INT,
	FOREIGN KEY (aluno_id) REFERENCES aluno(id_aluno)
);

CREATE TABLE ajuda(
	id_ajuda INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(200)
);

CREATE TABLE sessao_jogo(
	id_sessao INT PRIMARY KEY AUTO_INCREMENT,
	data_inicio DATE,
	data_fim DATE, 
	modo_pratica BOOLEAN,
	pontuacao_total DOUBLE,
	aluno_id INT,
	FOREIGN KEY (aluno_id) REFERENCES aluno(id_aluno)
);

CREATE TABLE resposta_aluno(
	id_resposta INT PRIMARY KEY AUTO_INCREMENT,
	alternativa_respondida CHAR(1),
	correta BOOLEAN NOT NULL,
	tempo_resposta DOUBLE,
	sessao_id INT, 
	questao_id INT,
	FOREIGN KEY (sessao_id) REFERENCES sessao_jogo(id_sessao),
	FOREIGN KEY (questao_id) REFERENCES questao(id_questao)
);

CREATE TABLE ajuda_utilizada(
	id_utilizacao INT PRIMARY KEY AUTO_INCREMENT,
	data_hora TIMESTAMP,
	sessao_id INT,
	ajuda_id INT,
	questao_id INT,
	FOREIGN KEY (sessao_id) REFERENCES sessao_jogo(id_sessao),
	FOREIGN KEY (ajuda_id) REFERENCES ajuda(id_ajuda),
	FOREIGN KEY (questao_id) REFERENCES questao(id_questao)
);
