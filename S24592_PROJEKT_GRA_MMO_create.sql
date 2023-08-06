-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-08-06 21:01:15.183

-- tables
-- Table: ekwipunek
CREATE TABLE ekwipunek (
    id int  NOT NULL,
    CONSTRAINT ekwipunek_pk PRIMARY KEY  (id)
);

-- Table: klan
CREATE TABLE klan (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    CONSTRAINT klan_pk PRIMARY KEY  (id)
);

-- Table: konto
CREATE TABLE konto (
    id int  NOT NULL,
    email text  NOT NULL,
    login text  NOT NULL,
    haslo text  NOT NULL,
    data_zalozenia date  NOT NULL,
    status_gracza_id int  NOT NULL,
    CONSTRAINT konto_pk PRIMARY KEY  (id)
);

-- Table: konto_swiat
CREATE TABLE konto_swiat (
    id int  NOT NULL,
    konto_id int  NOT NULL,
    swiat_id int  NOT NULL,
    CONSTRAINT konto_swiat_pk PRIMARY KEY  (id)
);

-- Table: lokacja
CREATE TABLE lokacja (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    status_pvp text  NOT NULL,
    CONSTRAINT lokacja_pk PRIMARY KEY  (id)
);

-- Table: npc
CREATE TABLE npc (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    CONSTRAINT npc_pk PRIMARY KEY  (id)
);

-- Table: npc_lokacja
CREATE TABLE npc_lokacja (
    npc_id int  NOT NULL,
    lokacja_id int  NOT NULL,
    CONSTRAINT npc_lokacja_pk PRIMARY KEY  (npc_id,lokacja_id)
);

-- Table: postac
CREATE TABLE postac (
    id int  NOT NULL,
    lvl int  NOT NULL,
    nick text  NOT NULL,
    klan_id int  NULL,
    profesja_id int  NOT NULL,
    ekwipunek_id int  NOT NULL,
    statystyki_id int  NOT NULL,
    lokacja_id int  NOT NULL,
    konto_swiat_id int  NOT NULL,
    CONSTRAINT postac_pk PRIMARY KEY  (id)
);

-- Table: potwor
CREATE TABLE potwor (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    statystyki_id int  NOT NULL,
    potwor_typ_id int  NOT NULL,
    CONSTRAINT potwor_pk PRIMARY KEY  (id)
);

-- Table: potwor_lokacja
CREATE TABLE potwor_lokacja (
    potwor_id int  NOT NULL,
    lokacja_id int  NOT NULL,
    CONSTRAINT potwor_lokacja_pk PRIMARY KEY  (potwor_id,lokacja_id)
);

-- Table: potwor_przedmiot
CREATE TABLE potwor_przedmiot (
    potwor_id int  NOT NULL,
    przedmiot_id int  NOT NULL,
    CONSTRAINT potwor_przedmiot_pk PRIMARY KEY  (potwor_id,przedmiot_id)
);

-- Table: potwor_typ
CREATE TABLE potwor_typ (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    CONSTRAINT potwor_typ_pk PRIMARY KEY  (id)
);

-- Table: profesja
CREATE TABLE profesja (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    umiejetnosci_id int  NOT NULL,
    CONSTRAINT profesja_pk PRIMARY KEY  (id)
);

-- Table: przedmiot
CREATE TABLE przedmiot (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    statystyki_id int  NOT NULL,
    profesja_id int  NOT NULL,
    przedmiot_typ_id int  NOT NULL,
    przedmiot_klasa_id int  NOT NULL,
    CONSTRAINT przedmiot_pk PRIMARY KEY  (id)
);

-- Table: przedmiot_ekwipunek
CREATE TABLE przedmiot_ekwipunek (
    ekwipunek_id int  NOT NULL,
    przedmiot_id int  NOT NULL,
    CONSTRAINT przedmiot_ekwipunek_pk PRIMARY KEY  (ekwipunek_id,przedmiot_id)
);

-- Table: przedmiot_klasa
CREATE TABLE przedmiot_klasa (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    bonus text  NULL,
    CONSTRAINT przedmiot_klasa_pk PRIMARY KEY  (id)
);

-- Table: przedmiot_typ
CREATE TABLE przedmiot_typ (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    CONSTRAINT przedmiot_typ_pk PRIMARY KEY  (id)
);

-- Table: status_gracza
CREATE TABLE status_gracza (
    id int  NOT NULL,
    opis text  NOT NULL,
    CONSTRAINT status_gracza_pk PRIMARY KEY  (id)
);

-- Table: statystyki
CREATE TABLE statystyki (
    id int  NOT NULL,
    atak int  NOT NULL,
    pancerz int  NOT NULL,
    zrecznosc int  NOT NULL,
    inteligencja int  NOT NULL,
    sila int  NOT NULL,
    unik int  NOT NULL,
    blok int  NOT NULL,
    zycie int  NOT NULL,
    szybkosc_ataku int  NOT NULL,
    energia int  NOT NULL,
    mana int  NOT NULL,
    CONSTRAINT statystyki_pk PRIMARY KEY  (id)
);

-- Table: swiat
CREATE TABLE swiat (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    CONSTRAINT swiat_pk PRIMARY KEY  (id)
);

-- Table: umiejetnosc
CREATE TABLE umiejetnosc (
    id int  NOT NULL,
    nazwa text  NOT NULL,
    umiejetnosci text  NOT NULL,
    bonus text  NOT NULL,
    opis text  NOT NULL,
    CONSTRAINT umiejetnosc_pk PRIMARY KEY  (id)
);

-- foreign keys
-- Reference: konto_status_gracza (table: konto)
ALTER TABLE konto ADD CONSTRAINT konto_status_gracza
    FOREIGN KEY (status_gracza_id)
    REFERENCES status_gracza (id);

-- Reference: konto_swiat_konto (table: konto_swiat)
ALTER TABLE konto_swiat ADD CONSTRAINT konto_swiat_konto
    FOREIGN KEY (konto_id)
    REFERENCES konto (id);

-- Reference: konto_swiat_swiat (table: konto_swiat)
ALTER TABLE konto_swiat ADD CONSTRAINT konto_swiat_swiat
    FOREIGN KEY (swiat_id)
    REFERENCES swiat (id);

-- Reference: npc_lokacja_lokacja (table: npc_lokacja)
ALTER TABLE npc_lokacja ADD CONSTRAINT npc_lokacja_lokacja
    FOREIGN KEY (lokacja_id)
    REFERENCES lokacja (id);

-- Reference: npc_lokacja_npc (table: npc_lokacja)
ALTER TABLE npc_lokacja ADD CONSTRAINT npc_lokacja_npc
    FOREIGN KEY (npc_id)
    REFERENCES npc (id);

-- Reference: postac_ekwipunek (table: postac)
ALTER TABLE postac ADD CONSTRAINT postac_ekwipunek
    FOREIGN KEY (ekwipunek_id)
    REFERENCES ekwipunek (id);

-- Reference: postac_klan (table: postac)
ALTER TABLE postac ADD CONSTRAINT postac_klan
    FOREIGN KEY (klan_id)
    REFERENCES klan (id);

-- Reference: postac_konto_swiat (table: postac)
ALTER TABLE postac ADD CONSTRAINT postac_konto_swiat
    FOREIGN KEY (konto_swiat_id)
    REFERENCES konto_swiat (id);

-- Reference: postac_lokacja (table: postac)
ALTER TABLE postac ADD CONSTRAINT postac_lokacja
    FOREIGN KEY (lokacja_id)
    REFERENCES lokacja (id);

-- Reference: postac_profesja (table: postac)
ALTER TABLE postac ADD CONSTRAINT postac_profesja
    FOREIGN KEY (profesja_id)
    REFERENCES profesja (id);

-- Reference: postac_statystyki (table: postac)
ALTER TABLE postac ADD CONSTRAINT postac_statystyki
    FOREIGN KEY (statystyki_id)
    REFERENCES statystyki (id);

-- Reference: potwor_lokacja_lokacja (table: potwor_lokacja)
ALTER TABLE potwor_lokacja ADD CONSTRAINT potwor_lokacja_lokacja
    FOREIGN KEY (lokacja_id)
    REFERENCES lokacja (id);

-- Reference: potwor_lokacja_potwor (table: potwor_lokacja)
ALTER TABLE potwor_lokacja ADD CONSTRAINT potwor_lokacja_potwor
    FOREIGN KEY (potwor_id)
    REFERENCES potwor (id);

-- Reference: potwor_potwor_typ (table: potwor)
ALTER TABLE potwor ADD CONSTRAINT potwor_potwor_typ
    FOREIGN KEY (potwor_typ_id)
    REFERENCES potwor_typ (id);

-- Reference: potwor_przedmiot_potwor (table: potwor_przedmiot)
ALTER TABLE potwor_przedmiot ADD CONSTRAINT potwor_przedmiot_potwor
    FOREIGN KEY (potwor_id)
    REFERENCES potwor (id);

-- Reference: potwor_przedmiot_przedmiot (table: potwor_przedmiot)
ALTER TABLE potwor_przedmiot ADD CONSTRAINT potwor_przedmiot_przedmiot
    FOREIGN KEY (przedmiot_id)
    REFERENCES przedmiot (id);

-- Reference: potwor_statystyki (table: potwor)
ALTER TABLE potwor ADD CONSTRAINT potwor_statystyki
    FOREIGN KEY (statystyki_id)
    REFERENCES statystyki (id);

-- Reference: profesja_umiejetnosci (table: profesja)
ALTER TABLE profesja ADD CONSTRAINT profesja_umiejetnosci
    FOREIGN KEY (umiejetnosci_id)
    REFERENCES umiejetnosc (id);

-- Reference: przedmiot_ekwipunek_ekwipunek (table: przedmiot_ekwipunek)
ALTER TABLE przedmiot_ekwipunek ADD CONSTRAINT przedmiot_ekwipunek_ekwipunek
    FOREIGN KEY (ekwipunek_id)
    REFERENCES ekwipunek (id);

-- Reference: przedmiot_ekwipunek_przedmiot (table: przedmiot_ekwipunek)
ALTER TABLE przedmiot_ekwipunek ADD CONSTRAINT przedmiot_ekwipunek_przedmiot
    FOREIGN KEY (przedmiot_id)
    REFERENCES przedmiot (id);

-- Reference: przedmiot_profesja (table: przedmiot)
ALTER TABLE przedmiot ADD CONSTRAINT przedmiot_profesja
    FOREIGN KEY (profesja_id)
    REFERENCES profesja (id);

-- Reference: przedmiot_przedmiot_klasa (table: przedmiot)
ALTER TABLE przedmiot ADD CONSTRAINT przedmiot_przedmiot_klasa
    FOREIGN KEY (przedmiot_klasa_id)
    REFERENCES przedmiot_klasa (id);

-- Reference: przedmiot_przedmiot_typ (table: przedmiot)
ALTER TABLE przedmiot ADD CONSTRAINT przedmiot_przedmiot_typ
    FOREIGN KEY (przedmiot_typ_id)
    REFERENCES przedmiot_typ (id);

-- Reference: przedmiot_statystyki (table: przedmiot)
ALTER TABLE przedmiot ADD CONSTRAINT przedmiot_statystyki
    FOREIGN KEY (statystyki_id)
    REFERENCES statystyki (id);

-- End of file.

