-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 07 fév. 2023 à 12:34
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gesco_ecole`
--

-- --------------------------------------------------------

--
-- Structure de la table `chapitre`
--

DROP TABLE IF EXISTS `chapitre`;
CREATE TABLE IF NOT EXISTS `chapitre` (
  `Num_chapitre` int(11) NOT NULL AUTO_INCREMENT,
  `Lib_chapitre` varchar(255) NOT NULL,
  PRIMARY KEY (`Num_chapitre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `chapitre_matiere`
--

DROP TABLE IF EXISTS `chapitre_matiere`;
CREATE TABLE IF NOT EXISTS `chapitre_matiere` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Num_chapitre` int(11) NOT NULL,
  `CodMat` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `chapitre_matiere_chapitre_Num_chapitre` (`Num_chapitre`),
  KEY `chapitre_matiere_matiere_CodMat` (`CodMat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `composition`
--

DROP TABLE IF EXISTS `composition`;
CREATE TABLE IF NOT EXISTS `composition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Notecomp` int(11) NOT NULL,
  `Datecompo` int(11) NOT NULL,
  `CodMat` int(11) NOT NULL,
  `NumIns` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `composition_matiere_CodMat` (`CodMat`),
  KEY `composition_inscription_NumIns` (`NumIns`),
  KEY `composition_date_compo_Datcompo` (`Datecompo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `date_compo`
--

DROP TABLE IF EXISTS `date_compo`;
CREATE TABLE IF NOT EXISTS `date_compo` (
  `Datecompo` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Datecompo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `echeance`
--

DROP TABLE IF EXISTS `echeance`;
CREATE TABLE IF NOT EXISTS `echeance` (
  `Numech` int(11) NOT NULL AUTO_INCREMENT,
  `Montech` int(11) NOT NULL,
  `Datech` date NOT NULL,
  `NumIns` int(11) NOT NULL,
  PRIMARY KEY (`Numech`),
  KEY `echeance_inscription_NumIns` (`NumIns`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
CREATE TABLE IF NOT EXISTS `etudiant` (
  `Matricule` int(11) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(255) NOT NULL,
  `Prenom` varchar(255) NOT NULL,
  `Sexe` varchar(255) NOT NULL,
  PRIMARY KEY (`Matricule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `filiere`
--

DROP TABLE IF EXISTS `filiere`;
CREATE TABLE IF NOT EXISTS `filiere` (
  `CodeFile` int(11) NOT NULL AUTO_INCREMENT,
  `LibFil` varchar(255) NOT NULL,
  `Cout` int(11) NOT NULL,
  PRIMARY KEY (`CodeFile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `inscription`
--

DROP TABLE IF EXISTS `inscription`;
CREATE TABLE IF NOT EXISTS `inscription` (
  `NumIns` int(11) NOT NULL AUTO_INCREMENT,
  `DateIns` date NOT NULL,
  `Annee` int(11) NOT NULL,
  `CodeFil` int(11) NOT NULL,
  `Matricule` int(11) NOT NULL,
  PRIMARY KEY (`NumIns`),
  KEY `inscription_filiere_CodeFile` (`CodeFil`),
  KEY `inscription_etudiant_Matricule` (`Matricule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `matiere`
--

DROP TABLE IF EXISTS `matiere`;
CREATE TABLE IF NOT EXISTS `matiere` (
  `CodMat` int(11) NOT NULL AUTO_INCREMENT,
  `Libmat` varchar(255) NOT NULL,
  `Coef` int(11) NOT NULL,
  `Nbmax` int(11) NOT NULL,
  PRIMARY KEY (`CodMat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `chapitre_matiere`
--
ALTER TABLE `chapitre_matiere`
  ADD CONSTRAINT `chapitre_matiere_chapitre_Num_chapitre` FOREIGN KEY (`Num_chapitre`) REFERENCES `chapitre` (`Num_chapitre`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chapitre_matiere_matiere_CodMat` FOREIGN KEY (`CodMat`) REFERENCES `matiere` (`CodMat`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `composition`
--
ALTER TABLE `composition`
  ADD CONSTRAINT `composition_date_compo_Datcompo` FOREIGN KEY (`Datecompo`) REFERENCES `date_compo` (`Datecompo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `composition_inscription_NumIns` FOREIGN KEY (`NumIns`) REFERENCES `inscription` (`NumIns`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `composition_matiere_CodMat` FOREIGN KEY (`CodMat`) REFERENCES `matiere` (`CodMat`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `echeance`
--
ALTER TABLE `echeance`
  ADD CONSTRAINT `echeance_inscription_NumIns` FOREIGN KEY (`NumIns`) REFERENCES `inscription` (`NumIns`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `inscription`
--
ALTER TABLE `inscription`
  ADD CONSTRAINT `inscription_etudiant_Matricule` FOREIGN KEY (`Matricule`) REFERENCES `etudiant` (`Matricule`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inscription_filiere_CodeFile` FOREIGN KEY (`CodeFil`) REFERENCES `filiere` (`CodeFile`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
