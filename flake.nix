{
  description = "Akeyless Serverless Gateway — Terraform (AWS Lambda) and Bicep (Azure) modules for deploying Akeyless Gateway as a serverless function";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    substrate = {
      url = "github:pleme-io/substrate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, substrate, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
      mkTerraformModuleCheck = (import "${substrate}/lib/terraform-module.nix").mkTerraformModuleCheck;
    in {
      checks.default = mkTerraformModuleCheck pkgs {
        pname = "akeyless-serverless-gateway";
        version = "0.0.0-dev";
        src = self;
        description = "Akeyless Serverless Gateway — Terraform (AWS Lambda) and Bicep (Azure) modules for deploying Akeyless Gateway as a serverless function";
        homepage = "https://github.com/pleme-io/akeyless-serverless-gateway";
      };

      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          opentofu
          tflint
          terraform-docs
        ];
      };
    });
}
