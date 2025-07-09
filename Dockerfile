# Use .NET 8 SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy only the csproj file and restore dependencies
COPY LibraryEmailReminder.csproj ./
RUN dotnet restore LibraryEmailReminder.csproj

# Copy all source files
COPY . ./

# Publish the app
RUN dotnet publish LibraryEmailReminder.csproj -c Release -o out

# Use .NET 8 runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy the build output to the runtime image
COPY --from=build /app/out .

# Start the application
ENTRYPOINT ["dotnet", "LibraryEmailReminder.dll"]
