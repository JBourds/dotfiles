import os
import subprocess
import sys
from typing import List

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
USER = os.getlogin()
HOME_DIR = os.path.expanduser(f"~{USER}")
LOCAL_BIN_DIR = os.path.join(HOME_DIR, ".local", "bin")
DOTFILE_DIRS = [
    f for f in os.listdir(SCRIPT_DIR)
    if os.path.isdir(f) and f.startswith(".") and f != ".git"
]

if os.geteuid() != 0:
    print("Error: File must be run with superuser privileges", file=sys.stderr)
    exit(1)


def install_if_not_installed(program: str, install_cmds: List[str]) -> bool:
    result = subprocess.run(
        ["which", program],
        capture_output=True,
        text=True,
    )
    if result.returncode == 0:
        print(f"Found {program} installation at {result.stdout}")
        return True

    # Run all the commands in a single terminal session
    cmd = "; ".join(install_cmds)
    print(f"Running commands: \n\t{"\n\t".join(install_cmds)}")
    result = subprocess.run(
        # Pipe yes into command to skip user input
        f"yes | {cmd}",
        stderr=sys.stderr,
        stdout=sys.stdout,
        shell=True
    )

    success = result.returncode == 0
    if success:
        print(f"Successfully installed `{program}`")
    else:
        print(f"Failed to install `{program}`")
    return success


def copy_dotfiles() -> bool:
    if not install_if_not_installed("stow", ["sudo apt install stow"]):
        print("Failed to install GNU Stow to setup symlinks")
        return False

    # Change to the script directory
    cwd = os.getcwd()
    os.chdir(SCRIPT_DIR)

    if not DOTFILE_DIRS:
        print("No dotfile directories found.")
        return False
    else:
        print(f"Stowing the following packages: {DOTFILE_DIRS}")

    cmd = f"stow --target={HOME_DIR} " + ' '.join(DOTFILE_DIRS)
    result = subprocess.run(
        cmd, shell=True, stderr=sys.stderr, stdout=sys.stdout)
    os.chdir(cwd)

    if result.returncode == 0:
        print("Successfully set up dotfile symlinks")
    else:
        print("Failed to set up dotfile symlinks")

    return result.returncode == 0


if __name__ == "__main__":
    copy_dotfiles()

    # Core utils dropins
    bat_symlink = os.path.join(LOCAL_BIN_DIR, "bat")
    print(bat_symlink)
    install_if_not_installed("bat", [
        "sudo apt install bat",
        f"if [ -L {bat_symlink} ]; then exit 0; fi",
        f"mkdir -p {LOCAL_BIN_DIR}",
        f"ln -s $(which batcat) {bat_symlink}",
        "which bat",
    ])
    install_if_not_installed("rg", ["sudo apt install ripgrep"])
