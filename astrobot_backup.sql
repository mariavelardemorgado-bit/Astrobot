-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: astrobot_db
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `conocimiento_faq`
--

DROP TABLE IF EXISTS `conocimiento_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conocimiento_faq` (
  `ID_FAQ` int NOT NULL AUTO_INCREMENT,
  `Intencion` varchar(50) NOT NULL,
  `Respuesta` text NOT NULL,
  `Clasificacion` varchar(50) DEFAULT 'Procedimiento',
  PRIMARY KEY (`ID_FAQ`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conocimiento_faq`
--

LOCK TABLES `conocimiento_faq` WRITE;
/*!40000 ALTER TABLE `conocimiento_faq` DISABLE KEYS */;
INSERT INTO `conocimiento_faq` VALUES (1,'reportar_falla_login','He detectado un problema de inicio de sesión. Por favor, indícame si el error dice \"Credenciales inválidas\" o si la pantalla se queda cargando.','Procedimiento'),(2,'reportar_falla_interfaz','Entiendo que hay un error visual. ¿Podrías confirmarme qué navegador y sistema operativo estás utilizando para añadirlo al reporte técnico?','Procedimiento'),(3,'solicitar_agente','Comprendo. Estoy transfiriendo tu sesión, junto con los datos técnicos recopilados, a un agente humano. Un momento, por favor.','Condicional'),(4,'donde_pagar','Ingresa https://inter.com.ve/mediosdepago/ y conoce todos los medios de pagos que tenemos a tu disposición.','Procedimiento'),(5,'oficinas','Ubica nuestras oficinas comerciales ingresando en https://inter.com.ve/ubicacion/','Procedimiento'),(6,'suspender_servicio','Debes estar al día con tus pagos, si lo estas pideme escalar tu caso a un agente.','Procedimiento'),(7,'fecha_corte','El corte del servicio se realiza entre los 05 primeros días del mes.','Procedimiento'),(8,'restablecer_contraseña','Ingresa en mi.inter.com.ve y haz clic en ¿Olvidaste tu contraseña?, llena los campos con la información solicitada, recibirás un correo con tu nueva contraseña y ya puedes entrar de nuevo a Mi inter. Si dejaste de usar el correo electrónico registrado selecciona la opción “restablecer usuario” y vuelve a registrarte con un correo nuevo.','Procedimiento'),(9,'sin_audio_canales','La función SAP o MTS podría estar activada en tu tv, de contar con un decodificador verifica la opción Idioma/lenguaje/audio debe estar seleccionado en la opción español/primario y guardar los cambios.','Procedimiento'),(10,'decodificador_error_7','Verifica las conexiones que estén bien ajustadas, realiza un reinicio físico del equipo. En caso de persistir presiona el botón menú, selecciona la opción configuración, ingresa en la pestaña configuración de fabrica colocando el código 0000.','Procedimiento'),(11,'mensaje_stb','Cuando muestra el mensaje STB no activado en tu equipo es debido que no se encuentra activado. Desconecta el equipo de la toma de corriente por 30 segundos y vuélvelo a conectar, este debe encontrarse conectado y activado en sistema, de persistir se debe enviar comandos al equipo. Si persiste pideme que escale a un agente.','Procedimiento'),(12,'lentitud_internet','Debes estar frente a tus equipos POE / PC, para realizar las siguientes verificaciones: 1- Conectar directo del POE al PC. 2- Realizar test de velocidad ingresando a speedtest.net. De persistir la lentitud con el servicio, luego del soporte realizado, pideme que escale a un agente.','Procedimiento');
/*!40000 ALTER TABLE `conocimiento_faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `ID_Log` int NOT NULL AUTO_INCREMENT,
  `ID_Sesion` int DEFAULT NULL,
  `Mensaje_Usuario` text NOT NULL,
  `Intencion_Detectada` varchar(50) DEFAULT NULL,
  `Respuesta_Bot` text,
  `Timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `Navegador` varchar(100) DEFAULT NULL,
  `Sistema_Operativo` varchar(100) DEFAULT NULL,
  `Remitente` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID_Log`),
  KEY `ID_Sesion` (`ID_Sesion`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`ID_Sesion`) REFERENCES `sesion_usuario` (`ID_Sesion`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (1,1,'la pagina se quedo en blanco','reportar_falla_interfaz','Entiendo que hay un error visual. ¿Podrías confirmarme qué navegador y sistema operativo estás utilizando para añadirlo al reporte técnico?','2026-06-23 20:27:25',NULL,NULL,NULL),(2,1,'la pagina me dio un error 404','reportar_falla_pago','Disculpa, tengo problemas para encontrar el procedimiento exacto. Déjame escalar tu caso.','2026-06-23 20:27:50',NULL,NULL,NULL),(3,1,'no puedo hacer un pago','reportar_falla_login','He detectado un problema de inicio de sesión. Por favor, indícame si el error dice \"Credenciales inválidas\" o si la pantalla se queda cargando.','2026-06-23 20:30:40',NULL,NULL,NULL),(4,1,'me da un error','reportar_falla_login','He detectado un problema de inicio de sesión. Por favor, indícame si el error dice \"Credenciales inválidas\" o si la pantalla se queda cargando.','2026-06-23 20:31:03',NULL,NULL,NULL),(5,1,'hola tengo un problema para comprar','solicitar_agente','Comprendo. Estoy transfiriendo tu sesión, junto con los datos técnicos recopilados, a un agente humano. Un momento, por favor.','2026-06-23 20:33:09',NULL,NULL,NULL),(6,1,'hola, la pagina me esta dando errores','reportar_falla_pago','Disculpa, tengo problemas para encontrar el procedimiento exacto. Déjame escalar tu caso.','2026-06-23 20:35:12',NULL,NULL,NULL),(7,1,'tengo un problema con la interfaz','solicitar_agente','Comprendo. Estoy transfiriendo tu sesión, junto con los datos técnicos recopilados, a un agente humano. Un momento, por favor.','2026-06-23 21:21:48',NULL,NULL,NULL),(8,1,'hola no puedo hacer un pago','reportar_falla_login','He detectado un problema de inicio de sesión. Por favor, indícame si el error dice \"Credenciales inválidas\" o si la pantalla se queda cargando.','2026-06-23 21:22:01',NULL,NULL,NULL),(9,1,'macOS','informar_sistema_operativo','Disculpa, tengo problemas para encontrar el procedimiento exacto. Déjame escalar tu caso.','2026-06-23 21:22:22',NULL,NULL,NULL),(10,1,'masOS','informar_sistema_operativo','Disculpa, tengo problemas para encontrar el procedimiento exacto. Déjame escalar tu caso.','2026-06-28 11:51:52','Safari','masOS',NULL),(11,1,'Windows','informar_sistema_operativo','Disculpa, tengo problemas para encontrar el procedimiento exacto. Déjame escalar tu caso.','2026-06-28 12:12:25','Chrome','Windows',NULL),(13,1,'no puedo ver la pagina','reportar_falla_pago','Disculpa, tengo problemas para encontrar el procedimiento exacto. Déjame escalar tu caso.','2026-06-29 18:41:57',NULL,NULL,NULL),(15,9448,'El usuario solicitó un agente','escalado_humano','Bot pausado, esperando humano...','2026-06-29 18:56:53','-','-',NULL),(16,1776,'El usuario solicitó un agente','escalado_humano','Bot pausado, esperando humano...','2026-06-29 19:03:02','-','-',NULL),(17,1,'la pagina me da un error 404','reportar_falla_pago','Disculpa, tengo problemas para encontrar el procedimiento exacto. Déjame escalar tu caso.','2026-06-29 19:11:39',NULL,NULL,NULL),(18,970,'El usuario solicitó un agente','escalado_humano','Bot pausado, esperando humano...','2026-06-29 19:28:35','-','-',NULL),(19,1,'Linux','informar_sistema_operativo','Disculpa, tengo problemas para encontrar el procedimiento exacto. Déjame escalar tu caso.','2026-06-29 20:00:22','Firefox','Linux',NULL),(20,3037,'El usuario solicitó un agente','escalado_humano','Bot pausado, esperando humano...','2026-06-29 20:00:28','-','-',NULL),(21,1233,'El usuario solicitó un agente','escalado_humano','Bot pausado, esperando humano...','2026-06-30 14:13:25','-','-',NULL),(22,8286,'El usuario solicitó un agente','escalado_humano','Bot pausado, esperando humano...','2026-06-30 14:35:57','-','-',NULL),(23,1,'macOS','informar_sistema_operativo','Disculpa, tengo problemas para encontrar el procedimiento exacto. Déjame escalar tu caso.','2026-06-30 14:40:42','Chrome','macOS',NULL),(24,1,'Linux','informar_sistema_operativo','Disculpa, tengo problemas para encontrar el procedimiento exacto. Déjame escalar tu caso.','2026-06-30 14:45:47','Chrome','Linux',NULL),(25,3156,'El usuario solicitó un agente','escalado_humano','Bot pausado, esperando humano...','2026-06-30 18:59:22','-','-',NULL),(26,5930,'tengo el internet lento','lentitud_internet','Debes estar frente a tus equipos POE / PC, para realizar las siguientes verificaciones: 1- Conectar directo del POE al PC. 2- Realizar test de velocidad ingresando a speedtest.net. De persistir la lentitud con el servicio, luego del soporte realizado, pideme que escale a un agente.','2026-06-30 19:16:14','-','-',NULL),(27,5930,'necesito hablar con un agente','escalado_humano','Transfiriendo tu caso a un agente de soporte técnico. Por favor, espera...','2026-06-30 19:16:49','-','-',NULL);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sesion_usuario`
--

DROP TABLE IF EXISTS `sesion_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sesion_usuario` (
  `ID_Sesion` int NOT NULL AUTO_INCREMENT,
  `ID_Usuario` int DEFAULT NULL,
  `Fecha_Inicio` datetime DEFAULT CURRENT_TIMESTAMP,
  `Estado` varchar(20) DEFAULT 'Abierta',
  PRIMARY KEY (`ID_Sesion`),
  KEY `ID_Usuario` (`ID_Usuario`),
  CONSTRAINT `sesion_usuario_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuario` (`ID_Usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9449 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesion_usuario`
--

LOCK TABLES `sesion_usuario` WRITE;
/*!40000 ALTER TABLE `sesion_usuario` DISABLE KEYS */;
INSERT INTO `sesion_usuario` VALUES (1,1,'2026-06-11 18:36:48','Abierta'),(970,NULL,'2026-06-29 19:28:35','Abierta'),(1233,NULL,'2026-06-30 14:13:25','Abierta'),(1776,NULL,'2026-06-29 19:03:02','Abierta'),(3037,NULL,'2026-06-29 20:00:28','Abierta'),(3156,NULL,'2026-06-30 18:59:22','Abierta'),(5930,NULL,'2026-06-30 19:16:14','Abierta'),(8286,NULL,'2026-06-30 14:35:57','Abierta'),(9448,NULL,'2026-06-29 18:56:53','Abierta');
/*!40000 ALTER TABLE `sesion_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `ID_Usuario` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Correo` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_Usuario`),
  UNIQUE KEY `Correo` (`Correo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Carlos QA','carlos.qa@test.com');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-30 19:32:55
