import ballerinax/github;
import ballerina/http;

// import ballerinax/github;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # + return - string[] 
    resource function get getRepos() returns string[]|error? {

        github:Client ghClient = check new (config = {
            auth: {
                token: "c"
            }
        });
        // Send a response back to the caller.

        // string[] r = [];
        // int i = 0;
        stream<github:Repository, error?> getRepositoriesResponse = check ghClient->getRepositories();
        // foreach var x in check getRepositoriesResponse {
        //     if x is github:Repository {
        //         r[i] = x.name;
        //         i = i + 1;
        //     }
        // }

        string[]? repos = check from github:Repository r in getRepositoriesResponse select r.name;
        check getRepositoriesResponse.close();


        return repos;
    }
}
