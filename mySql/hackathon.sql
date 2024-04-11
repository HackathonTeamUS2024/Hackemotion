-- MySQL Script generated by MySQL Workbench
-- Thu Apr 11 19:57:12 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hackathon
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `hackathon` ;

-- -----------------------------------------------------
-- Schema hackathon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hackathon` DEFAULT CHARACTER SET utf8 ;
USE `hackathon` ;

-- -----------------------------------------------------
-- Table `hackathon`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hackathon`.`user` ;

CREATE TABLE IF NOT EXISTS `hackathon`.`user` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `birthYear` INT NOT NULL,
  `sex` ENUM("male", "female") NOT NULL,
  `placeOfResidence` ENUM("village", "small town", "mid town", "big town") NOT NULL,
  `additionalInformation` LONGTEXT NULL,
  `email` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `password` BLOB(64) NOT NULL,
  `salt` BLOB(64) NOT NULL,
  `token` VARCHAR(255) NULL,
  PRIMARY KEY (`userId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`training_session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hackathon`.`training_session` ;

CREATE TABLE IF NOT EXISTS `hackathon`.`training_session` (
  `sessionId` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM("image", "audio") NOT NULL,
  `age` INT NOT NULL,
  `startedAt` DATETIME NOT NULL,
  `endedAt` DATETIME NOT NULL,
  `user_userId` INT NOT NULL,
  PRIMARY KEY (`sessionId`, `user_userId`),
  INDEX `fk_training_session_user1_idx` (`user_userId` ASC) VISIBLE,
  CONSTRAINT `fk_training_session_user1`
    FOREIGN KEY (`user_userId`)
    REFERENCES `hackathon`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`emotion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hackathon`.`emotion` ;

CREATE TABLE IF NOT EXISTS `hackathon`.`emotion` (
  `emotionId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`emotionId`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `hackathon`.`resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hackathon`.`resource` ;

CREATE TABLE IF NOT EXISTS `hackathon`.`resource` (
  `resourseId` INT NOT NULL AUTO_INCREMENT,
  `path` VARCHAR(60) NOT NULL,
  `type` ENUM("image", "audio") NOT NULL,
  `age` ENUM("child", "young adult", "middle-aged adults", "old-aged adults") NULL,
  `sex` ENUM("male", "female") NULL,
  `imageCategory` ENUM("face", "full-body") NULL,
  `emotion_emotionId` INT NOT NULL,
  PRIMARY KEY (`resourseId`, `emotion_emotionId`),
  INDEX `fk_resource_emotion1_idx` (`emotion_emotionId` ASC) VISIBLE,
  CONSTRAINT `fk_resource_emotion1`
    FOREIGN KEY (`emotion_emotionId`)
    REFERENCES `hackathon`.`emotion` (`emotionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hackathon`.`training_session_result`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hackathon`.`training_session_result` ;

CREATE TABLE IF NOT EXISTS `hackathon`.`training_session_result` (
  `resultId` INT NOT NULL AUTO_INCREMENT,
  `startedAt` DATETIME NOT NULL,
  `endedAt` DATETIME NOT NULL,
  `emotion_emotionId` INT NOT NULL,
  `training_session_sessionId` INT NOT NULL,
  `training_session_user_userId` INT NOT NULL,
  `resource_resourseId` INT NOT NULL,
  `resource_emotion_emotionId` INT NOT NULL,
  PRIMARY KEY (`resultId`, `emotion_emotionId`, `training_session_sessionId`, `training_session_user_userId`, `resource_resourseId`, `resource_emotion_emotionId`),
  INDEX `fk_training_session_result_emotion1_idx` (`emotion_emotionId` ASC) VISIBLE,
  INDEX `fk_training_session_result_training_session1_idx` (`training_session_sessionId` ASC, `training_session_user_userId` ASC) VISIBLE,
  INDEX `fk_training_session_result_resource1_idx` (`resource_resourseId` ASC, `resource_emotion_emotionId` ASC) VISIBLE,
  CONSTRAINT `fk_training_session_result_emotion1`
    FOREIGN KEY (`emotion_emotionId`)
    REFERENCES `hackathon`.`emotion` (`emotionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_training_session_result_training_session1`
    FOREIGN KEY (`training_session_sessionId` , `training_session_user_userId`)
    REFERENCES `hackathon`.`training_session` (`sessionId` , `user_userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_training_session_result_resource1`
    FOREIGN KEY (`resource_resourseId` , `resource_emotion_emotionId`)
    REFERENCES `hackathon`.`resource` (`resourseId` , `emotion_emotionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO emotion (name)
VALUES 
('anger'),
('contempt'),
('fear'),
('disgust'),
('happiness'),
('sadness'),
('surprise');

INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0001_0.wav','female',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0002_0.wav','female',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0003_0.wav','female',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0004_0.wav','female',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0005_0.wav','female',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0006_0.wav','female',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0007_0.wav','female',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0008_0.wav','female',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0009_0.wav','female',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0010_0.wav','female',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0011_1.wav','male',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0012_1.wav','male',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0013_1.wav','male',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0014_1.wav','male',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0015_1.wav','male',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0016_1.wav','male',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0017_1.wav','male',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0018_1.wav','male',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0019_1.wav','male',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/anger/0020_1.wav','male',1,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0001_0.wav','female',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0002_0.wav','female',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0003_0.wav','female',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0004_0.wav','female',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0005_0.wav','female',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0006_0.wav','female',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0007_0.wav','female',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0008_0.wav','female',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0009_0.wav','female',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0010_0.wav','female',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0011_1.wav','male',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0012_1.wav','male',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0013_1.wav','male',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0014_1.wav','male',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0015_1.wav','male',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0016_1.wav','male',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0017_1.wav','male',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0018_1.wav','male',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0019_1.wav','male',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/disgust/0020_1.wav','male',4,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0001_0.wav','female',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0002_0.wav','female',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0003_0.wav','female',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0004_0.wav','female',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0005_0.wav','female',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0006_0.wav','female',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0007_0.wav','female',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0008_0.wav','female',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0009_0.wav','female',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0010_0.wav','female',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0011_1.wav','male',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0012_1.wav','male',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0013_1.wav','male',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0014_1.wav','male',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0015_1.wav','male',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0016_1.wav','male',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0017_1.wav','male',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0018_1.wav','male',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0019_1.wav','male',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/fear/0020_1.wav','male',3,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0001_0.wav','female',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0002_0.wav','female',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0003_0.wav','female',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0004_0.wav','female',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0005_0.wav','female',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0006_0.wav','female',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0007_0.wav','female',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0008_0.wav','female',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0009_0.wav','female',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0010_0.wav','female',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0012_1.wav','male',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0013_1.wav','male',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0014_1.wav','male',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0015_1.wav','male',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0016_1.wav','male',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0017_1.wav','male',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0018_1.wav','male',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0019_1.wav','male',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0020_1.wav','male',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/happiness/0021_1.wav','male',5,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0001_0.wav','female',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0002_0.wav','female',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0003_0.wav','female',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0004_0.wav','female',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0005_0.wav','female',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0006_0.wav','female',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0007_0.wav','female',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0008_0.wav','female',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0009_0.wav','female',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0010_0.wav','female',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0012_1.wav','male',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0013_1.wav','male',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0014_1.wav','male',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0015_1.wav','male',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0016_1.wav','male',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0017_1.wav','male',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0018_1.wav','male',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0019_1.wav','male',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0020_1.wav','male',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/sadness/0021_1.wav','male',6,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0001_0.wav','female',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0002_0.wav','female',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0003_0.wav','female',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0004_0.wav','female',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0005_0.wav','female',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0006_0.wav','female',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0007_0.wav','female',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0008_0.wav','female',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0009_0.wav','female',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0010_0.wav','female',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0011_1.wav','male',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0012_1.wav','male',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0013_1.wav','male',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0014_1.wav','male',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0015_1.wav','male',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0016_1.wav','male',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0017_1.wav','male',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0018_1.wav','male',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0019_1.wav','male',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('audio/surprise/0020_1.wav','male',7,'audio');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0001_0.jpg','female',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0002_0.jpg','female',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0003_0.jpg','female',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0004_0.jpg','female',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0005_0.jpg','female',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0006_0.jpg','female',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0007_0.jpg','female',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0008_0.jpg','female',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0009_0.jpg','female',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0010_0.jpg','female',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0011_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0012_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0013_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0014_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0015_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0016_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0017_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0018_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0019_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0020_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0021_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0022_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0023_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0024_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0025_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0026_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0027_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0028_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0029_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/anger/0030_1.jpg','male',1,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0001_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0002_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0003_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0004_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0005_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0006_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0007_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0008_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0009_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0010_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0011_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0012_0.jpg','female',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0013_1.jpg','male',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0014_1.jpg','male',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0015_1.jpg','male',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0016_1.jpg','male',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0017_1.jpg','male',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/disgust/0018_1.jpg','male',4,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0001_0.jpg','female',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0002_0.jpg','female',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0003_0.jpg','female',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0004_0.jpg','female',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0005_0.jpg','female',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0006_0.jpg','female',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0007_0.jpg','female',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0008_0.jpg','female',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0009_1.jpg','male',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0010_1.jpg','male',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0011_1.jpg','male',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0012_1.jpg','male',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0013_1.jpg','male',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/fear/0014_1.jpg','male',3,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0001_0.JPG','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0002_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0003_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0004_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0005_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0006_0.JPG','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0007_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0008_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0009_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0010_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0011_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0012_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0013_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0014_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0015_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0016_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0017_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0018_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0019_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0020_0.jpg','female',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0021_1.jpg','male',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0022_1.JPG','male',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0023_1.jpg','male',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0024_1.jpg','male',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0025_1.jpg','male',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0026_1.jpg','male',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0027_1.jpg','male',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0028_1.jpg','male',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0029_1.jpg','male',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/happiness/0030_1.jpg','male',5,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0001_0.JPG','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0002_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0003_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0004_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0005_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0006_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0007_0.JPG','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0008_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0009_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0010_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0011_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0012_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0013_0.jpg','female',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0014_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0015_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0016_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0017_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0018_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0019_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0020_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0021_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0022_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0023_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0024_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0025_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0026_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0027_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0028_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0029_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/sadness/0030_1.jpg','male',6,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0001_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0002_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0003_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0004_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0005_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0006_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0007_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0008_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0009_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0010_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0011_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0012_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0013_0.jpg','female',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0014_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0015_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0016_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0017_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0018_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0019_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0020_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0021_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0022_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0023_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0024_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0025_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0026_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0027_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0028_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0029_1.jpg','male',7,'image');
INSERT INTO resource (path, sex, emotion_emotionId,type) VALUES ('image/surprise/0030_1.jpg','male',7,'image');

