# ~/.dotfiles/home.nix

{ config, pkgs, ... }:

{
  home.username = "tofu_kozo";
  home.homeDirectory = "/home/tofu_kozo";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "tōfu_kozō";
    userEmail = "torakoishi@duck.com";
    extraConfig = {
      init.defaultBranch = "main";
      };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter
      alpha-nvim
      nvim-cmp
      vim-polyglot
      gruvbox-material
      ];
  };

  home.packages = with pkgs; [
    _1password
    _1password-gui
    obsidian
    tor
    mullvad-vpn
  ];

  # Nicely reload system units when changing configs
  #systemd.user.startServices = "sd-switch";

}
