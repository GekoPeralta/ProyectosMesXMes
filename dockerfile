# Etapa de construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia el archivo .csproj desde la ruta correcta
COPY ProyectosMesXMes/_Evaluacion_Mensual_Abril/_Evaluacion_Mensual_Abril.csproj ./ 
RUN dotnet restore

# Copia el resto del proyecto
COPY ProyectosMesXMes/_Evaluacion_Mensual_Abril/. ./
RUN dotnet publish -c Release -o out

# Etapa de ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "_Evaluacion_Mensual_Abril.dll"]
