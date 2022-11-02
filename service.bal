import ballerinax/github;
import ballerina/http;

configurable string ghaccessToken = ?;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # + return - string[] 
    resource function get getRepos() returns string[]|error? {

        github:Client ghClient = check new (config = {
            auth: {
                token: ghaccessToken
            }
        });
        stream<github:Repository, error?> getRepoStream = check ghClient->getRepositories();

        string[]? repos = check from github:Repository repo in getRepoStream select repo.name;
        //check getRepoStream.close();

        return repos;
    }
}
