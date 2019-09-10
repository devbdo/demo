#!/usr/bin/env sh

. /etc/rc.subr

name="boxnet"
rcvar="boxnet_enable"
start_cmd="boxnet_start"
stop_cmd="boxnet_stop"

pidfile="/var/run/nginx-boxnet.pid"
config_file="/usr/local/boxnet/install/nginx-boxnet.conf"

load_rc_config ${name}

boxnet_start()
{
if checkyesno ${rcvar}; then
    if [ -f $pidfile ]; then
        echo "boxnet already running."
        boxnet_stop
    fi
    echo -n "boxnet starting..."
    /usr/local/sbin/nginx -c ${config_file}
    echo " Done."
fi
}

boxnet_stop()
{
if [ -f $pidfile ]; then
        echo -n "boxnet stopping."
        pkill -F $pidfile
        while [ `pgrep -F $pidfile` ]; do
            echo -n "."
            sleep 5
        done
        rm $pidfile
        echo " Done."
    fi
}

run_rc_command "$1"