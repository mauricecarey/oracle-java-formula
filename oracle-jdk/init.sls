# Install Oracle Java JDK.

install-python-software-properties:
  pkg.installed:
    - name: python-software-properties

oracle-java-ppa:
  pkgrepo.managed:
    - ppa: webupd8team/java

oracle-license-select:
  cmd.run:
    - unless: which java
    - name: '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections'
    - require_in:
      - pkg: install-java-jdk
      - cmd: oracle-license-seen-lie
 
oracle-license-seen-lie:
  cmd.run:
    - unless: which java
    - name: '/bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 seen true  | /usr/bin/debconf-set-selections'
    - require_in:
      - pkg: install-java-jdk

install-java-jdk:
  pkg.installed:
    - name: oracle-java8-installer
    - require:
      - pkgrepo: oracle-java-ppa

JAVA_HOME:
  file.append:
    - name: /etc/profile.d/myglobalenvexports.sh
    - text: export JAVA_HOME=/usr/lib/jvm/java-8-oracle
