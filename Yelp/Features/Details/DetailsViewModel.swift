//
//  DetailsViewModel.swift
//  Yelp
//
//  Created by JonathanTriC on 17/06/23.
//

import Foundation
import Alamofire

class DetailsViewModel: ObservableObject {
    @Published var model: DetailsModel!
    @Published var reviewsModel: ReviewsModel!
    @Published var isLoading: Bool = true
    
    func fetchDataDetails(businessId: String) {
        let url = URL(string: "\(Constants.BASE_URL)\(businessId)")!
        let headers: HTTPHeaders = ["accept": "application/json", "Authorization": "Bearer \(Constants.API_KEYS)"]
        
        AF.request(url, method: .get, headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(DetailsModel.self, from: data)
                                                
                        self.model = result
                    } catch {
                        print("Error: \(error)")
                    }
                    
                    self.fetchPreviewReview(businessId: businessId)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    func fetchPreviewReview(businessId: String) {
        let url = URL(string: "\(Constants.BASE_URL)\(businessId)/reviews?limit=3&sort_by=yelp_sort")!
        let headers: HTTPHeaders = ["accept": "application/json", "Authorization": "Bearer \(Constants.API_KEYS)"]
        
        AF.request(url, method: .get, headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    self.isLoading = false
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(ReviewsModel.self, from: data)
                        
                        
                        self.reviewsModel = result
                    } catch {
                        print("Error: \(error)")
                    }
                case let .failure(error):
                    print(error)
                }
            }
    }
}
