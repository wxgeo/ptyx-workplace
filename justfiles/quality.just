
ruff project:
    @cd {{project}} && {{uv}} run ruff check src tests

mypy project:
    @cd {{project}} && {{uv}} run mypy src tests

pytest project:
    @cd {{project}} && {{uv}} run pytest -n auto tests

test project: (ruff project) (mypy project) (pytest project)

test-all:
    @for p in {{projects}}; do \
        echo -e "\n\e[1;97;44m $p \e[0m"; \
        just test $p; \
    done

fix project:
    @cd {{project}} && {{uv}} run black src tests
    @cd {{project}} && {{uv}} run ruff check --fix src tests

fix-all:
    for p in {{projects}}; do just fix $p; done