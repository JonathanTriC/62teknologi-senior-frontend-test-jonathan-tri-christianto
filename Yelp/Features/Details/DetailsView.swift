//
//  DetailsView.swift
//  Yelp
//
//  Created by JonathanTriC on 17/06/23.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct DetailsView: View {
    @StateObject private var viewModel = DetailsViewModel()
    @State var businessId: String
    @State private var isShowMoreReview: Bool = false
    
    var body: some View {
        ZStack {
            Color("BgColor")
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.gray))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                ImageSlider(viewModel.model.photos)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text(viewModel.model.name)
                            .font(.title.bold())
                            .multilineTextAlignment(.leading)
                        
                        Text("\(viewModel.model.location.address1) • \(viewModel.model.location.city)")
                            .font(.subheadline)
                        
                        HStack(spacing: 8) {
                            StarsView(rating: Float(viewModel.model.rating))
                            
                            Text("\(viewModel.model.reviewCount) Reviews")
                                .font(.subheadline)
                        }
                        Button {
                            let longitude = viewModel.model.coordinates.longitude
                            let latitude = viewModel.model.coordinates.latitude
                            let name = viewModel.model.alias
                            let nameQuery = name.replacingOccurrences(of: "-", with: "+")
                            
                            let url = URL(string: "comgooglemaps://?q=\(nameQuery)&center=\(latitude),\(longitude)&zoom=12&mapmode=standard")
                            
                            if UIApplication.shared.canOpenURL(url!) {
                                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                            }
                            else{
                                let urlBrowser = URL(string: "https://www.google.co.in/maps/?q=\(nameQuery)&center=\(latitude),\(longitude)&zoom=12&mapmode=standard")
                                
                                UIApplication.shared.open(urlBrowser!, options: [:], completionHandler: nil)
                            }
                        } label: {
                            Text("Open In Google Maps")
                                .foregroundColor(Color.blue)
                        }
                        .padding(.bottom)
                        
                        
                        Text("Reviews")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom)
                        
                        ForEach(viewModel.reviewsModel.reviews) { review in
                            ReviewsCard(imageUrl: review.user.imageURL ?? "",
                                        name: review.user.name,
                                        date: review.timeCreated,
                                        rating: review.rating,
                                        text: review.text)
                        }
                        
                        Button {
                            isShowMoreReview.toggle()
                        } label: {
                            Text("See More Reviews")
                                .padding()
                                .foregroundColor(.white)
                                .background {
                                    Color.blue
                                }
                                .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background {
                    Color.white.cornerRadius(20, corners: [.topLeft, .topRight])
                }
                .padding(.top, 285)
            }
        }
        .foregroundColor(.black)
        .fullScreenCover(isPresented: $isShowMoreReview, content: {
            ReviewsView(businessId: businessId)
        })
        .task {
            await viewModel.fetchDataDetails(businessId: businessId)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(businessId: "zj8Lq1T8KIC5zwFief15jg")
    }
}
