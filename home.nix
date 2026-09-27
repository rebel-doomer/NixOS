/* not ready to use flakes, sticking to channels for now. this is example code to edit and use later on in the distant future */
/*
{ pkgs, inputs, settings, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    backupFileExtension
    users.reb = import ./modules/home-manager;
    extraSpecialArgs = { inherit inputs settings pkgs; };
  };
}
*/