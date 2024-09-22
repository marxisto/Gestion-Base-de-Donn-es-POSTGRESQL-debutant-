
SET SEARCH_PATH = "I_NOTE";


----------------------------------------------------------------------------
-------------------- Table N°1 : "I_NOTE"."TB_ETUDIANT" --------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_CIVILITE_ETUDIANT" ;
CREATE INDEX "IDX_CIVILITE_ETUDIANT" 
ON "TB_ETUDIANT" USING BTREE ("CIVILITE_ETUDIANT");

--DROP INDEX IF EXISTS "IDX_NOM_PREN_ETUDIANT" ;
CREATE UNIQUE INDEX "IDX_NOM_PREN_ETUDIANT" 
ON "TB_ETUDIANT" USING BTREE ("NOM_ETUDIANT", "PREN_ETUDIANT");

----------------------------------------------------------------------------
---------------- Table N°2 : "I_NOTE"."TB_TYPE_MATIERE" --------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_LB_TYPE_MATIERE"; 
CREATE INDEX "IDX_LB_TYPE_MATIERE" 
ON "TB_TYPE_MATIERE" USING BTREE ("LB_TYPE_MATIERE");



----------------------------------------------------------------------------
------------------- Table N°4 : "I_NOTE"."TB_ENSEIGNANT" -------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_NOM_PREN_ENSEIGNANT"; 
CREATE INDEX "IDX_NOM_PREN_ENSEIGNANT" 
ON "TB_ENSEIGNANT" USING BTREE ("NOM_ENSEIGNANT", "PREN_ENSEIGNANT");



----------------------------------------------------------------------------
-------------------- Table N°5 : "I_NOTE"."TB_MATIERE" ---------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_LB_MATIERE"; 
CREATE INDEX "IDX_LB_MATIERE" 
ON "TB_MATIERE" USING BTREE ("LB_MATIERE");



----------------------------------------------------------------------------
---------------------- Table N°6 : "I_NOTE"."TB_NOTE" ----------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_DT_NOTE"; 
CREATE INDEX "IDX_DT_NOTE" 
ON "TB_NOTE" USING BTREE ("DT_NOTE");