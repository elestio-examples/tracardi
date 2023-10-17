[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Tracardi, verified and packaged by Elestio

[Tracardi](https://github.com/Tracardi/tracardi) is an API-first solution, low-code / no-code platform aimed at any business that wants to start using user data for automated customer engagement. Tracardi is intended for anyone who carries out any type of customer interaction, be it through sales or service delivery.

<img src="https://github.com/elestio-examples/tracardi/raw/main/tracardi.png" alt="tracardi" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/tracardi">fully managed Tracardi</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you are interested in exploring a decentralized and community-oriented approach to online content.

[![deploy](https://github.com/elestio-examples/Tracardi/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?soft=Tracardi)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/tracardi.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:6580`

## Docker-compose

Here are some example snippets to help you get started creating a container.


    version: "3.7"
    services:
      tracardi-staging-api:
        image: elestio4test/tracardi-api:${SOFTWARE_VERSION_TAG}
        restart: always
        environment:
          ELASTIC_HOST: http://elasticsearch:9200
          REDIS_HOST: redis://redis:6379
          LOGGING_LEVEL: info
          LICENSE: ${API_LICENSE}
          PRODUCTION: "no"
          TRACK_DEBUG: "yes"
        ports:
          - 172.17.0.1:8686:80
        depends_on:
          - redis
          - elasticsearch

      tracardi-gui:
        image: elestio4test/tracardi-api:${SOFTWARE_VERSION_TAG}
        restart: always
        environment:
          API_URL: http://tracardi-staging-api:80
        ports:
          - 172.17.0.1:8787:80
        depends_on:
          - tracardi-staging-api

      elasticsearch:
        image: docker.elastic.co/elasticsearch/elasticsearch:7.13.2
        restart: always
        environment:
          bootstrap.memory_lock: "true"
          ES_JAVA_OPTS: "-Xms512m -Xmx512m"
          discovery.type: single-node
          xpack.security.enabled: "false"
          cluster.name: contextElasticSearch
        volumes:
          - ./es_data:/usr/share/elasticsearch/data

      redis:
        image: redis
        restart: always
        volumes:
          - ./data:/data



### Environment variables

|       Variable       | Value (example) |
| :------------------: | :-------------: |
| SOFTWARE_VERSION_TAG |     latest      |
|  ADMIN_PASSWORD      |    password     |
|  ADMIN_EMAIL         |     Email       |

# Maintenance

## Logging

The Elestio Tracardi Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/Tracardi/tracardi">Tracardi Github repository</a>

- <a target="_blank" href="https://docs.tracardi.com/">Tracardi documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/leantracarditime">Elestio/Tracardi Github repository</a>
