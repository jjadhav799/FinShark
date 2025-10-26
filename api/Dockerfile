# api/Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["api/", "./"]
# restore & build - adjust csproj path if different
RUN dotnet restore "api/FinShark.Api.csproj"
RUN dotnet publish "api/FinShark.Api.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
ENV ASPNETCORE_URLS=http://+:80
ENTRYPOINT ["dotnet", "FinShark.Api.dll"]
