-- Criando Banco
CREATE database OficinaMecanica;
USE OficinaMecanica;

-- Criando Tabelas
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `cpf` VARCHAR(45) NULL,
  `endereço` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Ordem de Serviço` (
  `número` INT NOT NULL,
  `data_emissão` DATE NULL,
  `data_conclusão` DATE NULL,
  `valor` FLOAT NULL,
  `status` VARCHAR(45) NULL,
  `Equipe_idEquipe` INT NOT NULL,
  `Veículo_idVeículo` INT NOT NULL,
  `autorização_cliente` TINYINT NULL,
  PRIMARY KEY (`número`, `Equipe_idEquipe`, `Veículo_idVeículo`),
  INDEX `fk_Ordem de Serviço_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  INDEX `fk_Ordem de Serviço_Veículo1_idx` (`Veículo_idVeículo` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `mydb`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço_Veículo1`
    FOREIGN KEY (`Veículo_idVeículo`)
    REFERENCES `mydb`.`Veículo` (`idVeículo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Veículo` (
  `idVeículo` INT NOT NULL,
  `marca` VARCHAR(45) NULL,
  `modelo` VARCHAR(45) NULL,
  `ano` VARCHAR(45) NULL,
  `placa` VARCHAR(45) NULL,
  `cor` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVeículo`),
  INDEX `fk_Veículo_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Veículo_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Mecânico` (
  `idMecânico` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `endereço` VARCHAR(45) NULL,
  `especialidade` VARCHAR(45) NULL,
  PRIMARY KEY (`idMecânico`))
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Serviço` (
  `idServiço` INT NOT NULL,
  `descrição` VARCHAR(45) NULL,
  `valor_mão_de_obra` FLOAT NULL,
  PRIMARY KEY (`idServiço`))
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Ordem de Serviço_has_Serviço` (
  `Ordem de Serviço_número` INT NOT NULL,
  `Serviço_idServiço` INT NOT NULL,
  PRIMARY KEY (`Ordem de Serviço_número`, `Serviço_idServiço`),
  INDEX `fk_Ordem de Serviço_has_Serviço_Serviço1_idx` (`Serviço_idServiço` ASC) VISIBLE,
  INDEX `fk_Ordem de Serviço_has_Serviço_Ordem de Serviço1_idx` (`Ordem de Serviço_número` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço_has_Serviço_Ordem de Serviço1`
    FOREIGN KEY (`Ordem de Serviço_número`)
    REFERENCES `mydb`.`Ordem de Serviço` (`número`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço_has_Serviço_Serviço1`
    FOREIGN KEY (`Serviço_idServiço`)
    REFERENCES `mydb`.`Serviço` (`idServiço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Ordem de Serviço_has_Peça` (
  `Ordem de Serviço_número` INT NOT NULL,
  `Peça_idPeça` INT NOT NULL,
  PRIMARY KEY (`Ordem de Serviço_número`, `Peça_idPeça`),
  INDEX `fk_Ordem de Serviço_has_Peça_Peça1_idx` (`Peça_idPeça` ASC) VISIBLE,
  INDEX `fk_Ordem de Serviço_has_Peça_Ordem de Serviço1_idx` (`Ordem de Serviço_número` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço_has_Peça_Ordem de Serviço1`
    FOREIGN KEY (`Ordem de Serviço_número`)
    REFERENCES `mydb`.`Ordem de Serviço` (`número`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço_has_Peça_Peça1`
    FOREIGN KEY (`Peça_idPeça`)
    REFERENCES `mydb`.`Peça` (`idPeça`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Peça` (
  `idPeça` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  PRIMARY KEY (`idPeça`))
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Equipe_has_Mecânico` (
  `Equipe_idEquipe` INT NOT NULL,
  `Mecânico_idMecânico` INT NOT NULL,
  PRIMARY KEY (`Equipe_idEquipe`, `Mecânico_idMecânico`),
  INDEX `fk_Equipe_has_Mecânico_Mecânico1_idx` (`Mecânico_idMecânico` ASC) VISIBLE,
  INDEX `fk_Equipe_has_Mecânico_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe_has_Mecânico_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `mydb`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_has_Mecânico_Mecânico1`
    FOREIGN KEY (`Mecânico_idMecânico`)
    REFERENCES `mydb`.`Mecânico` (`idMecânico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `mydb`.`Equipe` (
  `idEquipe` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB


CREATE TABLE IF NOT EXISTS `mydb`.`Peça` (
  `idPeça` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  PRIMARY KEY (`idPeça`))
ENGINE = InnoDB


-- Realizando Selects

 -- ordena os Cliente pelo nome
SELECT * FROM Cliente ORDER BY nome;

-- status da ordem de serviço do cliente com o valor do serviço
SELECT Cliente.nome, Ordem de Serviço_has_Serviço.valor_orcamento, Ordem de Serviço.status_os FROM Cliente INNER JOIN Ordem de Serviço_has_Serviço ON Cliente.idCliente = Ordem de Serviço_has_Serviço.id_cliente_orcamento JOIN Ordem de Serviço ON Ordem de Serviço.id_os = Ordem de Serviço_has_Serviço.id_cliente_orcamento;

-- tipo de serviço solicitado pelo cliente, com o nome do mecanico resposavel
SELECT Cliente.nome, Ordem de Serviço.Descricao_serviço, Equipe_has_Mecânico.nome_mecanico FROM Cliente INNER JOIN Ordem de Serviço ON Cliente.idCliente = Ordem de Serviço.idCliente_os JOIN Equipe_has_Mecânico ON Equipe_has_Mecânico.id_mecaninco = Ordem de Serviço.idMecanico_os;

-- especialidadade de cada mecanico 
SELECT Equipe_has_Mecânico.nome_mecanico, Equipe_has_Mecânico.especialidade_mecanica FROM  Equipe_has_Mecânico;

-- valor de cada peça para cada solicitação do cliente 
SELECT Peça.nome, Peça.valor, Ordem de Serviço_has_Serviço.id_cliente_orcamento FROM orcamento INNER JOIN Peça ON Ordem de Serviço_has_Serviço.Id_orcamento = Peça.idPeça;