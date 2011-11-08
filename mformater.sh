MFORMATER_HOME=`dirname $0`
MFORMATER_PROJECT=`pwd`
ACTION=""

if [ -z $1 ] ; then
	ACTION="help"
else
	ACTION=$1
fi

if [ $ACTION = "testdeps" ] ; then
	for l in $( cat $MFORMATER_PROJECT/mformater.conf ); do
		if [ ${l:0:1} != \# ] ; then
			for d in $( cat $MFORMATER_HOME/langs/$l/deps ); do
				echo "* test fo $d need by $l"
				hash $d 2>&- || { echo >&2 "Require $d but it's not installed. "; echo "--------------------------------" ; cat $MFORMATER_HOME/langs/$l/deps_help ; echo " " ; echo "--------------------------------" ; }
			done
		fi
	done
elif [ $ACTION = "format" -o $ACTION = "precommit" ] ; then
	for l in $( cat $MFORMATER_PROJECT/mformater.conf ); do
		if [ ${l:0:1} != \# ] ; then
			for d in $( cat $MFORMATER_HOME/langs/$l/deps ); do
				echo "* test fo $d need by $l"
				hash $d 2>&- || { echo >&2 "I require $d but it's not installed.  Aborting. try  : mformater testdeps"; cat $MFORMATER_HOME/langs/$l/deps_help ; echo " " ; exit 1; }
			done
		fi
	done
	for l in $( cat $MFORMATER_PROJECT/mformater.conf ); do
		if [ ${l:0:1} != \# ] ; then
			echo "===> NOW format $l"
			MFORMATER_PROJECT=$MFORMATER_PROJECT MFORMATER_HOME=$MFORMATER_HOME ACTION=$ACTION $MFORMATER_HOME/langs/$l/exec.sh
		fi
	done
elif [ $ACTION = "help" ] ; then
	cat $MFORMATER_HOME/help_home
	echo " "
else
	echo "try mformater help"
fi



