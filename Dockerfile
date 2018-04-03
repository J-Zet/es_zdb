# Elasticsearch v5.6.4 with ZomboDB v5.6.4-1.0.1

FROM docker.elastic.co/elasticsearch/elasticsearch:5.6.4

# Define ENV with most recent Version
ENV ZOMBODB_VER 5.6.4-1.0.1

# Add elasticsearch.yml config
ADD config/elasticsearch.yml /usr/share/elasticsearch/config/

USER root

# Download zomboDB
RUN \
  cd / && \
  mkdir zombodb && \
  cd zombodb && \
  wget https://www.zombodb.com/releases/v${ZOMBODB_VER}/zombodb-es-plugin-${ZOMBODB_VER}.zip 

# Make elasticsearch owner of plugin & config file
RUN \
  chown elasticsearch:elasticsearch \
  /zombodb/zombodb-es-plugin-${ZOMBODB_VER}.zip \
  /usr/share/elasticsearch/config/elasticsearch.yml

USER elasticsearch

# Remove X-Pack & therefore security that comes with it. Container purpose is to speed up dev
RUN bin/elasticsearch-plugin remove x-pack

# Install zomboDB (--batch flag to grant requested permissions)
RUN bin/elasticsearch-plugin install --batch file:///zombodb/zombodb-es-plugin-${ZOMBODB_VER}.zip

# Define default command.
CMD ["bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200 9300
