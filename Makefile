install:
	wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.8.0-rc4.tgz
	tar -zxvf mongodb-linux-x86_64-2.8.0-rc4.tgz
	mv mongodb-linux-x86_64-2.8.0-rc4 2.8.0-rc4
	wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.6.7.tgz
	tar -zxvf mongodb-linux-x86_64-2.6.7.tgz
	mv mongodb-linux-x86_64-2.6.7 2.6.7

2.8:
	mkdir -p /data/db
	rm -rf /data/db/*
	./2.8.0-rc4/bin/mongod --nojournal --noprealloc

2.6:
	mkdir -p /data/db
	rm -rf /data/db/*
	./2.6.7/bin/mongod --nojournal --noprealloc

2.6-enterprise:
	mkdir -p /data/db
	rm -rf /data/db/*
	./2.6.4-enterprise/bin/mongod --nojournal --noprealloc

2.6-repl:
	rm -rf /data/db-*/*
	rm -rf ./2700*.log*
	mkdir -p /data/db-27000
	mkdir -p /data/db-27001
	mkdir -p /data/db-27002
	./2.6.1/bin/mongod --nojournal --noprealloc --fork --logpath ./27000.log --port 27000 --replSet "2.6-mongoose" --dbpath /data/db-27000 
	./2.6.1/bin/mongod --nojournal --noprealloc --fork --logpath ./27001.log --port 27001 --replSet "2.6-mongoose" --dbpath /data/db-27001
	./2.6.1/bin/mongod --nojournal --noprealloc --fork --logpath ./27002.log --port 27002 --replSet "2.6-mongoose" --dbpath /data/db-27002
	echo "rs.status(); quit();" | ./2.6.1/bin/mongo --port 27000
	sleep 5
	./2.6.1/bin/mongo --port 27000 < start_replica_set.mongo.js
	./2.6.1/bin/mongo --port 27000
	
2.4:
	rm -rf /data/db/*
	./2.4.8/bin/mongod --nojournal --noprealloc --setParameter textSearchEnabled=true

2.2:
	rm -rf /data/db/*
	./2.2.7/bin/mongod --nojournal --noprealloc
