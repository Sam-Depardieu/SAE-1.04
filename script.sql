DROP TABLE Fournisseur;
DROP TABLE Abonnement;
DROP TABLE Velo;
DROP TABLE Client;
DROP TABLE Station;

CREATE TABLE Station(
    Id char(4),
    Nom char(50) UNIQUE NOT NULL,
    VeloMax numeric DEFAULT 20,
    NbrVelo numeric NOT NULL,
    PRIMARY KEY(Id),
    CHECK(VeloMax >= 10)

);

CREATE TABLE Client(
    Id char(4),
    Nom varchar(50) NOT NULL,
    Prenom varchar(50) NOT NULL,
    NumTel numeric UNIQUE NOT NULL,
    Mail char(100) UNIQUE NOT NULL,
    Age numeric NOT NULL,
    Statut char(50),
    Abonnement char(50) NOT NULL,
    PRIMARY KEY(Id),
    CHECK( Statut IN('Professionnel','Particulier')),
    CHECK( Mail LIKE '%@%'),
    CHECK( Age > 14 ),
    CHECK( Abonnement IN('Gratuit','Longue durée'))

);

CREATE TABLE Velo(
    Id char(4),
    IdClient char(4),
    IdStation char(4),
    NbrReserv numeric NOT NULL,
    Statut char(50),
    TypeVelo char(100) NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY(IdStation) REFERENCES Station(Id),
    CHECK( Statut IN('Réservé', 'Libre')),
    CHECK( TypeVelo IN ('Classique', 'Assistance électrique', 'Assistance électrique pliant'))
);

CREATE TABLE Abonnement(
    Id char(4),
    IdClient char(4),
    AboType char(50) NOT NULL,
    VeloType char(100) NOT NULL,
    TarifType char(50) NOT NULL,
    DateDebut date NOT NULL,
    DateFin date NOT NULL,
    Prix numeric NOT NULL,
    Caution numeric NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY(IdClient) REFERENCES Client(Id),
    CHECK( AboType IN('Gratuit','Longue durée')),
    CHECK ( VeloType IN ('Classique', 'Assistance électrique', 'Assistance électrique pliant')),
    CHECK ( DateFin > DateDebut),
    CHECK ( TarifType IN ('Plein', 'Reduit', 'Spécifique')),
    CHECK ( (AboType = 'Gratuit' and Prix = 0) OR 
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 1 and TarifType = 'Plein' and Prix = 5) OR
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 7 and TarifType = 'Plein' and Prix = 12) OR
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 30 and TarifType = 'Plein' and Prix = 25) OR
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 60 and TarifType = 'Plein' and Prix = 40) OR
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 180 and TarifType = 'Plein' and Prix = 80) OR
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 365 and TarifType = 'Plein' and Prix = 120) OR
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 7 and TarifType = 'Reduit' and Prix = 10) OR
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 30 and TarifType = 'Reduit' and Prix = 20) OR
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 60 and TarifType = 'Reduit' and Prix = 30) OR
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 180 and TarifType = 'Reduit' and Prix = 60) OR
    (AboType = 'Longue durée' and VeloType = 'Classique' and DateFin-DateDebut <= 365 and TarifType = 'Reduit' and Prix = 90) OR
    (AboType = 'Longue durée' and VeloType = 'Assistance électrique' and DateFin-DateDebut <= 1 and TarifType = 'Plein' and Prix = 10) OR
    (AboType = 'Longue durée' and VeloType = 'Assistance électrique' and DateFin-DateDebut <= 7 and TarifType = 'Plein' and Prix = 24) OR
    (AboType = 'Longue durée' and VeloType = 'Assistance électrique' and DateFin-DateDebut <= 30 and TarifType = 'Plein' and Prix = 50) OR
    (AboType = 'Longue durée' and VeloType = 'Assistance électrique' and DateFin-DateDebut <= 60 and TarifType = 'Plein' and Prix = 80) OR
    (AboType = 'Longue durée' and VeloType = 'Assistance électrique' and DateFin-DateDebut <= 90 and TarifType = 'Plein' and Prix = 110) OR
    (AboType = 'Longue durée' and VeloType = 'Assistance électrique' and DateFin-DateDebut <= 7 and TarifType = 'Reduit' and Prix = 20) OR
    (AboType = 'Longue durée' and VeloType = 'Assistance électrique' and DateFin-DateDebut <= 30 and TarifType = 'Reduit' and Prix = 40) OR
    (AboType = 'Longue durée' and VeloType = 'Assistance électrique' and DateFin-DateDebut <= 60 and TarifType = 'Reduit' and Prix = 60) OR
    (AboType = 'Longue durée' and VeloType = 'Assistance électrique' and DateFin-DateDebut <= 90 and TarifType = 'Reduit' and Prix = 85) OR
    (AboType = 'Longue durée' and VeloType = 'Assistance électrique pliant' and DateFin-DateDebut <= 90 and TarifType = 'Spécifique' and Prix = 75)),
    CHECK( (Caution = 200 and VeloType = 'Classique') OR (Caution = 350 and (VeloType = 'Assistance électrique' or VeloType = 'Assistance électrique pliant')))
);

CREATE TABLE Fournisseur(
    Id char(4),
    Nom char(10) UNIQUE NOT NULL,
    TypeVelo char(100) NOT NULL,
    NbrVeloStock numeric NOT NULL,
    PRIMARY KEY(Id),
    CHECK( TypeVelo IN ('Classique', 'Assistance électrique', 'Assistance électrique pliant'))
);


INSERT INTO Station VALUES ('S001','Jaude',24,8);
INSERT INTO Station VALUES ('S020','Pocket Lagaye',24,8);
INSERT INTO Station VALUES ('S033','La Fayette',20,0);
INSERT INTO Station VALUES ('S039','Oradou',19,3);
INSERT INTO Station VALUES ('S004','Campus',30,5);
INSERT INTO Station VALUES ('S032','Liondards',16,6);
INSERT INTO Station VALUES ('S006','CHU G.Montpied',32,9);
INSERT INTO Station VALUES ('S021','CROUS/Dolet',24,4);
INSERT INTO Station VALUES ('S031','Poncillon',18,6);
INSERT INTO Station VALUES ('S018','Côte Blatin',16,7);
INSERT INTO Station VALUES ('S046','Musset',17,6);
INSERT INTO Station VALUES ('S045','Trois coquins',20,7);
INSERT INTO Station VALUES ('S040','Parking Gare',16,2);
INSERT INTO Station VALUES ('S002','Parvis de la gare',40,4);
INSERT INTO Station VALUES ('S011','Gare - Terminal routier',48,8);
INSERT INTO Station VALUES ('S038','Les Paulines',20,1);
INSERT INTO Station VALUES ('S019','Amboise',20,10);
INSERT INTO Station VALUES ('S030','Coubertin',24,5);
INSERT INTO Station VALUES ('S005','Salins',32,10);
INSERT INTO Station VALUES ('S023','Lagarlaye',32,8);
INSERT INTO Station VALUES ('S029','Regensburg',16,5);
INSERT INTO Station VALUES ('S022','Jaures',13,0);
INSERT INTO Station VALUES ('S028','Morel Ladeuil',16,7);
INSERT INTO Station VALUES ('S027','Berthelot',19,10);
INSERT INTO Station VALUES ('S048','Voltaire',19,9);
INSERT INTO Station VALUES ('S049','Galaxie',20,8);
INSERT INTO Station VALUES ('S016','Fontgiève',20,11);
INSERT INTO Station VALUES ('S026','Clos Notre Dame',17,2);
INSERT INTO Station VALUES ('S008','Gaillard',26,8);
INSERT INTO Station VALUES ('S025','Apollinaire',20,3);
INSERT INTO Station VALUES ('S015','Maison des sports',32,8);
INSERT INTO Station VALUES ('S014','Les Carmes',24,7);
INSERT INTO Station VALUES ('S053','Les Carmes - Barbusse',28,8);
INSERT INTO Station VALUES ('S007','Delille',20,7);
INSERT INTO Station VALUES ('S047','Carnot',24,8);
INSERT INTO Station VALUES ('S010','Ballainvilliers',24,8);
INSERT INTO Station VALUES ('S034','République',32,8);
INSERT INTO Station VALUES ('S013','1er mai',24,4);
INSERT INTO Station VALUES ('S035','Cataroux',44,10);
INSERT INTO Station VALUES ('S036','Rodade',16,0);
INSERT INTO Station VALUES ('S017','Hôpital d Estaing',24,9);
INSERT INTO Station VALUES ('S044','Brage',28,11);
INSERT INTO Station VALUES ('S012','Montferrand',24,5);
INSERT INTO Station VALUES ('S043','Chandiots',24,4);
INSERT INTO Station VALUES ('S037','Musée d art Roger Quilliot',20,2);
INSERT INTO Station VALUES ('S042','Les pistes',24,9);
INSERT INTO Station VALUES ('S050','Sabourin',16,6);
INSERT INTO Station VALUES ('S057','Croix de Neyrat',20,7);
INSERT INTO Station VALUES ('S056','Collège Albert Camus',12,6);
INSERT INTO Station VALUES ('S054','La plaine',15,6);
INSERT INTO Station VALUES ('S055','Viviani',20,9);
INSERT INTO Station VALUES ('S003','Universités',31,6);
INSERT INTO Station VALUES ('S009','Chamalières Mairie',20,11);
INSERT INTO Station VALUES ('S024','Dumas',19,2);
INSERT INTO Station VALUES ('S041','Cézeaux Pellez',19,5);
INSERT INTO Station VALUES ('S051','Montjuzet',14,11);
INSERT INTO Station VALUES ('S052','La Glacière',19,1);


INSERT INTO Client VALUES('C001', 'Depardieu', 'Sam', '0761095390', 'samdepardieu@hotmail.com', 18, 'Particulier', 'Gratuit');
INSERT INTO Client VALUES('C002', 'Duclos', 'Timothey', '0603841177', 'timotheyduclos@hotmail.fr', 18, 'Particulier', 'Gratuit');
INSERT INTO Client VALUES('C003', 'Fournie', 'Mathéo', '0659128369', 'matheofournie063@gmail.com', 18, 'Particulier', 'Longue durée');
INSERT INTO Client VALUES('C004', 'Moulin', 'Mathis', '0781959513', 'mathis.moulin121@gmail.com', 18, 'Particulier', 'Gratuit');
INSERT INTO Client VALUES('C005', 'Delage', 'Mathis', '0771175950', 'mathis.dlge.mk@gmail.com', 18, 'Particulier', 'Longue durée');
INSERT INTO Client VALUES('C006', 'Grousseau', 'Mathieu', '0642564946', 'mathieu.grousseau@gmail.com', 18, 'Particulier', 'Gratuit');
INSERT INTO Client VALUES('C007', 'Biard', 'Tom', '0781799744', 'k3l.kgl@gmail.com', 19, 'Particulier', 'Gratuit');
INSERT INTO Client VALUES('C008', 'Van Bradandt', 'Jade', '0637171224', 'illustrerin@gmail.com', 18, 'Particulier', 'Longue durée');
INSERT INTO Client VALUES('C009', 'Eiras', 'Cléo', '0642742244', 'cleo.eiras63@yahoo.fr', 21, 'Particulier', 'Longue durée');
INSERT INTO Client VALUES('C010', 'Sérange', 'Quentin', '0690530961', 'quentin.serange@gmail.com', 19, 'Particulier', 'Gratuit');
INSERT INTO Client VALUES('C011', 'Sérange', 'Antoine', '0692185470', 'antoine.serange@gmail.com', 19, 'Particulier', 'Longue durée');
INSERT INTO Client VALUES('C012', 'Champeau', 'Yann', '0768856359', 'yanto.c3po@gmail.com', 17, 'Particulier', 'Gratuit');
INSERT INTO Client VALUES('C013', 'Azemar', 'Jules', '0761856759', '@uca.iut.fr', 26, 'Professionnel', 'Longue durée');


INSERT INTO Velo VALUES('V001', 'NULL', 'S001', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V002', 'NULL', 'S001', 40, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V003', 'NULL', 'S001', 20, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V004', 'C002', 'S001', 5, 'Réservé', 'Classique');
INSERT INTO Velo VALUES('V005', 'NULL', 'S001', 29, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V006', 'NULL', 'S001', 27, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V007', 'NULL', 'S001', 28, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V008', 'NULL', 'S001', 12, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V009', 'NULL', 'S002', 39, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V010', 'C001', 'S002', 11, 'Réservé', 'Classique');
INSERT INTO Velo VALUES('V011', 'NULL', 'S002', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V012', 'NULL', 'S002', 26, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V013', 'NULL', 'S002', 38, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V014', 'NULL', 'S003', 9, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V015', 'NULL', 'S003', 32, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V016', 'NULL', 'S003', 1, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V017', 'NULL', 'S003', 34, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V018', 'NULL', 'S003', 1, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V019', 'NULL', 'S003', 1, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V020', 'NULL', 'S004', 31, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V021', 'NULL', 'S004', 6, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V022', 'NULL', 'S004', 48, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V023', 'NULL', 'S004', 0, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V024', 'NULL', 'S004', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V025', 'NULL', 'S005', 20, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V026', 'NULL', 'S005', 31, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V027', 'C003', 'S005', 21, 'Réservé', 'Classique');
INSERT INTO Velo VALUES('V028', 'NULL', 'S005', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V029', 'NULL', 'S005', 21, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V030', 'NULL', 'S005', 50, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V031', 'NULL', 'S005', 20, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V032', 'NULL', 'S005', 4, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V033', 'NULL', 'S005', 24, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V034', 'NULL', 'S005', 34, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V035', 'NULL', 'S006', 42, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V036', 'NULL', 'S006', 41, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V037', 'NULL', 'S006', 46, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V038', 'NULL', 'S006', 31, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V039', 'NULL', 'S006', 11, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V040', 'NULL', 'S006', 37, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V041', 'NULL', 'S006', 50, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V042', 'NULL', 'S006', 1, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V043', 'NULL', 'S006', 21, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V044', 'NULL', 'S007', 27, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V045', 'NULL', 'S007', 27, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V046', 'NULL', 'S007', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V047', 'NULL', 'S007', 48, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V048', 'NULL', 'S007', 12, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V049', 'C004', 'S007', 43, 'Réservé', 'Classique');
INSERT INTO Velo VALUES('V050', 'NULL', 'S007', 21, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V051', 'NULL', 'S008', 13, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V052', 'NULL', 'S008', 49, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V053', 'NULL', 'S008', 48, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V054', 'NULL', 'S008', 2, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V055', 'NULL', 'S008', 17, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V056', 'NULL', 'S008', 44, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V057', 'NULL', 'S008', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V058', 'NULL', 'S008', 15, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V059', 'C006', 'S009', 4, 'Réservé', 'Classique');
INSERT INTO Velo VALUES('V060', 'NULL', 'S009', 4, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V061', 'NULL', 'S009', 36, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V062', 'NULL', 'S009', 46, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V063', 'NULL', 'S009', 7, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V064', 'NULL', 'S009', 9, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V065', 'NULL', 'S009', 43, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V066', 'NULL', 'S009', 50, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V067', 'NULL', 'S009', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V068', 'NULL', 'S009', 39, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V069', 'C007', 'S009', 9, 'Réservé', 'Classique');
INSERT INTO Velo VALUES('V070', 'NULL', 'S010', 6, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V071', 'NULL', 'S010', 7, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V072', 'NULL', 'S010', 4, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V073', 'NULL', 'S010', 18, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V074', 'NULL', 'S010', 18, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V075', 'NULL', 'S010', 49, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V076', 'NULL', 'S010', 37, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V077', 'NULL', 'S010', 1, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V078', 'NULL', 'S011', 9, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V079', 'NULL', 'S011', 8, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V080', 'NULL', 'S011', 8, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V081', 'NULL', 'S011', 46, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V082', 'NULL', 'S011', 47, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V083', 'NULL', 'S011', 34, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V084', 'NULL', 'S011', 6, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V085', 'NULL', 'S011', 24, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V086', 'NULL', 'S011', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V087', 'NULL', 'S011', 7, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V088', 'NULL', 'S011', 46, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V089', 'NULL', 'S011', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V090', 'NULL', 'S011', 36, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V091', 'NULL', 'S012', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V092', 'NULL', 'S012', 48, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V093', 'NULL', 'S012', 45, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V094', 'NULL', 'S012', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V095', 'NULL', 'S013', 32, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V096', 'NULL', 'S013', 28, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V097', 'NULL', 'S013', 4, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V098', 'NULL', 'S013', 42, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V099', 'NULL', 'S013', 15, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V100', 'NULL', 'S013', 30, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V101', 'NULL', 'S013', 0, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V102', 'NULL', 'S014', 12, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V103', 'NULL', 'S014', 24, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V104', 'NULL', 'S014', 36, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V105', 'NULL', 'S014', 38, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V106', 'NULL', 'S014', 36, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V107', 'NULL', 'S014', 47, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V108', 'NULL', 'S014', 2, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V109', 'NULL', 'S015', 32, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V110', 'NULL', 'S015', 29, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V111', 'NULL', 'S015', 38, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V112', 'NULL', 'S015', 17, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V113', 'NULL', 'S015', 21, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V114', 'NULL', 'S015', 18, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V115', 'NULL', 'S015', 25, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V116', 'NULL', 'S015', 6, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V117', 'NULL', 'S016', 14, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V118', 'NULL', 'S016', 24, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V119', 'NULL', 'S016', 27, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V120', 'NULL', 'S016', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V121', 'NULL', 'S016', 34, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V122', 'NULL', 'S016', 14, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V123', 'NULL', 'S016', 13, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V124', 'NULL', 'S016', 42, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V125', 'NULL', 'S016', 47, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V126', 'NULL', 'S016', 41, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V127', 'NULL', 'S016', 11, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V128', 'NULL', 'S017', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V129', 'NULL', 'S017', 41, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V130', 'NULL', 'S017', 15, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V131', 'NULL', 'S017', 45, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V132', 'NULL', 'S017', 48, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V133', 'NULL', 'S017', 43, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V134', 'NULL', 'S017', 21, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V135', 'NULL', 'S017', 36, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V136', 'NULL', 'S017', 8, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V137', 'NULL', 'S018', 45, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V138', 'NULL', 'S018', 12, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V139', 'NULL', 'S018', 27, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V140', 'NULL', 'S018', 5, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V141', 'NULL', 'S018', 17, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V142', 'NULL', 'S018', 35, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V143', 'NULL', 'S018', 2, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V144', 'NULL', 'S019', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V145', 'NULL', 'S019', 36, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V146', 'NULL', 'S019', 1, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V147', 'NULL', 'S019', 12, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V148', 'NULL', 'S019', 12, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V149', 'NULL', 'S019', 45, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V150', 'NULL', 'S019', 24, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V151', 'NULL', 'S019', 28, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V152', 'NULL', 'S019', 8, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V153', 'NULL', 'S019', 22, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V154', 'NULL', 'S020', 15, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V155', 'NULL', 'S020', 49, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V156', 'NULL', 'S020', 25, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V157', 'NULL', 'S020', 46, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V158', 'NULL', 'S020', 35, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V159', 'NULL', 'S020', 30, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V160', 'NULL', 'S020', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V161', 'NULL', 'S020', 37, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V162', 'NULL', 'S021', 30, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V163', 'NULL', 'S021', 45, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V164', 'NULL', 'S021', 26, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V165', 'NULL', 'S021', 33, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V166', 'NULL', 'S023', 41, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V167', 'NULL', 'S023', 39, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V168', 'NULL', 'S023', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V169', 'NULL', 'S023', 49, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V170', 'NULL', 'S023', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V171', 'NULL', 'S023', 24, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V172', 'NULL', 'S023', 6, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V173', 'NULL', 'S023', 25, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V174', 'NULL', 'S024', 46, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V175', 'NULL', 'S024', 8, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V176', 'NULL', 'S025', 36, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V177', 'NULL', 'S025', 45, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V178', 'NULL', 'S025', 7, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V179', 'NULL', 'S026', 27, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V180', 'NULL', 'S026', 25, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V181', 'NULL', 'S027', 14, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V182', 'NULL', 'S027', 42, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V183', 'NULL', 'S027', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V184', 'NULL', 'S027', 41, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V185', 'NULL', 'S027', 10, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V186', 'NULL', 'S027', 13, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V187', 'NULL', 'S027', 17, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V188', 'NULL', 'S027', 18, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V189', 'NULL', 'S027', 44, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V190', 'NULL', 'S027', 12, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V191', 'NULL', 'S028', 44, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V192', 'NULL', 'S028', 48, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V193', 'NULL', 'S028', 41, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V194', 'NULL', 'S028', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V195', 'NULL', 'S028', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V196', 'NULL', 'S028', 32, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V197', 'NULL', 'S028', 36, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V198', 'NULL', 'S029', 33, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V199', 'NULL', 'S029', 26, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V200', 'NULL', 'S029', 40, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V201', 'NULL', 'S029', 8, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V202', 'NULL', 'S029', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V203', 'NULL', 'S030', 47, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V204', 'NULL', 'S030', 29, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V205', 'NULL', 'S030', 28, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V206', 'NULL', 'S030', 28, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V207', 'NULL', 'S030', 2, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V208', 'NULL', 'S031', 36, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V209', 'NULL', 'S031', 12, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V210', 'NULL', 'S031', 28, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V211', 'NULL', 'S031', 45, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V212', 'NULL', 'S031', 49, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V213', 'NULL', 'S031', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V214', 'NULL', 'S032', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V215', 'NULL', 'S032', 37, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V216', 'NULL', 'S032', 30, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V217', 'NULL', 'S032', 25, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V218', 'NULL', 'S032', 19, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V219', 'NULL', 'S032', 33, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V220', 'NULL', 'S034', 5, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V221', 'NULL', 'S034', 50, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V222', 'NULL', 'S034', 20, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V223', 'NULL', 'S034', 9, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V224', 'NULL', 'S034', 41, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V225', 'NULL', 'S034', 5, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V226', 'NULL', 'S034', 15, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V227', 'NULL', 'S034', 22, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V228', 'NULL', 'S035', 17, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V229', 'NULL', 'S035', 0, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V230', 'NULL', 'S035', 15, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V231', 'NULL', 'S035', 9, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V232', 'NULL', 'S035', 5, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V233', 'NULL', 'S035', 34, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V234', 'NULL', 'S035', 32, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V235', 'NULL', 'S035', 22, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V236', 'NULL', 'S035', 24, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V237', 'NULL', 'S035', 24, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V238', 'NULL', 'S037', 50, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V239', 'NULL', 'S037', 41, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V240', 'NULL', 'S038', 15, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V241', 'NULL', 'S039', 25, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V242', 'NULL', 'S039', 21, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V243', 'NULL', 'S039', 18, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V244', 'NULL', 'S040', 35, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V245', 'NULL', 'S040', 6, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V246', 'NULL', 'S041', 20, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V247', 'NULL', 'S041', 18, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V248', 'NULL', 'S041', 45, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V249', 'NULL', 'S041', 14, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V250', 'NULL', 'S041', 17, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V251', 'NULL', 'S042', 35, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V252', 'NULL', 'S042', 48, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V253', 'NULL', 'S042', 27, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V254', 'NULL', 'S042', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V255', 'NULL', 'S042', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V256', 'NULL', 'S042', 17, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V257', 'NULL', 'S042', 4, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V258', 'NULL', 'S042', 25, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V259', 'NULL', 'S042', 11, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V260', 'NULL', 'S043', 46, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V261', 'NULL', 'S043', 42, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V262', 'NULL', 'S043', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V263', 'NULL', 'S043', 8, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V264', 'NULL', 'S044', 50, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V265', 'NULL', 'S044', 17, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V266', 'NULL', 'S044', 33, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V267', 'NULL', 'S044', 40, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V268', 'NULL', 'S044', 50, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V269', 'NULL', 'S044', 5, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V270', 'NULL', 'S044', 21, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V271', 'NULL', 'S044', 12, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V272', 'NULL', 'S044', 14, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V273', 'NULL', 'S044', 11, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V274', 'NULL', 'S044', 7, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V275', 'NULL', 'S045', 46, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V276', 'NULL', 'S045', 27, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V277', 'NULL', 'S045', 5, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V278', 'NULL', 'S045', 7, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V279', 'C009', 'S045', 39, 'Réservé', 'Classique');
INSERT INTO Velo VALUES('V280', 'NULL', 'S045', 29, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V281', 'NULL', 'S045', 1, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V282', 'NULL', 'S046', 19, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V283', 'NULL', 'S046', 21, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V284', 'NULL', 'S046', 34, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V285', 'NULL', 'S046', 43, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V286', 'NULL', 'S046', 43, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V287', 'NULL', 'S046', 43, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V288', 'NULL', 'S047', 0, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V289', 'NULL', 'S047', 37, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V290', 'NULL', 'S047', 6, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V291', 'NULL', 'S047', 4, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V292', 'NULL', 'S047', 14, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V293', 'NULL', 'S047', 7, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V294', 'NULL', 'S047', 15, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V295', 'NULL', 'S047', 25, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V296', 'NULL', 'S048', 37, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V297', 'C010', 'S048', 50, 'Réservé', 'Classique');
INSERT INTO Velo VALUES('V298', 'NULL', 'S048', 1, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V299', 'NULL', 'S048', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V300', 'NULL', 'S048', 34, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V301', 'NULL', 'S048', 0, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V302', 'NULL', 'S048', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V303', 'NULL', 'S048', 48, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V304', 'NULL', 'S048', 34, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V305', 'NULL', 'S049', 7, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V306', 'NULL', 'S049', 29, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V307', 'NULL', 'S049', 38, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V308', 'NULL', 'S049', 37, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V309', 'NULL', 'S049', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V310', 'NULL', 'S049', 6, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V311', 'NULL', 'S049', 44, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V312', 'NULL', 'S049', 15, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V313', 'NULL', 'S050', 27, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V314', 'NULL', 'S050', 2, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V315', 'NULL', 'S050', 5, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V316', 'C011', 'S050', 10, 'Réservé', 'Classique');
INSERT INTO Velo VALUES('V317', 'NULL', 'S050', 6, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V318', 'NULL', 'S050', 38, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V319', 'NULL', 'S051', 28, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V320', 'NULL', 'S051', 42, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V321', 'NULL', 'S051', 2, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V322', 'NULL', 'S051', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V323', 'NULL', 'S051', 20, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V324', 'NULL', 'S051', 37, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V325', 'NULL', 'S051', 7, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V326', 'NULL', 'S051', 40, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V327', 'NULL', 'S051', 36, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V328', 'NULL', 'S051', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V329', 'NULL', 'S051', 1, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V330', 'NULL', 'S052', 49, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V331', 'NULL', 'S053', 0, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V332', 'C012', 'S053', 34, 'Réservé', 'Classique');
INSERT INTO Velo VALUES('V333', 'NULL', 'S053', 39, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V334', 'NULL', 'S053', 1, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V335', 'NULL', 'S053', 14, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V336', 'NULL', 'S053', 45, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V337', 'NULL', 'S053', 3, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V338', 'NULL', 'S053', 9, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V339', 'NULL', 'S054', 26, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V340', 'NULL', 'S054', 30, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V341', 'NULL', 'S054', 0, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V342', 'NULL', 'S054', 20, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V343', 'NULL', 'S055', 33, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V344', 'NULL', 'S055', 38, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V345', 'NULL', 'S055', 46, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V346', 'NULL', 'S055', 42, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V347', 'NULL', 'S055', 8, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V348', 'NULL', 'S055', 46, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V349', 'NULL', 'S055', 43, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V350', 'NULL', 'S055', 21, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V351', 'NULL', 'S055', 10, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V352', 'NULL', 'S056', 23, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V353', 'NULL', 'S056', 16, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V354', 'NULL', 'S056', 30, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V355', 'NULL', 'S056', 37, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V356', 'NULL', 'S056', 11, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V357', 'NULL', 'S056', 48, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V358', 'NULL', 'S057', 9, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V359', 'NULL', 'S057', 10, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V360', 'NULL', 'S057', 48, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V361', 'NULL', 'S057', 14, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V362', 'NULL', 'S057', 27, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V363', 'NULL', 'S057', 19, 'Libre', 'Classique');
INSERT INTO Velo VALUES('V364', 'NULL', 'S057', 24, 'Libre', 'Classique');


INSERT INTO Abonnement VALUES('A001', 'C001', 'Gratuit', 'Classique', 'Reduit', '2022-11-12', '2023-10-30', 0, 200);
INSERT INTO Abonnement VALUES('A002', 'C002', 'Gratuit', 'Classique', 'Plein', '2022-11-13', '2023-01-26', 0, 200);
INSERT INTO Abonnement VALUES('A003', 'C003', 'Longue durée', 'Classique', 'Plein', '2022-11-14', '2023-03-22', 80, 200);
INSERT INTO Abonnement VALUES('A004', 'C004', 'Gratuit', 'Classique', 'Plein', '2022-11-14', '2023-01-15', 0, 200);
INSERT INTO Abonnement VALUES('A005', 'C005', 'Longue durée', 'Assistance électrique', 'Reduit', '2022-11-16', '2023-06-17', 60, 350);
INSERT INTO Abonnement VALUES('A006', 'C006', 'Gratuit', 'Classique', 'Plein', '2022-11-17', '2023-01-18', 0, 200);
INSERT INTO Abonnement VALUES('A007', 'C007', 'Gratuit', 'Classique', 'Plein', '2022-11-18', '2023-10-24', 0, 200);
INSERT INTO Abonnement VALUES('A008', 'C008', 'Longue durée', 'Classique', 'Plein', '2022-11-19', '2023-05-26', 80, 200);
INSERT INTO Abonnement VALUES('A009', 'C009', 'Longue durée', 'Assistance électrique pliant', 'Spécifique', '2022-11-20', '2023-01-30', 75, 350);
INSERT INTO Abonnement VALUES('A010', 'C010', 'Gratuit', 'Classique', 'Plein', '2022-11-21', '2023-12-22', 0, 200);
INSERT INTO Abonnement VALUES('A011', 'C011', 'Longue durée', 'Classique', 'Plein', '2022-11-22', '2023-01-25', 80, 200);
INSERT INTO Abonnement VALUES('A012', 'C013', 'Longue durée', 'Assistance électrique', 'Reduit', '2022-11-23', '2023-10-26', 60, 350);
INSERT INTO Abonnement VALUES('A013', 'C012', 'Gratuit', 'Classique', 'Plein', '2022-11-01', '2023-01-02', 0, 200);


INSERT INTO Fournisseur VALUES('F001', 'CVelo', 'Classique', 200);
INSERT INTO Fournisseur VALUES('F002', 'LaFraise Cycles', 'Assistance électrique', 50);
INSERT INTO Fournisseur VALUES('F003', 'Cycles Daniel Cattin', 'Classique', 420);
INSERT INTO Fournisseur VALUES('F004', 'Cycles Pierre Perrin', 'Assistance électrique', 150);
INSERT INTO Fournisseur VALUES('F005', 'Vagabonde Cycles', 'Classique', 300);
INSERT INTO Fournisseur VALUES('F006', 'Alex Singer', 'Assistance électrique pliant', 75);

SELECT * FROM Abonnement;
SELECT * FROM Velo;
SELECT * FROM Fournisseur;
SELECT * FROM Client;
SELECT * FROM Station;

/*
QUESTION 1 ≠ QUESTION 3 ?

1)(Articles peu loué)
    SELECT FROM Velo
    WHERE NbrReserv < 5;

2)
    SELECT SUM(Abonnement.prix)
    FROM Client, Abonnement
    WHERE Client.Statut = "Professionnel" AND Abonnement.IdClient = Client.Id AND CURRENT_DATE-7 > Abonnement.DateDebut;

3)
    SELECT FROM Velo
    WHERE NbrReserv = 0;

4)
    SELECT SUM(Abonnement.prix)
    FROM Client, Abonnement
    WHERE Client.Statut = "Professionnel" AND Abonnement.IdClient = Client.Id;

    SELECT SUM(Abonnement.prix)
    FROM Client, Abonnement
    WHERE Client.Statut = "Particulier" AND Abonnement.IdClient = Client.Id;
*/
