# FVCKER
## Tool for Pentesting.
### Use for your own risk, we are not responsible for any damages.

# Installing
If you dont have git installed:
(Git Install)[https://git-scm.com/book/en/v2/Getting-Started-Installing-Git]

First of all, clone the repo in your machine
```git
git clone https://github.com/dgzdev/fvcker-tool.git
```
Go to the directory of the repo
```cmd
cd fvcker-tool
```
Give permission for the script execution
```sh
chmod +x fvcker.sh
```
Now, run the script and be free.
```sh
./fvcker.sh
```
# One step Installation
If you need a one step installation, just copy and paste in your terminal.
```sh
git clone https://github.com/dgzdev/fvcker-tool.git && cd fvcker-tool && chmod +x fvcker.sh
```
Then;
```sh
./fvcker.sh
```
# What the script does?
> Well, it lists all the subdomains of the URL typed, then it checks for the alives domains, checks the vulnerabilities for the alive domains and then lists all endpoints of the domains.
# Is it malicious?
> You can check the entire code of the script in the file fvcker.sh, but no, it is not malware.