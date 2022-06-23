{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/22.05";
  outputs = {self,nixpkgs}: {
    devShells = builtins.mapAttrs (system: pkgs: {
      default = pkgs.mkShell {
        shellHook = ''
          echo 'WARNING: gotcha during nix develop shellHooks'
          function _direnv_hook(){
              echo 'WARNING, "_direnv_hook" has been overwritten"'
          }
        '';
        packages = [
          (pkgs.writeShellApplication {
            name = "ls";
            text = ''
              echo 'WARNING, "ls" has been overwritten"'
            '';
          }
            )
        ];
      };
    }) nixpkgs.legacyPackages;
  };
}
