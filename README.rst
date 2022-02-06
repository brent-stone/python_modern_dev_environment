A Modern Python Dev Setup Demo
=======================


Setup
--------------------------
After installing pyenv and Poetry for your operating system, follow the steps below to install (potentially multiple versions of) Python with pyenv, activate a local virtual environment for this project using Poetry, then run ``poetry install`` and ``pre-commit install``. The intention here is to simultaneously enable high quality, automatically documented, and mostly bug free code using a full suite of modern python development tools.

If you're on Linux, the bash scripts in the ``/scripts`` folder may help you with creating and activing your virtual environment for the first time.

Summary introductions to modern Python dev environments are available `at this blog post`_ and `this blog post`_.
`This article`_ has succinct discussion about static and runtime type checking using Pydantic and MyPy.

It's recommended to add tools to your system in the following order. Details about `pyenv installation of ~/.profile and ~/.bashrc are posted here.`_

**Pull requests are welcome!** Fork this repo to your own account, create a branch in that fork, commit+push an update, then create the pull request from your fork into this repo using the "Pull requests" link above.

1.  `pyenv`_.

    * Ensure your computer may support `pyenv` by following `the directions here`_.
    * At a minimum, restart your terminal session: ``exec $SHELL``.
    * It's possible/likely a full restart may be required.
    * ``pyenv --version`` to test install succeeded.
    * Install Python versions using the install command: ``pyenv install 3.10.2``.
    * [optional] Set your preferred default python version systemwide: ``pyenv global 3.10.2``.
    * [optional] Set your preferred default python version for a folder/project/repo: ``pyenv local 3.10.2``.
    * [optional] Global default may be checked with ``which python``.

2.  `Poetry`_

    * If the poetry install script off GitHub causes a ``ModuleNotFoundError: No module named 'cleo'``, try ``pip install poetry``
    * verify with ``poetry --version``
    * ``poetry new <project_name>`` auto-creates a distributable boilerplate in folder <project_name>.
    * Inside <project_name>, ``pyenv local 3.10.2`` sets a specific pyenv version for the project.
    * ``poetry env use python`` creates a new virtual environment for the package/project.
    * ``poetry install`` adds any dependencies from the config files and poetry itself.
    * ``poetry update`` updates any packages to their latest compatible version(s).
    * ``poetry shell`` moves the terminal to execute within the context of the virtual environment.
    * ``poetry run pytest`` automatically finds \tests\ and executes tests, producing a report. [NOTE: lost of plugins
    * ``poetry show -v`` will printout the virtual environment path. Helpful when configuring IDEs.
    * ``poetry config virtualenvs.in-project true`` will host virtual environments inside the project root. This can
      make referencing the virtual environment easier when configuring IDEs or writing scripts.
      available to improve this output including HTML reports)
    * If ``poetry shell`` was used, simply calling ``pytest`` will also run tests.

------
``Poetry install`` using pyproject.toml installs the rest of these tools.
------

3.  `pytest-cov`_

    * Several ways to install coverage but pytest-cov plugin is streamlined 
    * ``poetry add pytest-cov --dev``.
    * ``pytest --cov=<project_name> tests/``.

4.  `pre-commit`_

    * ``poetry add pre-commit --dev``.
    * Pre-commit allows automated tooling to automatically run when prepping a git commit.

5.  `flake8`_

    * In IDE and CLI code quality assistant.
    * ``poetry add flake8 --dev``.

6.  `reorder-python-imports`_

    * More 'robust' alternative to isort.
    * ``poetry add reorder-python-imports --dev``.

7.  `add-trailing-comma`_

    * Ensure minimal diffs when making signature updates to functions and data structures.
    * ``poetry add add-trailing-comma --dev``.

8.  `setup-cfg-fmt`_

    * Ensure `setup.cfg` files are standardized.
    * ``poetry add setup-cfg-fmt --dev``

9.  `mypy`_

    * Maximize accurate use of python's (continuously expanded) typing system to minimize bugs.
    * ``poetry add mypy --dev``

10. `black`_

    * Automatically apply linting best practices. Goodbye pedantic code reviews on style/format.
    * ``poetry add black --dev``

11. `pydantic`_

    * Run time type checking compatible with MyPy static analysis.
    * Also assists with APIs and JSON conversions.

.. _pyenv installation of ~/.profile and ~/.bashrc are posted here.: https://github.com/pyenv/pyenv/issues/1911#issue-882944925
.. _pyenv: https://github.com/pyenv/pyenv
.. _Poetry: https://github.com/python-poetry/poetry
.. _at this blog post: https://mitelman.engineering/posts/python-best-practice/automating-python-best-practices-for-a-new-project/
.. _this blog post: https://www.laac.dev/blog/setting-up-modern-python-development-environment-ubuntu-20/
.. _This article: https://medium.com/codex/python-typing-and-validation-with-mypy-and-pydantic-a2563d67e6d
.. _pytest-cov: https://pypi.org/project/pytest-cov/
.. _pre-commit: https://pre-commit.com/
.. _flake8: https://pypi.org/project/flake8/
.. _add-trailing-comma: https://github.com/asottile/add-trailing-comma
.. _setup-cfg-fmt: https://github.com/asottile/setup-cfg-fmt
.. _mypy: https://github.com/pre-commit/mirrors-mypy
.. _black: https://github.com/psf/black
.. _reorder-python-imports: https://pypi.org/project/reorder-python-imports/
.. _pydantic: https://pydantic-docs.helpmanual.io/

.. _the directions here: https://github.com/pyenv/pyenv/wiki#suggested-build-environment



.. note::

    Poetry may have unmet dependencies listed with distutils and cleo. If you're getting an error about cleo and other dependencies, make sure you're using
    the latest poetry install script listed on the github page and not a deprecated version listed at ReadTheDocs or other websites.
    Also, ensure you installed build dependencies for pyenv before following the install directions.

The environment is correctly configured if the success message appears after running the `scripts/setup_dev_env_poetry.sh` script.

Testing your solution and applying the automated tooling can be done by running tox from the activated Pyenv + Poetry virtual environment.

.. code-block:: console

    tox


Tips
--------------------------

1.  ``exit`` instead of ``deactivate`` to have your shell exit the Poetry virtual environment.

    * If you can't use `poetry shell` to enter virtual environment because 'it already exists', try the following:

.. code-block:: console

    source "$( poetry env list --full-path | grep Activated | cut -d' ' -f1 )/bin/activate"

2.  To start a new project, try ``poetry new <project_name>`` and a decent default folder structure will be created.

3.  To add a reasonable pyproject.toml to an existing project: ``poetry init``

4.  To manually activate a virtual environment:

    * ``pyenv versions`` to see which Python versions are installed.

    * ``poetry env use <python_version>`` to create a virtual environment with the preffered versions.

    * ``poetry shell`` to activate the new environment.

    * ``python -V`` in the activated virtual environment to verify the correct python version is being used.

    * ``poetry install`` and ``pre-commit install`` to ensure all dependencies and the pre-commit hook are added.

5.  By default, Poetry creates virtual environments in the user profile cache. Likely, you'll want to have it created
    in the local project folder. To do this, set the poetry environment variable or add the poetry.toml file as shown in
    this repo.

    * ``poetry config virtualenvs.in-project true``

6.  If Sphinx or other tools are warning they can't find your module (dev_demo), ensure ``poetry show`` lists the module.
    If not, use ``poetry install`` to locally install in development mode. This is similar to ``pip install -e <module>``.
