#!/bin/sh
set -e

#
# Launch uWSGI daemon
#

[ -z "${FLASK_APP}" ] && echo "Error: Missing \$FLASK_APP!" && exit 1
[ -z "${APPDIR}" ] && echo "Error: Missing \$APPDIR!" && exit 1
[ -z "${VEDIR}" ] && echo "Error: Missing \$VEDIR!" && exit 1

UWSGI_PYTHON="python$(/usr/bin/python3 --version |awk '{print $2}' |cut -b1,3)"

# FIXME: flask db init, upgrade, ...

cd "${APPDIR:-/app}"

uwsgi \
    --plugins "${UWSGI_PYTHON}" \
    --master \
    --processes=10 \
    --workers=5 \
    --harakiri=30 \
    --chdir "${APPDIR}" \
    --vacuum \
    --die-on-term \
    --env LC_ALL=C.UTF-8 \
    --env LANG=C.UTF-8 \
    --procname "${FLASK_APP}" \
    --pythonpath "${APPDIR}" \
    --virtualenv "${VEDIR}" \
    --enable-threads \
    --stats 127.0.0.1:9191 \
    --socket=":9000" \
    --http-socket=":8080" \
    --module "${FLASK_APP}"

# --profiler
