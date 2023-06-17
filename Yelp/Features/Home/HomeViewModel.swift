//
//  HomeViewModel.swift
//  Yelp
//
//  Created by JonathanTriC on 16/06/23.
//

import Foundation
import Alamofire

class HomeViewModel: ObservableObject {
    @Published var model: HomeModel!
    @Published var isLoading: Bool = true
    
    func fetchData(sort_by: String, location: String, term: String?, offset: Int) {
        let url = URL(string: "\(Constants.BASE_URL)search")!
        let parameters: [String : Any] = ["location":location,
                                          "sort_by":sort_by,
                                          "term": term ?? "",
                                          "limit": 10,
                                          "offset": offset]
        let headers: HTTPHeaders = ["accept": "application/json", "Authorization": "Bearer \(Constants.API_KEYS)"]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    self.isLoading = false

                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(HomeModel.self, from: data)
                        
                        self.model = result
                    } catch {
                        print("Error: \(error)")
                    }
                case let .failure(error):
                    print(error)
                }
            }
    }
}
