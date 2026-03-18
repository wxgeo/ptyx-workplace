ui:
    @cd src && find ui -name "*.ui" -exec sh -c 'pyuic6 -o "{{project}}/generated_${1%.ui}_ui.py" -x "$1"' _ {} \;
    @echo "Python files successfully generated from .ui files."
