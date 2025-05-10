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
	dica VARCHAR(200),
	explicacao_erro VARCHAR(200),
	resposta_correta VARCHAR(10) NOT NULL,
	FOREIGN KEY (id_nivel_dificuldade) REFERENCES nivel_dificuldade(id_nivel),
	FOREIGN KEY (materia_id) REFERENCES materia(id_materia),
	ano_letivo INT NOT NULL
);

CREATE TABLE alternativa(
	id_alternativa INT PRIMARY KEY AUTO_INCREMENT,
	FOREIGN KEY (questao_id) REFERENCES questao(id_questao),
	letra VARCHAR(10) NOT NULL,
	texto VARCHAR(100) NOT NULL
);

CREATE TABLE ranking(
	id_ranking INT PRIMARY KEY AUTO_INCREMENT,
	FOREIGN KEY (aluno_id) REFERENCES aluno(id_aluno),
	pontuacao DOUBLE, 
	ultima_atualizacao DATE
);

CREATE TABLE premio(
	id_premio INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(200),
	faixas_acertos INT NOT NULL,
	valor_simbolico DOUBLE
);

CREATE TABLE historico_jogo(
	id_historico INT PRIMARY KEY AUTO_INCREMENT,
	FOREIGN KEY (aluno_id) REFERENCES aluno(id_aluno),
	data_partida DATE,
	acertos INT NOT NULL,
	erros INT NOT NULL,
	checkpoint_alcancado VARCHAR(100),
	pontuacao_total DOUBLE
);

CREATE TABLE ajuda(
	id_ajuda INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(200)
);

CREATE TABLE sessao_jogo(
	id_sessao INT PRIMARY KEY AUTO_INCREMENT,
	FOREIGN KEY (aluno_id) REFERENCES aluno(id_aluno),
	data_inicio DATE,
	data_fim DATE, 
	modo_pratica BOOLEAN,
	pontuacao_total DOUBLE
);

CREATE TABLE resposta_aluno(
	id_resposta INT PRIMARY KEY AUTO_INCREMENT,
	FOREIGN KEY (sessao_id) REFERENCES sessao_jogo(id_sessao),
	FOREIGN KEY (questao_id) REFERENCES questao(id_questao),
	alternativa_respondida VARCHAR(10),
	correta BOOLEAN NOT NULL,
	tempo_resposta DOUBLE 
);

CREATE TABLE ajuda_utilizada(
	id_utilizacao INT PRIMARY KEY AUTO_INCREMENT,
	FOREIGN KEY (sessao_id) REFERENCES sessao_jogo(id_sessao),
	FOREIGN KEY (ajuda_id) REFERENCES ajuda(id_ajuda),
	FOREIGN KEY (questao_id) REFERENCES questao(id_questao),
	data_hora TIMESTAMP
);
