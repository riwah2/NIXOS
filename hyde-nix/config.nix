{
  username = "riwah";
  gitUser = "riwah2";
  gitEmail = "abdellah28284@gmail.com";
  host = "hydenix";
  /*
    Default password is required for sudo support in systems
    !REMEMBER TO USE passwd TO CHANGE THE PASSWORD!
  */
  defaultPassword = "hydenix";
  timezone = "Africa/Casablanca";
  locale = "en_CA.UTF-8";

  # hardware config - sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
  hardwareConfig = (toString ./hardware-configuration.nix);

  # List of drivers to install in ./hosts/nixos/drivers.nix
  drivers = [
    # "amdgpu" # im setting up drivers myself
    # "intel"
    # "nvidia"
    # "amdcpu"
    # "intel-old"
  ];

  /*
    These will be imported after the default modules and override/merge any conflicting options
    !Its very possible to break hydenix by overriding options
    eg:
      # lets say hydenix has a default of:
      {
        services.openssh.enable = true;
        environment.systemPackages = [ pkgs.vim ];
      }
      # your module
      {
        services.openssh.enable = false;  #? This wins by default (last definition)
        environment.systemPackages = [ pkgs.git ];  #? This gets merged with hydenix
      }
  */
  # List of nix modules to import in ./hosts/nixos/default.nix
  nixModules = [
    (toString ./src/configuration.nix)
  ];
  # List of nix modules to import in ./lib/mkConfig.nix
  homeModules = [
    (toString ./src/home.nix)
  ];

  hyde = rec {
    sddmTheme = "Candy"; # or "Corners"

    enable = true;

    # wallbash config, sets extensions as active
    wallbash = {
      vscode = true;
    };

    # active theme, must be in themes list
    activeTheme = "Tokyo Night";

    # list of themes to choose from
    themes = [
      # -- Default themes
       "Catppuccin Latte"
      "Catppuccin Mocha"
       "Decay Green"
       "Edge Runner"
       "Frosted Glass"
       "Graphite Mono"
       "Gruvbox Retro"
       "Material Sakura"
       "Nordic Blue"
       "Rose Pine"
       "Synth Wave"
      "Tokyo Night"

      # # -- Themes from hyde-gallery
       "Abyssal-Wave"
       "AbyssGreen"
       "Bad Blood"
       "Cat Latte"
       "Crimson Blade"
       "Dracula"
       "Edge Runner"
       "Green Lush"
       "Greenify"
       "Hack the Box"
       "Ice Age"
       "Mac OS"
       "Monokai"
       "Monterey Frost"
       "One Dark"
       "Oxo Carbon"
       "Paranoid Sweet"
       "Pixel Dream"
       "Rain Dark"
       "Red Stone"
       "Rose Pine"
       "Scarlet Night"
       "Sci-fi"
       "Solarized Dark"
       "Vanta Black"
       "Windows 11"
    ];

    # Exactly the same as hyde.conf
    conf = {
      hydeTheme = activeTheme;
      wallFramerate = 144;
      wallTransDuration = 0.4;
      wallAddCustomPath = "";
      enableWallDcol = 0;
      wallbashCustomCurve = "";
      skip_wallbash = [
        # "\${hydeConfDir}/wallbash/Wall-Ways/discord.dcol"
        # "\${hydeConfDir}/wallbash/Wall-Ways/code.dcol"
      ];
      themeSelect = 2;
      rofiStyle = 2;
      rofiScale = 9;
      wlogoutStyle = 1;
    };
  };

  vm = {
    # 4 GB minimum
    memorySize = 4096;
    # 2 cores minimum
    cores = 2;
    # 30GB minimum for one theme - 50GB for multiple themes - more for development and testing
    diskSize = 20000;
  };
}
