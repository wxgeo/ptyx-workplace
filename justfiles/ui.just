ui project:
    @cd {{project}}/src \
    && find ui -name "*.ui" -exec sh -c 'uv run pyuic6 -o "{{replace(project, "-", "_")}}/generated_${1%.ui}_ui.py" -x "$1"' _ {} \; \
    && echo "✅ Python files successfully generated from .ui files."
