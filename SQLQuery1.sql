-- Tabelul LOCATII
CREATE TABLE LOCATII (
    id_locatie INT PRIMARY KEY,
    oras VARCHAR(30) NOT NULL,
    localitate VARCHAR(20) NOT NULL,
    judet VARCHAR(30) NOT NULL
);

-- Tabelul CLIENTI
CREATE TABLE CLIENTI (
    id_client INT PRIMARY KEY,
    nume VARCHAR(50) NOT NULL,
    prenume VARCHAR(30) NOT NULL
);

-- Tabelul FACTURARI
CREATE TABLE FACTURARI (
    id_facturare INT PRIMARY KEY,
    CUI VARCHAR(10) NOT NULL,
    nume_firma VARCHAR(50) NOT NULL
);

-- Tabelul ADRESE
CREATE TABLE ADRESE (
    id_adresa INT PRIMARY KEY,
    id_locatie INT NOT NULL,
    id_client INT NOT NULL,
    tip_adresa VARCHAR(20) NOT NULL,
    strada VARCHAR(30) NOT NULL,
    nr_strada VARCHAR(5) NOT NULL,
    bloc VARCHAR(10),
    nr_bloc VARCHAR(10),
    FOREIGN KEY (id_locatie) REFERENCES LOCATII(id_locatie),
    FOREIGN KEY (id_client) REFERENCES CLIENTI(id_client)
);

-- Tabelul VOUCHERE
CREATE TABLE VOUCHERE (
    id_voucher INT PRIMARY KEY,
    reducere INT NOT NULL,
    data_expirare DATETIME NOT NULL
);

-- Tabelul COMENZI
CREATE TABLE COMENZI (
    id_comanda INT PRIMARY KEY,
    id_adresa_livrare INT NOT NULL,
    id_adresa_facturare INT NOT NULL,
    id_voucher INT,
    id_facturare INT NOT NULL,
    stare_comanda VARCHAR(20) NOT NULL,
    data_emitere DATETIME NOT NULL,
    FOREIGN KEY (id_adresa_livrare) REFERENCES ADRESE(id_adresa),
    FOREIGN KEY (id_adresa_facturare) REFERENCES ADRESE(id_adresa),
    FOREIGN KEY (id_voucher) REFERENCES VOUCHERE(id_voucher),
    FOREIGN KEY (id_facturare) REFERENCES FACTURARI(id_facturare)
);

-- Tabelul PRODUSE
CREATE TABLE PRODUSE (
    id_produs INT PRIMARY KEY,
    nume_produs VARCHAR(100) NOT NULL,
    cod_produs VARCHAR(50) NOT NULL,
    descriere VARCHAR(150),
    stoc INT NOT NULL
);

-- Tabel intermediar PRODUSE_COMANDA
CREATE TABLE PRODUSE_COMANDA (
    id_produs_comanda INT IDENTITY(1,1) PRIMARY KEY,
    id_produs INT NOT NULL,
    id_comanda INT NOT NULL,
    nr_bucati INT NOT NULL,
    pret DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_produs) REFERENCES PRODUSE(id_produs),
    FOREIGN KEY (id_comanda) REFERENCES COMENZI(id_comanda)
);

-- Alter Table Constraints
ALTER TABLE ADRESE ADD CONSTRAINT FK_ADRESE_LOCATII FOREIGN KEY (id_locatie) REFERENCES LOCATII (id_locatie);
ALTER TABLE ADRESE ADD CONSTRAINT FK_ADRESE_CLIENTI FOREIGN KEY (id_client) REFERENCES CLIENTI (id_client);
ALTER TABLE COMENZI ADD CONSTRAINT FK_COMENZI_ADRESE_LIVRARE FOREIGN KEY (id_adresa_livrare) REFERENCES ADRESE (id_adresa);
ALTER TABLE COMENZI ADD CONSTRAINT FK_COMENZI_ADRESE_FACTURARE FOREIGN KEY (id_adresa_facturare) REFERENCES ADRESE (id_adresa);
ALTER TABLE COMENZI ADD CONSTRAINT FK_COMENZI_FACTURARI FOREIGN KEY (id_facturare) REFERENCES FACTURARI (id_facturare);
ALTER TABLE COMENZI ADD CONSTRAINT FK_COMENZI_VOUCHERE FOREIGN KEY (id_voucher) REFERENCES VOUCHERE (id_voucher);
ALTER TABLE PRODUSE_COMANDA ADD CONSTRAINT FK_PRODUSE_COMANDA_PRODUSE FOREIGN KEY (id_produs) REFERENCES PRODUSE (id_produs);
ALTER TABLE PRODUSE_COMANDA ADD CONSTRAINT FK_PRODUSE_COMANDA_COMENZI FOREIGN KEY (id_comanda) REFERENCES COMENZI (id_comanda);

-- INSERTURI PENTRU LOCATII
INSERT INTO LOCATII (id_locatie, oras, localitate, judet) VALUES
(1, N'Bucuresti', N'Sector 1', N'Ilfov'),
(2, N'Cluj-Napoca', N'Centru', N'Cluj'),
(3, N'Timisoara', N'Zona Vest', N'Timis'),
(4, N'Iasi', N'Targu Cucu', N'Iasi'),
(5, N'Brasov', N'Schei', N'Brasov');

-- INSERTURI PENTRU CLIENTI
INSERT INTO CLIENTI (id_client, nume, prenume) VALUES
(1, 'Popescu', 'Ion'),
(2, 'Ionescu', 'Maria'),
(3, 'Vasilescu', 'Andrei'),
(4, 'Dumitrescu', 'Ana'),
(5, 'Georgescu', 'Radu'),
(6, 'Marinescu', 'Elena'),
(7, 'Dobre', 'Cristina'),
(8, 'Stan', 'Mihai'),
(9, 'Iliescu', 'Ioana');

-- INSERTURI PENTRU FACTURARI
INSERT INTO FACTURARI (id_facturare, CUI, nume_firma) VALUES
(1, 'RO123456', 'SC Exemplu SRL'),
(2, 'RO654321', 'SC Test SRL'),
(3, 'RO789123', 'SC Prod Com SRL'),
(4, 'RO456789', 'SC Alta Firma SRL');

-- INSERTURI PENTRU ADRESE
INSERT INTO ADRESE (id_adresa, id_locatie, id_client, tip_adresa, strada, nr_strada, bloc, nr_bloc) VALUES
(1, 1, 1, 'Livrare', 'Strada Exemplu', '10', 'A', '1'),
(2, 2, 2, 'Facturare', 'Strada Test', '20', 'B', '2'),
(3, 3, 3, 'Livrare', 'Strada Vest', '30', 'C', '3'),
(4, 4, 4, 'Facturare', 'Strada Est', '40', 'D', '4'),
(5, 5, 5, 'Livrare', 'Strada Noua', '50', 'E', '5');

-- INSERTURI PENTRU VOUCHERE
INSERT INTO VOUCHERE (id_voucher, reducere, data_expirare) VALUES
(1, 10, '2025-12-31'),
(2, 20, '2025-06-30'),
(3, 15, '2025-09-15'),
(4, 25, '2026-01-01');

-- INSERTURI PENTRU COMENZI
INSERT INTO COMENZI (id_comanda, id_adresa_livrare, id_adresa_facturare, id_voucher, id_facturare, stare_comanda, data_emitere) VALUES
(1, 1, 2, 1, 1, 'Noua', '2025-01-10'),
(2, 3, 4, 2, 2, 'Procesata', '2025-01-11'),
(3, 1, 4, NULL, 3, 'Finalizata', '2025-01-12'),
(4, 5, 3, 3, 4, 'Anulata', '2025-01-13');

-- INSERTURI PENTRU PRODUSE
INSERT INTO PRODUSE (id_produs, nume_produs, cod_produs, descriere, stoc) VALUES
(1, 'Laptop', 'LTP123', 'Laptop performant', 50),
(2, 'Telefon', 'TEL456', 'Smartphone modern', 100),
(3, 'Televizor', 'TV789', 'Televizor LED', 30),
(4, 'Tableta', 'TAB012', 'Tableta compacta', 75),
(5, 'Monitor', 'MON345', 'Monitor Full HD', 40),
(6, 'Router', 'RTR678', 'Router wireless', 60),
(7, 'Mouse', 'MSE234', 'Mouse ergonomic', 120),
(8, 'Tastatura', 'KBD567', 'Tastatura mecanica', 80),
(9, 'Imprimanta', 'PRT890', 'Imprimanta color', 25);

-- INSERTURI PENTRU PRODUSE_COMANDA (aceasta coloana are IDENTITY)
INSERT INTO PRODUSE_COMANDA (id_produs, id_comanda, nr_bucati, pret) VALUES
(1, 1, 1, 4500.00),
(2, 1, 2, 1500.00),
(3, 2, 1, 2000.00),
(4, 3, 3, 300.00),
(5, 4, 2, 750.00),
(6, 2, 4, 500.00),
(7, 3, 2, 100.00),
(8, 4, 1, 450.00),
(9, 1, 3, 300.00),
(5, 3, 2, 750.00),
(2, 4, 5, 1500.00),
(3, 2, 2, 2000.00),
(6, 3, 4, 500.00),
(7, 4, 6, 100.00),
(8, 2, 1, 450.00),
(9, 3, 3, 300.00),
(5, 4, 2, 750.00),
(1, 2, 1, 4500.00),
(7, 3, 3, 100.00),
(8, 4, 2, 450.00);

SELECT * FROM LOCATII;
SELECT * FROM CLIENTI;
SELECT * FROM FACTURARI;
SELECT * FROM ADRESE;
SELECT * FROM VOUCHERE;
SELECT * FROM COMENZI;
SELECT * FROM PRODUSE;
SELECT * FROM PRODUSE_COMANDA;

