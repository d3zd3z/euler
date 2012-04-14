#! /bin/sh

name=Problem$1.scala
URL="http://projecteuler.net/problem=$1"
echo '/**********************************************************************' > $name
w3m -dump -cols 69 "$URL" |
	sed -e 's/^/ * /' -e 's/ $//' >> $name
echo ' **********************************************************************/' >> $name
cat <<ZED >> $name

object Problem$1 {

  def main(args: Array[String]) {
  }
}
ZED
