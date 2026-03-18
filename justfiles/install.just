install:
    ( cd ptyx; uv tool install --editable . )
    ( cd ptyx-mcq; uv tool install --editable . )
    ( cd ptyx-mcq-editor; uv tool install  --with-executables-from ruff --editable . )
    ( cd ptyx-mcq-corrector; uv tool install --editable . )
    @echo "{{projects}} successfully installed."

full-install: install
    mcq install shell-completion
    mcq-editor --install-shortcuts
