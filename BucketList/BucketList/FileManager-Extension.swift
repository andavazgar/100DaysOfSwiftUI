//
//  FileManager-Extension.swift
//  BucketList
//
//  Created by Andres Vazquez on 2020-08-14.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

extension FileManager {
    func writeToDocumentsDirectory(fileName: String, content: String) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readFromDocumentsDirectory(fileName: String) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            return try String(contentsOf: fileURL)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
