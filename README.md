
# Installlation

Use `poetry install`, on nix, run `make nix-shell`

> Note: Can skip this step. Train AI with `make train` will install the dependencies.

# Training AI

`make train`

# On Nix systems / servers

> Note: And Nvidia RTX card (Turing or above recommended), Nvidia open-dkms driver, and `nvidia_uvm` kernel module is required for GPU accelerated training.

## Train AI
`make nix-train`

## Shell
`make nix-shell`

## Check YOLO compatibility
`make nix-check`

## Check nvidia-smi in the venv
`make nix-smi`

