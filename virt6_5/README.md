**Задача 1**  

```
solo@solo-vm:~$ cat Dockerfile
FROM centos:7
ENV PATH=/usr/lib:/usr/lib/jvm/jre-11/bin:$PATH

RUN yum install java-11-openjdk -y 
RUN yum install wget -y 

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz \
    && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz.sha512 
RUN yum install perl-Digest-SHA -y 
RUN shasum -a 512 -c elasticsearch-8.2.2-linux-x86_64.tar.gz.sha512 \ 
    && tar -xzf elasticsearch--8.2.2-linux-x86_64.tar.gz \
    && yum upgrade -y
    
ADD elasticsearch.yml /elasticsearch/config/
ENV JAVA_HOME=/elasticsearch/jdk/
ENV ES_HOME=/elasticsearch-8.2.2
RUN groupadd elasticsearch \
    && useradd -g elasticsearch elasticsearch
    
RUN mkdir /var/lib/logs \
    && chown elasticsearch:elasticsearch /var/lib/logs \
    && mkdir /var/lib/data \
    && chown elasticsearch:elasticsearch /var/lib/data \
    && chown -R elasticsearch:elasticsearch /elasticsearch/
RUN mkdir /elasticsearch/snapshots &&\
    chown elasticsearch:elasticsearch /elasticsearch/snapshots
    
USER elasticsearch
CMD ["/usr/sbin/init"]
CMD ["/elasticsearch/bin/elasticsearch"]
```
https://hub.docker.com/r/dsolokhin/elasticsearch
```
docker pull dsolokhin/elasticsearch
```
```
elasticsearch@4341d2ae6021:~$ curl --cacert /usr/share/elasticsearch/config/certs/http_ca.crt -u elastic https://localhost:9200
Enter host password for user 'elastic':
{
  "name" : "4341d2ae6021",
  "cluster_name" : "netology_test",
  "cluster_uuid" : "nF121thfThaT1dEGIt7lIQ",
  "version" : {
    "number" : "8.2.2",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "9876968ef3c745186b94fdabd4483e01499224ef",
    "build_date" : "2022-05-25T15:47:06.259735307Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

**Задача 2**  
```
elasticsearch@6955d3023d93:~$ curl -X PUT localhost:9200/ind-1 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
curl: (52) Empty reply from server
elasticsearch@6955d3023d93:~$ curl --cacert /usr/share/elasticsearch/config/certs/http_ca.crt -u elastic -X PUT https://localhost:9200/ind-1?pretty -H 'Content-Type: application/json' -d'{ "settings": { "index": { "number_of_shards": 1, "number_of_replicas": 0 }}}'
Enter host password for user 'elastic':
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-1"
}
elasticsearch@6955d3023d93:~$ curl --cacert /usr/share/elasticsearch/config/certs/http_ca.crt -u elastic -X PUT https://localhost:9200/ind-2?pretty -H 'Content-Type: application/json' -d'{ "settings": { "index": { "number_of_shards": 2, "number_of_replicas": 1 }}}'
Enter host password for user 'elastic':
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-2"
}
elasticsearch@6955d3023d93:~$ curl --cacert /usr/share/elasticsearch/config/certs/http_ca.crt -u elastic -X PUT https://localhost:9200/ind-3?pretty -H 'Content-Type: application/json' -d'{ "settings": { "index": { "number_of_shards": 4, "number_of_replicas": 2 }}}'
Enter host password for user 'elastic':
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-3"
}
elasticsearch@6955d3023d93:~$ curl --cacert /usr/share/elasticsearch/config/certs/http_ca.crt -u elastic https://localhost:9200/_cat/indices?v
Enter host password for user 'elastic':
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 1VfO1znuTRumq1hHz4tb4w   1   0          0            0       225b           225b
yellow open   ind-2 34VbW6fGTKq0eJ0I6MATeQ   2   1          0            0       450b           450b
yellow open   ind-3 pbcaY8SFQgKUiVyBO6ykZw   4   2          0            0       900b           900b
```
```
elasticsearch@6955d3023d93:~$ curl --cacert /usr/share/elasticsearch/config/certs/http_ca.crt -u elastic https://localhost:9200/_cluster/health?pretty
Enter host password for user 'elastic':
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 9,
  "active_shards" : 9,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 47.368421052631575
}
```
Cтатус Yellow в данном случае показывает, что репликам некуда реплицироваться.  
```
elasticsearch@6955d3023d93:~$ curl --cacert /usr/share/elasticsearch/config/certs/http_ca.crt -u elastic -X DELETE https://localhost:9200/ind-1?pretty
Enter host password for user 'elastic':
{
  "acknowledged" : true
}
elasticsearch@6955d3023d93:~$ curl --cacert /usr/share/elasticsearch/config/certs/http_ca.crt -u elastic -X DELETE https://localhost:9200/ind-2?pretty
Enter host password for user 'elastic':
{
  "acknowledged" : true
}
elasticsearch@6955d3023d93:~$ curl --cacert /usr/share/elasticsearch/config/certs/http_ca.crt -u elastic -X DELETE https://localhost:9200/ind-3?pretty
Enter host password for user 'elastic':
{
  "acknowledged" : true
}
```
