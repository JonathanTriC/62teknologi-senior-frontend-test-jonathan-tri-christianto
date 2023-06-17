//
//  ReviewsViewModal.swift
//  Yelp
//
//  Created by JonathanTriC on 17/06/23.
//

import Foundation
import Alamofire

class ReviewsViewModel: ObservableObject {
    @Published var model: ReviewsModel!
    @Published var isLoading: Bool = true

    
    func fetchData(businessId: String, offset: Int) {
        let url = URL(string: "\(Constants.BASE_URL)\(businessId)/reviews")!
        let parameters: [String : Any] = ["limit": 10,
                                          "sort_by": "yelp_sort",
                                          "offset": offset]
        let headers: HTTPHeaders = ["accept": "application/json", "Authorization": "Bearer \(Constants.API_KEYS)"]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    self.isLoading = false
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(ReviewsModel.self, from: data)
                                                
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
