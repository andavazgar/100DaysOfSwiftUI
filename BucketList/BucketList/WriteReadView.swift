//
//  WriteReadView.swift
//  BucketList
//
//  Created by Andres Vazquez on 2020-08-14.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct WriteReadView: View {
    var body: some View {
        Text("Hello, World!")
        .onTapGesture {
            let str = "Test Message"
            FileManager.default.writeToDocumentsDirectory(fileName: "message.txt", content: str)
            
            let input = FileManager.default.readFromDocumentsDirectory(fileName: "message.txt")
            print(input ?? "")
        }
    }
}

struct WriteReadView_Previews: PreviewProvider {
    static var previews: some View {
        WriteReadView()
    }
}
