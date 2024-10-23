//
//  DatabaseManager.swift
//  iparknow
//
//  Created by Elisio Simao on 10/22/24.
//  Copyright © 2024 Martinho Macovere. All rights reserved.
//

import Foundation
import SQLite3
import UIKit

class DatabaseManager {
    var db: OpaquePointer?
    
    // Inicializa o banco de dados e cria a tabela slots
    init() {
        db = openDatabase()
        createSlotsTable()
    }
    
    // Função para abrir o banco de dados
    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("slotsIpark.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Erro ao abrir o banco de dados")
            return nil
        } else {
            print("Banco de dados aberto com sucesso")
            return db
        }
    }
    
    // Função para criar a tabela slots
    func createSlotsTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS slots (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            placa TEXT,
            marca TEXT,
            nomeProprietario TEXT,
            data TEXT,
            hora TEXT,
            numeroSlot INTEGER,
            valor REAL
        );
        """
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Tabela slots criada com sucesso")
            } else {
                print("Erro ao criar a tabela slots")
            }
        } else {
            print("Erro ao preparar a criação da tabela")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // Função para adicionar um slot na tabela
    func insertSlot(placa: String, marca: String, nomeProprietario: String, numeroSlot: Int, data: String, hora: String, valor: Double) {
        let insertQuery = "INSERT INTO slots (placa, marca, nomeProprietario, numeroSlot, data, hora, valor) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (placa as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (marca as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (nomeProprietario as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 4, Int32(numeroSlot))
            sqlite3_bind_text(insertStatement, 5, (data as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (hora as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 7, valor)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Slot adicionado com sucesso")
            } else {
                print("Erro ao adicionar o slot")
            }
        } else {
            print("Erro ao preparar a inserção")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // Função para listar todos os slots
    func fetchAllSlots() -> [(id: Int, String, String, String, Int, String, String, Double)] {
        let query = "SELECT id, placa, marca, nomeProprietario, numeroSlot, data, hora, valor FROM slots;"
        var fetchStatement: OpaquePointer? = nil
        var slots: [(Int, String, String, String, Int, String, String, Double)] = []
        
        if sqlite3_prepare_v2(db, query, -1, &fetchStatement, nil) == SQLITE_OK {
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let placa = String(cString: sqlite3_column_text(fetchStatement, 1))
                let marca = String(cString: sqlite3_column_text(fetchStatement, 2))
                let nomeProprietario = String(cString: sqlite3_column_text(fetchStatement, 3))
                let numeroSlot = Int(sqlite3_column_int(fetchStatement, 4))
                let data = String(cString: sqlite3_column_text(fetchStatement, 5))
                let hora = String(cString: sqlite3_column_text(fetchStatement, 6))
                let valor = sqlite3_column_double(fetchStatement, 7)
                
                slots.append((id, placa, marca, nomeProprietario, numeroSlot, data, hora, valor))
            }
        } else {
            print("Erro ao buscar os slots")
        }
        sqlite3_finalize(fetchStatement)
        return slots
    }
    
    // Função para atualizar um slot
    func updateSlot(id: Int, placa: String, marca: String, nomeProprietario: String, numeroSlot: Int, data: String, hora: String, valor: Double) {
        let updateQuery = "UPDATE slots SET placa = ?, marca = ?, nomeProprietario = ?, numeroSlot = ?, data = ?, hora = ?, valor = ? WHERE id = ?"
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateQuery, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (placa as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (marca as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (nomeProprietario as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 4, Int32(numeroSlot))
            sqlite3_bind_text(updateStatement, 5, (data as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 6, (hora as NSString).utf8String, -1, nil)
            sqlite3_bind_double(updateStatement, 7, valor)
            sqlite3_bind_int(updateStatement, 8, Int32(id))
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Slot atualizado com sucesso")
            } else {
                print("Erro ao atualizar o slot")
            }
        } else {
            print("Erro ao preparar a atualização")
        }
        sqlite3_finalize(updateStatement)
    }
    
}
