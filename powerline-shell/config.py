# -*- mode: python -*-
# This is the configuration file for your powerline-shell prompt
# Every time you make a change to this file, run install.py to apply changes
#
# For instructions on how to use the powerline-shell.py script, see the README

# Add, remove or rearrange these segments to customize what you see on the shell
# prompt. Any segment you add must be present in the segments/ directory, and
# the segment name here must match the segment file name (minus the extension)
# _exactly_.

SEGMENTS = [
    # Current system time
    'time',

    # Show current virtual environment (see http://www.virtualenv.org/)
    #'virtual_env',

    # Show the current user's username as in ordinary prompts
    'username',

    # Show a symbol when ssh-ing from another machine
    'ssh',

    # Show the machine's hostname. Mostly used when ssh-ing into other machines
    #'hostname',

    # Show the current directory. If the path is too long, the middle part is replaced with ellipsis ('...')
    'cwd',

    # Show a padlock if the current user has no write access to the current directory
    'read_only',

    # Show the current git branch and status
    'git',

    # Show the current mercurial branch and status
    #'hg',

    # Show the current svn branch and status
    'svn',

    # Show the current fossil branch and status
    #'fossil',

    # Cleanly moves to a new line
    'newline',

    # Shows a '#' if the current user is root, '$' otherwise
    # Also, changes color if the last command exited with a non-zero error code
    'root',
]

RIGHT_SEGMENTS = [
    # Show number of running jobs
     'jobs',

    # System uptime
     'uptime',

    # Battery status on linux systems
    # 'battery',
]

# Change the colors used to draw individual segments in your prompt
THEME = 'default'
