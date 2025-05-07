{pkgs, ...}: {
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        jetbrains.rider # dotnet
        dotnet-sdk_9
        dotnet-sdk_10
        dotnet-runtime_9        
        dotnet-runtime_10
        
        remmina # rdp&vnc
        qbittorrent # torrent
        sqlitebrowser # db
        anydesk # remote desktop client
        yt-dlp        
      ];      
    })
  ];
}
