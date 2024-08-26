NAME = yolov10n.pt

DATA_YAML = data.yaml

DATASET_DIR = datasets/2_can_training
# DATASET_DIR = datasets/3_bottle_training

BUILD_DIR = weights

EPOCHS = 100
BATCH = 16

install:
	poetry install

lock: install
	poetry lock

train: lock
	poetry run yolo task=detect mode=train epochs=$(EPOCHS) batch=$(BATCH) plots=True model=$(BUILD_DIR)/$(NAME) data=$(shell readlink -f $(DATASET_DIR)/$(DATA_YAML))

check: lock
	poetry run yolo checks

nix-shell:
	NIXPKGS_ALLOW_UNFREE=1 nix-shell

nix-train:
	NIXPKGS_ALLOW_UNFREE=1 nix-shell --run "poetry run yolo task=detect mode=train epochs=$(EPOCHS) batch=$(BATCH) plots=True model=$(BUILD_DIR)/$(NAME) data=$(DATASET_DIR)/$(DATA_YAML)"

nix-check:
	NIXPKGS_ALLOW_UNFREE=1 nix-shell --run "poetry run yolo checks"

nix-smi:
	NIXPKGS_ALLOW_UNFREE=1 nix-shell --run "nvidia-smi"

.PHONY: install lock train check nix-shell nix-train nix-check nix-smi
