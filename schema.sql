-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema fitness_app
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fitness_app
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fitness_app` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `fitness_app` ;

-- -----------------------------------------------------
-- Table `fitness_app`.`coach_profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`coach_profile` (
  `idcoach_profile_id` INT NOT NULL AUTO_INCREMENT,
  `use_id` INT NULL,
  `certification` VARCHAR(45) NULL,
  `experience` VARCHAR(45) NULL,
  `specialization` VARCHAR(45) NULL,
  `is_verified` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`idcoach_profile_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_app`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `date_of_birth` DATE NULL DEFAULT NULL,
  `gender` ENUM('Male', 'Female', 'Other') NULL DEFAULT NULL,
  `profile_picture` BLOB NULL DEFAULT NULL,
  `height` DECIMAL(5,2) NULL DEFAULT NULL,
  `weight` DECIMAL(5,2) NULL DEFAULT NULL,
  `is_coach` TINYINT NULL DEFAULT '0',
  `is _approved` TINYINT NULL DEFAULT '0',
  `coach_profile_idcoach_profile_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `coach_profile_idcoach_profile_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_user_coach_profile1_idx` (`coach_profile_idcoach_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_coach_profile1`
    FOREIGN KEY (`coach_profile_idcoach_profile_id`)
    REFERENCES `fitness_app`.`coach_profile` (`idcoach_profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fitness_app`.`user_posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`user_posts` (
  `post_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `post_text` TEXT NULL DEFAULT NULL,
  `post_image_url` VARCHAR(45) NULL DEFAULT NULL,
  `post_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`post_id`, `user_user_id`),
  INDEX `fk_user_posts_user_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_posts_user`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `fitness_app`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fitness_app`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`comments` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `post_id` INT NULL DEFAULT NULL,
  `comment_text` TEXT NULL DEFAULT NULL,
  `comment_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `user_posts_post_id` INT NOT NULL,
  `user_posts_user_user_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`comment_id`, `user_posts_post_id`, `user_posts_user_user_id`, `user_user_id`),
  INDEX `fk_comments_user_posts1_idx` (`user_posts_post_id` ASC, `user_posts_user_user_id` ASC) VISIBLE,
  INDEX `fk_comments_user1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `fitness_app`.`user` (`user_id`),
  CONSTRAINT `fk_comments_user_posts1`
    FOREIGN KEY (`user_posts_post_id` , `user_posts_user_user_id`)
    REFERENCES `fitness_app`.`user_posts` (`post_id` , `user_user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fitness_app`.`likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`likes` (
  `like_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `post_id` INT NULL DEFAULT NULL,
  `like_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `likescol` VARCHAR(45) NULL DEFAULT NULL,
  `user_posts_post_id` INT NOT NULL,
  `user_posts_user_user_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`like_id`, `user_posts_post_id`, `user_posts_user_user_id`, `user_user_id`),
  INDEX `fk_likes_user_posts1_idx` (`user_posts_post_id` ASC, `user_posts_user_user_id` ASC) VISIBLE,
  INDEX `fk_likes_user1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_likes_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `fitness_app`.`user` (`user_id`),
  CONSTRAINT `fk_likes_user_posts1`
    FOREIGN KEY (`user_posts_post_id` , `user_posts_user_user_id`)
    REFERENCES `fitness_app`.`user_posts` (`post_id` , `user_user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fitness_app`.`saved_posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`saved_posts` (
  `saved_posts_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `post_id` INT NULL DEFAULT NULL,
  `save_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `user_user_id` INT NOT NULL,
  `user_posts_post_id` INT NOT NULL,
  `user_posts_user_user_id` INT NOT NULL,
  PRIMARY KEY (`saved_posts_id`, `user_user_id`, `user_posts_post_id`, `user_posts_user_user_id`),
  INDEX `fk_saved_posts_user1_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `fk_saved_posts_user_posts1_idx` (`user_posts_post_id` ASC, `user_posts_user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_saved_posts_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `fitness_app`.`user` (`user_id`),
  CONSTRAINT `fk_saved_posts_user_posts1`
    FOREIGN KEY (`user_posts_post_id` , `user_posts_user_user_id`)
    REFERENCES `fitness_app`.`user_posts` (`post_id` , `user_user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fitness_app`.`user_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`user_images` (
  `image_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `image_title` VARCHAR(45) NULL DEFAULT NULL,
  `video_description` LONGTEXT NULL DEFAULT NULL,
  `image_url` VARCHAR(45) NULL DEFAULT NULL,
  `upload_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`image_id`, `user_user_id`),
  INDEX `fk_user_images_user1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_images_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `fitness_app`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fitness_app`.`user_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`user_videos` (
  `video_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `video_title` VARCHAR(45) NULL DEFAULT NULL,
  `video_description` LONGTEXT NULL DEFAULT NULL,
  `video_url` VARCHAR(45) NULL DEFAULT NULL,
  `upload_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`video_id`, `user_user_id`),
  INDEX `fk_user_videos_user1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_videos_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `fitness_app`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fitness_app`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`reviews` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `review_text` TEXT NULL,
  `review_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `rating` DECIMAL(3,1) NULL,
  PRIMARY KEY (`review_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_app`.`reviews_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`reviews_has_user` (
  `reviews_review_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  `user_coach_profile_idcoach_profile_id` INT NOT NULL,
  PRIMARY KEY (`reviews_review_id`, `user_user_id`, `user_coach_profile_idcoach_profile_id`),
  INDEX `fk_reviews_has_user_user1_idx` (`user_user_id` ASC, `user_coach_profile_idcoach_profile_id` ASC) VISIBLE,
  INDEX `fk_reviews_has_user_reviews1_idx` (`reviews_review_id` ASC) VISIBLE,
  CONSTRAINT `fk_reviews_has_user_reviews1`
    FOREIGN KEY (`reviews_review_id`)
    REFERENCES `fitness_app`.`reviews` (`review_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reviews_has_user_user1`
    FOREIGN KEY (`user_user_id` , `user_coach_profile_idcoach_profile_id`)
    REFERENCES `fitness_app`.`user` (`user_id` , `coach_profile_idcoach_profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitness_app`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitness_app`.`admin` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `date_of_birth` DATETIME NULL,
  `profile_picture` VARCHAR(45) NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
