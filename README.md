# Docker-craft

## Actual Minecraft version is **1.20.4**

## About
Docker-craft is just a simple ready repo to quickly enroll  new java Minecraft server inside of a Docker container on GNU-Linux.

Main ideas here are the simplicity and full transparency.


|[Installation](#Installation)|
|:---:|
|[Usage](#Usage)|
|[File structure](#File-structure)|


## Installation
### 1) Check dependencies:
Make sure to have this packages installed on your system:
- Docker

	You can find full installation manual here:
	https://docs.docker.com/desktop/install/linux-install/

- Docker compose

	You can find full installation manual here:
	https://docs.docker.com/compose/install/

- make
	```bash
	# For Debian based distributions.
	
	sudo apt install make -y
	```
	```bash
	# For RPM based distributions
	
	sudo yum install make
	```

- wget
	```bash
	# For Debian based distributions.
	
	sudo apt install wget -y
	```
	```bash
	# For RPM based distributions
	
	sudo yum install wget
	```

### 2) Clone repo
Just clone this repository.
```bash
git clone https://github.com/Molniyax/docker_craft.git
```

### 3) Set up server configurations
- **server.properties**
	Main config file for Minecraft server.
	Located here:
	```Location
	init/server.properties
	```
	
	Here you'll find different options, such us game difficulty level, spawn protection, game mode and etc.
	 
	Do **NOT** edit server port in this file!
	
	You can find more information here:
	https://minecraft.fandom.com/wiki/Server.properties

- **example.env**
	Located in root of repo:
	```location
	example.env
	```
	
	Here you can change name of the container and the server port.

### 4) Initialize project via make
Just execute this command from the root of the repo:
```bash
make init
```


## Usage
### Basic commands
To **start** or restart your server use:
```bash
make start
```

To **stop** it use: 
```bash
make stop
```

### Additional controls
To see server **logs** use:
```bash
make logs
```
Logs will appear on screen and will follow server execution until **Ctrl+C** is pressed.

To **interact** with the server console use:
```bash
make interact
```
Press **Ctrl+D** to stop interaction.

To **enter** insides of the container use:
```bash
make enter
```
You'll get into the shell of your container, **Ctrl+D** to exit.

To **kick all** the players use:
```bash
make kick_all
```


## File structure

```mermaid
graph TD;
	A{Docker-craft}-->|Initial server files| init;
	A{Docker-craft}-->|Docker volumes| volumes;
	A{Docker-craft}-->|Docker configuration files| E(Docker-compose.yaml, Makefile, etc)
	volumes-->|All save data| world;
	volumes-->|Log dumps| logs;
	volumes-->|Saved crash-reports| crash-reports;
	volumes-->|Miscellaneous data| misc;
	misc-->|List of servers OP's| B(ops.json);
	misc-->|Blacklist| C(banned-players.json);
	misc-->|Blacklist| D(banned-ips.json);
	misc-->|Whitelist| F(whitelist.json);
```


