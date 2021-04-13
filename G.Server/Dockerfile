FROM mcr.microsoft.com/dotnet/core/runtime:3.1 AS base
EXPOSE 12345
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["G.Server/G.Server.csproj", "G.Server/"]
COPY ["G.Shared/G.Shared.csproj", "G.Shared/"]
RUN dotnet restore "G.Server/G.Server.csproj"
COPY . .
WORKDIR "/src/G.Server"
RUN dotnet build "G.Server.csproj" -c Debug -o /app

FROM build AS publish
RUN dotnet publish "G.Server.csproj" -c Debug -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "G.Server.dll"]