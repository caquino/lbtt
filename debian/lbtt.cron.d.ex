#
# Regular cron jobs for the lbtt package
#
0 4	* * *	root	[ -x /usr/bin/lbtt_maintenance ] && /usr/bin/lbtt_maintenance
