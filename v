#! /usr/bin/env python3

from pathlib import Path
import sys
import os
import subprocess
import venv

try:
    import click
except ImportError:
    if sys.prefix != sys.base_prefix:
        print('You are already in a venv. Not activating a new one.',
              file=sys.stderr)
        exit(1)
    raise

NAME = '__venv__'

@click.command()
def ensure_activated_venv():
    """Activate Python virtual environment for current project

    An environment is searched for in parent directories.

    If one is not found, it is created -- either in the root of the containing
    Git repository, or in current directory if the Git repo is not found.
    """
    import click

    if sys.prefix != sys.base_prefix:
        click.secho('Inception prevention', fg='red', file=sys.stderr)
        click.secho('You are already in a venv. Not activating itagain.',
                    file=sys.stderr)
        exit(1)

    current_dir = Path('.').resolve()
    venv_dir = current_dir
    last_git_dir = None
    root = Path('/')

    while venv_dir.parent != venv_dir:
        if (venv_dir / NAME).exists():
            break
        if (venv_dir / '.git').exists():
            last_git_dir = venv_dir
        venv_dir = venv_dir.parent
    else:
        if last_git_dir == current_dir:
            click.secho('This is a Git repository; will create venv here',
                        fg='green',
                        file=sys.stderr)
            venv_dir = last_git_dir
        elif last_git_dir:
            click.secho('Containing Git repository found; will create venv there',
                        fg='yellow',
                        file=sys.stderr)
            venv_dir = last_git_dir
        else:
            click.secho(
                'Git repository not found; will create venv in current directory',
                fg='red',
                file=sys.stderr)
            venv_dir = current_dir
        click.confirm(f'Create venv at {venv_dir}?',
                      abort=True)
        venv.create(venv_dir / NAME, with_pip=True)

    click.secho(f'Entering venv in {venv_dir}; Ctrl+D to exit',
                fg='blue', file=sys.stderr)
    os.execv(
        '/bin/bash',
        ['/bin/bash', '-c', f'. {venv_dir}/{NAME}/bin/activate; exec bash'])


if __name__ == '__main__':
    ensure_activated_venv()
