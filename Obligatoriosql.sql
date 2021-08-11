USE master;
GO

IF exists(SELECT * FROM sysDataBases WHERE name='Obligatorio')
BEGIN
	DROP DATABASE Obligatorio 
END
GO

CREATE DATABASE Obligatorio
ON
(
NAME = Obligatorio,
FILENAME = 'C:\Users\Liam\Desktop\BD_Peliculas-BIOS-master\Obligatorio.mdf'
)
GO

USE Obligatorio
GO

SET NOCOUNT ON

CREATE TABLE Clientes
(
Nombre VARCHAR(20) not null,
Apellido VARCHAR(20) not null,
Direccion VARCHAR(50),
Telefono VARCHAR(20),
Cedula VARCHAR(10) PRIMARY KEY
)

CREATE TABLE ClientesRegistrados
(
Cedula VARCHAR(10) FOREIGN KEY REFERENCES Clientes(Cedula),
TarjCred VARCHAR(12) UNIQUE not null
)

CREATE TABLE ClientesEvaluacion
(
Cedula VARCHAR(10) FOREIGN KEY REFERENCES Clientes(Cedula),
FechCaducidad DATETIME not null
)

set dateformat dmy;

CREATE TABLE Peliculas(
--DROP table Peliculas
Titulo VARCHAR(50) not null,
Genero VARCHAR(20),
FechadEstreno smalldatetime,
Pais VARCHAR(20),
IdPelicula INT IDENTITY (1,1) PRIMARY KEY
)
/*
CREATE TABLE Alquileres
(
IdAlquiler INT IDENTITY (1,1) PRIMARY KEY,
Cedula VARCHAR(10) FOREIGN KEY REFERENCES Clientes(Cedula),
IdPelicula INT FOREIGN KEY REFERENCES Peliculas(IdPelicula),
CostoTotal INT not null,
FechaAlquiler DATETIME not null,
FechaFin DATETIME not null
)*/
set dateformat dmy;
--                           * * * CLIENTES * * *

INSERT Clientes VALUES ('JulitoElUno', 'Pippa', 'Arkano y Bios', '1229', '111') 
INSERT Clientes VALUES ('Carlitos', 'Yaben', 'Pablo De Maria 3030', '9658', '222')
INSERT Clientes VALUES ('Gabole', 'Jorgito', 'Silicon Valley', '8893', '333')
INSERT Clientes VALUES ('Tonga', 'Reino', 'Cuadrilatero 789', '8849', '444')
INSERT Clientes VALUES ('Tinki', 'Winki', 'Tubipapia 1002', '1108', '555')
INSERT Clientes VALUES ('Dipsy', 'Lala', 'Saltadilla 7821', '9874', '666')
INSERT Clientes VALUES ('José María', 'Listortti', 'Jugoloco 2254', '4711', '777')
INSERT Clientes VALUES ('Tony', 'Montana', 'Sicilia 1515', '8874', '888')
INSERT Clientes VALUES ('Jack', 'Sparrow', 'Ñeristown 1038', '4852', '999')
INSERT Clientes VALUES ('Tony', 'Pacheco', 'Propios 124', '2147', '1010')
INSERT Clientes VALUES ('Tony', 'Presidio', 'Ruta 8 km 28', '3681', '1111')
INSERT Clientes VALUES ('Recoba', 'Pechofrio', 'Chicken 1038', '5574', '1212')
INSERT Clientes VALUES ('Laprofe', 'Deallado', 'Lupite 3037', '4887', '1313')
INSERT Clientes VALUES ('Rosita', 'Perez', 'Yaguaron 1515', '1711', '1414')
INSERT Clientes VALUES ('Mongo', 'Lopez', 'Paysandu 1212', '3363', '1515')
INSERT Clientes VALUES ('Luis', 'Suarez', 'El Pistolero 9', '4722', '1616')
INSERT Clientes VALUES ('Liam', 'Perez', 'LiamPerez 2323', '2425', '1717')

--     * * * CLIENTES REGISTRADOS * * *

INSERT ClientesRegistrados VALUES('111', '11') 
INSERT ClientesRegistrados VALUES('222', '22')
INSERT ClientesRegistrados VALUES('333', '33')
INSERT ClientesRegistrados VALUES('444', '44')
INSERT ClientesRegistrados VALUES('555', '55')
INSERT ClientesRegistrados VALUES('666', '66')
INSERT ClientesRegistrados VALUES('777', '77')
INSERT ClientesRegistrados VALUES('888', '88')

--     * * * CLIENTES EVALUACIÓN * * *

INSERT ClientesEvaluacion VALUES('999', '31/08/2021') 
INSERT ClientesEvaluacion VALUES('1010', '11/11/2021')
INSERT ClientesEvaluacion VALUES('1111', '30/04/2021')
INSERT ClientesEvaluacion VALUES('1212', '04/01/2021')
INSERT ClientesEvaluacion VALUES('1313', '22/07/2021')
INSERT ClientesEvaluacion VALUES('1414', '14/06/2021')
INSERT ClientesEvaluacion VALUES('1515', '01/01/2021')
INSERT ClientesEvaluacion VALUES('1616', '07/05/2021')

--        * * * PELÍCULAS * * *
--select*from ClientesEvaluacion
INSERT Peliculas VALUES('Que Paso Ayer 2','Comedia','25/12/2015','Estados Unidos')	 --1
INSERT Peliculas VALUES('Lets be cops','Comedia','25/11/2015','Estados Unidos')		 --2
INSERT Peliculas VALUES('Tarzan','Romantica','25/09/2015','Argentina')				 --3
INSERT Peliculas VALUES('Big Hero','Animada','26/08/2016','Estados Unidos')			 --4
INSERT Peliculas VALUES('Que Paso Ayer 3','Comedia','20/11/2015','Estados Unidos')	 --5
INSERT Peliculas VALUES('Cantinflas','Comedia clásica','25/09/2015','Uruguay')		 --6
INSERT Peliculas VALUES('Ted 2','Comedia','22/12/2015','Mexico')					 --7
INSERT Peliculas VALUES('Un Amor en tiempos de selfie','Drama','25/01/2016','Espana')--8
INSERT Peliculas VALUES('Manya Campeon del Siglo','Documental','23/02/2014','Uruguay')--9

--        * * * ALQUILERES * * *
/*
INSERT Alquileres VALUES('333', 8, 60, '22/02/2021', '28/02/2021')
INSERT Alquileres VALUES('444', 5, 10, '22/02/2021', '23/02/2021')
INSERT Alquileres VALUES('555', 9, 20, '25/05/2021', '27/05/2021')
INSERT Alquileres VALUES('666', 7, 50, '01/01/2021', '06/01/2021')
INSERT Alquileres VALUES('777', 9, 10, '08/08/2021', '09/08/2021')
INSERT Alquileres VALUES('888', 1, 20, '01/11/2021', '03/11/2021')
INSERT Alquileres VALUES('1111', 6, 0, '02/11/2021', '05/11/2021')
INSERT Alquileres VALUES('1616', 4, 0, '01/07/2021', '08/07/2021')
*/


                        ---- *** TOTAL PELICULA POR PERIODO *** ----
GO
/*
CREATE PROCEDURE TOTAL_PELICULA_POR_PERIODO 
--ALTER PROCEDURE TOTAL_PELICULA_POR_PERIODO
@fechaAlquiler DATETIME,
@fechaFin DATETIME
AS 
BEGIN
	SELECT Titulo, SUM(A.CostoTotal) as Ganancia
	FROM Peliculas P inner join Alquileres A ON P.IdPelicula = A.IdPelicula
	WHERE A.FechaAlquiler BETWEEN @fechaAlquiler and @fechaFin 
	GROUP BY Titulo 
	ORDER BY Ganancia DESC
END

--EXECUTE Total_Pelicula_Por_Periodo '01/01/1753', '09/09/2021'



--               ---- *** STREAM MAS RENTABLE *** ----

GO
CREATE PROCEDURE [STREAM MAS RENTABLE]
--ALTER PROCEDURE [STREAM MAS RENTABLE]
AS 
BEGIN
	SELECT TOP 1 P.Titulo, P.IdPelicula, SUM(CostoTotal) as Ganancia 
	FROM Alquileres A inner join Peliculas P ON a.IdPelicula = p.IdPelicula
	GROUP BY P.Titulo, P.IdPelicula 
	ORDER BY Ganancia DESC
END

--EXEC [STREAM MAS RENTABLE]

*/
--               ---- *** Agregar pelicula *** ----
GO

CREATE PROCEDURE AgregarPelicula
--DROP PROCEDURE AgregarPelicula
@titulo varchar(50),
@Genero VARCHAR(20),
@FechadEstreno smalldatetime,
@Pais VARCHAR(20)
AS
BEGIN
       IF exists(SELECT*FROM Peliculas WHERE Titulo = @titulo)
	   BEGIN
	        return -1
	   END
	   ELSE
	   BEGIN
	   DECLARE @Error INT
	   BEGIN TRAN
	   INSERT Peliculas VALUES (@titulo,@Genero,@FechadEstreno,@Pais)
	   SET @Error = @@ERROR;
	   IF(@Error=0)
	   BEGIN
	        COMMIT TRAN;		
			return 1
		END
		ELSE
		BEGIN
		     ROLLBACK TRAN;
			 RETURN -404;
		END
	END
END
/*
declare @resp int
SET @resp = 0
EXECUTE @resp = AgregarPelicula 'TRUENO SAGRADO','Accion','02/05/2003','RUSIA'
IF @resp = 1
         PRINT 'Se cargo exitosamente'
ELSE IF @resp = -1
         PRINT 'Pelicula repetida'
ELSE IF @resp = -404
         PRINT 'Error al ingresar la pelicula'
*/
GO


  ----- *** ACTUALIZAR UNA PELÍCULA *** -----

CREATE PROCEDURE ActualizarPelicula
--DROP PROCEDURE ActualizarPelicula
@idPeli INT,
@titulo varchar(50),
@Genero VARCHAR(20),
@FechadEstreno smalldatetime,
@Pais VARCHAR(20)
AS
BEGIN
     IF(NOT EXISTS(Select*from Peliculas where IdPelicula = @idPeli))
	 BEGIN
	      RETURN -1;
	 END
	 ELSE
BEGIN
     DECLARE @Error int
	 BEGIN TRAN
     UPDATE Peliculas SET Titulo=@titulo,
                          Genero=@Genero,
                          FechadEstreno=@FechadEstreno,
                          Pais= @Pais
                          WHERE idPelicula=@idPeli;
	 SET @Error = @@ERROR;
	 IF(@Error = 0)
	 BEGIN
	      COMMIT TRAN;
		  return 1;
	END
	ELSE
	BEGIN
	       ROLLBACK TRAN;
		   RETURN -2;
	 END
 END

END
/*
declare @resp int
SET @resp = 0
EXECUTE @resp = ActualizarPelicula 10,'FUEGO SAGRADO','AVENTURA','02/05/2003','RUSIA'
IF @resp = 1
         PRINT 'Se ACTUALIZO exitosamente'
ELSE IF @resp = -1 
         PRINT 'Pelicula NO SE ENCUENTRA'
ELSE IF @resp = -2
PRINT 'ERROR AL ACTUALIZAR PELICULA'
*/




             ----- *** ELIMINAR UNA PELÍCULA *** -----
 
 GO
 CREATE PROC EliminarPelicula
 --DROP proc EliminarPelicula
 @IdPelicula INT
 AS
 BEGIN
	DECLARE @errores INT
	IF not exists (SELECT * FROM Peliculas WHERE IdPelicula = @IdPelicula)
		RETURN -1
	BEGIN TRANSACTION
	--IF exists(SELECT * FROM Alquileres WHERE IdPelicula=@IdPelicula)
	--BEGIN
		--DELETE Alquileres WHERE IdPelicula =@IdPelicula
		--SET @errores = @@error
		DELETE Peliculas WHERE IdPelicula = @IdPelicula
		SET @errores = @@error
		IF (@errores = 0)
		BEGIN
			COMMIT TRAN
			RETURN 1
		END
		ELSE
		BEGIN
			ROLLBACK TRAN
			RETURN -404
		END
	--END
END

/*
RETORNA 1 Se EIMINÓ correctamente

DECLARE @resp INT
EXEC @resp = EliminarPelicula '5'
PRINT @resp
-------------------------------------
RETORNA -1 La PELÍCULA NO EXISTE
  
DECLARE @resp INT
EXEC @resp = EliminarPelicula '900'
PRINT @resp
------------------------------------- 
*/


 --         -- *** Ingresar UN Clientes Registrados *** --
 
GO
CREATE PROCEDURE Ingresar_Clientes_Registrados
--DROP PROCEDURE Ingresar_Clientes_Registrados
@Nombre VARCHAR(20),
@Apellido VARCHAR(20),
@Direccion VARCHAR(50),
@Telefono VARCHAR(20),
@Cedula VARCHAR(10),
@TarjetaCredito VARCHAR(12)
AS																					
BEGIN
	DECLARE @errores INT
	SET @errores = 0
	IF  exists (SELECT * FROM Clientes C, ClientesRegistrados CR  WHERE C.Cedula = CR.Cedula AND C.Cedula= @Cedula)
	RETURN -1
	BEGIN TRANSACTION
	BEGIN
	INSERT Clientes VALUES(@Nombre,@Apellido,@Direccion,@Telefono,@Cedula)
	END
	SET @errores = @@ERROR
	IF(@errores = 0)
	BEGIN
	INSERT ClientesRegistrados VALUES(@Cedula,@TarjetaCredito)
	END
	SET @errores = @errores + @@ERROR
	IF(@errores=0)
	BEGIN
	COMMIT TRAN
	RETURN 1
	END
	ELSE
	BEGIN
	ROLLBACK TRANSACTION
	RETURN -404
	END
END

		
	
/*


DECLARE @resp INT
EXEC @resp = Ingresar_Clientes_Registrados 'Emilio','Garrido',' F.Pla 8585',' 995566','5555','0033'
if(@resp = 1)
PRINT 'ingreso correctamente'
ELSE IF(@resp = -1)
print 'cliente ya se encuentra registrado'
ELSE IF (@resp = -404)
print 'error en la transaccion'
------------------------------------------------------
*/

GO

/*BEGIN TRANSACTION
	DELETE FROM ClientesEvaluacion 
	WHERE Cedula = @Cedula
	SET @errores = @@error
	IF (@errores = 0)
	BEGIN
		INSERT INTO ClientesRegistrados VALUES(@Cedula, @TarjetaCredito)
	END
	SET @errores = @errores + @@ERROR
	IF (@errores = 0)
		BEGIN
			COMMIT TRANSACTION
			RETURN 1
		END
		ELSE
		BEGIN
			ROLLBACK TRAN
			RETURN -404
		END
END		
*/


--         -- ***Actualizar Clientes registrado *** --

CREATE PROCEDURE Actualizar_Cliente_Registrado
--DROP PROCEDURE Actualizar_Cliente_Registrado
@Nombre VARCHAR(20),
@Apellido VARCHAR(20),
@Direccion VARCHAR(50),
@Telefono VARCHAR(20),
@Cedula VARCHAR(10),
@TarjCred VARCHAR(12)
AS
BEGIN
     IF(NOT EXISTS(SELECT*FROM Clientes WHERE Cedula = @Cedula))
	 BEGIN
	      RETURN -1
	 END 
	 BEGIN
	 IF (EXISTS(SELECT*FROM ClientesEvaluacion WHERE Cedula = @Cedula))
	 BEGIN
	     RETURN -2
	 END
	 ELSE
	 BEGIN
	 DECLARE @error int

	 BEGIN TRANSACTION
	                  UPDATE Clientes SET Nombre = @NOMBRE,
					                      Apellido = @Apellido,
										  Direccion = @Direccion,
										  Telefono = @Telefono
								    WHERE Cedula = @Cedula
					 SET @error = @@ERROR
					 IF(@error = 0)
					 BEGIN
					 UPDATE ClientesRegistrados SET TarjCred = @TarjCred
					                          WHERE Cedula = @Cedula

					 SET @error = @error + @@ERROR
					 IF(@error = 0)
					 BEGIN
					 COMMIT TRANSACTION
					 RETURN 1
					 END
					 ELSE
					 BEGIN
					 ROLLBACK TRANSACTION
					 RETURN -404
					 END
			   END
	       END
      END
END
/*
DECLARE @RESP INT
EXECUTE @RESP = Actualizar_Cliente_Registrado 'CARLOS','ARIEL','Lauro Muller 4040','63025','222','6523'
if @RESP = 1
   print'se actualizo correctamente'
else if @RESP = -1
   print 'no existe'
else if @RESP = -2
   print 'error EL CLIENTE ES EVALUACION'
else if @RESP = -404
   print 'error en la transaction'
else
   print' error'
*/
--SELECT*FROM Clientes C , ClientesRegistrados CR WHERE C.Cedula = CR.Cedula and CR.Cedula = '222'

GO

--            ---- ****  ELIMINAR CLIENTE REGISTRADO **** ------


CREATE PROCEDURE EliminarClienteRegistrado
--drop procedure EliminarClienteRegistrado
@cedula int
AS
BEGIN
DECLARE @error int
     IF(NOT EXISTS(SELECT*FROM Clientes C, ClientesRegistrados CR WHERE C.Cedula = CR.Cedula AND CR.Cedula = @cedula))
	 BEGIN 
	 RETURN -1;
	 END
	 ELSE
	 BEGIN TRANSACTION
	      DELETE ClientesRegistrados WHERE Cedula = @cedula;
	 SET @error = @@ERROR;
	 IF(@error = 0)
	      DELETE Clientes WHERE Cedula = @cedula;
	 SET @error = @error + @@ERROR
	 IF(@error = 0)
	 BEGIN
	      COMMIT TRAN
		  RETURN 1;
	 END
	 ELSE
	 BEGIN
	      ROLLBACK TRAN
		  RETURN -404;
	 END
 END

 /*
DECLARE @RESP INT
EXECUTE @RESP = EliminarClienteRegistrado 111
IF(@RESP = 1)
PRINT ' EL CLIENTE FUE ELIMINADO'
ELSE IF (@RESP = -1)
PRINT ' NO SE ENCONTRO CLIENTE'
ELSE IF (@RESP = -44)
PRINT'ERROR EN LA TRANSACCION'
*/




 --         -- *** REGISTRAR UN Clientes Evaluacion *** --
GO

CREATE PROCEDURE RegistrarEvaluacion
--DROP PROCEDURE RegistrarEvaluacion
@Cedula VARCHAR(10),
@FechCaducidad smalldatetime
AS																					
BEGIN
	DECLARE @errores INT
	SET @errores = 0
	IF not exists (SELECT * FROM Clientes WHERE Cedula = @Cedula)
		RETURN -1
	IF exists (SELECT * FROM ClientesRegistrados WHERE Cedula = @Cedula)
		RETURN -2
    IF (exists(SELECT*FROM ClientesEvaluacion WHERE Cedula = @Cedula and @FechCaducidad < GETDATE()))
	    RETURN -4
	IF (exists(SELECT*FROM ClientesEvaluacion WHERE Cedula = @Cedula and FechCaducidad = @FechCaducidad))
	    RETURN -3 
	
		
	BEGIN TRANSACTION
	BEGIN
		INSERT INTO ClientesEvaluacion VALUES(@Cedula, @FechCaducidad)
	END
	SET @errores = @@error
	IF (@errores = 0)
		BEGIN
			COMMIT TRANSACTION
			RETURN 1
		END
		ELSE
		BEGIN
			ROLLBACK TRAN
			RETURN -404
		END
END	
/*
RETORNA 1 Registro EXITOSO

DECLARE @resp INT
EXEC @resp = RegistrarEvaluacion '1717', '01/11/2021'
PRINT @resp
------------------------------------------------------
RETORNA -1 La Cédula NO pertenece a ningun cliente

DECLARE @resp INT
EXEC @resp = RegistrarEvaluacion '789456123', '12/02/2020'
PRINT @resp
------------------------------------------------------
RETORNA -2 EL Cliente YA ES Registrado

DECLARE @resp INT
EXEC @resp = RegistrarEvaluacion '999', '31/08/2016'
PRINT @resp
------------------------------------------------------
RETORNA -3 EL Cliente ya esta registrado como evaluacion

DECLARE @resp INT
EXEC @resp = RegistrarEvaluacion '999', '31/08/2016'
PRINT @resp

------------------------------------------------------
RETORNA -4 EL Cliente YA ES Registrado PERO  TIENE VENCIDO SU EVALUACION

DECLARE @resp INT
EXEC @resp = RegistrarEvaluacion '999', '31/08/2016'
PRINT @resp
------------------------------------------------------
*/

GO

--            ---- **** ACTUALIZAR CLIENTE EVALUACION **** ----

CREATE PROCEDURE ActualizarClienteEvaluacion
--DROP PROCEDURE ActualizarClienteEvaluacion
@Nombre VARCHAR(20),
@Apellido VARCHAR(20),
@Direccion VARCHAR(50),
@Telefono VARCHAR(20),
@Cedula VARCHAR(10),
@FechCaducidad DATETIME
AS
BEGIN
     IF(NOT EXISTS(SELECT*FROM Clientes C,ClientesEvaluacion CE WHERE C.Cedula = CE.Cedula AND CE.Cedula = @Cedula))
	 BEGIN
	 RETURN -1;
	 END
	 ELSE 
	 DECLARE @error int
	 BEGIN TRANSACTION
	                   UPDATE Clientes SET Nombre = @Nombre,
					                       Apellido = @Apellido,
										   Direccion = @Direccion,
										   Telefono = @Telefono
										   WHERE Cedula = @Cedula
	SET @error = @@ERROR
	IF(@error = 0)
	                   UPDATE ClientesEvaluacion SET FechCaducidad = @FechCaducidad
					                       WHERE Cedula = @Cedula
    SET @error = @error + @@ERROR
	IF(@error = 0)
	BEGIN
	COMMIT TRAN 
	RETURN 1;
	END
	ELSE 
	BEGIN
	ROLLBACK TRAN
	RETURN -404;
  END
END	                  
/*
DECLARE @RESP INT
EXECUTE @RESP = ActualizarClienteEvaluacion 'ROBERTO','CASTILLOS','GRECIA 2525','66330','999','29/07/2021'
IF(@RESP = 1)
PRINT ' CLIENTE ACTUALIZADO'
ELSE IF (@RESP = -1)
PRINT'CLIENTE NO EXISTE'
ELSE IF(@RESP = -404)
PRINT 'ERROR EN LA TRANSACCION'
*/

GO


CREATE PROCEDURE EliminrClienteEvaluacion
--DROP PROCEDURE EliminrClienteEvaluacion
@cedula int
AS
BEGIN
     IF(NOT EXISTS(SELECT*FROM Clientes C , ClientesEvaluacion CE WHERE C.Cedula = CE.Cedula AND CE.Cedula = @cedula))
	 BEGIN
	 RETURN -1;
	 END
	 ELSE 
	 DECLARE @ERROR INT
	 BEGIN TRANSACTION
	                  DELETE ClientesEvaluacion WHERE Cedula = @cedula
	 SET @ERROR = @@ERROR
	 IF(@ERROR = 0)
	                  DELETE Clientes WHERE Cedula = @cedula
	SET @ERROR = @ERROR + @@ERROR
	IF(@ERROR = 0)
	BEGIN
	COMMIT TRAN
	RETURN 1;
	END
	ELSE
	BEGIN
	ROLLBACK TRAN
	RETURN -404;
	END
END
/*
DECLARE @RESP INT
EXECUTE @RESP = EliminrClienteEvaluacion 1212
IF(@RESP = 1)
PRINT'CLIENTE ELIMINADO'
ELSE IF(@RESP=-1)
PRINT'CLIENTE NO EXIXTE'
ELSE IF (@RESP = -404)
PRINT' ERROR EN LA TRANSACCION'
*/
GO







--          ---- *** AGREGAR ALQUILER *** ----



/*
CREATE PROCEDURE AgregarAlquiler
--ALTER PROCEDURE AgregarAlquiler
@Cedula INT, 
@IdPelicula INT, 
@fechaInicio DATETIME,
@fechaFin DATETIME
AS
BEGIN
	declare @CostoTotal INT
	IF not exists (SELECT * FROM Clientes WHERE Cedula = @Cedula)
		RETURN -1
	ELSE IF not exists (SELECT * FROM Peliculas WHERE IdPelicula = @IdPelicula) 
		RETURN -2
	ELSE IF (@fechaInicio > @fechaFin)
		RETURN -3
	IF exists (SELECT * FROM ClientesRegistrados WHERE Cedula = @Cedula)
	BEGIN
		SELECT @CostoTotal = Precio *(DATEDIFF (DAY, @fechaInicio, @fechaFin ))
		FROM Peliculas
		INSERT Alquileres VALUES(@Cedula, @IdPelicula, @CostoTotal, @fechaInicio, @fechaFin)
		RETURN 1
	END
	IF exists (SELECT * FROM ClientesEvaluacion WHERE Cedula = @Cedula)
	BEGIN	
		INSERT Alquileres VALUES(@Cedula, @IdPelicula, 0, @fechaInicio, @fechaFin)
		RETURN 1
	END
END*/

/*
RETORNA 1 Alquiler Agregado

------------------ALQUILER DE CLIENTE REGISTRADO-----------------
DECLARE @resp INT
EXEC @resp = AgregarAlquiler '222', 3, '01/01/2015', '02/01/2015'
PRINT @resp

------ALQUILER DE CLIENTE DE EVALUACIÓN, GENERA GANANCIA 0-------
DECLARE @resp INT
EXEC @resp = AgregarAlquiler '1212', 2, '02/02/2015', '03/02/2015'
PRINT @resp
-----------------------------------------------------------------
RETORNA -1 Cédula inexistente en el sistema

DECLARE @resp INT
EXEC @resp = AgregarAlquiler '789456123', 6, '01/01/2015', '02/01/2015'
PRINT @resp
-----------------------------------------------------------------
RETORNA -2 Id de Película inexistente

DECLARE @resp INT
EXEC @resp = AgregarAlquiler '777', 999999, '01/01/2015', '02/01/2015'
PRINT @resp
-----------------------------------------------------------------
RETORNA -3 Fecha de alquiler es posterior a la fecha de finalización

DECLARE @resp INT
EXEC @resp = AgregarAlquiler '444', 3, '06/08/2015', '02/08/2015'
PRINT @resp
*/


