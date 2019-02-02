# docker-sonar-lts


### Plugins list

 https://docs.sonarqube.org/display/PLUG/Plugin+Version+Matrix

 Also check http://www.sonarplugins.com/

 Today (feb 2019) the official download site is https://binaries.sonarsource.com/Distribution/

-------------
The base image download sonarqube then remove default bundle plugins and install basics plugins

## Images w/ plugins

- Base
    - sonar-java-plugin https://github.com/SonarSource/sonar-java#sonarjava---
    - sonar-scm-git-plugin https://github.com/SonarSource/sonar-scm-git
    - sonar-yaml-plugin https://github.com/sbaudoin/sonar-yaml
    - sonar-xml-plugin https://github.com/SonarSource/sonar-xml
    - sonar-json-plugin https://github.com/racodond/sonar-json-plugin#sonarqube-json-analyzer
    - sonar-l10n-es-plugin https://github.com/acalero/sonar-l10n-es
- Java
    - sonar-cobertura-plugin https://github.com/galexandre/sonar-cobertura#sonar-cobertura
    - sonar-jacoco-plugin https://github.com/SonarSource/sonar-jacoco
    - sonar-findbugs-plugin https://github.com/spotbugs/sonar-findbugs/#sonarqube-spotbugs-plugin
    - sonar-pmd-plugin https://github.com/jensgerdes/sonar-pmd
    - checkstyle-sonar-plugin https://github.com/checkstyle/sonar-checkstyle#sonar-checkstyle
    - sonar-jproperties-plugin https://github.com/racodond/sonar-jproperties-plugin
- JS
    - sonar-javascript-plugin https://github.com/SonarSource/SonarJS
    - sonar-typescript-plugin https://github.com/SonarSource/SonarTS


