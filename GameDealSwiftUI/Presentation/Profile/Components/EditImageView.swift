//
//  EditImageView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 20/12/24.
//

import SwiftUI
import PhotosUI

struct EditImageView: View {

    var deletePhotoAction: ()-> Void
    
    @Binding var pickerSelector: PhotosPickerItem?
    
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
                    PhotosPicker(selection: $pickerSelector) {
                        listItem(title: "Choose photo",
                                 icon: "photo.artframe",
                                 color: .primary)
                    }

                    Button {
                        deletePhotoAction()
                    } label: {
                        listItem(title: "Delete photo",
                                 icon: "trash",
                                 color: .red)
                    }
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
    func listItem(title: String, icon: String, color: Color? = nil) -> some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: icon)
        }
        .foregroundStyle(color ?? .black)
    }
}

fileprivate struct BackView: View {

    @State var showModal = true
    @State var picker: PhotosPickerItem? = nil

    var body: some View {
        VStack {
            Button {
                showModal.toggle()
            } label: {
                Text("Show Modal")
            }
        }
        .sheet(isPresented: $showModal) {
            EditImageView(deletePhotoAction: {},
                          pickerSelector: $picker)
                .presentationDetents([.height(200)])
        }
    }
}

#Preview {
    BackView()
}
