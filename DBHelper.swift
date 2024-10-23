//
//  DBHelper.swift
//  MecanicApp
//
//  Created by Elisio Simao on 10/15/24.
//  Copyright © 2024 Cleyton&Samir. All rights reserved.
//

import Foundation

import SQLite3

class DBHelper {
    var db: OpaquePointer?

    // Inicializa o banco de dados e cria a tabela adminMecanic
    init() {
        db = openDatabase()
        createAdminTable()
    }
    
    // Função para abrir o banco de dados
    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("adminIpark.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Erro ao abrir o banco de dados")
            return nil
        } else {
            print("Banco de dados aberto com sucesso")
            return db
        }
    }
    
    // Função para criar a tabela admin com os campos email e password
    func createAdminTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS admin (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            password TEXT
        );
        """
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Tabela admin criada com sucesso")
            } else {
                print("Erro ao criar a tabela admin")
            }
        } else {
            print("Erro ao preparar a criação da tabela")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // Função para adicionar um registro na tabela admin
    func insertAdmin(email: String, password: String) {
        let insertQuery = "INSERT INTO admin (email, password) VALUES (?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (password as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Admin adicionado com sucesso")
            } else {
                print("Erro ao adicionar admin")
            }
        } else {
            print("Erro ao preparar a inserção")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // Função para percorrer os registros da tabela admin e retornar email e password
    func fetchAllAdmins() -> [(String, String)] {
        let query = "SELECT email, password FROM admin;"
        var fetchStatement: OpaquePointer? = nil
        var admins: [(String, String)] = []
        
        if sqlite3_prepare_v2(db, query, -1, &fetchStatement, nil) == SQLITE_OK {
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                let email = String(cString: sqlite3_column_text(fetchStatement, 0))
                let password = String(cString: sqlite3_column_text(fetchStatement, 1))
                
                admins.append((email, password))
            }
        } else {
            print("Erro ao buscar administradores")
        }
        sqlite3_finalize(fetchStatement)
        return admins
    }
}

