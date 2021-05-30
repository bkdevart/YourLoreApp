//
//  EditView.swift
//  BucketList
//
//  Created by Brandon Knox on 5/23/21.
//

import MapKit
import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation
    @State private var loadingState = LoadingState.loading
    @Binding var locations: [CodableMKPointAnnotation]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
                Button("Delete pin") {
                    let removeIndex = locations.firstIndex(where: { $0.title! == placemark.wrappedTitle})
                    locations.remove(at: removeIndex!)
                    self.presentationMode.wrappedValue.dismiss()
                }
                .accentColor(.red)
            }
            .navigationBarItems(trailing: Button("Done") {
                                    self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
