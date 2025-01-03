# Onion Office

TL;DR: the goal is to make a *tor-ified* office environment where we can host our own services and clients.

Services are exposed as onion services and clients are torified using Torsocks.



## Services

- mox mail server 
- sourcehut
- mediawiki
- Postgres for database
- [Radicale](https://radicale.org/)
- Nginx for reverse proxy to route all traffic through the onion service to the docker containers
## Clients

- thunderbird + Torsocks
- tor browser



The goal is to make this into a docker compose file that can be deployed on a debian system.

i would LIKE for just one .onion address to be used for all services, so the users have a user@xyz.onion address.

```bash
 $ tree docker/onion_office
docker/onion_office
├── compose.yml
├── onionoffice.env
├── README.md
└── services
    └── sourcehut
        ├── Dockerfile
        └── mox
            └── Dockerfile

4 directories, 5 files
```


I uploaded a bunch of documentation on these services as html documents. can you please read them then help create a docker compose file that can be deployed on a debian system.

