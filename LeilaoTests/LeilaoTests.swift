//
//  LeilaoTests.swift
//  LeilaoTests
//
//  Created by Vinícius Tinajero Salomão on 07/07/21.
//

import XCTest
@testable import Leilao

class LeilaoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDeveReceberUmLance() {
        let leilao = Leilao(descricao: "Macbook Pro 15")
        XCTAssertEqual(0, leilao.lances?.count)
        
        let joao = Usuario(nome: "Joao")
        leilao.propoe(lance: Lance(joao, 2000.0))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
    }
    
    func testDeveReceberVariosLances() {
        let leilao = Leilao(descricao: "Macbook Pro 15")
        
        let joao = Usuario(nome: "Joao")
        leilao.propoe(lance: Lance(joao, 2000.0))
        
        let jonatan = Usuario(nome: "Jonatan")
        leilao.propoe(lance: Lance(jonatan, 1700.0))

        
        XCTAssertEqual(2, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
        XCTAssertEqual(1700.0, leilao.lances?[1].valor)

    }
    
    func testDeveIgnorarDoisLancesSeguidosDoMesmoUsuario() {
        let leilao = Leilao(descricao: "XBOX")
        
        let bob = Usuario(nome: "Bob")
        leilao.propoe(lance: Lance(bob, 2000.0))
        leilao.propoe(lance: Lance(bob, 2300.0))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000.0, leilao.lances?.first?.valor)
    }
    
    func testDeveIgnorarMaisDoQue5LancesDoMesmoUsuario() {
        let leilao = Leilao(descricao: "XBOX")
        
        let joao = Usuario(nome: "Joao")
        let jonatan = Usuario(nome: "Jonatan")
        
        leilao.propoe(lance: Lance(joao, 2000.0))
        leilao.propoe(lance: Lance(jonatan, 3000.0))
        
        leilao.propoe(lance: Lance(joao, 4000.0))
        leilao.propoe(lance: Lance(jonatan, 5000.0))
        
        leilao.propoe(lance: Lance(joao, 6000.0))
        leilao.propoe(lance: Lance(jonatan, 7000.0))
        
        leilao.propoe(lance: Lance(joao, 8000.0))
        leilao.propoe(lance: Lance(jonatan, 9000.0))
        
        leilao.propoe(lance: Lance(joao, 10000.0))
        leilao.propoe(lance: Lance(jonatan, 11000.0))
        
        // deve ignorar
        
        leilao.propoe(lance: Lance(joao, 12000.0))
        
        XCTAssertEqual(10, leilao.lances?.count)
        XCTAssertEqual(11000, leilao.lances?.last?.valor)
    }

}
