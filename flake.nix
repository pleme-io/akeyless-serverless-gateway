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

  outputs = inputs:
    (import "${inputs.substrate}/lib/repo-flake.nix" {
      inherit (inputs) nixpkgs flake-utils;
    }) {
      self = inputs.self;
      language = "terraform";
      builder = "check";
      pname = "akeyless-serverless-gateway";
      description = "Akeyless Serverless Gateway — Terraform (AWS Lambda) and Bicep (Azure) modules for deploying Akeyless Gateway as a serverless function";
    };
}
