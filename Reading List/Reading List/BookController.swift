//
//  BookController.swift
//  Reading List
//
//  Created by Ahava on 4/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead }
    }
    
    var unreadBooks: [Book] {
        return books.filter { !$0.hasBeenRead }
    }
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        
        return booksURL
    }
    
    func createBook(title: String, reasonToRead: String) {
        var book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        if let bookIndex = books.firstIndex(of: book) {
            books.remove(at: bookIndex)
        }
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        if let bookIndex = books.firstIndex(of: book) {
            books[bookIndex].hasBeenRead = !books[bookIndex].hasBeenRead
        }
        saveToPersistentStore()
    }
    
    func editBook(book: Book, newTitle: String, newReasonToRead: String) {
        if let bookIndex = books.firstIndex(of: book) {
            books[bookIndex].reasonToRead = newReasonToRead
            books[bookIndex].title = newTitle
        }
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            
            let encoder = PropertyListEncoder()
            let booksPlist = try encoder.encode(books)
            guard let readingListURL = readingListURL else { return }
            try booksPlist.write(to: readingListURL)
            
        } catch {
            print("Couldn't save list: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let readingListURL = readingListURL else { return }
            
            let booksPlist = try Data(contentsOf: readingListURL)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksPlist)
            self.books = decodedBooks
        } catch {
            print("Couldn't load books: \(error)")
        }
    }
}
