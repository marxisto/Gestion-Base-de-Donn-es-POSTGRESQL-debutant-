-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_NOTE";


----------------------------------------------------------------------------
-------------------- Table N°2 : "I_NOTE"."TB_ETUDIANT" --------------------
----------------------------------------------------------------------------
--- Sélection des données présentes dans la table "TB_ETUDIANT"
SELECT * FROM "TB_ETUDIANT";

--- Suppression des données présentes dans la table TB_ETUDIANT"
TRUNCATE "TB_ETUDIANT" CASCADE;

---- Copie des données présentes dans le fichier TB_ETUDIANT.csv
COPY  "TB_ETUDIANT"
FROM 'C:\Script SQL - Formation PostgreSQL\Mini Projet 1 Gestion des notes\TB_ETUDIANT.csv'
DELIMITER '|'
CSV HEADER;



----------------------------------------------------------------------------
------------------- Table N°4 : "I_NOTE"."TB_ENSEIGNANT" -------------------
----------------------------------------------------------------------------
--- Sélection des données présentes dans la table "TB_ENSEIGNANT"
SELECT * FROM "TB_ENSEIGNANT";

--- Suppression des données présentes dans la table "TB_ENSEIGNANT"
TRUNCATE "TB_ENSEIGNANT" CASCADE;

---- Copie des données présentes dans le fichier TB_ENSEIGNANT.csv
COPY  "TB_ENSEIGNANT"
FROM 'C:\Script SQL - Formation PostgreSQL\Mini Projet 1 Gestion des notes\TB_ENSEIGNANT.csv'
DELIMITER '|'
CSV HEADER;


----------------------------------------------------------------------------
-------------------- Table N°5 : "I_NOTE"."TB_MATIERE" ---------------------
----------------------------------------------------------------------------
--- Sélection des données présentes dans la table "TB_MATIERE"
SELECT * FROM "TB_MATIERE" ;

--- Suppression des données présentes dans la table TB_MATIERE"
TRUNCATE "TB_MATIERE" CASCADE;

---- Copie des données présentes dans le fichier TB_PRODUIT.csv
COPY  "TB_MATIERE"
FROM 'C:\Script SQL - Formation PostgreSQL\Mini Projet 1 Gestion des notes\TB_MATIERE.csv'
DELIMITER '|'
CSV HEADER;



----------------------------------------------------------------------------
---------------------- Table N°6 : "I_NOTE"."TB_NOTE" ----------------------
----------------------------------------------------------------------------
--- Sélection des données présentes dans la table "TB_NOTE"
SELECT * FROM "TB_NOTE";

--- Suppression des données présentes dans la table "I_OPE"."TB_NOTE"
TRUNCATE "TB_NOTE";

---- Copie des données présentes dans le fichier TB_NOTE.csv
COPY  "TB_NOTE" ("ID_ETUDIANT", "CD_MATIERE", "CD_TYPE_EVALUATION","ANNEE_SCOLAIRE","DT_NOTE", "NB_NOTE")
FROM 'C:\Script SQL - Formation PostgreSQL\Mini Projet 1 Gestion des notes\TB_NOTE.csv'
DELIMITER '|'
CSV HEADER;