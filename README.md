# FRI Xv6 Docker Environment

This documentation provides instructions for setting up and using the FRI Xv6 Docker environment. In this environment we will be using the *RISC-V version* of Xv6, as it is the currently maintained version of the Xv6 operating system.

This project is a part of the Bachelor Thesis titled **Instructional Operating Systems** by Dejan Jarc from the Faculty of Computer Science and Informatics (University of Ljubljana, Slovenia). It is meant to serve as a pedagogical tool for OS courses, but can also be used by any OS enthusiast.

> The base system we are using in this project is **Ubuntu 25.04**.

## Prerequisites

Before proceeding, ensure you have the following prerequisites set up:

1. **Install Docker and Docker Compose**:
    Make sure Docker and Docker Compose are installed on your system. You can download and install them from the [Docker website](https://www.docker.com/). **The best way is to setup [Docker Desktop](https://www.docker.com/products/docker-desktop/).**
    

    > For Windows users, it is recommended to enable *Windows Subsystem for Linux (WSL)* within Docker Desktop for better compatibility.

2. **Verify Docker Installation**:
    Confirm that Docker is installed and running by executing:
    ```bash
    docker --version
    docker-compose --version
    ```
---

## Getting Started

You can set up the Docker environment using Docker Hub.

1. **Pull the image from Docker Hub**
    ```bash
    docker pull dejanjarc/fri-xv6
    ```
    or (when in the directory of the Docker Compose file):
    ```bash
    docker compose pull
    ```

2. **Run a named container**
    ```bash
    docker run --name <CONTAINER_NAME> -itd dejanjarc/fri-xv6
    ```
  Replace `<CONTAINER_NAME>` with the name of your Xv6 container. You can choose your own name.
  The flag `-d` is there so that we run the container detached. 

3. **Connect to the Running Container**
    Once the containers are running, you can connect to the Xv6 container by executing:
    ```bash
    docker exec -it <CONTAINER_NAME> /bin/bash
    ```
    Replace `<CONTAINER_NAME>` with the name or ID of the Xv6 container. To find the container name or ID, run:
    
    ```bash
    docker ps
    ```

    Alternatively, you can attach to the container using:
    ```bash
    docker attach <CONTAINER_NAME>
    ```
    If you detach, restart the container with:
    ```bash
    docker start <CONTAINER_NAME>
    ```
    > It is recommended to use `docker exec` so your container doesn't stop after detaching.

You are now ready to use the FRI Xv6 Docker environment.

#### **Alternative for getting started**

1. **Clone the Repository**:
    Begin by cloning the repository from GitHub to your local machine:
    
    ```bash
    git clone https://github.com/dejanjarc/fri-xv6.git
    cd fri-xv6
    ```

2. **Build and Start the Docker Environment**:
    Build and start the Docker containers using the following command:
    ```bash
    docker-compose up --build
    ```
    or
    ```bash
    docker-compose build
    docker-compose up -d    
    ```

3. **Connect to the Running Container**:
    Once the containers are running, you can connect to the Xv6 container by executing:
    ```bash
    docker exec -it <CONTAINER_NAME> /bin/bash
    ```
    Replace `<CONTAINER_NAME>` with the name or ID of the Xv6 container. Default value for `CONTAINER_NAME` is `fri-xv6` To find the container name or ID, run:
    ```bash
    docker ps
    ```

    Alternatively, you can attach to the container using:
    ```bash
    docker attach <container_name>
    ```
    You need to run this commant to start the container again if you detach:
    ```bash
    docker start <CONTAINER_NAME>
    ``` 
    > It is recommended to use the `docker exec` instead so that your container doesn't always stop after you detach from it.

---

## Container Overview

The container home directory contains the Xv6 RISC-V directory, which contains the source code of Xv6. From there you can build the kernel and run the system. The steps on how to do that are described in the next part.

## Setting up and Running Xv6

Below are steps to build and run Xv6 inside the container. The references and guides used to make the process of setting up Xv6 are listed [here](#resources). Feel free to look through them for any other specific details about using Xv6.


The credentials for the system withing the container are: 
Username = **xv6**, password = **xv6** 
> If needed, you can freely install any packages you may require. If admin rights are needed, use the mentioned credentials.



### Running Xv6

To run Xv6 inside the container, you need to run this in the `xv6-riscv` directory:

```bash
make qemu
```
> This can be done directly without building the kernel, because that is done when the Docker environment is set up.

To shut down Xv6 you need to terminate QEMU by clicking **`CTRL+A`** and **`X`**. 

### Building the Kernel

If you want to rebuild the Xv6 kernel from source, you need to run this in the `xv6-riscv` directory:
```bash
make
```
> This will make sure the kernel is up to date based on the Makefile configuration and other changes made to the source code.

If needed, you can build the RISC-V toolchain by following the instructions in the `xv6-riscv/README` file.

---
## Resources
- [6.1810: Operating System Engineering (MIT)](https://pdos.csail.mit.edu/6.1810/2024)
- [Xv6 - Tools](https://pdos.csail.mit.edu/6.1810/2024/tools.html)
- [Xv6 - Guidance](https://pdos.csail.mit.edu/6.1810/2024/labs/guidance.html)
- [Xv6 and Unix utilities](https://pdos.csail.mit.edu/6.1810/2024/labs/util.html)
- *Xv6, a simple Unix-like teaching operating system* by Russ Cox, Frans M. Kaashoek, and Robert Morris. 2011.

---
## Notes

- Ensure Docker and Docker Compose are installed before proceeding. 
- If there are any bugs you wish to report, [open an issue or do a pull request with your solution](https://github.com/dejanjarc/fri-xv6).
