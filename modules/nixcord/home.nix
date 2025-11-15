{...}: {
  programs.nixcord = {
    enable = true;
    vesktop = {
      enable = true;
    };

    config = {
      themeLinks = [
        "https://raw.githubusercontent.com/catppuccin/discord/refs/heads/main/themes/frappe.theme.css"
      ];
      frameless = true;
      plugins = {
        # anonymiseFileNames = {
        #   anonymiseByDefault = true;
        #   anonymiseFileNames.method = "timestamp";
        # };
        youtubeAdblock.enable = true;
        voiceChatDoubleClick.enable = true;
        noProfileThemes.enable = true;
        fixSpotifyEmbeds = {
          enable = true;
          volume = 5.0;
        };
        spotifyControls = {
          enable = true;
        };
        noPendingCount = {
          enable = true;
          hideFriendRequestsCount = false;
          hideMessageRequestCount = false;
          hidePremiumOffersCount = true;
        };
        fakeNitro = {
          enable = true;
        };
      };
    };
  };
}
