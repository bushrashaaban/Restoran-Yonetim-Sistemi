CREATE DATABASE Restoran_y_s;
GO

USE Restoran_y_s
GO

CREATE TABLE tMusteriler
(
MusterilerID INT IDENTITY (1,1) not null PRIMARY KEY,
İsim NVARCHAR(15) not null,
Soyisim NVARCHAR (30) not null,
Telefon CHAR(10) UNIQUE null,
);
GO

CREATE TABLE tSubeler
(
SubelerID INT IDENTITY (1,1) not null PRIMARY KEY,
Sehir NVARCHAR(10) not null,
CalisanSayisi INT not null

);
GO

CREATE TABLE tPersoneller
(
PersonellerID INT IDENTITY (1,1) not null PRIMARY KEY,
İsim NVARCHAR(15) not null,
Soyisim NVARCHAR(30) not null,
Adres VARCHAR(100) null,
GirisTarihi DATE  not null,
SubelerID_PersonellerID INT, CONSTRAINT FK_SubelerID_PersonellerID FOREIGN KEY (SubelerID_PersonellerID) REFERENCES tSubeler(SubelerID),
);
GO

CREATE TABLE tMasalar
(
MasalarID INT IDENTITY (1,1) not null PRIMARY KEY,
MasaNo INT not null,
SandalyeSayısı INT not null,
SubelerID_MasalarID INT, CONSTRAINT FK_SubelerID_MasalarID FOREIGN KEY (SubelerID_MasalarID) REFERENCES tSubeler(SubelerID),
);
GO

CREATE TABLE tCesitler
(
CesitlerID INT IDENTITY (1,1) not null PRIMARY KEY,
İsim NVARCHAR(127)
);
GO

CREATE TABLE tMenu
(
MenuID INT IDENTITY (1,1) not null PRIMARY KEY,
Fiyat DECIMAL (10,2) not null,
CesitlerID_MenuID INT, CONSTRAINT FK_CesitlerID_MenuID FOREIGN KEY (CesitlerID_MenuID) REFERENCES tCesitler(CesitlerID),

);
GO

CREATE TABLE tSiparisler
(
SiparislerID INT IDENTITY (1,1) not null PRIMARY KEY,
Tarih DATE not null,
MasalarID_SiparislerID INT, CONSTRAINT FK_MasalarID_SiparislerID FOREIGN KEY (MasalarID_SiparislerID) REFERENCES tMasalar(MasalarID),
MusterilerID_SiparislerID INT, CONSTRAINT FK_MusterilerID_SiparislerID FOREIGN KEY (MusterilerID_SiparislerID) REFERENCES tMusteriler(MusterilerID),
PersonellerID_SiparislerID INT, CONSTRAINT FK_PersonellerID_SiparislerID FOREIGN KEY (PersonellerID_SiparislerID) REFERENCES tPersoneller(PersonellerID)
);
GO

CREATE TABLE tSiparisDetayları
(
SiparisDetaylarıID INT IDENTITY (1,1) not null PRIMARY KEY,
Miktar int not null,
SiparislerID_SiparisDetaylarıID INT, CONSTRAINT FK_SiparislerID_SiparisDetaylarıID FOREIGN KEY (SiparislerID_SiparisDetaylarıID) REFERENCES tSiparisler(SiparislerID),
MenuID_SiparisDetaylarıID INT, CONSTRAINT FK_MenuID_SiparisDetaylarıID FOREIGN KEY (MenuID_SiparisDetaylarıID) REFERENCES tMenu(MenuID),
);
GO

CREATE TABLE tDegerlendirmeler
(
DegerlendirmeID INT IDENTITY (1,1) not null PRIMARY KEY,
Yorum NVARCHAR(100),
MusteriID_DegerlendirmelerID INT, CONSTRAINT FK_MusteriID_DegerlendirmelerID FOREIGN KEY (MusteriID_DegerlendirmelerID) REFERENCES tMusteriler(MusterilerID),
SubelerID_DegerlendirmeID INT, CONSTRAINT FK_SubelerID_DegerlendirmeID FOREIGN KEY (SubelerID_DegerlendirmeID) REFERENCES tSubeler(SubelerID),
);

-- VERİ GİRİŞİ (INSERT) İŞLEMLERİ
-- Veri tabanı şeması hazırlandıktan sonra, ilişkileri doğrulamak ve veri akışını görmek için kullanılan örnek veri girişleri:
USE Restoran_y_s
GO 

INSERT INTO tMusteriler(İsim, Soyisim, Telefon)
VALUES ( 'Osman', 'Demir', '5511898408')
GO

INSERT INTO tSubeler(Sehir, CalisanSayisi)
VALUES ( 'Kocaeli', '10')
GO

INSERT INTO tPersoneller(İsim, Soyisim, Adres, GirisTarihi, SubelerID_PersonellerID)
VALUES ( 'Melek', 'Demir', 'Sakarya/Serdivan', '2024', 1)
GO

INSERT INTO tMasalar(MasaNo, SandalyeSayısı, SubelerID_MasalarID)
VALUES ( '7', '6', 1)
GO

INSERT INTO tCesitler(İsim)
VALUES ('Salata')
GO

INSERT INTO tMenu(Fiyat, CesitlerID_MenuID)
VALUES ('150', 1)
GO

INSERT INTO tSiparisler(Tarih, MasalarID_SiparislerID, MusterilerID_SiparislerID, PersonellerID_SiparislerID)
VALUES ('2024-10-20', 1, 1, 1)
GO

INSERT INTO tSiparisDetayları(Miktar, SiparislerID_SiparisDetaylarıID, MenuID_SiparisDetaylarıID)
VALUES ('2', 1, 1)
GO

INSERT INTO tDegerlendirmeler(Yorum, MusteriID_DegerlendirmelerID, SubelerID_DegerlendirmeID)
VALUES ('Çok Beğendim', 1, 1)
GO

/*
-- VERİ TABANI SIFIRLAMA / TEMİZLEME (OPTIONAL RESET)
-- Not: Aşağıdaki kodlar, veritabanını tamamen silmek ve
-- sistemi sıfırlamak istendiğinde kullanılmak üzere hazırlanmıştır.
-- Güvenlik amacıyla yorum satırı haline getirilmiştir.
-- Çalıştırmak için yorum işaretlerini (/* ... */) kaldırınız.
USE Restoran_y_s
GO 

ALTER TABLE tPersoneller
DROP CONSTRAINT FK_SubelerID_PersonellerID
GO

ALTER TABLE tMasalar
DROP CONSTRAINT FK_SubelerID_MasalarID
GO

ALTER TABLE tMenu
DROP CONSTRAINT FK_CesitlerID_MenuID
GO

ALTER TABLE tSiparisler
DROP CONSTRAINT FK_MasalarID_SiparislerID, FK_MusterilerID_SiparislerID, FK_PersonellerID_SiparislerID
GO

ALTER TABLE tSiparisDetayları
DROP CONSTRAINT FK_SiparislerID_SiparisDetaylarıID, FK_MenuID_SiparisDetaylarıID
GO

ALTER TABLE tDegerlendirmeler
DROP CONSTRAINT FK_MusteriID_DegerlendirmelerID, FK_SubelerID_DegerlendirmeID
GO

DROP TABLE tDegerlendirmeler, tSiparisDetayları, tSiparisler, tMenu, tMasalar, tPersoneller, tCesitler, tSubeler, tMusteriler
*/ 
