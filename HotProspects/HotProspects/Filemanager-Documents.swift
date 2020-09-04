//
//  Filemanager-Documents.swift
//  HotProspects
//
//  Created by Andres Vazquez on 2020-09-03.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

extension FileManager {
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func saveDocument(named name: String, data: Data, options: Data.WritingOptions) {
        let url = getDocumentsDirectory().appendingPathComponent(name)
        
        do {
            try data.write(to: url, options: options)
        } catch {
            fatalError("Error saving file: \(error.localizedDescription)")
        }
    }
    
    func loadDocument(named name: String) -> Data? {
        let url = getDocumentsDirectory().appendingPathComponent(name)
        
        if self.fileExists(atPath: url.path) {
            do {
                return try Data(contentsOf: url)
            } catch {
                fatalError("Error loading file: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
}
