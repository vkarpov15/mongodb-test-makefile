THREE-O = 3.0.0

install:
	rm -rf 3.0.*
	rm -rf mongodb-linux-x86_64-3.0.*.tgz
	wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-$(THREE-O).tgz
	tar -zxvf mongodb-linux-x86_64-$(THREE-O).tgz
	mv mongodb-linux-x86_64-$(THREE-O) $(THREE-O)
	rm -rf 2.6.*
	rm -rf mongodb-linux-x86_64-2.6.*.tgz
	wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.6.8.tgz
	tar -zxvf mongodb-linux-x86_64-2.6.8.tgz
	mv mongodb-linux-x86_64-2.6.8 2.6.8
	rm -rf 2.4.*
	rm -rf mongodb-linux-x86_64-2.4.*.tgz
	wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.4.12.tgz
	tar -zxvf mongodb-linux-x86_64-2.4.12.tgz
	mv mongodb-linux-x86_64-2.4.12 2.4.12

3.0:
	mkdir -p /data/db
	rm -rf /data/db/*
	./$(THREE-O)/bin/mongod --nojournal --noprealloc

3.0-wt:
	mkdir -p /data/db
	rm -rf /data/db/*
	./$(THREE-O)/bin/mongod --nojournal --noprealloc --storageEngine=wiredTiger

2.6:
	mkdir -p /data/db
	rm -rf /data/db/*
	./2.6.8/bin/mongod --nojournal --noprealloc

2.6-repl:
	rm -rf /data/db-*/*
	rm -rf ./2700*.log*
	mkdir -p /data/db-27000
	mkdir -p /data/db-27001
	mkdir -p /data/db-27002
	./2.6.8/bin/mongod --nojournal --noprealloc --fork --logpath ./27000.log --port 27000 --replSet "mongoose26" --dbpath /data/db-27000 
	./2.6.8/bin/mongod --nojournal --noprealloc --fork --logpath ./27001.log --port 27001 --replSet "mongoose26" --dbpath /data/db-27001
	./2.6.8/bin/mongod --nojournal --noprealloc --fork --logpath ./27002.log --port 27002 --replSet "mongoose26" --dbpath /data/db-27002
	echo "rs.initiate(); " | ./2.6.8/bin/mongo --port 27000
	sleep 5
	./2.6.8/bin/mongo --port 27000
	
2.4:
	rm -rf /data/db/*
	./2.4.12/bin/mongod --nojournal --noprealloc --setParameter textSearchEnabled=true
