# ~/.dotfiles/Profiles/zephyrus-ga503.nix

{ config, pkgs, lib, inputs, system, ... }:

{
  boot = {
	  initrd.kernelModules = [ "amdgpu" ];
	  kernelParams = [
		  "rd.driver.blacklist=nouveau"
		  "modprobe.blacklist=nouveau"
		  "nvidia-drm.modeset=1"
		  "iommu=on"
		  "amd_iommu=on"
		  "amd_pstate=guided"
		  "nowatchdog"
		  "modprobe.blacklist=sp5100_tco"
		];
  };

  powerManagement = {
	  enable = true;
	  #cpuFreqGovernor = "schedutil";
  };

  # Enable zram swap.
  zramSwap = {
	  enable = true;
	  priority = 100;
	  memoryPercent = 30;
	  swapDevices = 1;
  };

  services = {
	  asusd = {
		  enable = true;
	  	enableUserService = true;
    };
  };

	services.supergfxd.enable = true;

	services.power-profiles-daemon.enable = true;

	services.xserver.videoDrivers = ["nvidia" "amdgpu"];

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Graphics and Nvidia hardware.
  hardware = {
	  cpu.amd.updateMicrocode = true;

	  graphics = {
   	  enable = true;
   	  enable32Bit = true;
	 	  extraPackages = with pkgs; [
		  vaapiVdpau
   		  libvdpau
   		  libvdpau-va-gl
   		  nvidia-vaapi-driver
   		  vdpauinfo
		  libva
   		  libva-utils
      ];
    };

	  nvidia = {
   	  prime.amdgpuBusId = "PCI:7:0:0";
   	  prime.nvidiaBusId = "PCI:1:0:0";
   	  modesetting.enable = true;
		  prime.offload.enable =true;

		  # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
   	  powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      # powerManagement.finegrained = true;

      # Dynamic boost.
      dynamicBoost.enable = true;

      # nvidia-persistenced for NVIDIA GPU in headless mode.
      nvidiaPersistenced = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      open = false;

      nvidiaSettings = true;

      # Nvidia driver.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
  	};
  };
}