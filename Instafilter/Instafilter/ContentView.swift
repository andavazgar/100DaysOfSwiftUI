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
    @State private var filterRadius = 50.0
    @State private var filterScale = 5.0
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var showingAlert = false
    @State private var alert = Alert(title: Text(""))
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    let filters: [String: CIFilter] = [
        "Edges": CIFilter.edges(),
        "Gaussian Blur": CIFilter.gaussianBlur(),
        "Pixellate": CIFilter.pixellate(),
        "Sepia Tone": CIFilter.sepiaTone(),
        "Unsharp Mask": CIFilter.unsharpMask(),
        "Vignette": CIFilter.vignette(),
    ]
    var currentFilterName: String {
        let currentFilterName = filters.first { type(of:$1) == type(of: currentFilter) }!.key
        
        return currentFilterName
    }
    
    var body: some View {
        let intensityBinding = Binding(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            })
        
        let radiusBinding = Binding(
            get: {
                self.filterRadius
        }, set: {
            self.filterRadius = $0
            self.applyProcessing()
        })
        
        let scaleBinding = Binding(
            get: {
                self.filterScale
            },
            set: {
                self.filterScale = $0
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
                
                if inputImage != nil {
                    VStack {
                        if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                            HStack {
                                Text("Intensity")
                                Slider(value: intensityBinding)
                            }
                        }
                        
                        if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                            HStack {
                                Text("Radius")
                                Slider(value: radiusBinding, in: 0...100)
                            }
                        }
                        
                        if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                            HStack {
                                Text("Scale")
                                Slider(value: scaleBinding, in: 0...10)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                
                HStack {
                    Button(inputImage == nil ? "Select a Filter" : "Filter: \(currentFilterName)") {
                        self.showingFilterSheet = true
                    }
                    .disabled(inputImage == nil)
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage  else {
                            self.alert = Alert(title: Text("Error"), message: Text("Please select an image first."), dismissButton: .default(Text("OK")))
                            self.showingAlert = true
                            return
                        }
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
                ActionSheet(title: Text("Select a filter"), buttons: self.filters.sorted { $0.key < $1.key }
                    .map { key, value in
                        .default(Text(key), action: { self.setFilter(value) })
                    }
                    + [.cancel()]
                )
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
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
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
