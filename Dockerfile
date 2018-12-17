FROM postgres:10
MAINTAINER Nathan Suberi <nsuberi@gmail.com>

# Need a POSTGIS version specified here: https://apt.postgresql.org/pub/repos/apt/pool/main/p/postgis/
ENV POSTGIS_MAJOR 2.5
ENV POSTGIS_VERSION 2.5.1+*

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY Config/ /docker-entrypoint-initdb.d/

# Listen on port 5432 to accept data from preloader and serve requests to website
EXPOSE 5432

## Useful links:
# https://github.com/hyndsite/docker4devs-react-mongo-compose/blob/master/.docker/mongo.dev.dockerfile
# https://stackoverflow.com/questions/26598738/how-to-create-user-database-in-script-for-docker-postgres
# https://github.com/appropriate/docker-postgis/tree/f6d28e4a1871b1f72e1c893ff103f10b6d7cb6e1/10-2.4
# More simple: https://github.com/klokantech/postgres-docker
