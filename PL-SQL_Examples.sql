--trigger ktory sprawdza czy nowy login oraz nowe haslo nie sa takie same oraz czy konto nie ma blokady
CREATE OR REPLACE TRIGGER konto_trigger
BEFORE UPDATE OR INSERT ON KONTO
FOR EACH ROW
BEGIN
    IF UPDATING AND :OLD.STATUS_GRACZA_ID = 4 THEN
        raise_application_error(-20500, 'Nie wolno aktualizowac danych na kontach z banem');
    end if;
    IF INSERTING AND :NEW.HASLO = :NEW.LOGIN THEN
        raise_application_error(-20500, 'login oraz haslo nie moga byc takie same');
    end if;
end;


SELECT * FROM KONTO

INSERT INTO KONTO
VALUES (6,'mojmail@onet.pl','tosamo1','tosamo',TO_DATE(current_date),1);

UPDATE KONTO
set EMAIL = 'nowymail@mail.com'
WHERE id = 1;

--trigger sprawdzajacy czy tylko zbroje sa legendarne przy wstawianiu/updatowaniu oraz nie pozwalajacy usuwac przedmiotow dla lowcy
CREATE OR REPLACE TRIGGER przedmiot_trigger
BEFORE UPDATE OR DELETE OR INSERT ON PRZEDMIOT
FOR EACH ROW
BEGIN
    IF (INSERTING OR UPDATING) AND (:NEW.przedmiot_typ_id <> 2 AND :NEW.przedmiot_klasa_id = 2) THEN
        raise_application_error(-20500, 'Tylko zbroja moze byc klasy legendarnej');
    end if;
    IF DELETING AND :OLD.PROFESJA_ID = 2 THEN
        raise_application_error(-20500, 'nie mozna usuwac przedmiotow dla lowcow');
    end if;
end;

SELECT * FROM PRZEDMIOT_EKWIPUNEK;
SELECT * FROM PRZEDMIOT_TYP;
SELECT * FROM PROFESJA;
SELECT * FROM PRZEDMIOT;
SELECT * FROM PRZEDMIOT_KLASA;
SELECT * FROM UMIEJETNOSC;
SELECT * FROM POSTAC;
SELECT * FROM KLAN;
SELECT * FROM STATUS_GRACZA;

INSERT INTO PROFESJA values (5,'wszystko',null);

DELETE FROM PRZEDMIOT
WHERE PRZEDMIOT_TYP_ID = 1;

UPDATE PRZEDMIOT
SET PRZEDMIOT_KLASA_ID = 2
WHERE ID = 1;

--procedura ktora sprawdza ile jest zbroi dla wszystkich profesji oraz jesli jest <2 to wstawia 
CREATE OR REPLACE PROCEDURE inserting_przedmiot (nazwa_przedmiot VARCHAR2) AS
    ilosc NUMBER;
    curr_id NUMBER;
BEGIN
    SELECT COUNT(*) into ilosc FROM PRZEDMIOT WHERE PROFESJA_ID = 5;
    SELECT COUNT(*) into curr_id FROM PRZEDMIOT;
    IF ilosc < 2 THEN
        INSERT INTO PRZEDMIOT
        VALUES (curr_id+1,nazwa_przedmiot,1,5,2,1);
        DBMS_OUTPUT.PUT_LINE('wstawiono nowy przedmiot');
    ELSE
        raise_application_error(-20500, 'nie ma potrzeby wstawiania nowych zbroi');
    end if;
end;

--procedura ktora przenosi postacie konta zadanego parametrem na mape zadana parametrem oraz przenosi postacie do odpowiednich klanow zaleznie od poziomu, jezeli ich poziom jest ponizej sredniej - trafia do klanu o id 1, jezeli poziom jest wyzszy niz srednia - trafia do klanu o id 3
CREATE OR REPLACE PROCEDURE przenies_postaci (v_kontoid INTEGER, v_lokacja INTEGER) AS
    avg_poziom NUMBER;
    CURSOR zmien_klan IS SELECT * FROM POSTAC;
    v_postac POSTAC%rowtype;
BEGIN
    OPEN zmien_klan;
        LOOP
        FETCH zmien_klan into v_postac;
        EXIT WHEN zmien_klan%NOTFOUND;
        SELECT AVG(LVL) into avg_poziom FROM POSTAC;
        IF v_postac.LVL <= avg_poziom THEN
            UPDATE POSTAC
            SET KLAN_ID = 1
            WHERE ID = v_postac.ID;
        ELSE
            UPDATE POSTAC
            SET KLAN_ID = 3
            WHERE ID = v_postac.ID;
        END IF;
        IF v_postac.KONTO_SWIAT_ID = v_kontoid THEN
            UPDATE POSTAC
            SET LOKACJA_ID = v_lokacja
            WHERE ID = v_postac.ID;
            DBMS_OUTPUT.PUT_LINE('Przeniesiono postac '|| v_postac.NICK || ' konta od ID: ' || v_kontoid || ' na mape o ID: ' || v_lokacja);
        end if;
    END LOOP;
    CLOSE zmien_klan;
end;





