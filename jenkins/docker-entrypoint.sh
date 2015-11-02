#!/bin/bash

set -e
PLUGINS_ENDPOINT=http://updates.jenkins-ci.org/latest/
DATA=/var/lib/jenkins

mkdir -p $DATA/plugins

if find $DATA/plugins -maxdepth 0 -empty | read v; then
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/greenballs.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/credentials.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/ssh-credentials.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/ssh-agent.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/git-client.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/github.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/github-api.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/git.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/parameterized-trigger.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/token-macro.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/analysis-core.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/cobertura.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/email-ext.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/violations.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/postbuildscript.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/ghprb.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/scm-api.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/postbuild-task.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/ansicolor.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/publish-over-ssh.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/ssh-slaves.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/durable-task.hpi)
	(cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/docker-plugin.hpi)
fi

exec java -jar /opt/jenkins.war
