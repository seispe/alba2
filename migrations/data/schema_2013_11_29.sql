SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `alba2` ;
CREATE SCHEMA IF NOT EXISTS `alba2` DEFAULT CHARACTER SET utf8 ;
USE `alba2` ;

-- -----------------------------------------------------
-- Table `alba2`.`estado_alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_alumno` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`estado_alumno` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(45) NOT NULL ,
  `nombre_interno` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `estado_alumno_descripcion_unique` (`descripcion` ASC) ,
  UNIQUE INDEX `estado_alumno_nombre_interno_unique` (`nombre_interno` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_documento` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`tipo_documento` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(40) NOT NULL ,
  `abreviatura` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `tipo_documento_descripcion_unique` (`descripcion` ASC) ,
  UNIQUE INDEX `tipo_documento_abreviatura_unique` (`abreviatura` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`estado_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_documento` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`estado_documento` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `estado_documento_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`sexo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`sexo` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`sexo` (
  `id` INT NOT NULL ,
  `abreviatura` VARCHAR(10) NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `sexo_abreviatura_unique` (`abreviatura` ASC) ,
  UNIQUE INDEX `sexo_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`persona` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`persona` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `apellido` VARCHAR(30) NOT NULL ,
  `nombre` VARCHAR(30) NOT NULL ,
  `tipo_documento_id` INT(11) NOT NULL ,
  `numero_documento` VARCHAR(30) NOT NULL ,
  `estado_documento_id` INT NOT NULL ,
  `sexo_id` INT NOT NULL ,
  `fecha_nacimiento` DATE NULL DEFAULT NULL ,
  `lugar_nacimiento` VARCHAR(255) NULL ,
  `telefono` VARCHAR(60) NULL DEFAULT NULL ,
  `telefono_alternativo` VARCHAR(60) NULL DEFAULT NULL ,
  `email` VARCHAR(99) NULL DEFAULT NULL ,
  `fecha_alta` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `foto` VARCHAR(255) NULL ,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `persona_unique` (`tipo_documento_id` ASC, `numero_documento` ASC) ,
  INDEX `persona_estado_documento_idx` (`estado_documento_id` ASC) ,
  INDEX `persona_sexo_idx` (`sexo_id` ASC) ,
  CONSTRAINT `persona_tipo_documento_fk`
    FOREIGN KEY (`tipo_documento_id` )
    REFERENCES `alba2`.`tipo_documento` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `persona_estado_documento_fk`
    FOREIGN KEY (`estado_documento_id` )
    REFERENCES `alba2`.`estado_documento` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `persona_sexo_fk`
    FOREIGN KEY (`sexo_id` )
    REFERENCES `alba2`.`sexo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`alumno` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`alumno` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `persona_id` INT(11) NOT NULL ,
  `codigo` VARCHAR(30) NOT NULL ,
  `estado_id` INT(11) NOT NULL ,
  `fecha_alta` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `alumno_unique` (`codigo` ASC) ,
  INDEX `alumnos_persona_idx` (`persona_id` ASC) ,
  INDEX `alumnos_estado_idx` (`estado_id` ASC) ,
  CONSTRAINT `alumnos_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_alumno` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `alumnos_persona_fk`
    FOREIGN KEY (`persona_id` )
    REFERENCES `alba2`.`persona` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`alumno_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`alumno_estado` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`alumno_estado` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `alumno_id` INT(11) NOT NULL ,
  `estado_id` INT(11) NOT NULL ,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) ,
  INDEX `alumno_estado_alumno_idx` (`alumno_id` ASC) ,
  INDEX `alumno_estado_estado_idx` (`estado_id` ASC) ,
  CONSTRAINT `alumno_estado_alumno_fk`
    FOREIGN KEY (`alumno_id` )
    REFERENCES `alba2`.`alumno` (`id` ),
  CONSTRAINT `alumno_estado_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_alumno` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`estado_ciclo_lectivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_ciclo_lectivo` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`estado_ciclo_lectivo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(45) NOT NULL ,
  `nombre_interno` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `estado_ciclo_lectivo_descripcion_unique` (`descripcion` ASC) ,
  UNIQUE INDEX `estado_ciclo_lectivo_nombre_interno_unique` (`nombre_interno` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`nivel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`nivel` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`nivel` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `nivel_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`ciclo_lectivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`ciclo_lectivo` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`ciclo_lectivo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `anio` SMALLINT(6) NOT NULL ,
  `nivel_id` INT(11) NOT NULL ,
  `descripcion` VARCHAR(60) NULL DEFAULT NULL ,
  `fecha_inicio` DATE NULL DEFAULT NULL ,
  `fecha_fin` DATE NULL DEFAULT NULL ,
  `estado_id` INT(11) NOT NULL ,
  `activo` TINYINT(1) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `ciclo_lectivo_anio_unique` (`anio` ASC) ,
  INDEX `ciclo_lectivo_nivel_idx` (`nivel_id` ASC) ,
  INDEX `ciclo_lectivo_estado_idx` (`estado_id` ASC) ,
  CONSTRAINT `ciclo_lectivo_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_ciclo_lectivo` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `ciclo_lectivo_nivel_fk`
    FOREIGN KEY (`nivel_id` )
    REFERENCES `alba2`.`nivel` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`ciclo_lectivo_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`ciclo_lectivo_estado` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`ciclo_lectivo_estado` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `ciclo_lectivo_id` INT(11) NOT NULL ,
  `estado_id` INT(11) NOT NULL ,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) ,
  INDEX `ciclos_lectivos_estados_ciclo_lectivo_fk_idx` (`ciclo_lectivo_id` ASC) ,
  INDEX `ciclos_lectivos_estados_estado_fk_idx` (`estado_id` ASC) ,
  CONSTRAINT `ciclos_lectivos_estados_ciclo_lectivo_fk`
    FOREIGN KEY (`ciclo_lectivo_id` )
    REFERENCES `alba2`.`ciclo_lectivo` (`id` ),
  CONSTRAINT `ciclos_lectivos_estados_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_ciclo_lectivo` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`pais` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`pais` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(60) NOT NULL ,
  `codigo` VARCHAR(3) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `pais_nombre_unique` (`nombre` ASC) ,
  UNIQUE INDEX `pais_codigo_unique` (`codigo` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`provincia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`provincia` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`provincia` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `pais_id` INT(11) NOT NULL ,
  `nombre` VARCHAR(60) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `provincia_unique` (`pais_id` ASC, `nombre` ASC) ,
  CONSTRAINT `provincia_pais_fk`
    FOREIGN KEY (`pais_id` )
    REFERENCES `alba2`.`pais` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`ciudad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`ciudad` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`ciudad` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `provincia_id` INT(11) NOT NULL ,
  `nombre` VARCHAR(60) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `ciudad_unique` (`provincia_id` ASC, `nombre` ASC) ,
  CONSTRAINT `ciudad_provincia_fk`
    FOREIGN KEY (`provincia_id` )
    REFERENCES `alba2`.`provincia` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_gestion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_gestion` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`tipo_gestion` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `tipo_gestion_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`dependencia_organizativa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`dependencia_organizativa` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`dependencia_organizativa` (
  `id` INT NOT NULL ,
  `nombre` VARCHAR(99) NOT NULL ,
  `dependencia_padre_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `dependencia_organizativa_dependencia_padre_idx` (`dependencia_padre_id` ASC) ,
  CONSTRAINT `dependencia_organizativa_dependencia_padre_fk`
    FOREIGN KEY (`dependencia_padre_id` )
    REFERENCES `alba2`.`dependencia_organizativa` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`establecimiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`establecimiento` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`establecimiento` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `tipo_gestion_id` INT NOT NULL ,
  `codigo` VARCHAR(99) NOT NULL ,
  `nombre` VARCHAR(99) NOT NULL ,
  `numero` VARCHAR(20) NULL ,
  `telefono` VARCHAR(60) NULL DEFAULT NULL ,
  `telefono_alternativo` VARCHAR(60) NULL DEFAULT NULL ,
  `fax` VARCHAR(60) NULL DEFAULT NULL ,
  `email` VARCHAR(99) NULL DEFAULT NULL ,
  `sitio_web` VARCHAR(99) NULL DEFAULT NULL ,
  `dependencia_organizativa_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `establecimiento_tipo_gestion_idx` (`tipo_gestion_id` ASC) ,
  INDEX `establecimiento_dependencia_organizativa_idx` (`dependencia_organizativa_id` ASC) ,
  UNIQUE INDEX `establecimiento_codigo_unique` (`codigo` ASC) ,
  CONSTRAINT `establecimiento_tipo_gestion_fk`
    FOREIGN KEY (`tipo_gestion_id` )
    REFERENCES `alba2`.`tipo_gestion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_dependencia_organizativa_fk`
    FOREIGN KEY (`dependencia_organizativa_id` )
    REFERENCES `alba2`.`dependencia_organizativa` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`estado_plan_estudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_plan_estudio` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`estado_plan_estudio` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(99) NOT NULL ,
  `nombre_interno` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `estado_plan_estudio_nombre_interno_unique` (`nombre_interno` ASC) ,
  UNIQUE INDEX `estado_plan_estudio_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`plan_estudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`plan_estudio` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`plan_estudio` (
  `id` INT NOT NULL ,
  `nivel_id` INT NOT NULL ,
  `codigo` VARCHAR(45) NOT NULL ,
  `nombre_completo` VARCHAR(255) NOT NULL ,
  `nombre_corto` VARCHAR(99) NOT NULL ,
  `duracion` TINYINT NOT NULL ,
  `estado_id` INT NOT NULL ,
  `plan_estudio_origen_id` INT NULL DEFAULT NULL COMMENT 'Indica el plan de estudios original\nen caso de que el actual haya sido \ncreado a partir de otro existente.' ,
  `resoluciones` VARCHAR(255) NULL ,
  `normativas` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `plan_estudio_nivel_idx` (`nivel_id` ASC) ,
  UNIQUE INDEX `plan_estudio_codigo_unique` (`codigo` ASC) ,
  INDEX `plan_estudio_estado_idx` (`estado_id` ASC) ,
  INDEX `plan_estudio_plan_estudio_origen_idx` (`plan_estudio_origen_id` ASC) ,
  CONSTRAINT `plan_estudio_nivel_fk`
    FOREIGN KEY (`nivel_id` )
    REFERENCES `alba2`.`nivel` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_estudio_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_plan_estudio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_estudio_plan_estudio_origen_fk`
    FOREIGN KEY (`plan_estudio_origen_id` )
    REFERENCES `alba2`.`plan_estudio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`plan_estudio_anio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`plan_estudio_anio` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`plan_estudio_anio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `plan_estudio_id` INT NOT NULL ,
  `descripcion` VARCHAR(30) NOT NULL ,
  `orden` TINYINT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `plan_estudio_anio_plan_estudio_idx` (`plan_estudio_id` ASC) ,
  CONSTRAINT `plan_estudio_anio_plan_estudio_fk`
    FOREIGN KEY (`plan_estudio_id` )
    REFERENCES `alba2`.`plan_estudio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'es la tabla que configura los nombres de los años que se dan en cada plan de estudios';


-- -----------------------------------------------------
-- Table `alba2`.`tipo_responsable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_responsable` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`tipo_responsable` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `tipo_responsable_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`persona_domicilio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`persona_domicilio` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`persona_domicilio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `persona_id` INT(11) NOT NULL ,
  `direccion` VARCHAR(99) NOT NULL ,
  `cp` VARCHAR(30) NULL DEFAULT NULL ,
  `pais_id` INT(11) NULL DEFAULT NULL ,
  `provincia_id` INT(11) NULL DEFAULT NULL ,
  `ciudad_id` INT(11) NULL DEFAULT NULL ,
  `principal` TINYINT(1) NOT NULL DEFAULT '1' ,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `persona_domicilio_persona_idx` (`persona_id` ASC) ,
  INDEX `persona_domicilio_pais_idx` (`pais_id` ASC) ,
  INDEX `persona_domicilio_provincia_idx` (`provincia_id` ASC) ,
  INDEX `persona_domicilio_ciudad_idx` (`ciudad_id` ASC) ,
  CONSTRAINT `persona_domicilio_ciudad_fk`
    FOREIGN KEY (`ciudad_id` )
    REFERENCES `alba2`.`ciudad` (`id` ),
  CONSTRAINT `persona_domicilio_pais_fk`
    FOREIGN KEY (`pais_id` )
    REFERENCES `alba2`.`pais` (`id` ),
  CONSTRAINT `persona_domicilio_persona_fk`
    FOREIGN KEY (`persona_id` )
    REFERENCES `alba2`.`persona` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `persona_domicilio_provincia_fk`
    FOREIGN KEY (`provincia_id` )
    REFERENCES `alba2`.`provincia` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`nivel_instruccion_alcanzado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`nivel_instruccion_alcanzado` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`nivel_instruccion_alcanzado` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `nivel_instruccion_alcanzado_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`actividad_responsable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`actividad_responsable` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`actividad_responsable` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `actividad_responsable_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`responsable_alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`responsable_alumno` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`responsable_alumno` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `persona_id` INT(11) NOT NULL ,
  `alumno_id` INT(11) NOT NULL ,
  `actividad_id` INT NOT NULL ,
  `nivel_instruccion_alcanzado_id` INT NOT NULL ,
  `tipo_responsable_id` INT(11) NULL DEFAULT NULL ,
  `ocupacion` VARCHAR(255) NULL ,
  `autorizado_retirar` TINYINT(1) NOT NULL DEFAULT '0' ,
  `vive` TINYINT(1) NULL ,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `responsable_alumno_unique` (`persona_id` ASC, `alumno_id` ASC) ,
  INDEX `responsable_alumno_alumno_idx` (`alumno_id` ASC) ,
  INDEX `responsable_alumno_tipo_responsable_idx` (`tipo_responsable_id` ASC) ,
  INDEX `responsable_alumno_nivel_instruccion_alcanzado_idx` (`nivel_instruccion_alcanzado_id` ASC) ,
  INDEX `responsable_alumno_actividad_responsable_fk_idx` (`actividad_id` ASC) ,
  CONSTRAINT `responsable_alumno_alumno_fk`
    FOREIGN KEY (`alumno_id` )
    REFERENCES `alba2`.`alumno` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `responsable_alumno_tipo_responsable_fk`
    FOREIGN KEY (`tipo_responsable_id` )
    REFERENCES `alba2`.`tipo_responsable` (`id` ),
  CONSTRAINT `responsables_alumnos_persona_fk`
    FOREIGN KEY (`persona_id` )
    REFERENCES `alba2`.`persona` (`id` ),
  CONSTRAINT `responsable_alumno_niveles_instruccion_alcanzado_fk`
    FOREIGN KEY (`nivel_instruccion_alcanzado_id` )
    REFERENCES `alba2`.`nivel_instruccion_alcanzado` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `responsable_alumno_actividad_responsable_fk`
    FOREIGN KEY (`actividad_id` )
    REFERENCES `alba2`.`actividad_responsable` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`sede`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`sede` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`sede` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `establecimiento_id` INT(11) NOT NULL ,
  `codigo` VARCHAR(99) NOT NULL ,
  `nombre` VARCHAR(99) NOT NULL ,
  `telefono` VARCHAR(60) NULL DEFAULT NULL ,
  `telefono_alternativo` VARCHAR(60) NULL DEFAULT NULL ,
  `fax` VARCHAR(60) NULL DEFAULT NULL ,
  `principal` TINYINT(1) NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `sede_unique` (`establecimiento_id` ASC, `nombre` ASC) ,
  UNIQUE INDEX `sede_codigo_unique` (`codigo` ASC) ,
  CONSTRAINT `sede_establecimiento_fk`
    FOREIGN KEY (`establecimiento_id` )
    REFERENCES `alba2`.`establecimiento` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`turno` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`turno` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `turno_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`seccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`seccion` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`seccion` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `sede_id` INT(11) NOT NULL ,
  `plan_estudio_id` INT NOT NULL ,
  `ciclo_lectivo_id` INT(11) NOT NULL ,
  `turno_id` INT(11) NOT NULL ,
  `anio_id` INT(11) NOT NULL ,
  `identificador` VARCHAR(30) NOT NULL ,
  `cupo_maximo` SMALLINT(6) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `seccion_unique` (`sede_id` ASC, `ciclo_lectivo_id` ASC, `turno_id` ASC, `anio_id` ASC, `identificador` ASC) ,
  INDEX `seccion_turno_idx` (`turno_id` ASC) ,
  INDEX `seccion_grado_idx` (`anio_id` ASC) ,
  INDEX `seccion_plan_estudio_idx` (`plan_estudio_id` ASC) ,
  CONSTRAINT `seccion_grado_fk`
    FOREIGN KEY (`anio_id` )
    REFERENCES `alba2`.`plan_estudio_anio` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `seccion_sede_fk`
    FOREIGN KEY (`sede_id` )
    REFERENCES `alba2`.`sede` (`id` ),
  CONSTRAINT `seccion_turno_fk`
    FOREIGN KEY (`turno_id` )
    REFERENCES `alba2`.`turno` (`id` ),
  CONSTRAINT `seccion_plan_estudio_fk`
    FOREIGN KEY (`plan_estudio_id` )
    REFERENCES `alba2`.`plan_estudio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`sede_domicilio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`sede_domicilio` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`sede_domicilio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `sede_id` INT(11) NOT NULL ,
  `direccion` VARCHAR(99) NOT NULL ,
  `cp` VARCHAR(30) NULL DEFAULT NULL ,
  `pais_id` INT(11) NULL DEFAULT NULL ,
  `provincia_id` INT(11) NULL DEFAULT NULL ,
  `ciudad_id` INT(11) NULL DEFAULT NULL ,
  `principal` TINYINT(1) NOT NULL DEFAULT '1' ,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `sede_domicilio_pais_idx` (`pais_id` ASC) ,
  INDEX `sede_domicilio_provincia_idx` (`provincia_id` ASC) ,
  INDEX `sede_domicilio_ciudad_idx` (`ciudad_id` ASC) ,
  CONSTRAINT `sede_domicilio_ciudad_fk`
    FOREIGN KEY (`ciudad_id` )
    REFERENCES `alba2`.`ciudad` (`id` ),
  CONSTRAINT `sede_domicilio_pais_fk`
    FOREIGN KEY (`pais_id` )
    REFERENCES `alba2`.`pais` (`id` ),
  CONSTRAINT `sede_domicilio_provincia_fk`
    FOREIGN KEY (`provincia_id` )
    REFERENCES `alba2`.`provincia` (`id` ),
  CONSTRAINT `sede_domicilio_sede_fk`
    FOREIGN KEY (`sede_id` )
    REFERENCES `alba2`.`sede` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`servicio_salud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`servicio_salud` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`servicio_salud` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `codigo` VARCHAR(30) NOT NULL ,
  `abreviatura` VARCHAR(30) NOT NULL ,
  `nombre` VARCHAR(255) NOT NULL ,
  `email` VARCHAR(99) NULL DEFAULT NULL ,
  `sitio_web` VARCHAR(99) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `servicio_salud_codigo_unique` (`codigo` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`servicio_salud_contacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`servicio_salud_contacto` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`servicio_salud_contacto` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `servicio_salud_id` INT(11) NOT NULL ,
  `direccion` VARCHAR(99) NOT NULL ,
  `cp` VARCHAR(30) NULL DEFAULT NULL ,
  `pais_id` INT(11) NULL DEFAULT NULL ,
  `provincia_id` INT(11) NULL DEFAULT NULL ,
  `ciudad_id` INT(11) NULL DEFAULT NULL ,
  `telefono` VARCHAR(60) NOT NULL ,
  `telefono_alternativo` VARCHAR(60) NULL DEFAULT NULL ,
  `contacto_preferido` TINYINT(1) NULL ,
  `observaciones` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `servicios_salud_contacto_servicio_salud_idx` (`servicio_salud_id` ASC) ,
  INDEX `servicios_salud_contacto_pais_idx` (`pais_id` ASC) ,
  INDEX `servicios_salud_contacto_provincia_idx` (`provincia_id` ASC) ,
  INDEX `servicios_salud_contacto_ciudad_idx` (`ciudad_id` ASC) ,
  CONSTRAINT `servicios_salud_contacto_ciudad_fk`
    FOREIGN KEY (`ciudad_id` )
    REFERENCES `alba2`.`ciudad` (`id` )
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `servicios_salud_contacto_pais_fk`
    FOREIGN KEY (`pais_id` )
    REFERENCES `alba2`.`pais` (`id` ),
  CONSTRAINT `servicios_salud_contacto_provincia_fk`
    FOREIGN KEY (`provincia_id` )
    REFERENCES `alba2`.`provincia` (`id` ),
  CONSTRAINT `servicios_salud_contacto_servicio_salud_fk`
    FOREIGN KEY (`servicio_salud_id` )
    REFERENCES `alba2`.`servicio_salud` (`id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`area_asignatura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`area_asignatura` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`area_asignatura` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  `nivel_id` INT(11) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `area_asignatura_nivel_idx` (`nivel_id` ASC) ,
  CONSTRAINT `area_asignatura_nivel_fk`
    FOREIGN KEY (`nivel_id` )
    REFERENCES `alba2`.`nivel` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`asignatura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`asignatura` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`asignatura` (
  `id` INT NOT NULL ,
  `codigo` VARCHAR(45) NOT NULL ,
  `nombre` VARCHAR(99) NOT NULL ,
  `nombre_corto` VARCHAR(45) NOT NULL ,
  `area_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `asignatura_codigo_unique` (`codigo` ASC) ,
  INDEX `asignatura_area_idx` (`area_id` ASC) ,
  CONSTRAINT `asignatura_area_fk`
    FOREIGN KEY (`area_id` )
    REFERENCES `alba2`.`area_asignatura` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`plan_estudio_asignatura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`plan_estudio_asignatura` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`plan_estudio_asignatura` (
  `id` INT NOT NULL ,
  `plan_estudio_id` INT NOT NULL ,
  `asignatura_id` INT NOT NULL ,
  `anio_id` INT NOT NULL ,
  `carga_horaria_semanal` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `plan_estudio_asignatura_plan_estudio_idx` (`plan_estudio_id` ASC) ,
  INDEX `plan_estudio_asignatura_asignatura_idx` (`asignatura_id` ASC) ,
  INDEX `plan_estudio_asignatura_anio_idx` (`anio_id` ASC) ,
  CONSTRAINT `plan_estudio_asignatura_plan_estudio_fk`
    FOREIGN KEY (`plan_estudio_id` )
    REFERENCES `alba2`.`plan_estudio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_estudio_asignatura_asignatura_fk`
    FOREIGN KEY (`asignatura_id` )
    REFERENCES `alba2`.`asignatura` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_estudio_asignatura_anio_fk`
    FOREIGN KEY (`anio_id` )
    REFERENCES `alba2`.`plan_estudio_anio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`plan_estudio_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`plan_estudio_estado` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`plan_estudio_estado` (
  `id` INT NOT NULL ,
  `plan_estudio_id` INT NOT NULL ,
  `estado_id` INT NOT NULL ,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) ,
  INDEX `plan_estudio_estado_plan_estudio_idx` (`plan_estudio_id` ASC) ,
  INDEX `plan_estudio_estado_estado_idx` (`estado_id` ASC) ,
  CONSTRAINT `plan_estudio_estado_plan_estudio_fk`
    FOREIGN KEY (`plan_estudio_id` )
    REFERENCES `alba2`.`plan_estudio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_estudio_estado_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_plan_estudio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`estado_inscripcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_inscripcion` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`estado_inscripcion` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `estado_inscripcion_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`condicion_inscripcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`condicion_inscripcion` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`condicion_inscripcion` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL COMMENT 'Repitiente\nReinscripto\nIngresante\nPromovido\nEn Compensación' ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `condicion_inscripcion_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`inscripcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`inscripcion` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`inscripcion` (
  `id` INT NOT NULL ,
  `alumno_id` INT NOT NULL ,
  `plan_estudio_id` INT NOT NULL ,
  `anio_id` INT NOT NULL ,
  `turno_id` INT NOT NULL COMMENT 'Turno de preferencia\n' ,
  `ciclo_lectivo_id` INT NOT NULL ,
  `estado_id` INT NOT NULL ,
  `sede_id` INT NOT NULL ,
  `condicion_id` INT NULL COMMENT 'Por ejemplo si es \nhermano de un alumno\nactual o hijo de \nun docente' ,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `observaciones` VARCHAR(999) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `inscripcion_alumno_idx` (`alumno_id` ASC) ,
  INDEX `inscripcion_grado_idx` (`anio_id` ASC) ,
  INDEX `inscripcion_turno_idx` (`turno_id` ASC) ,
  INDEX `inscripcion_estado_idx` (`estado_id` ASC) ,
  INDEX `inscripcion_sede_idx` (`sede_id` ASC) ,
  INDEX `inscripcion_plan_estudio_idx` (`plan_estudio_id` ASC) ,
  INDEX `inscripcion_ciclo_lectivo_idx` (`ciclo_lectivo_id` ASC) ,
  INDEX `inscripcion_condicion_idx` (`condicion_id` ASC) ,
  CONSTRAINT `inscripcion_alumno_fk`
    FOREIGN KEY (`alumno_id` )
    REFERENCES `alba2`.`alumno` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_anio_fk`
    FOREIGN KEY (`anio_id` )
    REFERENCES `alba2`.`plan_estudio_anio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_turno_fk`
    FOREIGN KEY (`turno_id` )
    REFERENCES `alba2`.`turno` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_inscripcion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_sede_fk`
    FOREIGN KEY (`sede_id` )
    REFERENCES `alba2`.`sede` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_plan_estudio_fk`
    FOREIGN KEY (`plan_estudio_id` )
    REFERENCES `alba2`.`plan_estudio` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_ciclo_lectivo_fk`
    FOREIGN KEY (`ciclo_lectivo_id` )
    REFERENCES `alba2`.`ciclo_lectivo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_condicion_fk`
    FOREIGN KEY (`condicion_id` )
    REFERENCES `alba2`.`condicion_inscripcion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`inscripcion_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`inscripcion_estado` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`inscripcion_estado` (
  `id` INT NOT NULL ,
  `inscripcion_id` INT NOT NULL ,
  `estado_id` INT NOT NULL ,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) ,
  INDEX `inscripcion_estado_inscripcion_idx` (`inscripcion_id` ASC) ,
  INDEX `inscripcion_estado_estado_fk` (`estado_id` ASC) ,
  CONSTRAINT `inscripcion_estado_inscripcion_fk`
    FOREIGN KEY (`inscripcion_id` )
    REFERENCES `alba2`.`inscripcion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `inscripcion_estado_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_inscripcion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`alumno_seccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`alumno_seccion` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`alumno_seccion` (
  `id` INT NOT NULL ,
  `alumno_id` INT NOT NULL ,
  `seccion_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `alumno_seccion_seccion_idx` (`seccion_id` ASC) ,
  INDEX `alumno_seccion_alumno_idx` (`alumno_id` ASC) ,
  UNIQUE INDEX `alumno_seccion_seccion_unique` (`seccion_id` ASC) ,
  UNIQUE INDEX `alumno_seccion_alumno_unique` (`alumno_id` ASC) ,
  CONSTRAINT `alumno_seccion_seccion_fk`
    FOREIGN KEY (`seccion_id` )
    REFERENCES `alba2`.`seccion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `alumno_seccion_alumno_fk`
    FOREIGN KEY (`alumno_id` )
    REFERENCES `alba2`.`alumno` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`00___periodo_nivel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`00___periodo_nivel` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`00___periodo_nivel` (
  `id` INT NOT NULL COMMENT 'Quedó duplicada en el \nschema, en realidad es \ntipo_periodo' ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_periodo_ciclo_lectivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_periodo_ciclo_lectivo` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`tipo_periodo_ciclo_lectivo` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  `periodos_por_ciclo` TINYINT NOT NULL ,
  `nivel_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `tipo_periodo_nivel_idx` (`nivel_id` ASC) ,
  UNIQUE INDEX `tipo_periodo_descripcion_unique` (`descripcion` ASC) ,
  UNIQUE INDEX `tipo_periodo_nivel_unique` (`nivel_id` ASC) ,
  CONSTRAINT `tipo_periodo_nivel_fk`
    FOREIGN KEY (`nivel_id` )
    REFERENCES `alba2`.`nivel` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`estado_periodo_ciclo_lectivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_periodo_ciclo_lectivo` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`estado_periodo_ciclo_lectivo` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  `nombre_interno` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `estado_periodo_ciclo_lectivo_descripcion_unique` (`descripcion` ASC) ,
  UNIQUE INDEX `estado_periodo_ciclo_lectivo_nombre_interno_unique` (`nombre_interno` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`periodo_ciclo_lectivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`periodo_ciclo_lectivo` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`periodo_ciclo_lectivo` (
  `id` INT NOT NULL ,
  `ciclo_lectivo_id` INT(11) NOT NULL ,
  `tipo_periodo_id` INT NOT NULL ,
  `fecha_inicio` DATE NULL ,
  `fecha_fin` DATE NULL ,
  `orden` TINYINT NOT NULL ,
  `estado_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `periodo_ciclo_lectivo_ciclo_lectivo_idx` (`ciclo_lectivo_id` ASC) ,
  INDEX `periodo_ciclo_lectivo_tipo_periodo_idx` (`tipo_periodo_id` ASC) ,
  INDEX `periodo_ciclo_lectivo_estado_idx` (`estado_id` ASC) ,
  CONSTRAINT `periodo_ciclo_lectivo_ciclo_lectivo_fk`
    FOREIGN KEY (`ciclo_lectivo_id` )
    REFERENCES `alba2`.`ciclo_lectivo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `periodo_ciclo_lectivo_tipo_periodo_fk`
    FOREIGN KEY (`tipo_periodo_id` )
    REFERENCES `alba2`.`tipo_periodo_ciclo_lectivo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `periodo_ciclo_lectivo_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_periodo_ciclo_lectivo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `alba2`.`docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`docente` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`docente` (
  `id` INT NOT NULL ,
  `persona_id` INT(11) NOT NULL ,
  `codigo` VARCHAR(45) NOT NULL ,
  `fecha_alta` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `observaciones` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `docente_persona_idx` (`persona_id` ASC) ,
  UNIQUE INDEX `docente_codigo_unique` (`codigo` ASC) ,
  CONSTRAINT `docente_personas_fk`
    FOREIGN KEY (`persona_id` )
    REFERENCES `alba2`.`persona` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`estado_docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_docente` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`estado_docente` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  `nombre_interno` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `estado_docente_descripcion_unique` (`descripcion` ASC) ,
  UNIQUE INDEX `estado_docente_nombre_interno_unique` (`nombre_interno` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`docente_estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`docente_estado` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`docente_estado` (
  `id` INT NOT NULL ,
  `estado_id` INT NOT NULL ,
  `docente_id` INT NOT NULL ,
  `fecha` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  INDEX `docente_estado_docente_idx` (`docente_id` ASC) ,
  INDEX `docente_estado_estado_idx` (`estado_id` ASC) ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `docente_estado_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_docente` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `docente_estado_docente_fk`
    FOREIGN KEY (`docente_id` )
    REFERENCES `alba2`.`docente` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_designacion_docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_designacion_docente` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`tipo_designacion_docente` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `tipo_designacion_docente_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`estado_designacion_docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_designacion_docente` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`estado_designacion_docente` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  `nombre_interno` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `estado_designacion_docente_descripcion_unique` (`descripcion` ASC) ,
  UNIQUE INDEX `estado_designacion_docente_nombre_interno_unique` (`nombre_interno` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`designacion_docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`designacion_docente` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`designacion_docente` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `docente_id` INT NOT NULL ,
  `plan_estudio_asignatura_id` INT NOT NULL ,
  `tipo_designacion_id` INT NOT NULL COMMENT '- Titular\n- Interino\n- Suplente' ,
  `fecha_inicio` DATE NULL ,
  `fecha_fin` DATE NULL ,
  `estado_id` INT NOT NULL ,
  INDEX `designacion_docente_docente_idx` (`docente_id` ASC) ,
  PRIMARY KEY (`id`) ,
  INDEX `designacion_docente_tipo_designacion_idx` (`tipo_designacion_id` ASC) ,
  INDEX `designacion_docente_estado_idx` (`estado_id` ASC) ,
  INDEX `designacion_docente_asignatura_idx` (`plan_estudio_asignatura_id` ASC) ,
  CONSTRAINT `designacion_docente_docente_fk`
    FOREIGN KEY (`docente_id` )
    REFERENCES `alba2`.`docente` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `designacion_docente_tipo_designacion_fk`
    FOREIGN KEY (`tipo_designacion_id` )
    REFERENCES `alba2`.`tipo_designacion_docente` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `designacion_docente_estado_fk`
    FOREIGN KEY (`estado_id` )
    REFERENCES `alba2`.`estado_designacion_docente` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `designacion_docente_asignatura_fk`
    FOREIGN KEY (`plan_estudio_asignatura_id` )
    REFERENCES `alba2`.`plan_estudio_asignatura` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`documentacion_inscripcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`documentacion_inscripcion` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`documentacion_inscripcion` (
  `id` INT NOT NULL ,
  `inscripcion_id` INT NOT NULL ,
  `documento_alumno` TINYINT(1) NOT NULL ,
  `certificado_nacimiento` TINYINT(1) NOT NULL ,
  `documento_responsables` TINYINT(1) NOT NULL ,
  `certificado_vacunas` TINYINT(1) NOT NULL ,
  `planilla_completa` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `documentacion_inscripcion_inscripcion_idx` (`inscripcion_id` ASC) ,
  CONSTRAINT `documentacion_inscripcion_inscripcion_fk`
    FOREIGN KEY (`inscripcion_id` )
    REFERENCES `alba2`.`inscripcion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`estado_vacunacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`estado_vacunacion` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`estado_vacunacion` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  `nombre_interno` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `estado_vacunacion_descripcion_unique` (`descripcion` ASC) ,
  UNIQUE INDEX `estado_vacunacion_nombre_interno_unique` (`nombre_interno` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`ficha_salud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`ficha_salud` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`ficha_salud` (
  `id` INT NOT NULL ,
  `persona_id` INT(11) NOT NULL ,
  `servicio_salud_id` INT(11) NULL ,
  `numero_afiliado` VARCHAR(99) NULL ,
  `estado_vacunacion_id` INT NULL ,
  `enfermedad` VARCHAR(255) NULL ,
  `internacion` VARCHAR(255) NULL ,
  `alergia` VARCHAR(255) NULL ,
  `tratamiento` VARCHAR(255) NULL ,
  `limitacion_fisica` VARCHAR(255) NULL ,
  `otros` VARCHAR(255) NULL ,
  `altura` VARCHAR(45) NULL ,
  `peso` VARCHAR(45) NULL ,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) ,
  INDEX `ficha_salud_persona_idx` (`persona_id` ASC) ,
  INDEX `ficha_salud_servicio_salud_idx` (`servicio_salud_id` ASC) ,
  INDEX `ficha_salud_estado_vacunacion_idx` (`estado_vacunacion_id` ASC) ,
  UNIQUE INDEX `ficha_salud_persona_unique` (`persona_id` ASC) ,
  CONSTRAINT `ficha_salud_persona_fk`
    FOREIGN KEY (`persona_id` )
    REFERENCES `alba2`.`persona` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ficha_salud_servicio_salud_fk`
    FOREIGN KEY (`servicio_salud_id` )
    REFERENCES `alba2`.`servicio_salud` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ficha_salud_estado_vacunacion_fk`
    FOREIGN KEY (`estado_vacunacion_id` )
    REFERENCES `alba2`.`estado_vacunacion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`tipo_contacto_emergencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`tipo_contacto_emergencia` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`tipo_contacto_emergencia` (
  `id` INT NOT NULL ,
  `descripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `tipo_contacto_emergencia_descripcion_unique` (`descripcion` ASC) )
ENGINE = InnoDB
COMMENT = '- Médico\n- Familiar\n- Institución';


-- -----------------------------------------------------
-- Table `alba2`.`contacto_emergencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`contacto_emergencia` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`contacto_emergencia` (
  `id` INT NOT NULL ,
  `ficha_salud_id` INT NOT NULL ,
  `tipos_contacto_id` INT NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `domicilio` VARCHAR(99) NULL ,
  `telefono` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `contacto_emergencia_ficha_salud_idx` (`ficha_salud_id` ASC) ,
  INDEX `contacto_emergencia_tipo_contacto_idx` (`tipos_contacto_id` ASC) ,
  CONSTRAINT `contacto_emergencia_ficha_salud_fk`
    FOREIGN KEY (`ficha_salud_id` )
    REFERENCES `alba2`.`ficha_salud` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contacto_emergencia_tipo_contacto_fk`
    FOREIGN KEY (`tipos_contacto_id` )
    REFERENCES `alba2`.`tipo_contacto_emergencia` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`inscripcion_informacion_adicional`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`inscripcion_informacion_adicional` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`inscripcion_informacion_adicional` (
  `id` INT NOT NULL ,
  `inscripcion_id` INT NOT NULL ,
  `cantidad_hermanos` TINYINT NULL ,
  `hermanos_en_establecimiento` TINYINT NULL ,
  `distancia_establecimiento` VARCHAR(45) NULL ,
  `habitantes_hogar` TINYINT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `inscripcion_informacion_adicional_inscripcion_idx` (`inscripcion_id` ASC) ,
  UNIQUE INDEX `inscripcion_informacion_adicional_inscripcion_unique` (`inscripcion_id` ASC) ,
  CONSTRAINT `inscripcion_informacion_adicional_inscripcion_fk`
    FOREIGN KEY (`inscripcion_id` )
    REFERENCES `alba2`.`inscripcion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`establecimiento_procedencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`establecimiento_procedencia` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`establecimiento_procedencia` (
  `id` INT NOT NULL ,
  `inscripcion_id` INT NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `nivel_id` INT(11) NULL ,
  `tipo_gestion_id` INT NULL ,
  `pais_id` INT(11) NULL ,
  `provincia_id` INT(11) NULL ,
  `ciudad_id` INT(11) NULL ,
  `establecimiento_id` INT(11) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `establecimiento_procedencia_inscripcion_idx` (`inscripcion_id` ASC) ,
  INDEX `establecimiento_procedencia_pais_idx` (`pais_id` ASC) ,
  INDEX `establecimiento_procedencia_provincia_idx` (`provincia_id` ASC) ,
  INDEX `establecimiento_procedencia_ciudad_idx` (`ciudad_id` ASC) ,
  INDEX `establecimiento_procedencia_tipo_gestion_idx` (`tipo_gestion_id` ASC) ,
  INDEX `establecimiento_procedencia_nivel_idx` (`nivel_id` ASC) ,
  INDEX `establecimiento_procedencia_establecimiento_idx` (`establecimiento_id` ASC) ,
  CONSTRAINT `establecimiento_procedencia_inscripcion_fk`
    FOREIGN KEY (`inscripcion_id` )
    REFERENCES `alba2`.`inscripcion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_pais_fk`
    FOREIGN KEY (`pais_id` )
    REFERENCES `alba2`.`pais` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_provincia_fk`
    FOREIGN KEY (`provincia_id` )
    REFERENCES `alba2`.`provincia` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_ciudad_fk`
    FOREIGN KEY (`ciudad_id` )
    REFERENCES `alba2`.`ciudad` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_tipo_gestion_fk`
    FOREIGN KEY (`tipo_gestion_id` )
    REFERENCES `alba2`.`tipo_gestion` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_nivel_fk`
    FOREIGN KEY (`nivel_id` )
    REFERENCES `alba2`.`nivel` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `establecimiento_procedencia_establecimiento_fk`
    FOREIGN KEY (`establecimiento_id` )
    REFERENCES `alba2`.`establecimiento` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alba2`.`actualizacion_salud`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alba2`.`actualizacion_salud` ;

CREATE  TABLE IF NOT EXISTS `alba2`.`actualizacion_salud` (
  `id` INT NOT NULL ,
  `ficha_salud_id` INT NOT NULL ,
  `observaciones` VARCHAR(255) NOT NULL ,
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) ,
  INDEX `actualizacion_salud_ficha_salud_idx` (`ficha_salud_id` ASC) ,
  CONSTRAINT `fk_actualizaciones_salud_fichas_salud`
    FOREIGN KEY (`ficha_salud_id` )
    REFERENCES `alba2`.`ficha_salud` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `alba2` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
