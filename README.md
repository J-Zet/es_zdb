# es_zdb
a dockerfile based on elasticsearch including the zomboDB plugin

## preconfiguration contains
- removing x-pack plugin (beware, as it comes with security risks)
- bind `network.host` to `0.0.0.0` to not restrict access to a specific IP
- adding zomboDB plugin
- required settings for zombodb
