### Working with database
1. Start up Docker Compose\
`$ docker compose up -d`
2. Connect to to localhost:6000, credentials in compose.yaml file.\
Enjoy!
3. To back up database, run\
`$ ./backup.sh`\
The exported file is ./initdb.d/echovibe.sql
Remember to remove lines related to `ROLE postgres`
