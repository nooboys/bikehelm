# Use the official .NET SDK 6.0 image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the necessary files to the container
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# Create a runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

WORKDIR /app

# Copy the published output from the build image
COPY --from=build /app/out .

# Set the entry point for the application
ENTRYPOINT ["dotnet", "BestBikeApp.dll"]
