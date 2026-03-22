
clone-all:
    git clone git@github.com:wxgeo/ptyx.git
    git clone git@github.com:wxgeo/ptyx-mcq.git
    git clone git@github.com:wxgeo/ptyx-mcq-editor.git
    git clone git@github.com:wxgeo/ptyx-mcq-corrector.git


push project:
    @cd {{project}} && git push
    @cd {{project}} && git push --tags

push-all:
    just push .
    for p in {{projects}}; do just push $p; done

diff project:
    @cd {{project}} && git diff

diff-all:
    @{ \
        echo -e "\n\e[1;97;44m . \e[0m"; \
        git -c color.diff=always --no-pager diff; \
        for p in {{projects}}; do \
            echo -e "\n\e[1;97;44m $p \e[0m"; \
            cd "$p" && git -c color.diff=always --no-pager diff && cd ..; \
        done; \
    } | less -R

_status dir:
    @output=$(cd "{{dir}}" && git -c color.status=always status -s); \
     ahead=$(cd "{{dir}}" && git rev-list --count @{u}..HEAD 2>/dev/null || echo 0); \
     ahead_str=$([ "$ahead" -gt 0 ] && echo -e " \e[1;34m(+$ahead)\e[0m" || echo ""); \
     if [ -z "$output" ]; then echo -e "\n\e[1;97;44m {{dir}} \e[0m$ahead_str \e[32m✔\e[0m"; \
     else echo -e "\n\e[1;97;44m {{dir}} \e[0m$ahead_str\n$output"; fi
     
see:
    @just _status .
    @just _status ptyx
    @just _status ptyx-mcq
    @just _status ptyx-mcq-editor
    @just _status ptyx-mcq-corrector

commit-lock:
    git commit uv.lock -m "dev: update uv.lock"

commit-all message:
    @git diff-index --quiet HEAD || git commit -a -m "{{message}}"
    @for p in {{projects}}; do \
        cd "$p" && git diff-index --quiet HEAD || git commit -a -m "{{message}}" && cd ..; \
    done
