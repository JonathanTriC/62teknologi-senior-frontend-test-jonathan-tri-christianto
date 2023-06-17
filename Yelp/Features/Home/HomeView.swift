//
//  HomeView.swift
//  Yelp
//
//  Created by JonathanTriC on 16/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var page: Int = 0
    @State private var location: String = "nyc"
    @State private var isShowSearch: Bool = false
    @State private var searchTxt: String = ""
    @State private var searchLocation: String = ""
    
    var sort = ["Best Match", "Rating", "Review Count", "Distance"]
    @State var selectedSort: String = "Best Match"
    @State var sortBy: String = "best_match"

    
    @ViewBuilder private var header: some View {
        HStack() {
            Text("Yelp")
                .font(.title.bold())
            
            Spacer()
            
            Button {
                withAnimation {
                    isShowSearch.toggle()
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .fontWeight(.semibold)
            }
        }
        .padding(.bottom)
    }
    
    @ViewBuilder private var filter: some View {
        HStack {
            Text("Filter Sort By ")
            
            Picker("", selection: $selectedSort) {
                ForEach(sort, id: \.self) { item in
                    Text(item)
                }
            }
            .onChange(of: selectedSort, perform: { newValue in
                switch selectedSort {
                case "Rating":
                    sortBy = "rating"
                case "Review Count":
                    sortBy = "review_count"
                case "Distance":
                    sortBy = "distance"
                default:
                    sortBy = "best_match"
                }
                                
                page = 1
                
                viewModel.fetchData(sort_by: sortBy,
                                    location: location,
                                    term: searchTxt,
                                    offset: page)
            })
        }
    }
    
    @ViewBuilder private var search: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("",
                              text: $searchTxt,
                              prompt: Text("Input text...").foregroundColor(.gray)
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background {
                    Color.gray.opacity(0.1)
                }
                .cornerRadius(10)
                .padding(.bottom, 2)
                
                HStack {
                    Image(systemName: "location")
                    
                    TextField("",
                              text: $searchLocation,
                              prompt: Text("Input location...").foregroundColor(.gray)
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background {
                    Color.gray.opacity(0.1)
                }
                .cornerRadius(10)
            }
            .padding(.bottom, 6)
            
            
            Button {
                viewModel.fetchData(sort_by: sortBy,
                                    location: searchLocation.isEmpty ? "nyc" : searchLocation,
                                    term: searchTxt,
                                    offset: 1)
            } label: {
                Text("Search")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .background {
                        Color.blue
                    }
                    .cornerRadius(10)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor")
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    header
                    
                    if isShowSearch { search }
                    
                    filter
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.gray))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else {
                        ScrollView(showsIndicators: false) {
                            ForEach(self.viewModel.model.businesses) { item in
                                NavigationLink {
                                    DetailsView(businessId: item.id)
                                } label: {
                                    HomeCard(imageUrl: item.imageURL,
                                             name: item.name,
                                             address: "\(item.location.address1)\n\(item.location.city)",
                                             rating: item.rating,
                                             reviewsCount: item.reviewCount)
                                }
                            }
                            
                            Button {
                                page += 1
                                
                                viewModel.fetchData(sort_by: sortBy,
                                                    location: location,
                                                    term: searchTxt,
                                                    offset: page)
                            } label: {
                                Text("Load More")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background {
                                        Color.blue
                                    }
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .foregroundColor(.black)
            }
        }
        .task {
            await viewModel.fetchData(sort_by: sortBy,
                                      location: location,
                                      term: searchTxt,
                                      offset: page)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
