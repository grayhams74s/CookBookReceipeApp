import SwiftUI
import PhotosUI

struct AddReceipeView: View {
    
    @State var viewModel = AddReceipeViewModel()
    @State var doneViewModel = HomeViewModel()
    @StateObject var imageLoderViewModel = ImageLoaderViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                headerView
                imagePickerView
                formView
                addButton
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 40)
            .photosPicker(isPresented: $viewModel.showImageLibrary, selection: $imageLoderViewModel.imageSelection)
            .onChange(of: imageLoderViewModel.imageToUpload) { _, newValue in
                if let newValue = newValue {
                    viewModel.displayedReceipeImage = Image(uiImage: newValue)
                    viewModel.receipeImage = newValue
                }
            }
            .alert("Upload an image to your receipe", isPresented: $viewModel.showImageOptions) {
                Button("Upload from library") { viewModel.showImageLibrary = true }
                Button("Upload from Camera") { viewModel.showCamera = true }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Choose how you want to add a photo.")
            }
            .fullScreenCover(isPresented: $viewModel.showCamera) {
                CameraPicker { image in
                    viewModel.displayedReceipeImage = Image(uiImage: image)
                    viewModel.receipeImage = image
                }
            }
            if viewModel.isUploading {
                ProgressComponentView(value: $viewModel.uploadProgress, success: $viewModel.isSuccess)
            }
        
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button(action: {
                viewModel.showAlert = false
            }, label: {
                Text("OK")
            })
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("What's New")
                .font(.system(size: 26, weight: .bold))
                .padding(.top, 20)
        }
    }
    
    private var imagePickerView: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(.gray.opacity(0.1))
                    .frame(height: 200)
                Image(systemName: "photo.fill")
            }
            if let displayedReceipeImage = viewModel.displayedReceipeImage {
                displayedReceipeImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .onTapGesture {
            viewModel.showImageOptions = true
        }
    }
    
    private var formView: some View {
        VStack(alignment: .leading) {
            Text("Receipe Name")
                .font(.system(size: 15, weight: .bold))
                .padding(.top)
            TextField("Receipe Name", text: $viewModel.receipeName)
                .padding(.horizontal, 16)
                .frame(height: 45)
                .background(
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color.gray.opacity(0.1))
                )
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            Text("Preparation Time")
                .font(.system(size: 15, weight: .bold))
                .padding(.top)
            Picker("Preparation Time", selection: $viewModel.preparationTime) {
                ForEach(0...120, id: \.self) { time in
                    if time % 5 == 0 {
                        Text("\(time) mins")
                            .font(.system(size: 15))
                            .tag(time)
                    }
                }
            }
            .tint(.black)
            
            Text("Cooking Instructions")
                .font(.system(size: 15, weight: .semibold))
                .padding(.top)
            TextEditor(text: $viewModel.instructions)
                .frame(height: 150)
                .background(.gray.opacity(0.1))
                .scrollContentBackground(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private var addButton: some View {
        Button(action: {
            Task {
                let success = await viewModel.addReceipe()
                if success {
                    ToastManager.shared.showSuccess(title: "Success", message: "Operation completed sucessfully")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        dismiss()
                        viewModel.resetForm()
                    }
                } else {
                    ToastManager.shared.showError(title: "Error", message: "Something went wrong. Please try again later")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        viewModel.resetForm()
                    }
                }
            }
        }) {
            HStack {
                Text("Add Receipe")
                Image(systemName: "document.badge.plus.fill")
            }
        }
        .padding(.top)
        .buttonStyle(PrimaryButtonStyle())
        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0.0, y: 10)
    }
}

#Preview {
    AddReceipeView()
}

