--trigger sprawdzajacy czy wstawiane konto ma blokade
CREATE TRIGGER konto_trigger ON KONTO
FOR INSERT AS
BEGIN
DECLARE @status Int;
SELECT @status = status_gracza_id FROM inserted;
	IF EXISTS (SELECT 'X' FROM inserted WHERE @status = 4) BEGIN
	RAISERROR ( 'nie mozna wstawiac postaci ktore maja blokade',1,2);
	ROLLBACK;
	END;
END;

DROP TRIGGER konto_trigger

SELECT * FROM KONTO

DELETE FROM konto WHERE data_zalozenia = '2023-12-12';

INSERT INTO KONTO
VALUES (6,'mojmail@onet.pl','tosamo1','tosamo','2023-12-12',4);

--zmienia klase przedmiotu jezeli profesja jest id 1
CREATE TRIGGER przedmiot_trigger ON PRZEDMIOT
FOR INSERT,update,delete
AS 
BEGIN
	UPDATE przedmiot 
	set przedmiot_klasa_id = 3 
	WHERE profesja_id = 1
END;

DROP trigger przedmiot_trigger;

SELECT * FROM przedmiot;


INSERT INTO przedmiot VALUES (5,'luk',5,2,3,1);

INSERT INTO przedmiot VALUES (7,'luk trzeci',5,2,2,2);
UPDATE przedmiot
SET przedmiot_klasa_id = 1
WHERE id = 1;

DELETE FROM przedmiot WHERE id = 5 OR id = 6;

--procedura do zmieniania nazwy wybranego klanu
CREATE PROCEDURE klan_proc
@id_klan Int,@nazwa_klanu VARCHAR(50)
AS BEGIN
UPDATE klan
SET nazwa = @nazwa_klanu
WHERE id = @id_klan;
END;

SELECT * FROM klan;
EXEC klan_proc @id_klan = 1, @nazwa_klanu = 'procedura';

--procedura do usuwania postaci zadanej wybranym id jesli ma poziom mniejszy niz srednia
CREATE PROCEDURE postac_proc2 @dane_id Int
AS BEGIN 
DECLARE
@poziom_id Int,@srednia Int
SELECT @poziom_id = lvl FROM postac WHERE id = @dane_id;
SELECT @srednia = AVG(lvl) FROM postac;
	IF @srednia > @poziom_id BEGIN
		DELETE postac
		WHERE id = @dane_id
	END;
END;

SELECT * FROM postac;

EXEC postac_proc2 @dane_id = 2;

ROLLBACK;
