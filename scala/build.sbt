name := "Euler"

organization := "org.davidb"

// scalaVersion := "2.9.2"
// scalaVersion := "2.10.0-RC3"
// scalaVersion := "2.10.0-M6"
scalaVersion := "2.10.0"

// For offline work.
// offline := true

scalacOptions ++= List("-deprecation", "-optimise", "-target:jvm-1.7")

// Put the classpath needed to run the application into a file
// 'target/classpath.sh'.  The run script can source this to get a
// classpath appropriate to run the application.
// TODO: Figure out how to run this automatically.  Currently, this
// must be run by hand the first time, and any time the dependencies
// change.
TaskKey[Unit]("mkrun") <<=
  (fullClasspath in Runtime, target) map {
    (cp: Classpath, target: File) =>
    val script = "classpath='" + cp.files.absString + "'"
    val out = target / "classpath.sh"
    IO.write(out, script)
  }
