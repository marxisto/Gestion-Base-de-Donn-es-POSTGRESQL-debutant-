-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_SCOLARITE";



----------------------------------------------------------------------------
----------------- Détail des notes de l'année scolaire 2022 ---------------
----------------------------------------------------------------------------
SELECT N."ID_ETUDIANT" AS "N° Etudiant", 
       E."NOM_ETUDIANT" || ' '|| E."PREN_ETUDIANT" AS "Nom et Prénoms", 
       "LB_MATIERE" AS "Matière", "NB_NOTE" AS "Note", 
	   "NB_COEF" AS "Coefficient", "NB_NOTE"*"NB_COEF" AS "Note Coef"
FROM "TB_NOTE" N
INNER JOIN "TB_ETUDIANT" E ON N."ID_ETUDIANT" = E."ID_ETUDIANT"
INNER JOIN "TB_MATIERE" M ON M."CD_MATIERE" = N."CD_MATIERE"
WHERE "ANNEE_SCOLAIRE" = 2022;



----------------------------------------------------------------------------
--  Moyenne par étudiant par type d'évaluation pour l'année scolaire 2022 --
----------------------------------------------------------------------------
SELECT N."ID_ETUDIANT" AS "N° Etudiant", 
       E."NOM_ETUDIANT" || ' '|| E."PREN_ETUDIANT" AS "Nom et Prénoms", 
       SUM("NB_NOTE"*"NB_COEF") AS "Note Coef", 
	   SUM("NB_COEF") AS "Total Coef", 
	   ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2) AS "Moyenne", 
	   CASE 
	   		WHEN ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2)<10 
					THEN 'Faible'
	   		WHEN ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2)<12 
	   				THEN 'Passable'
			WHEN ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2)<14 
	   				THEN 'Assez Bien'
			WHEN ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2)<16 
	   				THEN 'Bien'
			WHEN ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2)<18 
	   				THEN 'Très Bien'
			ELSE	'Excellent'
		END AS "Appréciation",	   
	   RANK() OVER (PARTITION BY "LB_TYPE_EVALUATION" 
					ORDER BY ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2) DESC) AS "Rang",
	   "LB_TYPE_EVALUATION" AS "Type d''évaluation"
FROM "TB_NOTE" N
INNER JOIN "TB_ETUDIANT" E ON N."ID_ETUDIANT" = E."ID_ETUDIANT"
INNER JOIN "TB_MATIERE" M ON N."CD_MATIERE" = M."CD_MATIERE"
INNER JOIN "TB_TYPE_EVALUATION" T ON T."CD_TYPE_EVALUATION" = N."CD_TYPE_EVALUATION"
WHERE "ANNEE_SCOLAIRE" = 2022
GROUP BY N."ID_ETUDIANT", E."NOM_ETUDIANT" || ' '|| E."PREN_ETUDIANT", "LB_TYPE_EVALUATION"
ORDER BY "LB_TYPE_EVALUATION", ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2) DESC;



----------------------------------------------------------------------------
--  Statistique globale des notes de la classe pour l'année scolaire 2022 --
----------------------------------------------------------------------------

-- Sous requête : Moyenne de la classe par type d'évaluation
WITH "MOYENNE_CLASSE" AS (
    SELECT "LB_TYPE_EVALUATION" AS "Type d''évaluation", 
	       ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2) AS "Moyenne classe"
    FROM "TB_NOTE" N
	INNER JOIN "TB_MATIERE" M ON N."CD_MATIERE" = M."CD_MATIERE"
	INNER JOIN "TB_TYPE_EVALUATION" T ON T."CD_TYPE_EVALUATION" = N."CD_TYPE_EVALUATION"
	WHERE "ANNEE_SCOLAIRE" = 2022
    GROUP BY "LB_TYPE_EVALUATION"
)
SELECT DISTINCT P."Type d''évaluation", "Moyenne classe", 
        LAST_VALUE("Moyenne") 
		OVER (
		PARTITION BY P."Type d''évaluation" 
		ORDER BY "Moyenne" DESC 
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Faible Moyenne", 
		
		LAST_VALUE("Nom et Prénoms") 
		OVER (
		PARTITION BY P."Type d''évaluation" 
		ORDER BY "Moyenne" DESC 
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Moins Bon Etudiant", 
		
		LAST_VALUE("Moyenne") 
		OVER (
		PARTITION BY P."Type d''évaluation" 
		ORDER BY "Moyenne" ASC 
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Forte Moyenne", 
		
		LAST_VALUE("Nom et Prénoms") 
		OVER (
		PARTITION BY P."Type d''évaluation" 
		ORDER BY "Moyenne" ASC 
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Meilleur Etudiant" 
FROM
(
	-- Moyenne par étudiant par type d'évaluation pour l'année scolaire 2022
	SELECT N."ID_ETUDIANT" AS "N° Etudiant", 
		   E."NOM_ETUDIANT" || ' '|| E."PREN_ETUDIANT" AS "Nom et Prénoms", 
		   SUM("NB_NOTE"*"NB_COEF") AS "Note Coef", 
		   SUM("NB_COEF") AS "Total Coef", 
		   ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2) AS "Moyenne", 
		   CASE 
				WHEN ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2)<10 
						THEN 'Faible'
				WHEN ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2)<12 
						THEN 'Passable'
				WHEN ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2)<14 
						THEN 'Assez Bien'
				WHEN ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2)<16 
						THEN 'Bien'
				WHEN ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2)<18 
						THEN 'Très Bien'
				ELSE	'Excellent'
			END AS "Appréciation",	   
		   RANK() OVER (PARTITION BY "LB_TYPE_EVALUATION" 
						ORDER BY ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2) DESC) AS "Rang",
		   "LB_TYPE_EVALUATION" AS "Type d''évaluation"
	FROM "TB_NOTE" N
	INNER JOIN "TB_ETUDIANT" E ON N."ID_ETUDIANT" = E."ID_ETUDIANT"
	INNER JOIN "TB_MATIERE" M ON N."CD_MATIERE" = M."CD_MATIERE"
	INNER JOIN "TB_TYPE_EVALUATION" T ON T."CD_TYPE_EVALUATION" = N."CD_TYPE_EVALUATION"
	WHERE "ANNEE_SCOLAIRE" = 2022
	GROUP BY N."ID_ETUDIANT", E."NOM_ETUDIANT" || ' '|| E."PREN_ETUDIANT", "LB_TYPE_EVALUATION"
	ORDER BY "LB_TYPE_EVALUATION", ROUND((SUM("NB_NOTE"*"NB_COEF")/SUM("NB_COEF")),2) DESC
)P INNER JOIN "MOYENNE_CLASSE" MC ON MC."Type d''évaluation" = P."Type d''évaluation"
ORDER BY P."Type d''évaluation";



----------------------------------------------------------------------------
--Détail moyenne de l'étudiant : Todd Herv pour le partiel du 1er semestre--
----------------------------------------------------------------------------
SELECT M."CD_MATIERE" AS "Code Matière", "LB_MATIERE" AS "Matière", 
       "NB_NOTE" AS "Note", "NB_COEF" AS "Coefficient", 
       "NB_NOTE"*"NB_COEF" AS "Note Coef"
FROM "TB_NOTE" N
INNER JOIN "TB_ETUDIANT" E ON N."ID_ETUDIANT" = E."ID_ETUDIANT"
INNER JOIN "TB_MATIERE" M ON N."CD_MATIERE" = M."CD_MATIERE"
INNER JOIN "TB_TYPE_EVALUATION" T ON T."CD_TYPE_EVALUATION" = N."CD_TYPE_EVALUATION"
WHERE "ANNEE_SCOLAIRE" = 2022
AND   "LB_TYPE_EVALUATION" = 'Partiel du 1er semestre'
AND E."NOM_ETUDIANT" || ' '|| E."PREN_ETUDIANT" = 'Todd Herv'
ORDER BY "NB_NOTE" DESC;