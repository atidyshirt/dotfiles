//Used to set up a replication set once the mongod application has started
//See: https://docs.mongodb.com/manual/tutorial/deploy-replica-set/#initiate-the-replica-set
const conn = new Mongo();

try {
    rs.initiate();
    while (rs.status().myState !== 1 || rs.isMaster().ismaster !== true) {
        sleep(1000);
    }

    db.adminCommand({ setDefaultRWConcern: 1, defaultWriteConcern: { w: 1 } });
} catch (error) {
    if (error.codeName === 'AlreadyInitialized') {
        console.log('mongoInit.js: Mongo already initialized');
    } else {
        console.error('mongoInit.js: ', error);
        throw error;
    }
}
