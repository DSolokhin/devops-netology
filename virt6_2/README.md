**Задача 1**  
```
solo@solo-vm:~$ sudo docker pull postgres:12
[sudo] пароль для solo: 
12: Pulling from library/postgres
214ca5fb9032: Already exists 
e6930973d723: Pull complete 
aea7c534f4e1: Pull complete 
d0ab8814f736: Pull complete 
648cc138980a: Pull complete 
7804b894301c: Pull complete 
cfce56252c3f: Pull complete 
8cce7305e3b6: Pull complete 
4bdcc591c3ab: Pull complete 
3b8ac9686818: Pull complete 
0496910cafcd: Pull complete 
a0e0019d8bec: Pull complete 
8956e272abff: Pull complete 
Digest: sha256:742e8c57aaa18bf60076b959ea3e7c7aa118a963eca0a0d6b3daefe7bbbc0e8d
Status: Downloaded newer image for postgres:12
docker.io/library/postgres:12
solo@solo-vm:~$ docker volume create pgvolume1
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/volumes/create": dial unix /var/run/docker.sock: connect: permission denied
solo@solo-vm:~$ sudo docker volume create pgvolume1
pgvolume1
solo@solo-vm:~$ sudo docker volume create pgvolume2
pgvolume2
solo@solo-vm:~$ docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v pgvolume1:/var/lib/postgresql/data -v pgvolume2:/var/lib/postgresql postgres:12
docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/create?name=pg-docker": dial unix /var/run/docker.sock: connect: permission denied.
See 'docker run --help'.
solo@solo-vm:~$ sudo docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v pgvolume1:/var/lib/postgresql/data -v pgvolume2:/var/lib/postgresql postgres:12
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... Etc/UTC
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok

initdb: warning: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.

Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

waiting for server to start....2022-05-20 07:44:18.469 UTC [47] LOG:  starting PostgreSQL 12.11 (Debian 12.11-1.pgdg110+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 10.2.1-6) 10.2.1 20210110, 64-bit
2022-05-20 07:44:18.471 UTC [47] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-05-20 07:44:18.506 UTC [48] LOG:  database system was shut down at 2022-05-20 07:44:18 UTC
2022-05-20 07:44:18.512 UTC [47] LOG:  database system is ready to accept connections
 done
server started

/usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

2022-05-20 07:44:18.763 UTC [47] LOG:  received fast shutdown request
waiting for server to shut down....2022-05-20 07:44:18.766 UTC [47] LOG:  aborting any active transactions
2022-05-20 07:44:18.773 UTC [47] LOG:  background worker "logical replication launcher" (PID 54) exited with exit code 1
2022-05-20 07:44:18.774 UTC [49] LOG:  shutting down
2022-05-20 07:44:18.795 UTC [47] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2022-05-20 07:44:18.885 UTC [1] LOG:  starting PostgreSQL 12.11 (Debian 12.11-1.pgdg110+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 10.2.1-6) 10.2.1 20210110, 64-bit
2022-05-20 07:44:18.885 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2022-05-20 07:44:18.886 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2022-05-20 07:44:18.888 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-05-20 07:44:18.928 UTC [66] LOG:  database system was shut down at 2022-05-20 07:44:18 UTC
2022-05-20 07:44:18.934 UTC [1] LOG:  database system is ready to accept connections
^Z^C2022-05-20 07:46:58.497 UTC [1] LOG:  received fast shutdown request
2022-05-20 07:46:59.059 UTC [1] LOG:  aborting any active transactions
2022-05-20 07:46:59.062 UTC [1] LOG:  background worker "logical replication launcher" (PID 72) exited with exit code 1
2022-05-20 07:46:59.071 UTC [67] LOG:  shutting down
2022-05-20 07:46:59.763 UTC [1] LOG:  database system is shut down
```
