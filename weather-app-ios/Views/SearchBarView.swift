//
//  SearchBarView.swift
//  weather-app-ios
//
//  Created on 5/16/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var onSearch: () -> Void
    
    @FocusState private var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Search city...", text: $searchText)
                .padding(10)
                .padding(.leading, 28)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        Spacer()
                        
                        if isEditing {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .focused($isEditing)
                .onSubmit {
                    onSearch()
                }
                .padding(.horizontal, 10)
            
            Button(action: {
                onSearch()
            }) {
                Text("Search")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(searchText.isEmpty)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""), onSearch: {})
        .padding()
}
