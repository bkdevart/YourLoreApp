//
//  ContentView.swift
//  YourLore
//
//  Created by Brandon Knox on 4/24/21.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State var results = [Lore]()
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var annotations = [CodableMKPointAnnotation]()
    
    var body: some View {
        NavigationView {
            Form {
                NavigationLink("Map", destination: NavView(centerCoordinate: $centerCoordinate, locations: $annotations, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, showingEditScreen: $showingEditScreen))
                List(results, id: \.id) { lore in
                    NavigationLink(destination: LoreView(lore: lore)) {
                        VStack(alignment: .leading) {
                            Text(lore.title)
                                .font(.headline)
                        }
                    }
                }
                .navigationBarTitle("Your Lore")
            }
            .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        // create the URL we want to read
        guard let url = URL(string: "http://127.0.0.1:8000/lore") else {
            print("Invalid URL")
            return
        }
        
        // wrap url in URLRequest to configure how the URL will be accessed
        let request = URLRequest(url: url)
        
        // create and start a network task from the URLRequest
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle the result of the networking task
            if let data = data {
                if let decodedResponse = try?JSONDecoder().decode([Lore].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse
                    }
                    print("Results returned")
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            print(request)
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
