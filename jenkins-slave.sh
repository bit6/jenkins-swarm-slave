#!/bin/bash

# if `docker run` first argument start with `-` the user is passing jenkins swarm launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "-"* ]]; then

  # jenkins swarm slave
  JAR=`ls -1 /usr/share/jenkins/swarm-client-*.jar | tail -n 1`

  # if -master is not provided and using --link jenkins:jenkins
  if [[ "$@" != *"-master "* ]]; then
    PARAMS="-master http://jenkins:8080"
  fi

  echo Running java $JAVA_OPTS -jar $JAR -fsroot $HOME $PARAMS "$@"
  exec java $JAVA_OPTS -jar $JAR -fsroot $HOME $PARAMS "$@"
fi

# As argument is not jenkins, assume user want to run his own process, for sample a `bash` shell to explore this image
exec "$@"
