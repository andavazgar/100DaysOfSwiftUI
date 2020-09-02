//
//  MeView.swift
//  HotProspects
//
//  Created by Andres Vazquez on 2020-09-01.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = ""
    @State private var email = ""
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textContentType(.name)
                .font(.title)
                .padding(.horizontal)
            
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .font(.title)
                .padding([.horizontal, .bottom])
            
            Image(uiImage: generateQRCode(from: "\(name)\n\(email)"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Spacer()
        }
        .navigationBarTitle("Your code")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage, let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
