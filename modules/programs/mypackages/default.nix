{pkgs, ...}: {
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        jetbrains.rider # dotnet
        dotnet-sdk_9
        dotnet-runtime_9
        dotnet-ef
        code-cursor
        
        remmina # rdp&vnc
        qbittorrent # torrent
        sqlitebrowser # db
        anydesk # remote desktop client
        yt-dlp        
      ];      
    })
  ];
}
