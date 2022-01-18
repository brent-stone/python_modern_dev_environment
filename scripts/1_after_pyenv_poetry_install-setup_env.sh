#!/usr/bin/env bash
# Set our preferred version of Python
PREFERRED_VERSION="3.10.1"

# Set our alternative versions of Python
ALTERNATIVE_VERSIONS="3.8.12 3.9.9"

# All versions
ALL_VERSIONS="${PREFERRED_VERSION} ${ALTERNATIVE_VERSIONS}"

# Verify that the system has git, pyenv, and poetry installed
command -v git >/dev/null 2>&1 || { echo >&2 "Git needs to be installed. See the README. Aborting."; exit 1; }
command -v pyenv >/dev/null 2>&1 || { echo >&2 "pyenv needs to be installed. See the README. Aborting."; exit 1; }
command -v poetry >/dev/null 2>&1 || { echo >&2 "Poetry needs to be installed. See the README. Aborting."; exit 1; }

# Verify the minimum configuration files exist in this project
test -f pyproject.toml || { echo >&2 "Missing pyproject.toml. Aborting."; exit 1; }
test -f .pre-commit-config.yaml || { echo >&2 "Missing .pre-commit-config.yaml. Aborting."; exit 1; }
test -f tox.ini || { echo >&2 "Missing tox.ini. Aborting."; exit 1; }

# Check for Python 3.6 through 3.9. Download and add to pyenv if any are missing.
#for VARIABLE in 3.6.15 3.7.12 3.8.12 3.9.9
for VARIABLE in $ALL_VERSIONS
do
  # Check if the version's folder exists. If no, attempt to install. Auto-select no to re-install if we goofed somehow.
  ! compgen -G "${HOME}/.pyenv/versions/${VARIABLE}" > /dev/null && command echo "N" | pyenv install $VARIABLE
  # Verify the version's folder now exists. Exit if not.
  if [ ! -d "${HOME}/.pyenv/versions/${VARIABLE}" ]; then
    echo >&2 "Failed Python ${VARIABLE} install. Aborting.";
    exit 1;
  fi
done

# Set our default version of Python to PREFERRED_VERSION
# We also install the ALTERNATIVE_VERSIONS so Tox can test compatibility
# across all Python versions provided
# shellcheck disable=SC2086
pyenv global $ALL_VERSIONS

# Verify our preferred version of python is being used
if [ ! "$(python -V 2>&1 | grep ${PREFERRED_VERSION})" ]; then
  echo >&2 "Python ${PREFERRED_VERSION} not set as default. Aborting.";
  exit;
fi

# Have Poetry create a virtual environment for the project using the selected Python version
poetry env use python

# Activate the virtual environment in the current shell and install poetry's immediate dependencies
poetry shell
poetry install

# Install pre-commit (and extensions) as a git hook
pre-commit install

# Update the pre-commit internal hooks
pre-commit autoupdate

# Output a success notice to the developer.
echo "(⌐▨_▨) Your dev environment is setup, we got a full tank of gas," \
     "half a pack of cigarettes, it's dark, and we're wearing sunglasses. Hit it!"
