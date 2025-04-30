# Etapa de compilación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar los archivos del proyecto y restaurar dependencias
COPY *.csproj ./
RUN dotnet restore

# Copiar el resto del proyecto y compilar
COPY . ./
RUN dotnet publish -c Release -o /app/out

# Etapa de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copiar archivos publicados desde la etapa anterior
COPY --from=build /app/out .

# Configurar el puerto para Render (Render escucha en el 8080)
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Comando para ejecutar la app
ENTRYPOINT ["dotnet", "_Evaluacion_Mensual_Abril.dll"]
