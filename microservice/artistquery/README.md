### Development configuration
#### Prequisites
- `conda` installed
#### Create and activate conda environment:
`$ conda create -n echovibe python=3.13.1`\
`$ conda activate echovibe`
#### Install dependencies
`$ pip install -r requirements.txt`
### Database Alembic
- Initilize alembic:\
`$ alembic init alembic`\
- Run migration up to latest version:\
`$ alembic upgrade head`
- Create a migration script
`$ alembic revision -m <name>`

### Environment Variable
#### Application
`APP_HOST`\
`APP_PORT`

#### Kafka
`KAFKA_BROKER_BOOTSTRAP_SERVER_URLS`

#### Database
`DATABASE_VENDOR`\
`DATABASE_HOST`\
`DATABASE_PORT`\
`DATABASE_USERNAME`\
`DATABASE_PASSWORD`\
`DATABASE_NAME`
- Used to build database_uri:
`{DATABASE_VENDOR}://{DATABASE_USERNAME}:{DATABASE_PASSWORD}@{DATABASE_HOST}:{DATABASE_PORT}/{DATABASE_NAME}`
