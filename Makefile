NAME = yolov10n.pt

DATA_YAML = data.yaml

DATASET_DIR = ./dataset/3_bottle_training
BUILD_DIR = ./weights

EPOCHS = 100
BATCH = 16

train:
	poetry run yolo task=detect mode=train epochs=$(EPOCHS) batch=$(BATCH) plots=True model=$(BUILD_DIR)/$(NAME) data=$(DATASET_DIR)/$(DATA_YAML)

check:
	poetry run yolo checks

nix-shell:
	NIXPKGS_ALLOW_UNFREE=1 nix-shell

nix-train:
	NIXPKGS_ALLOW_UNFREE=1 nix-shell --run "poetry run yolo task=detect mode=train epochs=$(EPOCHS) batch=$(BATCH) plots=True model=$(BUILD_DIR)/$(NAME) data=$(DATASET_DIR)/$(DATA_YAML)"

nix-check:
	NIXPKGS_ALLOW_UNFREE=1 nix-shell --run "poetry run yolo checks"

nix-smi:
	NIXPKGS_ALLOW_UNFREE=1 nix-shell --run "nvidia-smi"

