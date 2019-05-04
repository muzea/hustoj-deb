PREFIX ?= /usr/local
USER_ROOT = `pwd`/debian/hustoj
HUSTOJ_ROOT = $(USER_ROOT)/home/judge

prepare:
	mv /hustoj/trunk/* .

judged:
	cd core/judged \
	&& g++ -Wall -c -I/usr/local/mysql/include/mysql -I/usr/include/mysql judged.cc \
	&& g++ -Wall -o judged judged.o -L/usr/local/mysql/lib/mysql -L/usr/lib/mysql  -L/usr/lib64/mysql  -lmysqlclient \
	&& chmod +x judged

judge_client:
	cd core/judge_client \
	&& g++ -Wall -c -I/usr/local/mysql/include/mysql -I/usr/include/mysql judge_client.cc \
	&& g++ -Wall -o judge_client judge_client.o -L/usr/local/mysql/lib/mysql -L/usr/lib/mysql  -L/usr/lib64/mysql -lmysqlclient \
	&& chmod +x judge_client

all: judged judge_client

install: all
	mkdir -p $(USER_ROOT)/usr/bin \
	&& cp ./core/judged/judged $(USER_ROOT)/usr/bin \
	&& cp ./core/judge_client/judge_client $(USER_ROOT)/usr/bin \
	&& mkdir -p $(HUSTOJ_ROOT) \
	&& mkdir $(HUSTOJ_ROOT)/etc \
	&& mkdir $(HUSTOJ_ROOT)/data \
	&& mkdir $(HUSTOJ_ROOT)/log \
	&& mkdir $(HUSTOJ_ROOT)/src \
	&& mkdir $(HUSTOJ_ROOT)/sql \
	&& cp -R ./web $(HUSTOJ_ROOT)/src/web \
	&& cp ./install/java0.policy $(HUSTOJ_ROOT)/etc/ \
	&& cp ./install/judge.conf $(HUSTOJ_ROOT)/etc/ \
	&& cp ./nginx.conf $(HUSTOJ_ROOT)/etc/ \
	&& cp ./install/db.sql $(HUSTOJ_ROOT)/sql/ \
	&& chmod 700 $(HUSTOJ_ROOT)/etc/judge.conf \
	&& chmod 700 $(HUSTOJ_ROOT)/src/web/include/db_info.inc.php \
	&& chown www-data $(HUSTOJ_ROOT)/src/web/include/db_info.inc.php \
	&& chown www-data $(HUSTOJ_ROOT)/src/web/upload $(HUSTOJ_ROOT)/data

