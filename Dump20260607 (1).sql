-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: ima_conservacao
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comunicacao`
--

DROP TABLE IF EXISTS `comunicacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comunicacao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unidade_id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descricao` text NOT NULL,
  `data_hora_envio` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `unidade_id` (`unidade_id`),
  CONSTRAINT `comunicacao_ibfk_1` FOREIGN KEY (`unidade_id`) REFERENCES `unidade_conservacao` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comunicacao`
--

LOCK TABLES `comunicacao` WRITE;
/*!40000 ALTER TABLE `comunicacao` DISABLE KEYS */;
INSERT INTO `comunicacao` VALUES (1,10,'davi68598@gmail.com','Teste','Teste Serra Furada','2026-06-07 10:44:39',1),(2,3,'davi68598@gmail.com','Testewwwwwwww','vffhhjbbl','2026-06-07 10:55:11',0),(3,1,'davi68598@gmail.com','Fogo no mato','Bituca de cigarro','2026-06-07 11:09:26',1),(4,3,'davi68598@gmail.com','testenovos','aDF DSD C','2026-06-07 11:21:14',0),(5,1,'davi68598@gmail.com','tyyffukf','ttutuggyo','2026-06-07 11:36:09',1);
/*!40000 ALTER TABLE `comunicacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instituicao`
--

DROP TABLE IF EXISTS `instituicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instituicao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instituicao`
--

LOCK TABLES `instituicao` WRITE;
/*!40000 ALTER TABLE `instituicao` DISABLE KEYS */;
INSERT INTO `instituicao` VALUES (1,'IMA - Instituto do Meio Ambiente de SC','Estadual');
/*!40000 ALTER TABLE `instituicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `municipio`
--

DROP TABLE IF EXISTS `municipio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `municipio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `municipio`
--

LOCK TABLES `municipio` WRITE;
/*!40000 ALTER TABLE `municipio` DISABLE KEYS */;
INSERT INTO `municipio` VALUES (1,'São Francisco do Sul'),(2,'Nova Veneza'),(3,'Siderópolis'),(4,'Treviso'),(5,'Bom Jardim da Serra'),(6,'Botuverá'),(7,'Nova Trento'),(8,'Celso Ramos'),(9,'São Domingos'),(10,'Galvão'),(11,'Concórdia'),(12,'Florianópolis'),(13,'Palhoça'),(14,'Santo Amaro da Imperatriz'),(15,'Águas Mornas'),(16,'São Bonifácio'),(17,'São Martinho'),(18,'Imbituba'),(19,'Paulo Lopes'),(20,'Doutor Pedrinho'),(21,'Benedito Novo'),(22,'Grão Pará'),(23,'Orleans');
/*!40000 ALTER TABLE `municipio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidade_conservacao`
--

DROP TABLE IF EXISTS `unidade_conservacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidade_conservacao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `data_criacao` date NOT NULL,
  `descricao` text,
  `imagem` text,
  `instituicao_id` int NOT NULL,
  `municipios` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instituicao_id` (`instituicao_id`),
  CONSTRAINT `unidade_conservacao_ibfk_1` FOREIGN KEY (`instituicao_id`) REFERENCES `instituicao` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidade_conservacao`
--

LOCK TABLES `unidade_conservacao` WRITE;
/*!40000 ALTER TABLE `unidade_conservacao` DISABLE KEYS */;
INSERT INTO `unidade_conservacao` VALUES (1,'Parque Estadual Acaraí','2006-02-23','Localizado em São Francisco do Sul, abrange restinga, manguezal e Mata Atlântica.','img/acarai.jpg',1,NULL),(2,'Reserva Biológica Estadual do Aguaí','1983-10-28','Unidade de proteção integral localizada no Planalto Serrano de Santa Catarina.','img/aguai.jpg',1,NULL),(3,'Parque Estadual das Araucárias','2003-07-22','Área de preservação da Floresta Ombrófila Mista, com destaque para araucárias.','img/araucarias.jpg',1,NULL),(4,'Parque Estadual da Serra do Tabuleiro','1975-10-01','Maior unidade de conservação de SC, abriga ecossistemas costeiros e de altitude.','img/serra do tabuleiro.jpg',1,NULL),(5,'Reserva Biológica Estadual da Canela Preta','1980-06-20','Área de preservação rigorosa que visa proteger a biodiversidade da Mata Atlântica no Vale do Itajaí. Recebe esse nome devido à alta ocorrência da árvore Ocotea catharinensis (Canela-preta), uma espécie nativa e ameaçada.','img/canela preta.jpg',1,NULL),(6,'Parque Estadual Rio Canoas	','2004-05-27','Área de preservação rigorosa que visa proteger a biodiversidade da Mata Atlântica no Vale do Itajaí. Recebe esse nome devido à alta ocorrência da árvore Ocotea catharinensis (Canela-preta), uma espécie nativa e ameaçada.','img/rio canoas.jpg',1,NULL),(7,'Parque Estadual Fritz Plauman','2003-09-24',' É o primeiro parque estadual focado na conservação da Floresta Estacional Decidual (floresta que perde as folhas no inverso). Teve sua criação como medida de compensação ambiental pela construção da Usina Hidrelétrica de Itá..','img/fritz plauman.jpg',1,NULL),(8,'Parque Estadual do Rio Vermelho','2007-05-24',' Situado na costa leste de Santa Catarina, atua diretamenteno contexto de extensão costeira protegendo áreas de restinga e Mata Atlântica. Abriga também o Centro de Triagem de Animais Silveste (CETAS), conciliando conservação e ecoturismo.','img/rio-vermelho.png',1,NULL),(9,'Reserva Biológica Estadual dos Sassafrás','1977-02-04','Uma das unidades mais antigas do estado, de proteção integral restrita. Seu grande objetivo é resguardar amostras significativas da Floresta Ombrófila Densa e proteger espécies raras da flora catarinense, como a árvore Sassafrás (Ocotea ororífera).','img/sassafras.jpg',1,NULL),(10,'Parque Estadual da Serra Furada','1980-06-20','Localizado na exuberante escarpa da Serra Geral catarinense, protege paisagens de beleza cênica monumental. Seu principal marco é a fenda na rocha conhecida como \"Serra Furada\", além de resguardar nescentes importantes e uma rica biodiversidade de encosta.','img/serra furada.jpg',1,NULL);
/*!40000 ALTER TABLE `unidade_conservacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidade_conservacao_municipio`
--

DROP TABLE IF EXISTS `unidade_conservacao_municipio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidade_conservacao_municipio` (
  `unidade_conservacao_id` int NOT NULL,
  `municipio_id` int NOT NULL,
  PRIMARY KEY (`unidade_conservacao_id`,`municipio_id`),
  KEY `municipio_id` (`municipio_id`),
  CONSTRAINT `unidade_conservacao_municipio_ibfk_1` FOREIGN KEY (`unidade_conservacao_id`) REFERENCES `unidade_conservacao` (`id`) ON DELETE CASCADE,
  CONSTRAINT `unidade_conservacao_municipio_ibfk_2` FOREIGN KEY (`municipio_id`) REFERENCES `municipio` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidade_conservacao_municipio`
--

LOCK TABLES `unidade_conservacao_municipio` WRITE;
/*!40000 ALTER TABLE `unidade_conservacao_municipio` DISABLE KEYS */;
INSERT INTO `unidade_conservacao_municipio` VALUES (1,1),(2,2),(2,3),(2,4),(2,5),(5,6),(5,7),(6,8),(3,9),(3,10),(7,11),(4,12),(8,12),(4,13),(4,14),(4,15),(4,16),(4,17),(4,18),(4,19),(9,20),(9,21),(10,22),(10,23);
/*!40000 ALTER TABLE `unidade_conservacao_municipio` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-07 12:42:18
