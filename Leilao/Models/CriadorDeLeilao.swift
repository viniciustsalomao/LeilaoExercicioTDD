//
//  CriadorDeLeilao.swift
//  Leilao
//
//  Created by Vinícius Tinajero Salomão on 07/07/21.
//

import Foundation

class CriadorDeLeilao: NSObject {
    
    private var leilao: Leilao!
    
    func para(descricao: String) -> Self{
        leilao = Leilao(descricao: descricao)
    
        return self
    }
    
    func lance(_ usuario: Usuario, _ valor: Double) -> Self {
        leilao.propoe(lance: Lance(usuario, valor))
        
        return self
    }
    
    func constroi() -> Leilao {
        return leilao
    }
}
