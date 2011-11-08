MFORMATER_HOME=`dirname $0`
MFORMATER_PROJECT=`pwd`
ACTION=""

if [ -z $1 ] ; then
	ACTION="help"
else
	ACTION=$1
fi

if [ $ACTION = "testdeps" ] ; then
	for l in $( cat $MFORMATER_PROJECT/.mformater ); do
		for d in $( cat $MFORMATER_HOME/langs/$l/deps ); do
			echo "* test fo $d need by $l"
			#			hash $d 2>&- || { echo >&2 "I require $d but it's not installed.  Aborting. "; cat $MFORMATER_HOME/langs/$l/deps_help ; echo " " ; exit 1; }
			hash $d 2>&- || { echo >&2 "Require $d but it's not installed. "; echo "--------------------------------" ; cat $MFORMATER_HOME/langs/$l/deps_help ; echo " " ; echo "--------------------------------" ; }
		done
	done
fi

if [ $ACTION = "help" ] ; then
	cat $MFORMATER_HOME/help_home
fi



