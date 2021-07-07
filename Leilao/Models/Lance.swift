//
//  Lance.swift
//  Leilao
//
//  Created by Vinícius Tinajero Salomão on 07/07/21.
//

import Foundation

class Lance {
    let usuario: Usuario
    let valor: Double
    
    init(_ usuario: Usuario, _ valor: Double) {
        self.usuario = usuario
        self.valor = valor
    }
}
