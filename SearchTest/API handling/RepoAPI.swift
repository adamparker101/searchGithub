//
//  RepoAPI.swift
//  SearchTest
//
//  Created by Adam Parker on 12/05/2020.
//  Copyright © 2020 Adam Parker. All rights reserved.
//

import Alamofire

class RepoAPI: NSObject {
    
    static let sharedInstance = RepoAPI()
    
    func searchRepos(name : String , completion: @escaping (SearchRepoResponse? , Error?) -> Void)
    {
        
        // you can pass further variables which change the order and so on if you wish.
        // You could also store this elsewhere in constants for example and have them put together such as
        // path = URL + name + URLparameters
        let path = "https://api.github.com/search/repositories?q=\(name)+language:assembly&sort=stars&order=desc"
        
        // Here we use alamofire to get a request from the GitHub API
        Alamofire.request(path).response { response in
            
            // This guard will allow us to check if the data is populated
            guard let data = response.data else {return}
            do {
                
                // We use JSONDecoder to use the data from the response and populate our custom object
                let decoder = JSONDecoder()
                let repoResponse = try decoder.decode(SearchRepoResponse.self, from: data)
                
                // Completion handler just allows us to return the data from wherever in the app we may need it easier.
                completion(repoResponse , nil)
                
            }catch let error {
                
                // Completion if no reponse we will return an error, this gives us good ability to send diagnostics or even show different messages to the user based on the error.
                completion(nil , error)
                
            }
        }
    }
    
}
