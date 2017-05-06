#   Node.js Docker Image
Want to use **docker** and **docker-compose** in your development pipeline? Welcome!

##  Features
All the images have the following features:
1.  Hint for the command to initialize a new project so that it can be **docker-compose** friendly.

    Spawn the following command in terminal:
    ```
    docker inspect <image> -f "{{.Config.Labels.init}}"
    ```
    *NOTE*: Replace `<image>` with appropriate image name or ID.

    **Example**: With an image name
    ```
    docker inspect eleidan/node:5.12.0-jessie -f "{{.Config.Labels.init}}"
    ```
    As a result, the following output is expected:
    ```
    docker run -it --rm -v $(pwd):/home/phantom/app eleidan/node:5.12.0-jessie docker-init.sh
    ```

    Now, check if it is possible to spawn a container with **docker-compose**.
    Issue the following command:
    ```
    docker-compose run dev
    ```
    A prompt of the container is expected to welcome you:
    ```
    [ 172.19.0.2 | node_app.dev | ~/app ]
    >
    ```

2.  Hint for the command to run a container.

    Spawn the following command in terminal:
    ```
    docker inspect <image> -f "{{.Config.Labels.run}}"
    ```
    *NOTE*: Replace `<image>` with appropriate image name or ID.

    **Example**: With an image name
    ```
    docker inspect eleidan/node:5.12.0-jessie -f "{{.Config.Labels.run}}"
    ```
    As a result, the following output is expected:
    ```
    docker run -it --rm -v $(pwd):/home/phantom/app eleidan/node:5.12.0-jessie bash
    ```

    Running the command above provides the following:
      * Current directory is mounted to the `/home/phantom/app` directory inside the container.
      * New container is spawned in interaction mode with a nifty shell prompt and proper user `UID` and `GID`.

3.  Nifty shell prompt with the container IP and a service name provided by the container.

    Running a command obtained thanks to the feature **2**, presents the following output:
    ```
    [ 172.17.0.2 | node:5.12.0-jessie | ~/app ]
    >
    ```
    The `172.17.0.2` is the container's IP,
    the `node:5.12.0-jessie` is the name of the service presented by the container,
    the `~/app` is the currunt working directory.

    Running the `docker-compose run dev` command provides the same info with the service name picked from the `docker-compose.yml` config file.
    Feel free to update the value for the `SERVICE_NAME` variable in there.

    *NOTE*: The `docker-compose.yml` config file is generated in scope of the feature **1**.

4.  The `node_modules/.bin` directory is added to the `$PATH`.
    This means, it is possible to run any executable binary inside container from that directory, by its name.

    **Example**: Run jasmine in a project that uses it

      ```
      [ 172.19.0.2 | node_app.dev | ~/app ]
      > jasmine
      Started

      No specs found
      Finished in 0.002 seconds
      ```

5.  Nifty non-root user out-of-box.
    During container start host user `UID` and `GID` are propagated to the container user.
    This means, any activity inside container respects host user ownership.

    **Example**:
    ```
    $ id
    uid=1004(user) gid=1004(user) groups=1004(user),999(docker)
    $ docker-compose run dev
    Updated UID and GID for the 'phantom' user according to the '/home/phantom/app' directory.
    [ 172.19.0.2 | node_app.dev | ~/app ]
    > id
    uid=1004(phantom) gid=1004(phantom) groups=1004(phantom)
    ```
    Commonly known issue is a root user inside container.
    New files created inside container have root `UID` and `GID`.
    This leads to issues for the host user, like a privileged access is needed for those files.
