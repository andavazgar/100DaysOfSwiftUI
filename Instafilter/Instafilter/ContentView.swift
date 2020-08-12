//
//  ContentView.swift
//  Instafilter
//
//  Created by Andres Vazquez on 2020-08-07.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        let intensityBinding = Binding(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensityBinding)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage  else { return }
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        imageSaver.errorHandler = { error in
                            print("Oops: \(error.localizedDescription)")
                        }
                            
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize"), action: { self.setFilter(CIFilter.crystallize()) }),
                    .default(Text("Edges"), action: { self.setFilter(CIFilter.edges()) }),
                    .default(Text("Gaussian Blur"), action: { self.setFilter(CIFilter.gaussianBlur()) }),
                    .default(Text("Pixellate"), action: { self.setFilter(CIFilter.pixellate()) }),
                    .default(Text("Sepia Tone"), action: { self.setFilter(CIFilter.sepiaTone()) }),
                    .default(Text("Unsharp Mask"), action: { self.setFilter(CIFilter.unsharpMask()) }),
                    .default(Text("Vignette"), action: { self.setFilter(CIFilter.vignette()) }),
                    .cancel()
                ])
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage,
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
        processedImage = uiImage
    }
    
    func setFilter(_ filter: CIFilter) {
        self.currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
