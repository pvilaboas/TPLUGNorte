USE [master]
GO
/****** Object:  Database [UAI_Biblioteca]    Script Date: 29/11/2018 8:28:25 ******/
CREATE DATABASE [UAI_Biblioteca] ON  PRIMARY 
( NAME = N'UAI_Biblioteca', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLSERVER_2014\MSSQL\DATA\UAI_Biblioteca.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'UAI_Biblioteca_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLSERVER_2014\MSSQL\DATA\UAI_Biblioteca_log.ldf' , SIZE = 4224KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UAI_Biblioteca].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UAI_Biblioteca] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET ARITHABORT OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [UAI_Biblioteca] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UAI_Biblioteca] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UAI_Biblioteca] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UAI_Biblioteca] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UAI_Biblioteca] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UAI_Biblioteca] SET RECOVERY FULL 
GO
ALTER DATABASE [UAI_Biblioteca] SET  MULTI_USER 
GO
ALTER DATABASE [UAI_Biblioteca] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UAI_Biblioteca] SET DB_CHAINING OFF 
GO
USE [UAI_Biblioteca]
GO
/****** Object:  User [biblioteca]    Script Date: 29/11/2018 8:28:25 ******/
CREATE USER [biblioteca] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'biblioteca'
GO
sys.sp_addrolemember @rolename = N'db_accessadmin', @membername = N'biblioteca'
GO
sys.sp_addrolemember @rolename = N'db_securityadmin', @membername = N'biblioteca'
GO
sys.sp_addrolemember @rolename = N'db_ddladmin', @membername = N'biblioteca'
GO
sys.sp_addrolemember @rolename = N'db_backupoperator', @membername = N'biblioteca'
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'biblioteca'
GO
sys.sp_addrolemember @rolename = N'db_datawriter', @membername = N'biblioteca'
GO
sys.sp_addrolemember @rolename = N'db_denydatareader', @membername = N'biblioteca'
GO
sys.sp_addrolemember @rolename = N'db_denydatawriter', @membername = N'biblioteca'
GO
/****** Object:  StoredProcedure [dbo].[adicional_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[adicional_Agregar]
	@cod_biblioteca		char(3),
    @cod_obra			int,
    @cod_imagen			char(22),
    @principal			int,
    @cod_localizacion	char(3),
    @alias				char(15),
    @nombre				varchar(64),
    @cod_tipo_archivo	int,
    @descripcion		varchar(60),
    @principal_imprenta	int,
    @cod_habilitacion	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_biblioteca from adicional where cod_biblioteca=@cod_biblioteca

	if (@existe is null)begin
	
		INSERT INTO [dbo].[adicional]
           ([cod_biblioteca]
           ,[cod_obra]
           ,[cod_imagen]
           ,[principal]
           ,[cod_localizacion]
           ,[alias]
           ,[nombre]
           ,[cod_tipo_archivo]
           ,[descripcion]
           ,[principal_imprenta]
           ,[cod_habilitacion])
     VALUES
           (@cod_biblioteca
           ,@cod_obra
           ,@cod_imagen
           ,@principal
           ,@cod_localizacion
           ,@alias
           ,@nombre
           ,@cod_tipo_archivo
           ,@descripcion
           ,@principal_imprenta
           ,@cod_habilitacion)
	end
	else begin
			UPDATE [dbo].[adicional]
			SET [cod_biblioteca] = @cod_biblioteca
				,[cod_obra] = @cod_obra
				,[cod_imagen] = @cod_imagen
				,[principal] = @principal
				,[cod_localizacion] = @cod_localizacion
				,[alias] = @alias
				,[nombre] = @nombre
				,[cod_tipo_archivo] = @cod_tipo_archivo
				,[descripcion] = @descripcion
				,[principal_imprenta] = @principal_imprenta
				,[cod_habilitacion] = @cod_habilitacion
			WHERE cod_biblioteca = @cod_biblioteca
			and cod_imagen = @cod_imagen
			and cod_obra = @cod_obra

	end
END

GO
/****** Object:  StoredProcedure [dbo].[adicional_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[adicional_Borrar]
	@cod_biblioteca		char(3),
    @cod_obra			int,
    @cod_imagen			char(22)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
			UPDATE [dbo].[adicional]
			SET [cod_habilitacion] = 0
			WHERE cod_biblioteca = @cod_biblioteca
			and cod_imagen = @cod_imagen
			and cod_obra = @cod_obra

END

GO
/****** Object:  StoredProcedure [dbo].[adicional_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[adicional_Traer]
	@cod_biblioteca		char(3),
    @cod_obra			int,
    @cod_imagen			char(22)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
			SELECT [cod_biblioteca]
				,[cod_obra]
				,[cod_imagen]
				,[principal]
				,[cod_localizacion]
				,[alias]
				,[nombre]
				,[cod_tipo_archivo]
				,[descripcion]
				,[principal_imprenta]
				,[cod_habilitacion]
			FROM [dbo].[adicional]
			WHERE cod_biblioteca = @cod_biblioteca
			and cod_imagen = @cod_imagen
			and cod_obra = @cod_obra

END

GO
/****** Object:  StoredProcedure [dbo].[adicional_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[adicional_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
			SELECT [cod_biblioteca]
				,[cod_obra]
				,[cod_imagen]
				,[principal]
				,[cod_localizacion]
				,[alias]
				,[nombre]
				,[cod_tipo_archivo]
				,[descripcion]
				,[principal_imprenta]
				,[cod_habilitacion]
			FROM [dbo].[adicional]

END

GO
/****** Object:  StoredProcedure [dbo].[autoridad_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================

CREATE PROCEDURE [dbo].[autoridad_Agregar]
	@cod_autoridad				int, 
	@nombre						varchar(50), 
	@apellido					varchar(50), 
	@responsable				varchar(50),
	@lugar						varchar(50), 
	@cod_pais					char(2), 
	@cod_idioma					char(2), 
	@notas						varchar(1000),
	@fecha_fallecimiento		date, 
	@fecha_naciemiento			date, 
	@numero						int, 
	@anio						int,
	@fuente						varchar(50), 
	@norma_fuente				varchar(50), 
	@fecha_fuente				date, 
	@observaciones				varchar(500),
	@fecha_ingreso				datetime, 
	@fecha_modificacion			datetime, 
	@operador_ingreso			int, 
	@operador_modificacion		int
AS
BEGIN
	SET NOCOUNT ON;

	Declare @existe int;
	select @existe=cod_autoridad from autoridad where cod_autoridad = @cod_autoridad


	if (@existe is null)begin

			INSERT INTO [dbo].[autoridad]
						([cod_autoridad]
			           ,[nombre]
			           ,[apellido]
			           ,[responsable]
			           ,[lugar]
			           ,[cod_pais]
			           ,[cod_idioma]
			           ,[notas]
			           ,[fecha_fallecimiento]
			           ,[fecha_nacimiento]
			           ,[numero]
			           ,[anio]
			           ,[fuente]
			           ,[norma_fuente]
			           ,[fecha_fuente]
			           ,[observaciones]
			           ,[fecha_ingreso]
			           ,[fecha_modificacion]
			           ,[operador_ingreso]
			           ,[operador_modificacion])
		     VALUES
			           (@cod_autoridad
					   , @nombre
					   , @apellido
					   , @responsable
					   , @lugar
					   , @cod_pais
					   , @cod_idioma
					   , @notas
					   , @fecha_fallecimiento
					   , @fecha_naciemiento
					   , @numero
					   , @anio
					   , @fuente
					   , @norma_fuente
					   , @fecha_fuente
					   , @observaciones
					   , @fecha_ingreso
					   , @fecha_modificacion
					   , @operador_ingreso
					   , @operador_modificacion)
	end
	else begin

				UPDATE [dbo].[autoridad]
				   SET	[nombre] = @nombre
						,[apellido] = @apellido
						,[responsable] = @responsable
						,[lugar] = @lugar
						,[cod_pais] = @cod_pais
						,[cod_idioma] = @cod_idioma
						,[notas] = @notas
						,[fecha_fallecimiento] = @fecha_fallecimiento
						,[fecha_nacimiento] = @fecha_naciemiento
						,[numero] = @numero
						,[anio] = @anio
						,[fuente] = @fuente
						,[norma_fuente] = @norma_fuente
						,[fecha_fuente] = @fecha_fuente
						,[observaciones] = @observaciones
						,[fecha_ingreso] = @fecha_ingreso
						,[fecha_modificacion] = @fecha_modificacion
						,[operador_ingreso] = @operador_ingreso
						,[operador_modificacion] = @operador_modificacion
				 WHERE cod_autoridad = @cod_autoridad
	end
END

GO
/****** Object:  StoredProcedure [dbo].[autoridad_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================

CREATE PROCEDURE [dbo].[autoridad_Traer]
	@cod_autoridad int
AS
BEGIN
	SET NOCOUNT ON;
		
SELECT [cod_autoridad]
      ,[nombre]
      ,[apellido]
      ,[responsable]
      ,[lugar]
      ,[cod_pais]
      ,[cod_idioma]
      ,[notas]
      ,[fecha_fallecimiento]
      ,[fecha_nacimiento]
      ,[numero]
      ,[anio]
      ,[fuente]
      ,[norma_fuente]
      ,[fecha_fuente]
      ,[observaciones]
      ,[fecha_ingreso]
      ,[fecha_modificacion]
      ,[operador_ingreso]
      ,[operador_modificacion]
  FROM [dbo].[autoridad]
  WHERE cod_autoridad = @cod_autoridad	
END
GO
/****** Object:  StoredProcedure [dbo].[autoridad_TraerTodos]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================

CREATE PROCEDURE [dbo].[autoridad_TraerTodos]
	@cod_autoridad int
AS
BEGIN

	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
SELECT *
  FROM [dbo].[autoridad]
END
GO
/****** Object:  StoredProcedure [dbo].[bitacora_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[bitacora_Agregar]
	@cod_entidad	nvarchar(50),
    @entidad		nvarchar(50),
    @operacion		nvarchar(50),
    @detalle		nvarchar(200),
    @fecha			datetime,
    @cod_operador	nvarchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_entidad from bitacora where cod_entidad=@cod_entidad

	if (@existe is null)begin
	
		INSERT INTO [dbo].[bitacora]
           ([cod_entidad]
           ,[entidad]
           ,[operacion]
           ,[detalle]
           ,[fecha]
           ,[cod_operador])
     VALUES
           (@cod_entidad
           ,@entidad
           ,@operacion
           ,@detalle
           ,@fecha
           ,@cod_operador)
	end
	else begin
		UPDATE [dbo].[bitacora]
		SET [cod_entidad] = @cod_entidad
			,[entidad] = @entidad
			,[operacion] = @operacion
			,[detalle] = @detalle
			,[fecha] = @fecha
			,[cod_operador] = @cod_operador
		WHERE cod_entidad = @cod_entidad
	end
END

GO
/****** Object:  StoredProcedure [dbo].[bitacora_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[bitacora_Traer]
	@cod_entidad	nvarchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_entidad]
      ,[entidad]
      ,[operacion]
      ,[detalle]
      ,[fecha]
      ,[cod_operador]
	FROM [dbo].[bitacora]
		WHERE cod_entidad = @cod_entidad

END

GO
/****** Object:  StoredProcedure [dbo].[bitacora_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[bitacora_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_entidad]
      ,[entidad]
      ,[operacion]
      ,[detalle]
      ,[fecha]
      ,[cod_operador]
	FROM [dbo].[bitacora]

END

GO
/****** Object:  StoredProcedure [dbo].[clasificador_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[clasificador_Agregar]
	@cod_clasificador		int,
	@fuente					varchar(50),
    @clasificador_decimal	varchar(50),
    @observaciones			varchar(2000),
    @tipo_clasificador		int,
    @cod_habilitacion		int,
    @fecha_ingreso			datetime,
    @fecha_modificacion		datetime,
    @operador_ingreso		nvarchar(50),
    @operador_modificacion	nvarchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_clasificador from clasificador where cod_clasificador=@cod_clasificador

	if (@existe is null)begin
	
		INSERT INTO [dbo].[clasificador]
           ([fuente]
           ,[clasificador_decimal]
           ,[observaciones]
           ,[tipo_clasificador]
           ,[cod_habilitacion]
           ,[fecha_ingreso]
           ,[fecha_modificacion]
           ,[operador_ingreso]
           ,[operador_modificacion])
     VALUES
           (@fuente
           ,@clasificador_decimal
           ,@observaciones
           ,@tipo_clasificador
           ,@cod_habilitacion
           ,@fecha_ingreso
           ,@fecha_modificacion
           ,@operador_ingreso
           ,@operador_modificacion)
	end
	else begin
		UPDATE [dbo].[clasificador]
   SET [fuente] = @fuente
      ,[clasificador_decimal] = @clasificador_decimal
      ,[observaciones] = @observaciones
      ,[tipo_clasificador] = @tipo_clasificador
      ,[cod_habilitacion] = @cod_habilitacion
      ,[fecha_ingreso] = @fecha_ingreso
      ,[fecha_modificacion] = @fecha_modificacion
      ,[operador_ingreso] = @operador_ingreso
      ,[operador_modificacion] = @operador_modificacion
	WHERE cod_clasificador = @cod_clasificador
	end
END

GO
/****** Object:  StoredProcedure [dbo].[clasificador_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[clasificador_Borrar]
	@cod_clasificador		int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		UPDATE [dbo].[clasificador]
   SET [cod_habilitacion] = 0
	WHERE cod_clasificador = @cod_clasificador

END

GO
/****** Object:  StoredProcedure [dbo].[clasificador_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[clasificador_Traer]
	@cod_clasificador		int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_clasificador]
      ,[fuente]
      ,[clasificador_decimal]
      ,[observaciones]
      ,[tipo_clasificador]
      ,[cod_habilitacion]
      ,[fecha_ingreso]
      ,[fecha_modificacion]
      ,[operador_ingreso]
      ,[operador_modificacion]
  FROM [dbo].[clasificador]
	WHERE cod_clasificador = @cod_clasificador

END

GO
/****** Object:  StoredProcedure [dbo].[clasificador_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[clasificador_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_clasificador]
      ,[fuente]
      ,[clasificador_decimal]
      ,[observaciones]
      ,[tipo_clasificador]
      ,[cod_habilitacion]
      ,[fecha_ingreso]
      ,[fecha_modificacion]
      ,[operador_ingreso]
      ,[operador_modificacion]
  FROM [dbo].[clasificador]

END

GO
/****** Object:  StoredProcedure [dbo].[ejemplar_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[ejemplar_Agregar]
	@cod_inventario			int,
	@cod_localizacion		char(3),
	@biblioteca_cod			char(1),
	@obra_cod				int,
	@signatura_topografica	varchar(50),
	@cod_prestamo			int,
	@disponible				int,
	@cod_proveedor			int,
	@precio					varchar(50),
	@cod_modena				int,
	@fecha_adquisicion		datetime,
    @condicion_adquisicion varchar(50),
    @cod_estado				int,
    @cod_habilitacion		int,
    @observaciones			varchar(1000),
    @destino				varchar(25),
    @extra					varchar(500),
    @fecha_ingreso			datetime,
    @fecha_modificado		datetime,
    @operador_ingreso		int,
    @operador_modificado	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_inventario from ejemplar where cod_inventario=@cod_inventario

	if (@existe is null)begin
	
		INSERT INTO [dbo].[ejemplar]
           ([cod_inventario]
           ,[cod_localizacion]
           ,[biblioteca_cod]
           ,[obra_cod]
           ,[signatura_topografica]
           ,[cod_prestamo]
           ,[disponible]
           ,[cod_proveedor]
           ,[precio]
           ,[cod_modena]
           ,[fecha_adquisicion]
           ,[condicion_adquisicion]
           ,[cod_estado]
           ,[cod_habilitacion]
           ,[observaciones]
           ,[destino]
           ,[extra]
           ,[fecha_ingreso]
           ,[fecha_modificado]
           ,[operador_ingreso]
           ,[operador_modificado])
     VALUES
           (@cod_inventario
           ,@cod_localizacion
           ,@biblioteca_cod
           ,@obra_cod
           ,@signatura_topografica
           ,@cod_prestamo
           ,@disponible
           ,@cod_proveedor
           ,@precio
           ,@cod_modena
           ,@fecha_adquisicion
           ,@condicion_adquisicion
           ,@cod_estado
           ,@cod_habilitacion
           ,@observaciones
           ,@destino
           ,@extra
           ,@fecha_ingreso
           ,@fecha_modificado
           ,@operador_ingreso
           ,@operador_modificado)
	end
	else begin
			UPDATE [dbo].[ejemplar]
			SET [cod_inventario] = @cod_inventario
			,[cod_localizacion] = @cod_localizacion
			,[biblioteca_cod] = @biblioteca_cod
			,[obra_cod] = @obra_cod
			,[signatura_topografica] = @signatura_topografica
			,[cod_prestamo] = @cod_prestamo
			,[disponible] = @disponible
			,[cod_proveedor] = @cod_proveedor
			,[precio] = @precio
			,[cod_modena] = @cod_modena
			,[fecha_adquisicion] = @fecha_adquisicion
			,[condicion_adquisicion] = @condicion_adquisicion
			,[cod_estado] = @cod_estado
			,[cod_habilitacion] = @cod_habilitacion
			,[observaciones] = @observaciones
			,[destino] = @destino
			,[extra] = @extra
			,[fecha_ingreso] = @fecha_ingreso
			,[fecha_modificado] = @fecha_modificado
			,[operador_ingreso] = @operador_ingreso
			,[operador_modificado] = @operador_modificado
		WHERE cod_inventario = @cod_inventario

	end
END

GO
/****** Object:  StoredProcedure [dbo].[ejemplar_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[ejemplar_Borrar]
	@cod_inventario			int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
			UPDATE [dbo].[ejemplar]
			SET [cod_habilitacion] = 0
		WHERE cod_inventario = @cod_inventario
END

GO
/****** Object:  StoredProcedure [dbo].[ejemplar_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[ejemplar_Traer]
	@cod_inventario			int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT [cod_inventario]
      ,[cod_localizacion]
      ,[biblioteca_cod]
      ,[obra_cod]
      ,[signatura_topografica]
      ,[cod_prestamo]
      ,[disponible]
      ,[cod_proveedor]
      ,[precio]
      ,[cod_modena]
      ,[fecha_adquisicion]
      ,[condicion_adquisicion]
      ,[cod_estado]
      ,[cod_habilitacion]
      ,[observaciones]
      ,[destino]
      ,[extra]
      ,[fecha_ingreso]
      ,[fecha_modificado]
      ,[operador_ingreso]
      ,[operador_modificado]
	FROM [dbo].[ejemplar]
		WHERE cod_inventario = @cod_inventario
END

GO
/****** Object:  StoredProcedure [dbo].[ejemplar_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[ejemplar_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_inventario]
      ,[cod_localizacion]
      ,[biblioteca_cod]
      ,[obra_cod]
      ,[signatura_topografica]
      ,[cod_prestamo]
      ,[disponible]
      ,[cod_proveedor]
      ,[precio]
      ,[cod_modena]
      ,[fecha_adquisicion]
      ,[condicion_adquisicion]
      ,[cod_estado]
      ,[cod_habilitacion]
      ,[observaciones]
      ,[destino]
      ,[extra]
      ,[fecha_ingreso]
      ,[fecha_modificado]
      ,[operador_ingreso]
      ,[operador_modificado]
	FROM [dbo].[ejemplar]

END

GO
/****** Object:  StoredProcedure [dbo].[idioma_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[idioma_Agregar]
	@cod_idioma			char(2),
    @detalle			varchar(50),
    @registro_estado_cod	int,
    @fecha_ingreso		datetime,
    @fecha_modificacion	datetime,
    @operador_ingreso	int,
    @operador_modificacion	int,
    @cod_habilitacion	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_idioma from idioma where cod_idioma=@cod_idioma

	if (@existe is null)begin
	
		INSERT INTO [dbo].[idioma]
           ([cod_idioma]
           ,[detalle]
           ,[registro_estado_cod]
           ,[fecha_ingreso]
           ,[fecha_modificacion]
           ,[operador_ingreso]
           ,[operador_modificacion]
           ,[cod_habilitacion])
     VALUES
           (@cod_idioma
           ,@detalle
           ,@registro_estado_cod
           ,@fecha_ingreso
           ,@fecha_modificacion
           ,@operador_ingreso
           ,@operador_modificacion
           ,@cod_habilitacion)
	end
	else begin
			UPDATE [dbo].[idioma]
		SET [cod_idioma] = @cod_idioma
			,[detalle] = @detalle
			,[registro_estado_cod] = @registro_estado_cod
			,[fecha_ingreso] = @fecha_ingreso
			,[fecha_modificacion] = @fecha_modificacion
			,[operador_ingreso] = @operador_ingreso
			,[operador_modificacion] = @operador_modificacion
			,[cod_habilitacion] = @cod_habilitacion
		WHERE cod_idioma = @cod_idioma

	end
END

GO
/****** Object:  StoredProcedure [dbo].[idioma_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[idioma_Borrar]
	@cod_idioma			char(2)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
			UPDATE [dbo].[idioma]
		SET [cod_habilitacion] = 0
		WHERE cod_idioma = @cod_idioma
END

GO
/****** Object:  StoredProcedure [dbo].[idioma_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[idioma_Traer]
	@cod_idioma			char(2)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT [cod_idioma]
      ,[detalle]
      ,[registro_estado_cod]
      ,[fecha_ingreso]
      ,[fecha_modificacion]
      ,[operador_ingreso]
      ,[operador_modificacion]
      ,[cod_habilitacion]
		FROM [dbo].[idioma]
		WHERE cod_idioma = @cod_idioma
END

GO
/****** Object:  StoredProcedure [dbo].[idioma_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[idioma_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT [cod_idioma]
      ,[detalle]
      ,[registro_estado_cod]
      ,[fecha_ingreso]
      ,[fecha_modificacion]
      ,[operador_ingreso]
      ,[operador_modificacion]
      ,[cod_habilitacion]
		FROM [dbo].[idioma]

END

GO
/****** Object:  StoredProcedure [dbo].[lista_encabezamiento_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_encabezamiento_Agregar]
	@cod_encabezamiento	int,
    @detalle			varchar(60)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_encabezamiento from lista_encabezamiento where cod_encabezamiento=@cod_encabezamiento

	if (@existe is null)begin
	
		INSERT INTO [dbo].[lista_encabezamiento]
           ([cod_encabezamiento]
           ,[detalle])
     VALUES
           (@cod_encabezamiento
           ,@detalle)
	end
	else begin
		UPDATE [dbo].[lista_encabezamiento]
		SET [cod_encabezamiento] = @cod_encabezamiento
			,[detalle] = @detalle
		WHERE cod_encabezamiento = @cod_encabezamiento
	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_encabezamiento_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_encabezamiento_Traer]
	@cod_encabezamiento	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_encabezamiento]
      ,[detalle]
	FROM [dbo].[lista_encabezamiento]
		WHERE cod_encabezamiento = @cod_encabezamiento

END

GO
/****** Object:  StoredProcedure [dbo].[lista_encabezamiento_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_encabezamiento_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_encabezamiento]
      ,[detalle]
	FROM [dbo].[lista_encabezamiento]

END

GO
/****** Object:  StoredProcedure [dbo].[lista_estado_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_estado_Agregar]
	@cod_estado		int,
    @detalle		varchar(60)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_estado from lista_estado where cod_estado=@cod_estado

	if (@existe is null)begin
	
		INSERT INTO [dbo].[lista_estado]
           ([cod_estado]
           ,[Detalle])
     VALUES
           (@cod_estado
           ,@detalle)
	end
	else begin
		UPDATE [dbo].[lista_estado]
		SET [cod_estado] = @cod_estado
			,[Detalle] = @detalle
		WHERE cod_estado = @cod_estado
	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_estado_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_estado_Traer]
	@cod_estado		int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_estado]
      ,[Detalle]
	FROM [dbo].[lista_estado]
		WHERE cod_estado = @cod_estado
END

GO
/****** Object:  StoredProcedure [dbo].[lista_estado_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_estado_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_estado]
      ,[Detalle]
	FROM [dbo].[lista_estado]

END

GO
/****** Object:  StoredProcedure [dbo].[lista_extensionUnidad_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/03/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_extensionUnidad_Agregar]
	@cod_extension int,
	@detalle varchar(60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @existe int;
	select @existe=cod_extension from lista_extensionUnidad where cod_extension=@cod_extension

	if (@existe is null)begin
	
		INSERT INTO [dbo].[lista_extensionUnidad]
				([cod_extension]
			  ,[detalle])
		VALUES
			  (@cod_extension
			  ,@detalle)
	end
	else begin

				UPDATE [dbo].[lista_extensionUnidad]
				SET [cod_extension] = @cod_extension
					,[detalle] = @detalle
				WHERE cod_extension = @cod_extension
	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_extensionUnidad_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/03/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_extensionUnidad_Traer]
	@cod_extension int,
	@detalle varchar(60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT [cod_extension]
      ,[detalle]
  FROM [dbo].[lista_extensionUnidad]
  where cod_extension = @cod_extension
END

GO
/****** Object:  StoredProcedure [dbo].[lista_extensionUnidad_TraerTodos]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/03/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_extensionUnidad_TraerTodos]
	@cod_extension int,
	@detalle varchar(60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [cod_extension]
      ,[detalle]
  FROM [dbo].[lista_extensionUnidad]
END

GO
/****** Object:  StoredProcedure [dbo].[lista_habilitacion_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_habilitacion_Agregar]
	@cod_habilitacion	int,
    @detalle			varchar(60)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_habilitacion from lista_habilitacion where cod_habilitacion=@cod_habilitacion

	if (@existe is null)begin
	
		INSERT INTO [dbo].[lista_habilitacion]
           ([cod_habilitacion]
           ,[detalle])
     VALUES
           (@cod_habilitacion
           ,@detalle)
	end
	else begin
		UPDATE [dbo].[lista_habilitacion]
		SET [cod_habilitacion] = @cod_habilitacion
			,[detalle] = @detalle
		WHERE cod_habilitacion = @cod_habilitacion
	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_habilitacion_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_habilitacion_Traer]
	@cod_habilitacion	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_habilitacion]
      ,[detalle]
	FROM [dbo].[lista_habilitacion]
	WHERE cod_habilitacion = @cod_habilitacion

END

GO
/****** Object:  StoredProcedure [dbo].[lista_habilitacion_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_habilitacion_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_habilitacion]
      ,[detalle]
	FROM [dbo].[lista_habilitacion]

END

GO
/****** Object:  StoredProcedure [dbo].[lista_moneda_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_moneda_Agregar]
	@cod_modena			int,
    @detalle			varchar(60),
    @cod_habilitacion	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_modena from Lista_moneda where cod_modena=@cod_modena

	if (@existe is null)begin
	
		INSERT INTO [dbo].[Lista_moneda]
           ([cod_modena]
           ,[detalle]
           ,[cod_habilitacion])
		VALUES
           (@cod_modena
           ,@detalle
           ,@cod_habilitacion)
	end
	else begin
		UPDATE [dbo].[Lista_moneda]
		SET [cod_modena] = @cod_modena
			,[detalle] = @detalle
			,[cod_habilitacion] = @cod_habilitacion
		WHERE cod_modena = @cod_modena

	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_moneda_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_moneda_Borrar]
	@cod_modena			int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		UPDATE [dbo].[Lista_moneda]
		SET [cod_habilitacion] = 0
		WHERE cod_modena = @cod_modena

END

GO
/****** Object:  StoredProcedure [dbo].[lista_moneda_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_moneda_Traer]
	@cod_modena			int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT [cod_modena]
      ,[detalle]
      ,[cod_habilitacion]
		FROM [dbo].[Lista_moneda]
		WHERE cod_modena = @cod_modena

END

GO
/****** Object:  StoredProcedure [dbo].[lista_moneda_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_moneda_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT [cod_modena]
      ,[detalle]
      ,[cod_habilitacion]
		FROM [dbo].[Lista_moneda]
END

GO
/****** Object:  StoredProcedure [dbo].[lista_nivelAutoridad_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_nivelAutoridad_Agregar]
	@Cod_nivel_Autoridad	int, 
	@Detalle				varchar(50)
AS
BEGIN
	
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @Existe int;
	select @Existe=cod_nivel_autoridad from lista_nivelAutoridad where cod_nivel_autoridad=@Cod_nivel_Autoridad

	if (@Existe is null)begin	

			INSERT INTO [dbo].[lista_nivelAutoridad]
					([cod_nivel_autoridad]
					,[detalle])
			VALUES
					(@Cod_nivel_Autoridad
					,@Detalle)

	end
	else begin

			UPDATE [dbo].[lista_nivelAutoridad]
				SET
					[detalle]=@Detalle
				where cod_nivel_autoridad = @Cod_nivel_Autoridad
				end
END
GO
/****** Object:  StoredProcedure [dbo].[lista_nivelAutoridad_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_nivelAutoridad_Traer] 
	@cod_nivel_autoridad int
AS
BEGIN

	SET NOCOUNT ON;

    -- Insert statements for procedure here	
	SELECT [cod_nivel_autoridad]
		  ,[detalle]
	  FROM [dbo].[lista_nivelAutoridad]
	 where cod_nivel_autoridad= @cod_nivel_autoridad

END
GO
/****** Object:  StoredProcedure [dbo].[lista_nivelAutoridad_TraerTodos]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_nivelAutoridad_TraerTodos] 
	@cod_nivel_autoridad int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT *
	  FROM [dbo].[lista_nivelAutoridad]

END
GO
/****** Object:  StoredProcedure [dbo].[lista_nivelBibliografico_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_nivelBibliografico_Agregar]
	@cod_nivel_bibliografico	int,
    @detalle					varchar(50),
    @cod_habilitacion			int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_nivel_bibliografico from lista_nivelBibliografico where cod_nivel_bibliografico=@cod_nivel_bibliografico

	if (@existe is null)begin
	
		INSERT INTO [dbo].[lista_nivelBibliografico]
           ([cod_nivel_bibliografico]
           ,[detalle]
           ,[cod_habilitacion])
     VALUES
           (@cod_nivel_bibliografico
           ,@detalle
           ,@cod_habilitacion)
	end
	else begin
			UPDATE [dbo].[lista_nivelBibliografico]
		SET [cod_nivel_bibliografico] = @cod_nivel_bibliografico
			,[detalle] = @detalle
			,[cod_habilitacion] = @cod_habilitacion
		WHERE cod_nivel_bibliografico = @cod_nivel_bibliografico
	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_nivelBibliografico_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_nivelBibliografico_Borrar]
	@cod_nivel_bibliografico	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		UPDATE [dbo].[lista_nivelBibliografico]
		SET [cod_habilitacion] = 0
		WHERE cod_nivel_bibliografico = @cod_nivel_bibliografico
END

GO
/****** Object:  StoredProcedure [dbo].[lista_nivelBibliografico_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_nivelBibliografico_Traer]
	@cod_nivel_bibliografico	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT [cod_nivel_bibliografico]
			,[detalle]
			,[cod_habilitacion]
		FROM [dbo].[lista_nivelBibliografico]
		WHERE cod_nivel_bibliografico = @cod_nivel_bibliografico
END

GO
/****** Object:  StoredProcedure [dbo].[lista_nivelBibliografico_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_nivelBibliografico_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT [cod_nivel_bibliografico]
			,[detalle]
			,[cod_habilitacion]
		FROM [dbo].[lista_nivelBibliografico]

END

GO
/****** Object:  StoredProcedure [dbo].[lista_obra_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_obra_Agregar]
	@cod_tipo_obra		int,
    @detalle			varchar(60),
    @es_especial		int,
    @dias_por_defecto	int,
    @conferencia		int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_tipo_obra from lista_obra where cod_tipo_obra=@cod_tipo_obra

	if (@existe is null)begin
	
		INSERT INTO [dbo].[lista_obra]
           ([cod_tipo_obra]
           ,[detalle]
           ,[es_especial]
           ,[dias_por_defecto]
           ,[conferencia])
     VALUES
           (@cod_tipo_obra
           ,@detalle
           ,@es_especial
           ,@dias_por_defecto
           ,@conferencia)
	end
	else begin
		UPDATE [dbo].[lista_obra]
		SET [cod_tipo_obra] = @cod_tipo_obra
			,[detalle] = @detalle
			,[es_especial] = @es_especial
			,[dias_por_defecto] = @dias_por_defecto
			,[conferencia] = @conferencia
		WHERE cod_tipo_obra = @cod_tipo_obra

	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_obra_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_obra_Traer]
	@cod_tipo_obra		int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_tipo_obra]
      ,[detalle]
      ,[es_especial]
      ,[dias_por_defecto]
      ,[conferencia]
	FROM [dbo].[lista_obra]
		WHERE cod_tipo_obra = @cod_tipo_obra

END

GO
/****** Object:  StoredProcedure [dbo].[lista_obra_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_obra_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_tipo_obra]
      ,[detalle]
      ,[es_especial]
      ,[dias_por_defecto]
      ,[conferencia]
	FROM [dbo].[lista_obra]

END

GO
/****** Object:  StoredProcedure [dbo].[lista_responsabilidad_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================

CREATE PROCEDURE [dbo].[lista_responsabilidad_Agregar]
	@cod_responsabilidad int, 
	@detalle			 varchar(59)
AS
BEGIN

	SET NOCOUNT ON;


	Declare @existe int;
	select @existe=cod_responsabilidad from lista_responsabiliad where cod_responsabilidad=@cod_responsabilidad


	if (@existe is null)begin
	
		INSERT INTO [dbo].[lista_responsabiliad]
			     ([cod_responsabilidad]
				   ,[detalle])
		 VALUES
			     (@cod_responsabilidad
				 ,@detalle)
	end
	else begin
			UPDATE [dbo].[lista_responsabiliad]
			SET 
			  [detalle] = @detalle
			WHERE cod_responsabilidad=@cod_responsabilidad
	end
END
GO
/****** Object:  StoredProcedure [dbo].[lista_responsabilidad_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_responsabilidad_Traer] 
	@cod_responsabilidad int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT [cod_responsabilidad]
		  ,[detalle]
	  FROM [dbo].[lista_responsabiliad]
	 WHERE cod_responsabilidad= @cod_responsabilidad

END
GO
/****** Object:  StoredProcedure [dbo].[lista_responsabilidad_TraerTodos]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_responsabilidad_TraerTodos]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT *
	  FROM [dbo].[lista_responsabiliad]

END
GO
/****** Object:  StoredProcedure [dbo].[lista_soporte_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_soporte_Agregar]
	@cod_soporte			int,
	@detalle			varchar(60),
	@reproduccion		int,
	@icono				varchar(50),
	@cod_habilitacion	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_soporte from lista_soporte where cod_soporte=@cod_soporte

	if (@existe is null)begin
	
		INSERT INTO [dbo].[lista_soporte]
           ([cod_soporte]
           ,[detalle]
           ,[reproduccion]
           ,[icono]
           ,[cod_habilitacion])
		VALUES
           (@cod_soporte
           ,@detalle
           ,@reproduccion
           ,@icono
           ,@cod_habilitacion)
	end
	else begin
			UPDATE [dbo].[lista_soporte]
			SET [cod_soporte] = @cod_soporte
				,[detalle] = @detalle
				,[reproduccion] = @reproduccion
				,[icono] = @icono
				,[cod_habilitacion] = @cod_habilitacion
			WHERE cod_soporte = @cod_soporte

	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_soporte_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_soporte_Borrar]
	@cod_soporte			int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

UPDATE [dbo].[lista_soporte]
   SET [cod_habilitacion] = 0
 WHERE cod_soporte = @cod_soporte
END

GO
/****** Object:  StoredProcedure [dbo].[lista_soporte_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_soporte_Traer]
	@cod_soporte			int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [cod_soporte]
      ,[detalle]
      ,[reproduccion]
      ,[icono]
      ,[cod_habilitacion]
  FROM [dbo].[lista_soporte]
  WHERE cod_soporte = @cod_soporte
END

GO
/****** Object:  StoredProcedure [dbo].[lista_soporte_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_soporte_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [cod_soporte]
      ,[detalle]
      ,[reproduccion]
      ,[icono]
      ,[cod_habilitacion]
  FROM [dbo].[lista_soporte]

END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoArchivo_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoArchivo_Agregar]
	@cod_tipo_archivo	int,
    @Detalle			varchar(60),
    @cod_habilitacion	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_tipo_archivo from lista_tipoArchivo where cod_tipo_archivo=@cod_tipo_archivo

	if (@existe is null)begin
	
		INSERT INTO [dbo].[lista_tipoArchivo]
           ([cod_tipo_archivo]
           ,[Detalle]
           ,[cod_habilitacion])
		VALUES
           (@cod_tipo_archivo
           ,@Detalle
           ,@cod_habilitacion)
	end
	else begin
		UPDATE [dbo].[lista_tipoArchivo]
		SET [cod_tipo_archivo] = @cod_tipo_archivo
			,[Detalle] = @Detalle
			,[cod_habilitacion] = @cod_habilitacion
		WHERE cod_tipo_archivo = @cod_tipo_archivo

	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoArchivo_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoArchivo_Borrar]
	@cod_tipo_archivo	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		UPDATE [dbo].[lista_tipoArchivo]
		SET [cod_habilitacion] = 0
		WHERE cod_tipo_archivo = @cod_tipo_archivo

END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoArchivo_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoArchivo_Traer]
	@cod_tipo_archivo	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT [cod_tipo_archivo]
      ,[Detalle]
      ,[cod_habilitacion]
		FROM [dbo].[lista_tipoArchivo]
		WHERE cod_tipo_archivo = @cod_tipo_archivo

END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoArchivo_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoArchivo_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT [cod_tipo_archivo]
      ,[Detalle]
      ,[cod_habilitacion]
		FROM [dbo].[lista_tipoArchivo]

END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoClasificador_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoClasificador_Agregar]
	@cod_clasificador	int,
    @detalle			varchar(60)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_clasificador from lLista_tipoClasificador where cod_clasificador=@cod_clasificador

	if (@existe is null)begin
	
		INSERT INTO [dbo].[lLista_tipoClasificador]
           ([cod_clasificador]
           ,[Detalle])
     VALUES
           (@cod_clasificador
           ,@detalle)
	end
	else begin
		UPDATE [dbo].[lLista_tipoClasificador]
		SET [cod_clasificador] = @cod_clasificador
			,[Detalle] = @detalle
		WHERE cod_clasificador = @cod_clasificador
	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoClasificador_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoClasificador_Traer]
	@cod_clasificador	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_clasificador]
      ,[Detalle]
	FROM [dbo].[lLista_tipoClasificador]
		WHERE cod_clasificador = @cod_clasificador
END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoClasificador_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoClasificador_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_clasificador]
      ,[Detalle]
	FROM [dbo].[lLista_tipoClasificador]

END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoColeccion_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoColeccion_Agregar]
	@cod_coleccion		int,
	@detalle			varchar(60),
	@cod_habilitacion	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_coleccion from lista_tipoColeccion where cod_coleccion=@cod_coleccion

	if (@existe is null)begin
	
		INSERT INTO [dbo].[lista_tipoColeccion]
           ([cod_coleccion]
           ,[detalle]
           ,[cod_habilitacion])
		VALUES
           (@cod_coleccion
           ,@detalle
           ,@cod_habilitacion)
	end
	else begin
			UPDATE [dbo].[lista_tipoColeccion]
			SET [cod_coleccion] = @cod_coleccion
				,[detalle] = @detalle
				,[cod_habilitacion] = @cod_habilitacion
			WHERE cod_coleccion = @cod_coleccion

	end
END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoColeccion_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoColeccion_Borrar]
	@cod_coleccion			int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[lista_tipoColeccion]
	SET [cod_habilitacion] = 0
	WHERE cod_coleccion = @cod_coleccion
END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoColeccion_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoColeccion_Traer]
	@cod_coleccion		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_coleccion]
      ,[detalle]
      ,[cod_habilitacion]
	FROM [dbo].[lista_tipoColeccion]
	WHERE cod_coleccion = @cod_coleccion
END

GO
/****** Object:  StoredProcedure [dbo].[lista_tipoColeccion_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[lista_tipoColeccion_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_coleccion]
      ,[detalle]
      ,[cod_habilitacion]
	FROM [dbo].[lista_tipoColeccion]
END

GO
/****** Object:  StoredProcedure [dbo].[Lista_TipoPrestamo_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================

CREATE PROCEDURE [dbo].[Lista_TipoPrestamo_Agregar]
	@cod_prestamo int, @detalle varchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	Declare @existe int;
	select @existe=cod_prestamo from Lista_TipoPrestamo where cod_prestamo = @cod_prestamo


	if (@existe is null)begin
			INSERT INTO [dbo].[Lista_TipoPrestamo]
				([cod_prestamo]
				,[Detalle])
			VALUES
				(@cod_prestamo, @detalle)

	end
	else begin

			UPDATE [dbo].[Lista_TipoPrestamo]
				SET	[Detalle] = @detalle
				where cod_prestamo = @cod_prestamo
	end
END
GO
/****** Object:  StoredProcedure [dbo].[Lista_TipoPrestamo_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================

CREATE PROCEDURE [dbo].[Lista_TipoPrestamo_Traer]
	@cod_prestamo int
AS
BEGIN

	SET NOCOUNT ON;

			SELECT [cod_prestamo]
					,[Detalle]
			FROM [dbo].[Lista_TipoPrestamo]
			WHERE cod_prestamo = @cod_prestamo	
END
GO
/****** Object:  StoredProcedure [dbo].[Lista_TipoPrestamo_TraerTodos]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================

CREATE PROCEDURE [dbo].[Lista_TipoPrestamo_TraerTodos]
	@cod_prestamo int
AS
BEGIN

	SET NOCOUNT ON;

			SELECT *
			FROM [dbo].[Lista_TipoPrestamo]
END
GO
/****** Object:  StoredProcedure [dbo].[localizacion_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[localizacion_Agregar]
	@cod_localizacion		char(3),
    @nombre					varchar(100),
    @carpeta				varchar(50),
    @direccion_postal		varchar(8),
    @Direccion				varchar(100),
    @NombreArchivo_foto		varchar(100),
    @fecha_ingreso			datetime,
    @fecha_modificacion		datetime,
    @operador_ingreso		int,
    @operador_modificacion	int,
    @cod_habilitacion		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_localizacion from localizacion where cod_localizacion=@cod_localizacion

	if (@existe is null)begin
	
		INSERT INTO [dbo].[localizacion]
           ([cod_localizacion]
           ,[nombre]
           ,[carpeta]
           ,[direccion_postal]
           ,[Direccion]
           ,[NombreArchivo_foto]
           ,[fecha_ingreso]
           ,[fecha_modificacion]
           ,[operador_ingreso]
           ,[operador_modificacion]
           ,[cod_habilitacion])
     VALUES
           (@cod_localizacion
           ,@nombre
           ,@carpeta
           ,@direccion_postal
           ,@Direccion
           ,@NombreArchivo_foto
           ,@fecha_ingreso
           ,@fecha_modificacion
           ,@operador_ingreso
           ,@operador_modificacion
           ,@cod_habilitacion)
	end
	else begin
			UPDATE [dbo].[localizacion]
			SET [cod_localizacion] = @cod_localizacion
			,[nombre] = @nombre
			,[carpeta] = @carpeta
			,[direccion_postal] = @direccion_postal
			,[Direccion] = @Direccion
			,[NombreArchivo_foto] = @NombreArchivo_foto
			,[fecha_ingreso] = @fecha_ingreso
			,[fecha_modificacion] = @fecha_modificacion
			,[operador_ingreso] = @operador_ingreso
			,[operador_modificacion] = @operador_modificacion
			,[cod_habilitacion] = @cod_habilitacion
		WHERE cod_localizacion=@cod_localizacion

	end
END

GO
/****** Object:  StoredProcedure [dbo].[localizacion_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[localizacion_Borrar]
	@cod_localizacion		char(3)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
			UPDATE [dbo].[localizacion]
			SET [cod_habilitacion] = 0
		WHERE cod_localizacion=@cod_localizacion
END

GO
/****** Object:  StoredProcedure [dbo].[localizacion_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[localizacion_Traer]
	@cod_localizacion		char(3)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT [cod_localizacion]
      ,[nombre]
      ,[carpeta]
      ,[direccion_postal]
      ,[Direccion]
      ,[NombreArchivo_foto]
      ,[fecha_ingreso]
      ,[fecha_modificacion]
      ,[operador_ingreso]
      ,[operador_modificacion]
      ,[cod_habilitacion]
		FROM [dbo].[localizacion]
		WHERE cod_localizacion=@cod_localizacion
END

GO
/****** Object:  StoredProcedure [dbo].[localizacion_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[localizacion_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		SELECT [cod_localizacion]
      ,[nombre]
      ,[carpeta]
      ,[direccion_postal]
      ,[Direccion]
      ,[NombreArchivo_foto]
      ,[fecha_ingreso]
      ,[fecha_modificacion]
      ,[operador_ingreso]
      ,[operador_modificacion]
      ,[cod_habilitacion]
		FROM [dbo].[localizacion]

END

GO
/****** Object:  StoredProcedure [dbo].[obra_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/03/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_Agregar]
	@cod_obra					int,
	@cod_biblioteca				char(1),
	@cod_nivel_bibliografico	int,
	@cod_coleccion				int,
	@cod_tipo_obra				int,
	@cod_soporte				int,
	@cod_encabezamiento			int,
	@titulo_corto				varchar(50),
	@titulo						varchar(300),
	@titulo_uniforme			varchar(300),
	@edicion					varchar(50),
	@cod_pais					char(2),
	@frecuencia					varchar(50),
	@lugar						varchar(50),
	@fecha_edicion_inicio		date,
	@fecha_edicion_final		date,
	@preliminares				varchar(225),
	@extension					int,
	@cod_extension				int,
	@extension_secundaria		int,
	@extension_secundaria_unidad int,
	@ilustracion				varchar(50),
	@alto						int,
	@ancho						int,
	@profundidad				int,
	@unidad						int,
	@complemento				varchar(100),
	@obra_padre_codigo			int,
	@obra_padre_biblioteca		char(1),
	@orden_coleccion			int,
	@serie_inicio				int,
	@serie_fin					int,
	@serie_ano_real				int,
	@serie_ano_interno			int,
	@serie_volumen				varchar(50),
	@serie_fecha				date,
	@area_especifica			varchar(100),
	@epoca_inicio				int,
	@epoca_fin					int,
	@notas						varchar(2000),
	@resumen					varchar(2000),
	@resumen_idioma				char(2),
	@titulo_original			varchar(2300),
	@titulo_original_idioma		char(10),
	@isbn						varchar(50),
	@coden						varchar(50),
	@otros						varchar(50),
	@observaciones				varchar(4000),
	@cod_estado					int,
	@cod_habilitacion			int,
	@destino					varchar(50),
	@extra						varchar(100),
	@cita_html					varchar(1000),
	@cantidad_ejemplar			int,
	@cantidad_imagen			int,
	@tiene_texto_completo		int,
	@registro_estado_cod		int,
	@fecha_ingreso				datetime,
	@fecha_modificacion			datetime,
	@cod_operador_ingreso		int,
	@cod_operador_modif			int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Declare @existe int;
	select @existe=cod_obra from obra where cod_obra=@cod_obra and cod_biblioteca=@cod_biblioteca

	if (@existe is null)begin
	
		INSERT INTO [dbo].[obra]
           ([cod_biblioteca]
           ,[cod_nivel_bibliografico]
           ,[cod_coleccion]
           ,[cod_tipo_obra]
           ,[cod_soporte]
           ,[cod_encabezamiento]
           ,[titulo_corto]
           ,[titulo]
           ,[titulo_uniforme]
           ,[edicion]
           ,[cod_pais]
           ,[frecuencia]
           ,[lugar]
           ,[fecha_edicion_inicio]
           ,[fecha_edicion_final]
           ,[preliminares]
           ,[extension]
           ,[cod_extension]
           ,[extension_secundaria]
           ,[extension_secundaria_unidad]
           ,[ilustracion]
           ,[alto]
           ,[ancho]
           ,[profundidad]
           ,[unidad]
           ,[complemento]
           ,[obra_padre_codigo]
           ,[obra_padre_biblioteca]
           ,[orden_coleccion]
           ,[serie_inicio]
           ,[serie_fin]
           ,[serie_ano_real]
           ,[serie_ano_interno]
           ,[serie_volumen]
           ,[serie_fecha]
           ,[area_especifica]
           ,[epoca_inicio]
           ,[epoca_fin]
           ,[notas]
           ,[resumen]
           ,[resumen_idioma]
           ,[titulo_original]
           ,[titulo_original_idioma]
           ,[isbn]
           ,[coden]
           ,[otros]
           ,[observaciones]
           ,[cod_estado]
           ,[cod_habilitacion]
           ,[destino]
           ,[extra]
           ,[cita_html]
           ,[cantidad_ejemplar]
           ,[cantidad_imagen]
           ,[tiene_texto_completo]
           ,[registro_estado_cod]
           ,[fecha_ingreso]
           ,[fecha_modificacion]
           ,[cod_operador_ingreso]
           ,[cod_operador_modif])
     VALUES
           (@cod_biblioteca
           ,@cod_nivel_bibliografico
           ,@cod_coleccion
           ,@cod_tipo_obra
           ,@cod_soporte
           ,@cod_encabezamiento
           ,@titulo_corto
           ,@titulo
           ,@titulo_uniforme
           ,@edicion
           ,@cod_pais
           ,@frecuencia
           ,@lugar
           ,@fecha_edicion_inicio
           ,@fecha_edicion_final
           ,@preliminares
		   ,@extension
           ,@cod_extension
           ,@extension_secundaria
           ,@extension_secundaria_unidad
           ,@ilustracion
           ,@alto
		   ,@ancho
           ,@profundidad
           ,@unidad
           ,@complemento
           ,@obra_padre_codigo
           ,@obra_padre_biblioteca
           ,@orden_coleccion
           ,@serie_inicio
           ,@serie_fin
           ,@serie_ano_real
           ,@serie_ano_interno
           ,@serie_volumen
           ,@serie_fecha
           ,@area_especifica
           ,@epoca_inicio
           ,@epoca_fin
           ,@notas
           ,@resumen
           ,@resumen_idioma
           ,@titulo_original
           ,@titulo_original_idioma
           ,@isbn
           ,@coden
           ,@otros
           ,@observaciones
           ,@cod_estado
           ,@cod_habilitacion
           ,@destino
           ,@extra
           ,@cita_html
           ,@cantidad_ejemplar
           ,@cantidad_imagen
           ,@tiene_texto_completo
           ,@registro_estado_cod
           ,@fecha_ingreso
           ,@fecha_modificacion
           ,@cod_operador_ingreso
           ,@cod_operador_modif)
	end
	else begin

				UPDATE [dbo].[obra]
   SET [cod_biblioteca]			= @cod_biblioteca
      ,[cod_nivel_bibliografico]= @cod_nivel_bibliografico
      ,[cod_coleccion]			= @cod_coleccion
      ,[cod_tipo_obra]			= @cod_tipo_obra
      ,[cod_soporte]			= @cod_soporte
      ,[cod_encabezamiento]		= @cod_encabezamiento
      ,[titulo_corto]			= @titulo_corto
      ,[titulo]					= @titulo
      ,[titulo_uniforme]		= @titulo_uniforme
      ,[edicion]				= @edicion
      ,[cod_pais]				= @cod_pais
      ,[frecuencia]				= @frecuencia
      ,[lugar]					= @lugar
      ,[fecha_edicion_inicio]	= @fecha_edicion_inicio
      ,[fecha_edicion_final]	= @fecha_edicion_final
      ,[preliminares]			= @preliminares
      ,[extension]				= @extension
      ,[cod_extension]			= @cod_extension
      ,[extension_secundaria]	= @extension_secundaria
      ,[extension_secundaria_unidad] = @extension_secundaria_unidad
      ,[ilustracion]			= @ilustracion
      ,[alto]					= @alto
      ,[ancho]					= @ancho
      ,[profundidad]			= @profundidad
      ,[unidad]					= @unidad
      ,[complemento]			= @complemento
      ,[obra_padre_codigo]		= @obra_padre_codigo
      ,[obra_padre_biblioteca]	= @obra_padre_biblioteca
      ,[orden_coleccion]		= @orden_coleccion
      ,[serie_inicio]			= @serie_inicio
      ,[serie_fin]				= @serie_fin
      ,[serie_ano_real]			= @serie_ano_real
      ,[serie_ano_interno]		= @serie_ano_interno
      ,[serie_volumen]			= @serie_volumen
      ,[serie_fecha]			= @serie_fecha
      ,[area_especifica]		= @area_especifica
      ,[epoca_inicio]			= @epoca_inicio
      ,[epoca_fin]				= @epoca_fin
      ,[notas]					= @notas
      ,[resumen]				= @resumen
      ,[resumen_idioma]			= @resumen_idioma
      ,[titulo_original]		= @titulo_original
      ,[titulo_original_idioma] = @titulo_original_idioma
      ,[isbn]					= @isbn
      ,[coden]					= @coden
      ,[otros]					= @otros
      ,[observaciones]			= @observaciones
      ,[cod_estado]				= @cod_estado
      ,[cod_habilitacion]		= @cod_habilitacion
      ,[destino]				= @destino
      ,[extra]					= @extra
      ,[cita_html]				= @cita_html
      ,[cantidad_ejemplar]		= @cantidad_ejemplar
      ,[cantidad_imagen]		= @cantidad_imagen
      ,[tiene_texto_completo]	= @tiene_texto_completo
      ,[registro_estado_cod]	= @registro_estado_cod
      ,[fecha_ingreso]			= @fecha_ingreso
      ,[fecha_modificacion]		= @fecha_modificacion
      ,[cod_operador_ingreso]	= @cod_operador_ingreso
      ,[cod_operador_modif]		= @cod_operador_modif
 WHERE cod_obra=@cod_obra AND cod_biblioteca=@cod_biblioteca
	end
END

GO
/****** Object:  StoredProcedure [dbo].[obra_autoridad_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================

CREATE PROCEDURE [dbo].[obra_autoridad_Agregar]
	@Cod_autoridad		int, 
	@Cod_Biblioteca		char(1), 
	@Cod_obra			int, 
	@cod_responsabilidad int,
	@cod_nivel_autoridad int, 
	@orden				int
AS
BEGIN

	SET NOCOUNT ON;

	Declare @existe int;
	select @existe=cod_autoridad from obra_autoridad where cod_autoridad=@Cod_autoridad


	if (@existe is null)begin

		INSERT INTO [dbo].[obra_autoridad]
		   ([cod_biblioteca]
		   ,[cod_obra]
	       ,[cod_responsabilidad]
		   ,[cod_nivel_autoridad],
		   [orden])
		VALUES
			(@Cod_Biblioteca, 
				@Cod_obra,
				@cod_responsabilidad,
				@cod_nivel_autoridad,
				@orden)
	end
	else begin

				UPDATE [dbo].[obra_autoridad]
				   SET 
					  [cod_biblioteca] = @Cod_Biblioteca,
					  [cod_obra] = @Cod_obra,
					  [cod_responsabilidad] = @cod_responsabilidad,
					  [cod_nivel_autoridad] = @cod_nivel_autoridad,
					  [orden] = @orden
				 WHERE cod_autoridad=@Cod_autoridad
	end
END
GO
/****** Object:  StoredProcedure [dbo].[obra_autoridad_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_autoridad_Traer]
	@cod_autoridad int

AS
BEGIN

	SET NOCOUNT ON;

SELECT [cod_autoridad]
      ,[cod_biblioteca]
      ,[cod_obra]
      ,[cod_responsabilidad]
      ,[cod_nivel_autoridad]
      ,[orden]
  FROM [dbo].[obra_autoridad]
  WHERE cod_autoridad = @cod_autoridad

END
GO
/****** Object:  StoredProcedure [dbo].[obra_autoridad_TraerTodos]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_autoridad_TraerTodos] 
AS
BEGIN

	SET NOCOUNT ON;


SELECT *
  FROM [dbo].[obra_autoridad]

END
GO
/****** Object:  StoredProcedure [dbo].[obra_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/03/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_Borrar]
	@cod_obra					int,
	@cod_biblioteca				char(1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[obra]
   SET [cod_habilitacion]		= 0
 WHERE cod_obra=@cod_obra AND cod_biblioteca=@cod_biblioteca
END

GO
/****** Object:  StoredProcedure [dbo].[obra_clasificador_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_clasificador_Agregar]
	@cod_biblioteca		char(1),
    @cod_obra			int,
    @cod_clasificador	int,
    @ordern				int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_biblioteca from obra_clasificador where cod_biblioteca=@cod_biblioteca and cod_obra = @cod_obra and cod_clasificador = @cod_clasificador

	if (@existe is null)begin
	
		INSERT INTO [dbo].[obra_clasificador]
           ([cod_biblioteca]
           ,[cod_obra]
           ,[cod_clasificador]
           ,[ordern])
     VALUES
           (@cod_biblioteca
           ,@cod_obra
           ,@cod_clasificador
           ,@ordern)
	end
	else begin
		UPDATE [dbo].[obra_clasificador]
		SET [cod_biblioteca] = @cod_biblioteca
			,[cod_obra] = @cod_obra
			,[cod_clasificador] = @cod_clasificador
			,[ordern] = @ordern
		WHERE cod_biblioteca = @cod_biblioteca
		and cod_clasificador=@cod_clasificador
		and cod_obra = @cod_obra
	end
END

GO
/****** Object:  StoredProcedure [dbo].[obra_clasificador_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_clasificador_Traer]
	@cod_biblioteca		char(1),
    @cod_obra			int,
    @cod_clasificador	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_biblioteca]
      ,[cod_obra]
      ,[cod_clasificador]
      ,[ordern]
	FROM [dbo].[obra_clasificador]
		WHERE cod_biblioteca = @cod_biblioteca
		and cod_clasificador=@cod_clasificador
		and cod_obra = @cod_obra
END

GO
/****** Object:  StoredProcedure [dbo].[obra_clasificador_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_clasificador_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [cod_biblioteca]
      ,[cod_obra]
      ,[cod_clasificador]
      ,[ordern]
	FROM [dbo].[obra_clasificador]

END

GO
/****** Object:  StoredProcedure [dbo].[obra_idioma_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================

CREATE PROCEDURE [dbo].[obra_idioma_Agregar]
	@cod_biblioteca char(1), 
	@cod_obra		int, 
	@cod_idioma		char(2)
AS
BEGIN

	SET NOCOUNT ON;


	Declare @existe int;
	select @existe=cod_biblioteca from obra_idioma where cod_biblioteca=@cod_biblioteca and cod_obra=@cod_obra and cod_idioma=@cod_idioma
	
	if (@existe is null)begin
	
		INSERT INTO [dbo].[obra_idioma]
			     ([cod_biblioteca]
		         ,[cod_obra],
				   [cod_idioma])
		VALUES
				(@cod_biblioteca,
				 @cod_obra,
				 @cod_idioma)

	end
	else begin

		UPDATE [dbo].[obra_idioma]
		SET 
			cod_obra = @cod_obra,
			cod_idioma = @cod_idioma
		WHERE cod_biblioteca = @cod_biblioteca
	end
END
GO
/****** Object:  StoredProcedure [dbo].[obra_idioma_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_idioma_Traer]
	@cod_biblioteca char(1), 
	@cod_obra		int, 
	@cod_idioma		char(2)

AS
BEGIN

	SET NOCOUNT ON;

SELECT [cod_biblioteca]
      ,[cod_obra]
      ,[cod_idioma]
  FROM [dbo].[obra_idioma]
  WHERE cod_biblioteca = @cod_biblioteca and
		cod_obra = @cod_obra and
		cod_idioma = @cod_idioma
END
GO
/****** Object:  StoredProcedure [dbo].[obra_idioma_TraerTodos]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Nicolas Lopez>
-- Create date: <11/07/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_idioma_TraerTodos]
	@cod_biblioteca char(1), 
	@cod_obra		int, 
	@cod_idioma		char(2)

AS
BEGIN

	SET NOCOUNT ON;

SELECT *
  FROM [dbo].[obra_idioma]
END

GO
/****** Object:  StoredProcedure [dbo].[obra_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/03/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_Traer]
	@cod_obra int,
	@cod_biblioteca char(1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT [cod_obra]
      ,[cod_biblioteca]
      ,[cod_nivel_bibliografico]
      ,[cod_coleccion]
      ,[cod_tipo_obra]
      ,[cod_soporte]
      ,[cod_encabezamiento]
      ,[titulo_corto]
      ,[titulo]
      ,[titulo_uniforme]
      ,[edicion]
      ,[cod_pais]
      ,[frecuencia]
      ,[lugar]
      ,[fecha_edicion_inicio]
      ,[fecha_edicion_final]
      ,[preliminares]
      ,[extension]
      ,[cod_extension]
      ,[extension_secundaria]
      ,[extension_secundaria_unidad]
      ,[ilustracion]
      ,[alto]
      ,[ancho]
      ,[profundidad]
      ,[unidad]
      ,[complemento]
      ,[obra_padre_codigo]
      ,[obra_padre_biblioteca]
      ,[orden_coleccion]
      ,[serie_inicio]
      ,[serie_fin]
      ,[serie_ano_real]
      ,[serie_ano_interno]
      ,[serie_volumen]
      ,[serie_fecha]
      ,[area_especifica]
      ,[epoca_inicio]
      ,[epoca_fin]
      ,[notas]
      ,[resumen]
      ,[resumen_idioma]
      ,[titulo_original]
      ,[titulo_original_idioma]
      ,[isbn]
      ,[coden]
      ,[otros]
      ,[observaciones]
      ,[cod_estado]
      ,[cod_habilitacion]
      ,[destino]
      ,[extra]
      ,[cita_html]
      ,[cantidad_ejemplar]
      ,[cantidad_imagen]
      ,[tiene_texto_completo]
      ,[registro_estado_cod]
      ,[fecha_ingreso]
      ,[fecha_modificacion]
      ,[cod_operador_ingreso]
      ,[cod_operador_modif]
  FROM [dbo].[obra]
  WHERE cod_obra = @cod_obra
  AND cod_biblioteca = @cod_biblioteca
END

GO
/****** Object:  StoredProcedure [dbo].[obra_TraerTodos]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/03/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[obra_TraerTodos]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT [cod_obra]
      ,[cod_biblioteca]
      ,[cod_nivel_bibliografico]
      ,[cod_coleccion]
      ,[cod_tipo_obra]
      ,[cod_soporte]
      ,[cod_encabezamiento]
      ,[titulo_corto]
      ,[titulo]
      ,[titulo_uniforme]
      ,[edicion]
      ,[cod_pais]
      ,[frecuencia]
      ,[lugar]
      ,[fecha_edicion_inicio]
      ,[fecha_edicion_final]
      ,[preliminares]
      ,[extension]
      ,[cod_extension]
      ,[extension_secundaria]
      ,[extension_secundaria_unidad]
      ,[ilustracion]
      ,[alto]
      ,[ancho]
      ,[profundidad]
      ,[unidad]
      ,[complemento]
      ,[obra_padre_codigo]
      ,[obra_padre_biblioteca]
      ,[orden_coleccion]
      ,[serie_inicio]
      ,[serie_fin]
      ,[serie_ano_real]
      ,[serie_ano_interno]
      ,[serie_volumen]
      ,[serie_fecha]
      ,[area_especifica]
      ,[epoca_inicio]
      ,[epoca_fin]
      ,[notas]
      ,[resumen]
      ,[resumen_idioma]
      ,[titulo_original]
      ,[titulo_original_idioma]
      ,[isbn]
      ,[coden]
      ,[otros]
      ,[observaciones]
      ,[cod_estado]
      ,[cod_habilitacion]
      ,[destino]
      ,[extra]
      ,[cita_html]
      ,[cantidad_ejemplar]
      ,[cantidad_imagen]
      ,[tiene_texto_completo]
      ,[registro_estado_cod]
      ,[fecha_ingreso]
      ,[fecha_modificacion]
      ,[cod_operador_ingreso]
      ,[cod_operador_modif]
  FROM [dbo].[obra]
END

GO
/****** Object:  StoredProcedure [dbo].[operador_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[operador_Agregar]
	@cod_operador		int,
	@email				nvarchar(50),
	@password			char(20),
	@cod_rol			int,
	@cod_habilitacion	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_operador from operador where cod_operador=@cod_operador

	if (@existe is null)begin
	
		INSERT INTO [dbo].[operador]
           ([cod_operador]
           ,[email]
           ,[password]
           ,[cod_habilitacion]
           ,[cod_rol])
		VALUES
           (@cod_operador
           ,@email
           ,@password
           ,@cod_habilitacion
           ,@cod_rol)
	end
	else begin
			UPDATE [dbo].[operador]
			SET [cod_operador] = @cod_operador
				,[email] = @email
				,[password] = @password
				,[cod_habilitacion] = @cod_habilitacion
				,[cod_rol] = @cod_rol
			WHERE cod_operador = @cod_operador
	end
END

GO
/****** Object:  StoredProcedure [dbo].[operador_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[operador_Borrar]
	@cod_operador		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   	UPDATE [dbo].[operador]
	SET [cod_habilitacion] = 0
	WHERE cod_operador = @cod_operador

END

GO
/****** Object:  StoredProcedure [dbo].[operador_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[operador_Traer]
	@cod_operador		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   	SELECT [cod_operador]
      ,[email]
      ,[password]
      ,[cod_habilitacion]
      ,[cod_rol]
	FROM [dbo].[operador]
	WHERE cod_operador = @cod_operador

END

GO
/****** Object:  StoredProcedure [dbo].[operador_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[operador_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   	SELECT [cod_operador]
      ,[email]
      ,[password]
      ,[cod_habilitacion]
      ,[cod_rol]
	FROM [dbo].[operador]

END

GO
/****** Object:  StoredProcedure [dbo].[pais_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[pais_Agregar]
	@cod_pais		char(2),
    @detalle		varchar(60),
    @cod_habilitacion int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_pais from pais where cod_pais=@cod_pais

	if (@existe is null)begin
	
		INSERT INTO [dbo].[pais]
           ([cod_pais]
           ,[detalle]
           ,[cod_habilitacion])
     VALUES
           (@cod_pais
           ,@detalle
           ,@cod_habilitacion)
	end
	else begin
		UPDATE [dbo].[pais]
   SET [cod_pais] = @cod_pais
      ,[detalle] = @detalle
      ,[cod_habilitacion] = @cod_habilitacion
	WHERE cod_pais = @cod_pais

	end
END

GO
/****** Object:  StoredProcedure [dbo].[pais_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[pais_Borrar]
	@cod_pais		char(2)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		UPDATE [dbo].[pais]
   SET [cod_habilitacion] = 0
	WHERE cod_pais = @cod_pais

END

GO
/****** Object:  StoredProcedure [dbo].[pais_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[pais_Traer]
	@cod_pais		char(2)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_pais]
      ,[detalle]
      ,[cod_habilitacion]
  FROM [dbo].[pais]
	WHERE cod_pais = @cod_pais

END

GO
/****** Object:  StoredProcedure [dbo].[pais_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[pais_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_pais]
      ,[detalle]
      ,[cod_habilitacion]
  FROM [dbo].[pais]

END

GO
/****** Object:  StoredProcedure [dbo].[Patente_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pablo Vilaboa>
-- Create date: <10/31/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[Patente_Agregar]
	@Cod_Patente int, 
	@Detalle varchar(50), 
	@Padre int,
	@cod_habilitacion int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @existe int;
	select @existe=cod_Patente from Patente where cod_patente=@Cod_Patente


	if (@existe is null)begin
	
		INSERT INTO [dbo].[Patente]
				   ([cod_patente]
				   ,[detalle]
				   ,[Padre])
			 VALUES
				   (@Cod_Patente
				   ,@Detalle
				   ,@Padre)
	end
	else begin

				UPDATE [dbo].[Patente]
				   SET 
					  [detalle] = @Detalle
					  ,[Padre] = @Padre
				 WHERE cod_patente=@Cod_Patente
	end


END


GO
/****** Object:  StoredProcedure [dbo].[patente_rol_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[patente_rol_Agregar]
	@cod_rol			int,
	@cod_patente		int,
	@cod_habilitacion	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_rol from patente_rol where cod_rol=@cod_rol and cod_patente = @cod_patente

	if (@existe is null)begin
	
		INSERT INTO [dbo].[patente_rol]
           ([cod_rol]
           ,[cod_patente]
           ,[cod_habilitacion])
     VALUES
           (@cod_rol
           ,@cod_patente
           ,@cod_habilitacion)
	end
	else begin
			UPDATE [dbo].[patente_rol]
			SET [cod_rol] = @cod_rol
				,[cod_patente] = @cod_patente
				,[cod_habilitacion] = @cod_habilitacion
			WHERE cod_rol = @cod_rol and cod_patente = @cod_patente
	end
END

GO
/****** Object:  StoredProcedure [dbo].[patente_rol_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[patente_rol_Borrar]
	@cod_rol			int,
	@cod_patente		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[patente_rol]
	SET [cod_habilitacion] = 0
	WHERE cod_patente = @cod_patente and cod_rol = @cod_rol
END

GO
/****** Object:  StoredProcedure [dbo].[patente_rol_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[patente_rol_Traer]
	@cod_rol			int,
	@cod_patente		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_rol]
      ,[cod_patente]
      ,[cod_habilitacion]
  FROM [dbo].[patente_rol]
  WHERE cod_rol = @cod_rol and cod_patente = @cod_patente
END

GO
/****** Object:  StoredProcedure [dbo].[patente_rol_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[patente_rol_TraerTodo]
	@cod_rol			int,
	@cod_patente		int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_rol]
      ,[cod_patente]
      ,[cod_habilitacion]
  FROM [dbo].[patente_rol]
END

GO
/****** Object:  StoredProcedure [dbo].[Patente_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pablo Vilaboa>
-- Create date: <10/31/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[Patente_Traer] 
	@cod_patente int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here	
	SELECT [cod_patente]
		  ,[detalle]
		  ,[Padre]
	  FROM [dbo].[Patente]
	 where cod_patente= @cod_patente

END


GO
/****** Object:  StoredProcedure [dbo].[Patente_TraerTodos]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Pablo Vilaboa>
-- Create date: <10/31/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[Patente_TraerTodos]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here	
	SELECT [cod_patente]
		  ,[detalle]
		  ,[Padre]
	  FROM [dbo].[Patente]
	 

END


GO
/****** Object:  StoredProcedure [dbo].[proveedor_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[proveedor_Agregar]
	@cod_proveedor		int,
    @detalle			varchar(60),
    @telefono			varchar(60),
    @correoElectronico	varchar(180),
    @cod_habilitacion	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_proveedor from proveedor where cod_proveedor=@cod_proveedor

	if (@existe is null)begin
	
		INSERT INTO [dbo].[proveedor]
           ([cod_proveedor]
           ,[detalle]
           ,[telefono]
           ,[correoElectronico]
           ,[cod_habilitacion])
		VALUES
           (@cod_proveedor
           ,@detalle
           ,@telefono
           ,@correoElectronico
           ,@cod_habilitacion)
	end
	else begin
		UPDATE [dbo].[proveedor]
		SET [cod_proveedor] = @cod_proveedor
      ,[detalle] = @detalle
      ,[telefono] = @telefono
      ,[correoElectronico] = @correoElectronico
      ,[cod_habilitacion] = @cod_habilitacion
		WHERE cod_proveedor = @cod_proveedor
	end
END

GO
/****** Object:  StoredProcedure [dbo].[proveedor_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[proveedor_Borrar]
	@cod_proveedor		int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		UPDATE [dbo].[proveedor]
		SET [cod_habilitacion] = 0
		WHERE cod_proveedor = @cod_proveedor

END

GO
/****** Object:  StoredProcedure [dbo].[proveedor_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[proveedor_Traer]
	@cod_proveedor		int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_proveedor]
      ,[detalle]
      ,[telefono]
      ,[correoElectronico]
      ,[cod_habilitacion]
  FROM [dbo].[proveedor]
		WHERE cod_proveedor = @cod_proveedor

END

GO
/****** Object:  StoredProcedure [dbo].[proveedor_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[proveedor_TraerTodo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_proveedor]
      ,[detalle]
      ,[telefono]
      ,[correoElectronico]
      ,[cod_habilitacion]
  FROM [dbo].[proveedor]

END

GO
/****** Object:  StoredProcedure [dbo].[rol_Agregar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[rol_Agregar]
	@cod_rol			int,
	@detalle			varchar(50),
	@cod_habilitacion	int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   Declare @existe int;
	select @existe=cod_rol from rol where cod_rol=@cod_rol

	if (@existe is null)begin
	
		INSERT INTO [dbo].[rol]
           ([cod_rol]
           ,[detalle]
           ,[cod_habilitacion])
		VALUES
           (@cod_rol
           ,@detalle
           ,@cod_habilitacion)
	end
	else begin
			UPDATE [dbo].[rol]
			SET [cod_rol] = @cod_rol
				,[detalle] = @detalle
				,[cod_habilitacion] = @cod_habilitacion
			WHERE cod_rol = @cod_rol

	end
END

GO
/****** Object:  StoredProcedure [dbo].[rol_Borrar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creación de scrip>
-- =============================================
CREATE PROCEDURE [dbo].[rol_Borrar]
	@cod_rol			int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [dbo].[rol]
	SET [cod_habilitacion] = 0
 WHERE cod_rol = @cod_rol
END

GO
/****** Object:  StoredProcedure [dbo].[rol_Traer]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[rol_Traer]
	@cod_rol			int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_rol]
      ,[detalle]
      ,[cod_habilitacion]
	FROM [dbo].[rol]
	WHERE cod_rol = @cod_rol
END

GO
/****** Object:  StoredProcedure [dbo].[rol_TraerTodo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Agustina Villarreal>
-- Create date: <11/10/2018>
-- Description:	<Creacion del scrip>
-- =============================================
CREATE PROCEDURE [dbo].[rol_TraerTodo]
	@cod_rol			int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [cod_rol]
      ,[detalle]
      ,[cod_habilitacion]
	FROM [dbo].[rol]
END

GO
/****** Object:  Table [dbo].[adicional]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[adicional](
	[cod_biblioteca] [char](3) NOT NULL,
	[cod_obra] [int] NOT NULL,
	[cod_imagen] [char](22) NOT NULL,
	[principal] [int] NULL,
	[cod_localizacion] [char](3) NULL,
	[alias] [char](15) NULL,
	[nombre] [varchar](64) NULL,
	[cod_tipo_archivo] [int] NULL,
	[descripcion] [varchar](60) NULL,
	[principal_imprenta] [int] NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_adicional] PRIMARY KEY CLUSTERED 
(
	[cod_biblioteca] ASC,
	[cod_obra] ASC,
	[cod_imagen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[autoridad]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[autoridad](
	[cod_autoridad] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
	[apellido] [varchar](50) NULL,
	[responsable] [varchar](50) NULL,
	[lugar] [varchar](50) NULL,
	[cod_pais] [char](2) NULL,
	[cod_idioma] [char](2) NULL,
	[notas] [varchar](1000) NULL,
	[fecha_fallecimiento] [date] NULL,
	[fecha_nacimiento] [date] NULL,
	[numero] [int] NULL,
	[anio] [int] NULL,
	[fuente] [varchar](50) NULL,
	[norma_fuente] [varchar](50) NULL,
	[fecha_fuente] [date] NULL,
	[observaciones] [varchar](500) NULL,
	[fecha_ingreso] [datetime] NULL,
	[fecha_modificacion] [datetime] NULL,
	[operador_ingreso] [int] NULL,
	[operador_modificacion] [int] NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_autoridad] PRIMARY KEY CLUSTERED 
(
	[cod_autoridad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[bitacora]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bitacora](
	[cod_entidad] [nvarchar](50) NOT NULL,
	[entidad] [nvarchar](50) NOT NULL,
	[operacion] [nvarchar](50) NOT NULL,
	[detalle] [nvarchar](200) NULL,
	[fecha] [datetime] NOT NULL,
	[cod_operador] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[clasificador]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[clasificador](
	[cod_clasificador] [int] IDENTITY(1,1) NOT NULL,
	[fuente] [varchar](50) NULL,
	[clasificador_decimal] [varchar](50) NULL,
	[observaciones] [varchar](2000) NULL,
	[tipo_clasificador] [int] NOT NULL,
	[cod_habilitacion] [int] NOT NULL,
	[fecha_ingreso] [datetime] NULL,
	[fecha_modificacion] [datetime] NULL,
	[operador_ingreso] [nvarchar](50) NULL,
	[operador_modificacion] [nvarchar](50) NULL,
 CONSTRAINT [PK_descriptor_dato_1] PRIMARY KEY CLUSTERED 
(
	[cod_clasificador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ejemplar]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ejemplar](
	[cod_inventario] [int] NOT NULL,
	[cod_localizacion] [char](3) NOT NULL,
	[biblioteca_cod] [char](1) NULL,
	[obra_cod] [int] NULL,
	[signatura_topografica] [varchar](50) NULL,
	[cod_prestamo] [int] NULL,
	[disponible] [int] NULL,
	[cod_proveedor] [int] NULL,
	[precio] [varchar](50) NULL,
	[cod_modena] [int] NULL,
	[fecha_adquisicion] [datetime] NULL,
	[condicion_adquisicion] [varchar](50) NULL,
	[cod_estado] [int] NULL,
	[cod_habilitacion] [int] NULL,
	[observaciones] [varchar](1000) NULL,
	[destino] [varchar](25) NULL,
	[extra] [varchar](500) NULL,
	[fecha_ingreso] [datetime] NULL,
	[fecha_modificado] [datetime] NULL,
	[operador_ingreso] [int] NULL,
	[operador_modificado] [int] NULL,
 CONSTRAINT [PK_ejemplar_1] PRIMARY KEY CLUSTERED 
(
	[cod_inventario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[idioma]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[idioma](
	[cod_idioma] [char](2) NOT NULL,
	[detalle] [varchar](50) NULL,
	[registro_estado_cod] [int] NOT NULL,
	[fecha_ingreso] [datetime] NULL,
	[fecha_modificacion] [datetime] NULL,
	[operador_ingreso] [int] NULL,
	[operador_modificacion] [int] NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_idioma] PRIMARY KEY CLUSTERED 
(
	[cod_idioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_encabezamiento]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_encabezamiento](
	[cod_encabezamiento] [int] NOT NULL,
	[detalle] [varchar](60) NOT NULL,
 CONSTRAINT [PK_tipo_encabezamiento] PRIMARY KEY CLUSTERED 
(
	[cod_encabezamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_estado]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_estado](
	[cod_estado] [int] NOT NULL,
	[Detalle] [varchar](60) NULL,
 CONSTRAINT [PK_Lista_estado] PRIMARY KEY CLUSTERED 
(
	[cod_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_extensionUnidad]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_extensionUnidad](
	[cod_extension] [int] NOT NULL,
	[detalle] [varchar](60) NULL,
 CONSTRAINT [PK_lista_extensionUnidad] PRIMARY KEY CLUSTERED 
(
	[cod_extension] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_habilitacion]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_habilitacion](
	[cod_habilitacion] [int] NOT NULL,
	[detalle] [varchar](60) NULL,
 CONSTRAINT [PK_tipo_habilitacion] PRIMARY KEY CLUSTERED 
(
	[cod_habilitacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Lista_moneda]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Lista_moneda](
	[cod_modena] [int] NOT NULL,
	[detalle] [varchar](60) NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_Lista_moneda] PRIMARY KEY CLUSTERED 
(
	[cod_modena] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_nivelAutoridad]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_nivelAutoridad](
	[cod_nivel_autoridad] [int] NOT NULL,
	[detalle] [varchar](60) NULL,
 CONSTRAINT [PK_Tipo_Rol_Autoridad] PRIMARY KEY CLUSTERED 
(
	[cod_nivel_autoridad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_nivelBibliografico]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_nivelBibliografico](
	[cod_nivel_bibliografico] [int] NOT NULL,
	[detalle] [varchar](50) NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_tipo_nivel_bibliografico] PRIMARY KEY CLUSTERED 
(
	[cod_nivel_bibliografico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_obra]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_obra](
	[cod_tipo_obra] [int] NOT NULL,
	[detalle] [varchar](60) NOT NULL,
	[es_especial] [int] NULL,
	[dias_por_defecto] [int] NULL,
	[conferencia] [int] NULL,
 CONSTRAINT [PK_tipo_obra] PRIMARY KEY CLUSTERED 
(
	[cod_tipo_obra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_responsabiliad]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_responsabiliad](
	[cod_responsabilidad] [int] NOT NULL,
	[detalle] [varchar](69) NOT NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_tipo_responsabiliad] PRIMARY KEY CLUSTERED 
(
	[cod_responsabilidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_soporte]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_soporte](
	[cod_soporte] [int] NOT NULL,
	[detalle] [varchar](60) NULL,
	[reproduccion] [int] NULL,
	[icono] [varchar](50) NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_tipo_soporte] PRIMARY KEY CLUSTERED 
(
	[cod_soporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_tipoArchivo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_tipoArchivo](
	[cod_tipo_archivo] [int] NOT NULL,
	[Detalle] [varchar](60) NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_Lista_tipoArchivo] PRIMARY KEY CLUSTERED 
(
	[cod_tipo_archivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_tipoColeccion]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_tipoColeccion](
	[cod_coleccion] [int] NOT NULL,
	[detalle] [varchar](60) NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_lista_tipocoleccion] PRIMARY KEY CLUSTERED 
(
	[cod_coleccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lista_TipoPrestamo]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lista_TipoPrestamo](
	[cod_prestamo] [int] NOT NULL,
	[Detalle] [varchar](60) NULL,
 CONSTRAINT [PK_Lista_TipoPrestamo] PRIMARY KEY CLUSTERED 
(
	[cod_prestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[lLista_tipoClasificador]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[lLista_tipoClasificador](
	[cod_clasificador] [int] NOT NULL,
	[Detalle] [varchar](60) NULL,
 CONSTRAINT [PK_Lista_TipoClasificador] PRIMARY KEY CLUSTERED 
(
	[cod_clasificador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[localizacion]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[localizacion](
	[cod_localizacion] [char](3) NOT NULL,
	[nombre] [varchar](100) NULL,
	[carpeta] [varchar](50) NULL,
	[direccion_postal] [varchar](8) NULL,
	[Direccion] [varchar](100) NULL,
	[NombreArchivo_foto] [varchar](100) NULL,
	[fecha_ingreso] [datetime] NULL,
	[fecha_modificacion] [datetime] NULL,
	[operador_ingreso] [int] NULL,
	[operador_modificacion] [int] NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_localizacion] PRIMARY KEY CLUSTERED 
(
	[cod_localizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[obra]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[obra](
	[cod_obra] [int] IDENTITY(1,1) NOT NULL,
	[cod_biblioteca] [char](1) NOT NULL,
	[cod_nivel_bibliografico] [int] NULL,
	[cod_coleccion] [int] NULL,
	[cod_tipo_obra] [int] NULL,
	[cod_soporte] [int] NULL,
	[cod_encabezamiento] [int] NULL,
	[titulo_corto] [varchar](50) NULL,
	[titulo] [varchar](300) NULL,
	[titulo_uniforme] [varchar](300) NULL,
	[edicion] [varchar](50) NULL,
	[cod_pais] [char](2) NULL,
	[frecuencia] [varchar](50) NULL,
	[lugar] [varchar](50) NULL,
	[fecha_edicion_inicio] [date] NULL,
	[fecha_edicion_final] [date] NULL,
	[preliminares] [varchar](225) NULL,
	[extension] [int] NULL,
	[cod_extension] [int] NULL,
	[extension_secundaria] [int] NULL,
	[extension_secundaria_unidad] [int] NULL,
	[ilustracion] [varchar](50) NULL,
	[alto] [int] NULL,
	[ancho] [int] NULL,
	[profundidad] [int] NULL,
	[unidad] [int] NULL,
	[complemento] [varchar](100) NULL,
	[obra_padre_codigo] [int] NULL,
	[obra_padre_biblioteca] [char](1) NULL,
	[orden_coleccion] [int] NULL,
	[serie_inicio] [int] NULL,
	[serie_fin] [int] NULL,
	[serie_ano_real] [int] NULL,
	[serie_ano_interno] [int] NULL,
	[serie_volumen] [varchar](50) NULL,
	[serie_fecha] [date] NULL,
	[area_especifica] [varchar](100) NULL,
	[epoca_inicio] [int] NULL,
	[epoca_fin] [int] NULL,
	[notas] [varchar](2000) NULL,
	[resumen] [varchar](2000) NULL,
	[resumen_idioma] [char](2) NULL,
	[titulo_original] [varchar](2300) NULL,
	[titulo_original_idioma] [char](10) NULL,
	[isbn] [varchar](50) NULL,
	[coden] [varchar](50) NULL,
	[otros] [varchar](50) NULL,
	[observaciones] [varchar](4000) NULL,
	[cod_estado] [int] NULL,
	[cod_habilitacion] [int] NULL,
	[destino] [varchar](50) NULL,
	[extra] [varchar](100) NULL,
	[cita_html] [varchar](1000) NULL,
	[cantidad_ejemplar] [int] NULL,
	[cantidad_imagen] [int] NULL,
	[tiene_texto_completo] [int] NULL,
	[registro_estado_cod] [int] NULL,
	[fecha_ingreso] [datetime] NULL,
	[fecha_modificacion] [datetime] NULL,
	[cod_operador_ingreso] [int] NULL,
	[cod_operador_modif] [int] NULL,
 CONSTRAINT [PK_obra_1] PRIMARY KEY CLUSTERED 
(
	[cod_obra] ASC,
	[cod_biblioteca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[obra_autoridad]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[obra_autoridad](
	[cod_autoridad] [int] IDENTITY(1,1) NOT NULL,
	[cod_biblioteca] [char](1) NOT NULL,
	[cod_obra] [int] NOT NULL,
	[cod_responsabilidad] [int] NULL,
	[cod_nivel_autoridad] [int] NULL,
	[orden] [int] NULL,
 CONSTRAINT [PK_obra_autoridad] PRIMARY KEY CLUSTERED 
(
	[cod_autoridad] ASC,
	[cod_biblioteca] ASC,
	[cod_obra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[obra_clasificador]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[obra_clasificador](
	[cod_biblioteca] [char](1) NOT NULL,
	[cod_obra] [int] NOT NULL,
	[cod_clasificador] [int] NOT NULL,
	[ordern] [int] NULL,
 CONSTRAINT [PK_obra_Clasificador] PRIMARY KEY CLUSTERED 
(
	[cod_biblioteca] ASC,
	[cod_obra] ASC,
	[cod_clasificador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[obra_idioma]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[obra_idioma](
	[cod_biblioteca] [char](1) NOT NULL,
	[cod_obra] [int] NOT NULL,
	[cod_idioma] [char](2) NOT NULL,
 CONSTRAINT [PK_obra_idioma] PRIMARY KEY CLUSTERED 
(
	[cod_biblioteca] ASC,
	[cod_obra] ASC,
	[cod_idioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[operador]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[operador](
	[cod_operador] [int] NOT NULL,
	[email] [nvarchar](50) NULL,
	[password] [char](20) NULL,
	[cod_habilitacion] [int] NULL,
	[cod_rol] [int] NULL,
 CONSTRAINT [PK_Operador] PRIMARY KEY CLUSTERED 
(
	[cod_operador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[pais]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pais](
	[cod_pais] [char](2) NOT NULL,
	[detalle] [varchar](60) NOT NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_pais] PRIMARY KEY CLUSTERED 
(
	[cod_pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[patente]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[patente](
	[cod_patente] [int] NOT NULL,
	[detalle] [varchar](50) NULL,
	[Padre] [int] NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_Patente] PRIMARY KEY CLUSTERED 
(
	[cod_patente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[patente_rol]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[patente_rol](
	[cod_rol] [int] NOT NULL,
	[cod_patente] [int] NOT NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_Patente_rol] PRIMARY KEY CLUSTERED 
(
	[cod_rol] ASC,
	[cod_patente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[proveedor]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[proveedor](
	[cod_proveedor] [int] NOT NULL,
	[detalle] [varchar](60) NULL,
	[telefono] [varchar](60) NULL,
	[correoElectronico] [varchar](180) NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_proveedor] PRIMARY KEY CLUSTERED 
(
	[cod_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[rol]    Script Date: 29/11/2018 8:28:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[rol](
	[cod_rol] [int] NOT NULL,
	[detalle] [varchar](50) NULL,
	[cod_habilitacion] [int] NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[cod_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B00EF3D7B AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B00F01149 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B00F70F7C AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B010E9337 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B010E948F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B010F1258 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B0118C857 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B011B10C9 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B011B997C AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B011C5EA9 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B012D6D46 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B01352B24 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B0137431B AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B014E7674 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B0150575F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B016353CE AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B0163AA0C AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C00962026 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C0096C5C9 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C00ADE92F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C0100097C AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C011AF22F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C0121F014 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C0124A48A AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C0149C5DC AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C014ACB1B AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C014ACB1B AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C014B7998 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C014C3D90 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D00A67DE5 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D00AA6594 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D00CB105C AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D01131551 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D01277314 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D013AA20F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D013C2853 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D013CDA66 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D013D0349 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D0140C86D AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D0142D86E AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00A192BE AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00A41C38 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00ADB5C0 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00B0C241 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00B1AD5F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00B27FBE AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00B3AD55 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00B60D43 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00C1128D AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00C1F01D AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00C33CD7 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00CA25BC AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00CBF3F5 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00CCFBBA AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00D72E61 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00FA3173 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00FE1AA4 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00FF042E AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E0108BC22 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E0109FDE8 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E0143EA49 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E0145335D AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E0147E466 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E0148B110 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'1', N'Grupo', N'Alta', N'Guardo cambios', CAST(0x0000A54E0148EE45 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'2', N'Grupo', N'Modificacion', N'Guardo cambios', CAST(0x0000A54E01498591 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'2', N'Grupo', N'Modificacion', N'Guardo cambios', CAST(0x0000A54E0149C7AA AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'2', N'Grupo', N'Modificacion', N'Guardo cambios', CAST(0x0000A54E0149E9A8 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'2', N'Grupo', N'Modificacion', N'Guardo cambios', CAST(0x0000A54E014A67FD AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E0155CC1E AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E01571B72 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'6', N'Grupo', N'Alta', N'Guardo cambios', CAST(0x0000A54E01572CD3 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'7', N'Grupo', N'Alta', N'Guardo cambios', CAST(0x0000A54E01574D22 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'8', N'Grupo', N'Alta', N'Guardo cambios', CAST(0x0000A54E0157631C AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E0158E2D9 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B013025B9 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54B01342B35 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C00B9375B AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C015656DD AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'1 10', N'Ejemplar', N'Alta', N'Guardo cambios', CAST(0x0000A54C01569188 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'2 91', N'Ejemplar', N'Alta', N'Guardo cambios', CAST(0x0000A54C015B9660 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'3 10', N'Ejemplar', N'Alta', N'Guardo cambios', CAST(0x0000A54C015BD1C5 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'4 300', N'Ejemplar', N'Alta', N'Guardo cambios', CAST(0x0000A54C015C5ACD AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'5 97', N'Ejemplar', N'Alta', N'Guardo cambios', CAST(0x0000A54C015D65D6 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C015FD173 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C0160D15A AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C0160D2D8 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'6 400', N'Ejemplar', N'Alta', N'Guardo cambios', CAST(0x0000A54C01614E73 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'200 400', N'Ejemplar', N'Alta', N'Guardo cambios', CAST(0x0000A54C01619793 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'201 400', N'Ejemplar', N'Alta', N'Guardo cambios', CAST(0x0000A54C0161D653 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D00E917C0 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D00F71DA9 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D01170CDF AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D011C57DC AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D011E8AE8 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'', N'Grupo', N'Alta', N'Guardo cambios', CAST(0x0000A54E0144C408 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'3', N'Autoridad', N'Borrado', N'Guardo cambios', CAST(0x0000A54E01592E75 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00A80FB5 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F010B2247 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F010BA357 AS DateTime), N'00001')
GO
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F010C133C AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F010D386E AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A54F01104C15 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A54F01112331 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A54F011175F6 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A54F01120E5A AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F01246F51 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F01269520 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A54F01284CA5 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A54F01297AD7 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F012999A5 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A551011AC4EB AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A551011B0803 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55101220309 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A551012500C2 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55101265416 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A551012743D8 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A5510128EBE3 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A5510133F242 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55101427ECE AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55101430344 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55101476C0D AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A5510162B5EE AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A5510164269D AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200A3770C AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200A482F6 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200A95050 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200AA4A62 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200AADE01 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200AE948D AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200B99118 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200BA4B85 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200BE33D6 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200BEC253 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200C063B0 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200C34164 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200C77F55 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200C95C1C AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54C0154368B AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54D00B39048 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E00ACDEAC AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E013EBD0F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E013F1FC5 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00AE1B3E AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A5510135F4F1 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200CE33C8 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200CF6BAE AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200CFF05F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200D0F6E8 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200D1C53F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Usuario', N'Modificacion', N'Cambio de Clave', CAST(0x0000A55200D1D146 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200D2535B AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Usuario', N'Modificacion', N'Cambio de Clave', CAST(0x0000A55200D263C0 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200D27ADF AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Usuario', N'Modificacion', N'Cambio de Clave', CAST(0x0000A55200D2A0FB AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200D3E89D AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Usuario', N'Modificacion', N'Cambio de Clave', CAST(0x0000A55200D3F29F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Usuario', N'Modificacion', N'Cambio de Clave', CAST(0x0000A55200D3FA80 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55200D4074D AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5520147C5BD AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A553008B1D74 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A553008BD4C4 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A553008EA92B AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5530096FED9 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A553009ED7AD AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A55300A07A5F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55300A3768C AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A553010B1803 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55400C1A4D2 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55400C2095F AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'8', N'Autoridad', N'Alta', N'Guardo cambios', CAST(0x0000A55400C279A0 AS DateTime), N'')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55400C33666 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55400C7454C AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5540101491A AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5540110847D AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5540116E680 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55401398883 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Sistema', N'Ingreso UsuarioBackEND', N'Ingreso al sistema', CAST(0x0000A554013D753B AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55500A3BF62 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55500F5DF0A AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A555012DECF4 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55600A7C394 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55600D88D7C AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55600DA44E4 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A556010FE5CA AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5560110C26B AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55601114106 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55601130CC6 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A557013C5A5F AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55701436772 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55800D72B72 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'1', N'Clasificador + DescriptorDato', N'Alta', N'Guardo cambios', CAST(0x0000A55800D755EB AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55800D82FDD AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55800D8340E AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'2', N'Clasificador + DescriptorDato', N'Alta', N'Guardo cambios', CAST(0x0000A55800D85CC1 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'3', N'Clasificador + DescriptorDato', N'Alta', N'Guardo cambios', CAST(0x0000A55800D8830A AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55800D96C79 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55800DE66C4 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55800E1C21F AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55800EF3957 AS DateTime), N'1')
GO
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5580128D73E AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5580128DAD1 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A558012AD127 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A558012B4631 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55801301FF9 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55F00C49B62 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55F00D21493 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56000B8C011 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56000F14EBB AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E014C48B4 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'1', N'Grupo', N'Modificacion', N'Guardo cambios', CAST(0x0000A54E014CAE59 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'2', N'Grupo', N'Alta', N'Guardo cambios', CAST(0x0000A54E014D15F0 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E014EE9D3 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'3', N'Grupo', N'Alta', N'Guardo cambios', CAST(0x0000A54E014F2D55 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E0150A253 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E01519655 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E01521DD2 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'4', N'Grupo', N'Alta', N'Guardo cambios', CAST(0x0000A54E01524602 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54E0152A086 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'5', N'Grupo', N'Alta', N'Guardo cambios', CAST(0x0000A54E0152EA2A AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00B584C6 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00C662D2 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00C81EC9 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00C92CD7 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N' ', N'Usuario', N'Habilitacion Usuario', N'Pago Deuda', CAST(0x0000A54F00C9AB77 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N' ', N'Usuario', N'Habilitacion Usuario', N'Lo pidio el director', CAST(0x0000A54F00CA5492 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'', N'Usuario', N'Habilitacion Usuario', N'ssadasdasdas', CAST(0x0000A54F00CBD866 AS DateTime), N'')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00CC75D2 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Usuario', N'Habilitacion Usuario', N'Hijo del Dueño', CAST(0x0000A54F00CC98B1 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00001', N'Usuario', N'Habilitacion Usuario', N'asdasdasdasdasd', CAST(0x0000A54F00CD0859 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00CDB9B8 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00CE22AD AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00004', N'Usuario', N'Habilitacion Usuario', N'zzzzzzzzzzzzzzzzzz', CAST(0x0000A54F00CE3895 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00CEA0BE AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'00004', N'Usuario', N'Habilitacion Usuario', N'dasdasdasdasd', CAST(0x0000A54F00CEC347 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00F35A0F AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00F3E7C3 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F00FEFA97 AS DateTime), N'00001')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F01218A33 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F0121960A AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F0121B7F8 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F01238244 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A54F0123DEFD AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55600DFA692 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'202 70', N'Ejemplar', N'Alta', N'Guardo cambios', CAST(0x0000A55600E11DA3 AS DateTime), N'')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56500AD9769 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A567013B777C AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A567013F007E AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56701434BE6 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56701468E7C AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56701492A50 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5670149D50B AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A567014BF927 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56701509FBA AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5670151612A AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5670157F4D2 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5670158DF30 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5670159A749 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A567015A8F29 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A567015A91A2 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5670166F433 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A567016817BA AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56701697029 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A567016AF1F7 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56800A960C2 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56800C040DC AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56800C13188 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56800C49328 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56800F585C6 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56801090C59 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A568010C30CF AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A568016ADE57 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A568016DD9EF AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C0120C049 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C012148D0 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A554011B01CD AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A554011B0440 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'7', N'Autoridad', N'Modificacion', N'Guardo cambios', CAST(0x0000A554011B540B AS DateTime), N'')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'6', N'Autoridad', N'Modificacion', N'Guardo cambios', CAST(0x0000A554011B68C4 AS DateTime), N'')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'5', N'Autoridad', N'Modificacion', N'Guardo cambios', CAST(0x0000A554011B83E0 AS DateTime), N'')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'4', N'Autoridad', N'Modificacion', N'Guardo cambios', CAST(0x0000A554011B9ADA AS DateTime), N'')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5550119CC54 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A555012C7B96 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5550132FFEE AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55501372B6E AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A555014DCD45 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55600D3F9FB AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55600DB6741 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5580122137C AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5670142C470 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A568010AF432 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00BB6EF4 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55600B8FA07 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A55600BC048F AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56800CE5613 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A556010E3262 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A557014EAFDF AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A560010B248D AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56800C656D2 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00B302BC AS DateTime), N'1')
GO
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00B3CEFB AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00BC8B55 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00C162DF AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00C31370 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00C488CA AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00C51B4A AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00C5CDFF AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00C6B915 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00C706E5 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00C7822F AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00CACC33 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00CB6730 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00CC8FE9 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00CF5344 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00D0BFF6 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C00D24572 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C0104A9F1 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C0108D7E1 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C0109BD75 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C010ACD09 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C010BD14D AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C010C739E AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C010D6D1D AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C010F2456 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C01100F5D AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56000B320FB AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56000FD2745 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56000FE75D8 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56001006E7D AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56001185E2E AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5600118C0D4 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56800A8AC2A AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5680148A818 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5680151A994 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5680153A125 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56801546A2C AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56801555DBB AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5680155AE4F AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A568015803A4 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A568015B30B5 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C01251172 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C012AFAC7 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C012C0004 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C012CF87C AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C012DF3BC AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C012EA39D AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56C012F3BCA AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A568016FBDA6 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56801712736 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A56801728032 AS DateTime), N'1')
INSERT [dbo].[bitacora] ([cod_entidad], [entidad], [operacion], [detalle], [fecha], [cod_operador]) VALUES (N'0', N'Sistema', N'Ingreso', N'Ingreso al sistema', CAST(0x0000A5680174E849 AS DateTime), N'1')
SET IDENTITY_INSERT [dbo].[clasificador] ON 

INSERT [dbo].[clasificador] ([cod_clasificador], [fuente], [clasificador_decimal], [observaciones], [tipo_clasificador], [cod_habilitacion], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion]) VALUES (1, N'CDD', N'801', N'Clasificador de Arquitectura', 1, 1, CAST(0x0000A55800D755E3 AS DateTime), CAST(0x0000A55800D755E3 AS DateTime), N'1', N'1')
INSERT [dbo].[clasificador] ([cod_clasificador], [fuente], [clasificador_decimal], [observaciones], [tipo_clasificador], [cod_habilitacion], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion]) VALUES (2, N'CDD', N'803', N'Descriptor Decimal Informatica', 2, 1, CAST(0x0000A55800D85CBE AS DateTime), CAST(0x0000A55800D85CBE AS DateTime), N'1', N'1')
INSERT [dbo].[clasificador] ([cod_clasificador], [fuente], [clasificador_decimal], [observaciones], [tipo_clasificador], [cod_habilitacion], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion]) VALUES (3, N'LEMB', N'Computacion Nivel 1', N'Computacion Nivel 1', 3, 1, CAST(0x0000A55800D88307 AS DateTime), CAST(0x0000A55800D88307 AS DateTime), N'1', N'1')
SET IDENTITY_INSERT [dbo].[clasificador] OFF
INSERT [dbo].[idioma] ([cod_idioma], [detalle], [registro_estado_cod], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion], [cod_habilitacion]) VALUES (N'01', N'Castellano', 1, CAST(0x0000A54300000000 AS DateTime), CAST(0x0000A54300000000 AS DateTime), 1, 1, NULL)
INSERT [dbo].[idioma] ([cod_idioma], [detalle], [registro_estado_cod], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion], [cod_habilitacion]) VALUES (N'02', N'Ingles', 1, CAST(0x0000A54300000000 AS DateTime), CAST(0x0000A54300000000 AS DateTime), 1, 1, NULL)
INSERT [dbo].[idioma] ([cod_idioma], [detalle], [registro_estado_cod], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion], [cod_habilitacion]) VALUES (N'03', N'Frances', 1, CAST(0x0000A54300000000 AS DateTime), CAST(0x0000A54300000000 AS DateTime), 1, 1, NULL)
INSERT [dbo].[idioma] ([cod_idioma], [detalle], [registro_estado_cod], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion], [cod_habilitacion]) VALUES (N'04', N'Portugues', 1, CAST(0x0000A54300000000 AS DateTime), CAST(0x0000A54300000000 AS DateTime), 1, 1, NULL)
INSERT [dbo].[idioma] ([cod_idioma], [detalle], [registro_estado_cod], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion], [cod_habilitacion]) VALUES (N'05', N'Aleman', 1, CAST(0x0000A54300000000 AS DateTime), CAST(0x0000A54300000000 AS DateTime), 1, 1, NULL)
INSERT [dbo].[lista_encabezamiento] ([cod_encabezamiento], [detalle]) VALUES (1, N'Personal')
INSERT [dbo].[lista_encabezamiento] ([cod_encabezamiento], [detalle]) VALUES (2, N'Institucional')
INSERT [dbo].[lista_encabezamiento] ([cod_encabezamiento], [detalle]) VALUES (3, N'Evento')
INSERT [dbo].[lista_encabezamiento] ([cod_encabezamiento], [detalle]) VALUES (4, N'Titulo')
INSERT [dbo].[lista_nivelAutoridad] ([cod_nivel_autoridad], [detalle]) VALUES (1, N'Principal')
INSERT [dbo].[lista_nivelAutoridad] ([cod_nivel_autoridad], [detalle]) VALUES (2, N'Secundario')
INSERT [dbo].[lista_nivelBibliografico] ([cod_nivel_bibliografico], [detalle], [cod_habilitacion]) VALUES (1, N'Monografia.', NULL)
INSERT [dbo].[lista_nivelBibliografico] ([cod_nivel_bibliografico], [detalle], [cod_habilitacion]) VALUES (2, N'Coleccion.', NULL)
INSERT [dbo].[lista_nivelBibliografico] ([cod_nivel_bibliografico], [detalle], [cod_habilitacion]) VALUES (3, N'P.S Existencia.', NULL)
INSERT [dbo].[lista_nivelBibliografico] ([cod_nivel_bibliografico], [detalle], [cod_habilitacion]) VALUES (4, N'Pub. Seriada.', NULL)
INSERT [dbo].[lista_nivelBibliografico] ([cod_nivel_bibliografico], [detalle], [cod_habilitacion]) VALUES (5, N'Analitica.', NULL)
INSERT [dbo].[lista_responsabiliad] ([cod_responsabilidad], [detalle], [cod_habilitacion]) VALUES (1, N'Persona', NULL)
INSERT [dbo].[lista_responsabiliad] ([cod_responsabilidad], [detalle], [cod_habilitacion]) VALUES (2, N'Evento', NULL)
INSERT [dbo].[lista_responsabiliad] ([cod_responsabilidad], [detalle], [cod_habilitacion]) VALUES (3, N'Proyecto', NULL)
INSERT [dbo].[lista_responsabiliad] ([cod_responsabilidad], [detalle], [cod_habilitacion]) VALUES (4, N'Institucion', NULL)
INSERT [dbo].[lista_responsabiliad] ([cod_responsabilidad], [detalle], [cod_habilitacion]) VALUES (5, N'Tesis', NULL)
INSERT [dbo].[lista_soporte] ([cod_soporte], [detalle], [reproduccion], [icono], [cod_habilitacion]) VALUES (1, N'DVD', 1, NULL, NULL)
INSERT [dbo].[lista_soporte] ([cod_soporte], [detalle], [reproduccion], [icono], [cod_habilitacion]) VALUES (2, N'CD', 1, NULL, NULL)
INSERT [dbo].[lista_soporte] ([cod_soporte], [detalle], [reproduccion], [icono], [cod_habilitacion]) VALUES (3, N'LIBRO DIGITAL', 1, NULL, NULL)
INSERT [dbo].[lista_soporte] ([cod_soporte], [detalle], [reproduccion], [icono], [cod_habilitacion]) VALUES (4, N'LIBRO FISICO', 1, NULL, NULL)
INSERT [dbo].[lLista_tipoClasificador] ([cod_clasificador], [Detalle]) VALUES (1, N'Descriptor')
INSERT [dbo].[lLista_tipoClasificador] ([cod_clasificador], [Detalle]) VALUES (2, N'Indicador')
INSERT [dbo].[lLista_tipoClasificador] ([cod_clasificador], [Detalle]) VALUES (3, N'Palabra clave')
INSERT [dbo].[localizacion] ([cod_localizacion], [nombre], [carpeta], [direccion_postal], [Direccion], [NombreArchivo_foto], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion], [cod_habilitacion]) VALUES (N'44 ', N'4448', N'444', N'444', N'4444', N'', CAST(0x0000A54200B0CD62 AS DateTime), CAST(0x0000A54200B1AD50 AS DateTime), 1, 2, NULL)
INSERT [dbo].[localizacion] ([cod_localizacion], [nombre], [carpeta], [direccion_postal], [Direccion], [NombreArchivo_foto], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion], [cod_habilitacion]) VALUES (N'77 ', N'lomas', N'/lomas', N'1882', N'ss', N'favicon[1].ico', CAST(0x0000A54500A8F208 AS DateTime), CAST(0x0000A54500A8F208 AS DateTime), 1, 1, NULL)
INSERT [dbo].[localizacion] ([cod_localizacion], [nombre], [carpeta], [direccion_postal], [Direccion], [NombreArchivo_foto], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion], [cod_habilitacion]) VALUES (N'88 ', N'Irlanda', N'popp', N'upo', N'sdasda', N'Biblioteca.txt', CAST(0x0000A54200AA86A6 AS DateTime), CAST(0x0000A54200B4A4E9 AS DateTime), 1, 2, NULL)
INSERT [dbo].[localizacion] ([cod_localizacion], [nombre], [carpeta], [direccion_postal], [Direccion], [NombreArchivo_foto], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion], [cod_habilitacion]) VALUES (N'98 ', N'456', N'5464', N'465464', N'asdasdad', N'chrome.exe', CAST(0x0000A54200B91C50 AS DateTime), CAST(0x0000A54200B91C50 AS DateTime), 1, 1, NULL)
INSERT [dbo].[localizacion] ([cod_localizacion], [nombre], [carpeta], [direccion_postal], [Direccion], [NombreArchivo_foto], [fecha_ingreso], [fecha_modificacion], [operador_ingreso], [operador_modificacion], [cod_habilitacion]) VALUES (N'99 ', N'Argentina', N'9875sd', N'6562', N'9999, 9999', N'', CAST(0x0000A54100D11DA5 AS DateTime), CAST(0x0000A54401878EF0 AS DateTime), 1, 2, NULL)
ALTER TABLE [dbo].[adicional]  WITH CHECK ADD  CONSTRAINT [FK_adicional_Lista_tipoArchivo] FOREIGN KEY([cod_tipo_archivo])
REFERENCES [dbo].[lista_tipoArchivo] ([cod_tipo_archivo])
GO
ALTER TABLE [dbo].[adicional] CHECK CONSTRAINT [FK_adicional_Lista_tipoArchivo]
GO
ALTER TABLE [dbo].[adicional]  WITH CHECK ADD  CONSTRAINT [FK_adicional_localizacion] FOREIGN KEY([cod_localizacion])
REFERENCES [dbo].[localizacion] ([cod_localizacion])
GO
ALTER TABLE [dbo].[adicional] CHECK CONSTRAINT [FK_adicional_localizacion]
GO
ALTER TABLE [dbo].[autoridad]  WITH CHECK ADD  CONSTRAINT [FK_autoridad_idioma] FOREIGN KEY([cod_idioma])
REFERENCES [dbo].[idioma] ([cod_idioma])
GO
ALTER TABLE [dbo].[autoridad] CHECK CONSTRAINT [FK_autoridad_idioma]
GO
ALTER TABLE [dbo].[autoridad]  WITH CHECK ADD  CONSTRAINT [FK_autoridad_pais] FOREIGN KEY([cod_pais])
REFERENCES [dbo].[pais] ([cod_pais])
GO
ALTER TABLE [dbo].[autoridad] CHECK CONSTRAINT [FK_autoridad_pais]
GO
ALTER TABLE [dbo].[clasificador]  WITH CHECK ADD  CONSTRAINT [FK_Clasificador_Lista_TipoClasificador] FOREIGN KEY([tipo_clasificador])
REFERENCES [dbo].[lLista_tipoClasificador] ([cod_clasificador])
GO
ALTER TABLE [dbo].[clasificador] CHECK CONSTRAINT [FK_Clasificador_Lista_TipoClasificador]
GO
ALTER TABLE [dbo].[ejemplar]  WITH CHECK ADD  CONSTRAINT [FK_ejemplar_Lista_estado] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[lista_estado] ([cod_estado])
GO
ALTER TABLE [dbo].[ejemplar] CHECK CONSTRAINT [FK_ejemplar_Lista_estado]
GO
ALTER TABLE [dbo].[ejemplar]  WITH CHECK ADD  CONSTRAINT [FK_ejemplar_lista_habilitacion] FOREIGN KEY([cod_habilitacion])
REFERENCES [dbo].[lista_habilitacion] ([cod_habilitacion])
GO
ALTER TABLE [dbo].[ejemplar] CHECK CONSTRAINT [FK_ejemplar_lista_habilitacion]
GO
ALTER TABLE [dbo].[ejemplar]  WITH CHECK ADD  CONSTRAINT [FK_ejemplar_Lista_moneda] FOREIGN KEY([cod_modena])
REFERENCES [dbo].[Lista_moneda] ([cod_modena])
GO
ALTER TABLE [dbo].[ejemplar] CHECK CONSTRAINT [FK_ejemplar_Lista_moneda]
GO
ALTER TABLE [dbo].[ejemplar]  WITH CHECK ADD  CONSTRAINT [FK_ejemplar_Lista_TipoPrestamo] FOREIGN KEY([cod_prestamo])
REFERENCES [dbo].[lista_TipoPrestamo] ([cod_prestamo])
GO
ALTER TABLE [dbo].[ejemplar] CHECK CONSTRAINT [FK_ejemplar_Lista_TipoPrestamo]
GO
ALTER TABLE [dbo].[ejemplar]  WITH CHECK ADD  CONSTRAINT [FK_ejemplar_localizacion] FOREIGN KEY([cod_localizacion])
REFERENCES [dbo].[localizacion] ([cod_localizacion])
GO
ALTER TABLE [dbo].[ejemplar] CHECK CONSTRAINT [FK_ejemplar_localizacion]
GO
ALTER TABLE [dbo].[ejemplar]  WITH CHECK ADD  CONSTRAINT [FK_ejemplar_proveedor] FOREIGN KEY([cod_proveedor])
REFERENCES [dbo].[proveedor] ([cod_proveedor])
GO
ALTER TABLE [dbo].[ejemplar] CHECK CONSTRAINT [FK_ejemplar_proveedor]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_lista_encabezamiento] FOREIGN KEY([cod_encabezamiento])
REFERENCES [dbo].[lista_encabezamiento] ([cod_encabezamiento])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_lista_encabezamiento]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_Lista_estado] FOREIGN KEY([cod_estado])
REFERENCES [dbo].[lista_estado] ([cod_estado])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_Lista_estado]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_lista_extensionUnidad] FOREIGN KEY([cod_extension])
REFERENCES [dbo].[lista_extensionUnidad] ([cod_extension])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_lista_extensionUnidad]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_lista_habilitacion] FOREIGN KEY([cod_habilitacion])
REFERENCES [dbo].[lista_habilitacion] ([cod_habilitacion])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_lista_habilitacion]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_lista_nivel_bibliografico] FOREIGN KEY([cod_nivel_bibliografico])
REFERENCES [dbo].[lista_nivelBibliografico] ([cod_nivel_bibliografico])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_lista_nivel_bibliografico]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_lista_obra] FOREIGN KEY([cod_tipo_obra])
REFERENCES [dbo].[lista_obra] ([cod_tipo_obra])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_lista_obra]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_lista_Soporte] FOREIGN KEY([cod_soporte])
REFERENCES [dbo].[lista_soporte] ([cod_soporte])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_lista_Soporte]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_lista_tipocoleccion] FOREIGN KEY([cod_coleccion])
REFERENCES [dbo].[lista_tipoColeccion] ([cod_coleccion])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_lista_tipocoleccion]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_obra] FOREIGN KEY([obra_padre_codigo], [obra_padre_biblioteca])
REFERENCES [dbo].[obra] ([cod_obra], [cod_biblioteca])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_obra]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_Operador] FOREIGN KEY([cod_operador_ingreso])
REFERENCES [dbo].[operador] ([cod_operador])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_Operador]
GO
ALTER TABLE [dbo].[obra]  WITH CHECK ADD  CONSTRAINT [FK_obra_pais] FOREIGN KEY([cod_pais])
REFERENCES [dbo].[pais] ([cod_pais])
GO
ALTER TABLE [dbo].[obra] CHECK CONSTRAINT [FK_obra_pais]
GO
ALTER TABLE [dbo].[obra_autoridad]  WITH CHECK ADD  CONSTRAINT [FK_obra_autoridad_autoridad] FOREIGN KEY([cod_autoridad])
REFERENCES [dbo].[autoridad] ([cod_autoridad])
GO
ALTER TABLE [dbo].[obra_autoridad] CHECK CONSTRAINT [FK_obra_autoridad_autoridad]
GO
ALTER TABLE [dbo].[obra_autoridad]  WITH CHECK ADD  CONSTRAINT [FK_obra_autoridad_lista_nivelAutoridad] FOREIGN KEY([cod_nivel_autoridad])
REFERENCES [dbo].[lista_nivelAutoridad] ([cod_nivel_autoridad])
GO
ALTER TABLE [dbo].[obra_autoridad] CHECK CONSTRAINT [FK_obra_autoridad_lista_nivelAutoridad]
GO
ALTER TABLE [dbo].[obra_autoridad]  WITH CHECK ADD  CONSTRAINT [FK_obra_autoridad_lista_responsabiliad] FOREIGN KEY([cod_responsabilidad])
REFERENCES [dbo].[lista_responsabiliad] ([cod_responsabilidad])
GO
ALTER TABLE [dbo].[obra_autoridad] CHECK CONSTRAINT [FK_obra_autoridad_lista_responsabiliad]
GO
ALTER TABLE [dbo].[obra_autoridad]  WITH CHECK ADD  CONSTRAINT [FK_obra_autoridad_obra] FOREIGN KEY([cod_obra], [cod_biblioteca])
REFERENCES [dbo].[obra] ([cod_obra], [cod_biblioteca])
GO
ALTER TABLE [dbo].[obra_autoridad] CHECK CONSTRAINT [FK_obra_autoridad_obra]
GO
ALTER TABLE [dbo].[obra_clasificador]  WITH CHECK ADD  CONSTRAINT [FK_obra_Clasificador_Clasificador] FOREIGN KEY([cod_clasificador])
REFERENCES [dbo].[clasificador] ([cod_clasificador])
GO
ALTER TABLE [dbo].[obra_clasificador] CHECK CONSTRAINT [FK_obra_Clasificador_Clasificador]
GO
ALTER TABLE [dbo].[obra_clasificador]  WITH CHECK ADD  CONSTRAINT [FK_obra_Clasificador_obra] FOREIGN KEY([cod_obra], [cod_biblioteca])
REFERENCES [dbo].[obra] ([cod_obra], [cod_biblioteca])
GO
ALTER TABLE [dbo].[obra_clasificador] CHECK CONSTRAINT [FK_obra_Clasificador_obra]
GO
ALTER TABLE [dbo].[obra_idioma]  WITH CHECK ADD  CONSTRAINT [FK_obra_idioma_idioma] FOREIGN KEY([cod_idioma])
REFERENCES [dbo].[idioma] ([cod_idioma])
GO
ALTER TABLE [dbo].[obra_idioma] CHECK CONSTRAINT [FK_obra_idioma_idioma]
GO
ALTER TABLE [dbo].[obra_idioma]  WITH CHECK ADD  CONSTRAINT [FK_obra_idioma_obra] FOREIGN KEY([cod_obra], [cod_biblioteca])
REFERENCES [dbo].[obra] ([cod_obra], [cod_biblioteca])
GO
ALTER TABLE [dbo].[obra_idioma] CHECK CONSTRAINT [FK_obra_idioma_obra]
GO
ALTER TABLE [dbo].[operador]  WITH CHECK ADD  CONSTRAINT [FK_Operador_Rol] FOREIGN KEY([cod_rol])
REFERENCES [dbo].[rol] ([cod_rol])
GO
ALTER TABLE [dbo].[operador] CHECK CONSTRAINT [FK_Operador_Rol]
GO
ALTER TABLE [dbo].[patente]  WITH CHECK ADD  CONSTRAINT [FK_Patente_Patente] FOREIGN KEY([Padre])
REFERENCES [dbo].[patente] ([cod_patente])
GO
ALTER TABLE [dbo].[patente] CHECK CONSTRAINT [FK_Patente_Patente]
GO
ALTER TABLE [dbo].[patente_rol]  WITH CHECK ADD  CONSTRAINT [FK_Patente_rol_Patente] FOREIGN KEY([cod_patente])
REFERENCES [dbo].[patente] ([cod_patente])
GO
ALTER TABLE [dbo].[patente_rol] CHECK CONSTRAINT [FK_Patente_rol_Patente]
GO
ALTER TABLE [dbo].[patente_rol]  WITH CHECK ADD  CONSTRAINT [FK_Patente_rol_Rol] FOREIGN KEY([cod_rol])
REFERENCES [dbo].[rol] ([cod_rol])
GO
ALTER TABLE [dbo].[patente_rol] CHECK CONSTRAINT [FK_Patente_rol_Rol]
GO
USE [master]
GO
ALTER DATABASE [UAI_Biblioteca] SET  READ_WRITE 
GO
