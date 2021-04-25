//
//  ContentView.swift
//  YourLore
//
//  Created by Brandon Knox on 4/24/21.
//

import SwiftUI

struct Result: Codable {
    var id: Int
    var title: String
    var story: String
}

struct ContentView: View {
    @State var results = [Result]()
    
    var body: some View {
        Form {
            List(results, id: \.id) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.story)
                        .font(.body)
                }
            }
        }
        .onAppear(perform: loadData)
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
                if let decodedResponse = try?JSONDecoder().decode([Result].self, from: data) {
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
