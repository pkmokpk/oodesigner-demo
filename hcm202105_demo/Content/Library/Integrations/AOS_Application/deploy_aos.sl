namespace: Integrations.AOS_Application
flow:
  name: deploy_aos
  inputs:
    - target_host_username: root
    - target_host: 172.16.239.129
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 159
        'y': 95
      install_java:
        x: 365
        'y': 96
      install_tomcat:
        x: 570
        'y': 94
      install_aos_application:
        x: 773
        'y': 91
        navigate:
          6340b590-32f7-4c07-c5d2-b3674ee55a2d:
            targetId: edf69bbd-2942-4db5-ca46-23328e2aa2c5
            port: SUCCESS
    results:
      SUCCESS:
        edf69bbd-2942-4db5-ca46-23328e2aa2c5:
          x: 984
          'y': 87
