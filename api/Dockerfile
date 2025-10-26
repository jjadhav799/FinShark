# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project file and restore dependencies
COPY ["api.csproj", "./"]
RUN dotnet restore "api.csproj"

# Copy all other files and build
COPY . .
RUN dotnet publish "api.csproj" -c Release -o /app/publish

# Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Expose the port your app runs on (adjust if needed)
EXPOSE 5000
EXPOSE 8080

# Set environment variables
ENV ASPNETCORE_URLS=http://+:5000
ENV ASPNETCORE_ENVIRONMENT=Production

ENTRYPOINT ["dotnet", "api.dll"]
