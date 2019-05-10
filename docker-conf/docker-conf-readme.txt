This directory is for files that will be mounted at /conf in the docker image at runtime

agent.csv
    - required
    - modify this to provide the appropriate URL for the ACS to contact, and any other config settings
    - the dump location should be /dump unless you've mounted alternate values elsewhere