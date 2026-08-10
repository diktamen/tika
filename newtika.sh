#!/bin/bash
# Vendor the jars built by build.sh into DiktaNet/lib under the -0 names its pom.xml
# references. Build with JDK 17: javac 21+ emits the MethodParameters attribute that
# crashes the Excelsior JET JIT (see DiktaNet/ci/ExcelsiorCompatCheck.java), javac 17
# does not. If the check below fails, rebuild with JDK 17 or run
# DiktaNet/ci/StripMethodParameters.java. Needs JDK 11+ on PATH.
set -e
TIKA="$(cd "$(dirname "$0")" && pwd)"
DIKTANET=~/diktamen/java/DiktaNet
V=3.3.2
cp "$TIKA/tika-core/target/tika-core-$V.jar" "$DIKTANET/lib/tika-core-$V-0.jar"
cp "$TIKA/tika-parsers/tika-parsers-standard/tika-parsers-standard-modules/tika-parser-audiovideo-module/target/tika-parser-audiovideo-module-$V.jar" "$DIKTANET/lib/tika-parser-audiovideo-module-$V-0.jar"
cd "$DIKTANET"
java ci/ExcelsiorCompatCheck.java "lib/tika-core-$V-0.jar" "lib/tika-parser-audiovideo-module-$V-0.jar"
