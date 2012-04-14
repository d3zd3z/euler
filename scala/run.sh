#! /bin/sh

# Run program, assuming at top level of dev dir, and 'xsbt mkrun' has
# been run.

BASEDIR=.
if [ -f ${BASEDIR}/target/classpath.sh ]; then
  . ${BASEDIR}/target/classpath.sh
else
  echo "Classpath not configured.  Please run 'xsbt mkrun'"
  exit 1
fi

# Run one of the main programs.
java \
	-cp ${classpath} \
	-XX:+UseCompressedOops \
	-Xmx512M \
	"$@"

# This is disabled in VMs I'm using.
#	-XX:+DoEscapeAnalysis \
