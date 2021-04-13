FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /work
COPY ./G.Server ./G.Server
COPY ./G.Shared ./G.Shared
COPY ./G.Unity/Assets/Scripts/ServerShared ./G.Unity/Assets/Scripts/ServerShared

RUN dotnet restore "G.Server/G.Server.csproj"
RUN dotnet publish "G.Server/G.Server.csproj" -c Release -o ./publish

FROM mcr.microsoft.com/dotnet/aspnet:5.0 as final
ENV PATH $PATH:/application
WORKDIR /application
COPY --from=build /work/publish .

ENV ASPNETCORE_URLS=https://+:5001
EXPOSE 5000
EXPOSE 5001
EXPOSE 5002
EXPOSE 12345
ENTRYPOINT ["dotnet", "G.Server.dll"]
