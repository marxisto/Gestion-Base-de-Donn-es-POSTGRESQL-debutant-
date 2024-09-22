----------------------------------------------------------------------------
----------------- Script de création des différentes tables ----------------
----------------------------------------------------------------------------

-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_NOTE";

----------------------------------------------------------------------------
-------------------- Table N°2 : "I_NOTE"."TB_ETUDIANT" --------------------
----------------------------------------------------------------------------
DROP TABLE IF EXISTS "TB_ETUDIANT" ;
CREATE TABLE "TB_ETUDIANT" 
(
"ID_ETUDIANT" 			VARCHAR(50) NOT NULL,
"CIVILITE_ETUDIANT" 	VARCHAR(100) NOT NULL,
"NOM_ETUDIANT" 			VARCHAR(100) NOT NULL,
"PREN_ETUDIANT" 		VARCHAR(100) NOT NULL,
"CD_POSTAL_ETUDIANT" 	VARCHAR(100) NOT NULL,
"VILLE_ETUDIANT" 		VARCHAR(100) NOT NULL,
CONSTRAINT "TB_ETUDIANT_PKEY" PRIMARY KEY("ID_ETUDIANT")
);


----------------------------------------------------------------------------
------------------- Table N°4 : "I_NOTE"."TB_ENSEIGNANT" -------------------
----------------------------------------------------------------------------
DROP TABLE IF EXISTS "TB_ENSEIGNANT" ;
CREATE TABLE "TB_ENSEIGNANT" 
(
"ID_ENSEIGNANT" 	VARCHAR(50) NOT NULL,
"NOM_ENSEIGNANT" 	VARCHAR(100) NOT NULL,
"PREN_ENSEIGNANT" 	VARCHAR(100) NOT NULL,
"EMAIL_ENSEIGNANT" 	VARCHAR(100) NOT NULL,
CONSTRAINT "TB_ENSEIGNANT_PKEY" PRIMARY KEY("ID_ENSEIGNANT")
);


----------------------------------------------------------------------------
-------------------- Table N°5 : "I_NOTE"."TB_MATIERE" ---------------------
----------------------------------------------------------------------------
DROP TABLE IF EXISTS "TB_MATIERE" ;
CREATE TABLE "TB_MATIERE" 
(
"CD_MATIERE" 		VARCHAR(50) NOT NULL,
"LB_MATIERE" 		VARCHAR(100) NOT NULL,
"NB_COEF"    		NUMERIC NOT NULL,
"CD_TYPE_MATIERE" 	VARCHAR(50) NOT NULL,
"ID_ENSEIGNANT" 	VARCHAR(50) NOT NULL,
CONSTRAINT "TB_MATIERE_PKEY" PRIMARY KEY("CD_MATIERE"), 
	
CONSTRAINT "TB_TYPE_MATIERE_FKEY" FOREIGN KEY ("CD_TYPE_MATIERE") 
	REFERENCES "TB_TYPE_MATIERE"("CD_TYPE_MATIERE"),
	
CONSTRAINT "TB_MATIERE_ENSEIGNANT_FKEY" FOREIGN KEY ("ID_ENSEIGNANT") 
	REFERENCES "TB_ENSEIGNANT"("ID_ENSEIGNANT")
);


----------------------------------------------------------------------------
---------------------- Table N°6 : "I_NOTE"."TB_NOTE" ----------------------
----------------------------------------------------------------------------
DROP TABLE IF EXISTS "TB_NOTE" ;
CREATE TABLE "TB_NOTE" 
(
"ID_ETUDIANT" 			VARCHAR(50) NOT NULL,
"CD_MATIERE" 			VARCHAR(50) NOT NULL,	
"CD_TYPE_EVALUATION" 	VARCHAR(50) NOT NULL,	
"ANNEE_SCOLAIRE"		NUMERIC NOT NULL,
"DT_NOTE"				TIMESTAMP NOT NULL,
"NB_NOTE" 				NUMERIC NOT NULL,

CONSTRAINT "TB_NOTE_PKEY" PRIMARY KEY("ID_ETUDIANT","CD_MATIERE","CD_TYPE_EVALUATION","ANNEE_SCOLAIRE"), 											
CONSTRAINT "TB_NOTE_ETUDIANT_FKEY" FOREIGN KEY ("ID_ETUDIANT") 
	REFERENCES "TB_ETUDIANT"("ID_ETUDIANT"), 
	
CONSTRAINT "TB_NOTE_MATIERE_FKEY" FOREIGN KEY ("CD_MATIERE") 
	REFERENCES "TB_MATIERE"("CD_MATIERE"),
	
CONSTRAINT "TB_TYPE_EVALUATION_FKEY" FOREIGN KEY ("CD_TYPE_EVALUATION") 
	REFERENCES "TB_TYPE_EVALUATION"("CD_TYPE_EVALUATION")
);