name := "Euler"

organization := "org.davidb"

scalaVersion := "2.9.1"

// For offline work.
// offline := true

scalacOptions ++= List("-deprecation", "-optimise")

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
