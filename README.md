tr069-simulator
===============

This is a Java based TR069 Simulator for CPE devices. Currently this simulator supports <a href="http://www.broadband-forum.org/cwmp/cwmp-1-0.xsd">cwmp-1-0.xsd</a>
schema. Jibx tool has been used to bind the schema file into java classes.

This simulator can support different type of CPE devices. Also you can simulate hundreds of devices using the same instance.

<b>How to use:</b><br>
To run this simulator,<br> 
1. download the project and unzip it to a suitable location.<br>
2. Modify the agent.csv configuration file available in the root directory.<br>

<b>agent.csv</b> file is the csv configuration file that contains the following:<br>
<div class="highlight"><pre>
<span class="c1">startip, endip, acs_url, conn_req_url, http_port, periodic_inform, dump_location, username, password, authtype, useragent, xmlformat</span>
<span class="kd">192.168.1.111, 192.168.1.120, http://tr069.me/tr069/ws?wsdl&probe=257ebf, /wsdl, 8035, 300, /dump/microcell/, user1, passwd1, basic</span>
<span class="kd">192.168.2.211, 192.168.2.220, http://tr069.me/tr069/ws?wsdl&probe=257ebf, /wsdl, 8035, 300, /dump/microcell/, user1, passwd1, basic</span>
</pre></div>
Start IP Address <br> 
End IP Address<br>
ACS Server URL<br>
Connection Request URL<br>
Http Port<br>
Period Inform Interval (in seconds)<br>
Dump Location Path<br>
Username<br>
Password<br>
Authtype<br>
Useragent<br>
XML Formatter<br>
Serial Number Format (printf style)<br>
Serial Number (integer)<br>

You can modify these parameter according to your requirements. To simulate multiple CPE devices, provide the start and<br>
end ipaddress. Periodic Inform Interval is in seconds. Simulator will send Inform request based on this parameter.<br><br> 

Dump Location Path is the directory path where simulator will read and load the CPE data. <br>
Simulator will check for two set of files.<br>
<b>1. getvalues.txt</b><br>
<b>2. getnames.txt</b><br>

getvalues.txt contains Name/Value data as XML Nodes. Simulator will respond to the ACS Server based on this Name/Value Pair.<br>
getnames.txt contains ParameterInfoStruct XML Nodes. Access detail about the parameters are retrieved from this file.
<br>
Currently, Femtocell device dump is being bundled with the JAR. If the user wish to simulate a different CPE, either they need to <br>
create these xml two files manually or they need to take a dump from the real CPE device by reading the GetParameterValuesResponse
and GetParameterNamesResponse.<br>

If the ACS Server supports HTTP Authentication, provide the username, password and authentication type. basic and digest 
methods are currently supported. If authentication is not supported, these fields are not required.<br><br>

<b>To run:</b><br>
<div class="highlight"><pre>
java -jar target/tr069-0.6.2-SNAPSHOT.jar server simulator.yml<br>
</pre></div>
Or simply doubleclick the batch launcher (for Windows).
<b>Note:</b> Java must be available in your system.

### agent.csv Configuration
- Start IP and End IP define a range of IP addresses, and the system runs a simulator thread for each
- The HTTP Port defines the port on which a simulator listens for connection requests.
- The simulator reports a ConnectionRequestURL constructed from the IP address, port, and the path configured in agent.csv
- The Dump Location is a relative path to the folder containing the device configuration data.
- User name, password, and authentication type are used to authenticate the device with ACS, this should be basic authentication with the correct credentials.

### Connection Request Testing
1. The connection request URL reported by the device as a TR-069 parameter is determined by the agent.csv IP address configuration, not the actual IP address.
2. For connection request testing, you can put connection requests in the JMS queue using Postman with the test harness. In this case enter a URL that corresponds with the actual visible IP address and port of the simulator.
3. For functional tests, the agent.csv configuration will have to be set up so the device reports a valid connection request URL.

### Dockerfile
The Dockerfile packages all the data in the dump directory at the project root into the docker image.
The build requires a build argument JAR_FILE that is passed from the maven plugin to avoid having version dependencies
in the Dockerfile directly.

When run in a docker container, the agent.csv file is not required. Instead the following environment variables can be
passed, from docker-compose, or from the docker command line --env-file. The agent file
can be used if desired by mounting a volume at /conf in the docker image.

- SIMULATOR: (required) Name of the subdirectory in which the simulator configuration files are found.
- ACS_URL: (required) URL to the ACS TR-069 server.
- PI_INTERVAL: Initial periodic inform interval in seconds, defaults to 600 if not set.
- CR_PATH: The path component of the connection request URL for the simulator, defaults to /.
- CR_PORT: The port on which the simulator listens for connection requests, defaults to 8035.
- AUTH_TYPE: Type of authentication, basic or digest. Defaults to none.
- AUTH_USER_NAME: User name for authentication, if required.
- AUTH_CREDENTIAL: Password for authentication, if required.
 
### Requirement

- JDK >=1.7

<br>

<b>License</b><br>
MIT License.<br>



