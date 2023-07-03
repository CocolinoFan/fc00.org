# fc00.org

Source code for http://www.fc00.org (http://h.fc00.org on Hyperboria).

## Sending your view of the network

In order to display accurate map of Hyperboria fc00 we need your help. If you run CJDNS node, please send your network view using sendGraph.py script.

```bash
# Install the Python3 packages: requests and cjdns
pip3 install cjdns requests
# Get the script
wget https://raw.githubusercontent.com/cjdelisle/fc00.org/master/scripts/sendGraph.py
# Edit configuration
nano sendGraph.py
chmod +x sendGraph.py

# Run this every 20-100 minutes
./sendGraph.py
# For example, add it to crontab
(crontab -l; echo "@hourly /root/sendGraph.py") | crontab -
```

## Web server
```bash
git clone git@github.com:cjdelisle/fc00.org.git
cd fc00.org
git clone git@github.com:zielmicha/nodedb.git web/nodedb

### Debian/Ubuntu

sudo apt-get install python-flask python-flup python-pymysql python-pygraphviz

### Gentoo

sudo emerge --ask dev-python/flask dev-python/pymysql dev-python/pygraphviz


Configuring an SQL server:
On Gentoo:
sudo echo "dev-db/mysql server" > /etc/portage/package.use/mysql 
sudo emerge --ask dev-db/mysql (Follow instructions on https://wiki.gentoo.org/wiki/MySQL for setup)

Createing the required database, tables and columns
mysql -u root -p
CREATE DATABASE cjdns;
USE cjdns;
CREATE TABLE nodes (
ip varchar(255),
name varchar(255),
version varchar(255),
first_seen varchar(255),
last_seen varchar(255)
);
CREATE TABLE edges (
a varchar(255),
b varchar(255),
first_seen varchar(255),
last_seen varchar(255),
uploaded_by varchar(255)
);
#Confirm that the apropriate tables have been created
SHOW TABLES;
#and that they have the correct columns
SHOW COLUMNS FROM nodes;
SHOW COLUMNS FROM edges;
#If correct
EXIT;

cp web_config.example.cfg web_config.cfg
vim web_config.cfg
#Set the appropriate MYSQL_DATABASE_USER, MYSQL_DATABASE_PASSWORD, MYSQL_DATABASE_PORT (if sql not running on the default 3306) and MYSQL_DATABASE_HOST (if sql not running on the same machine)

python web/web.py
```

Run `web/updateGraph.py` periodically to rerender nodes graph. You may want to customize reverse-proxy IP retrieval logic in web.py.
