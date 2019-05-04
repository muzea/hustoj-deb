#
# Regular cron jobs for the hustoj package
#
0 4	* * *	root	[ -x /usr/bin/hustoj_maintenance ] && /usr/bin/hustoj_maintenance
