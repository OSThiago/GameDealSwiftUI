//
//  EditImageView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 20/12/24.
//

import SwiftUI

struct EditImageView: View {

    var selectPhotoAction: ()-> Void
    var deletePhotoAction: ()-> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Edit Image")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding([.horizontal, .top], 20)

            List {
                Section {
                    listItem(title: "Choose photo",
                             icon: "photo.artframe",
                             action: {
                        
                    })

                    listItem(title: "Delete photo",
                             icon: "trash",
                             color: .red,
                             action: {
                        
                    })
                }
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .padding(.top, -20)
        }
        .background(.gray.opacity(0.07))
    }
}

extension EditImageView {
    func listItem(title: String, icon: String, color: Color? = nil, action: @escaping ()-> Void) -> some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: icon)
            }
            .foregroundStyle(color ?? .black)
        }
    }
}

fileprivate struct BackView: View {

    @State var showModal = true

    var body: some View {
        VStack {
            Button {
                showModal.toggle()
            } label: {
                Text("Show Modal")
            }
        }
        .sheet(isPresented: $showModal) {
            EditImageView(selectPhotoAction: {},
                          deletePhotoAction: {})
                .presentationDetents([.height(200)])
        }
    }
}

#Preview {
    BackView()
}
