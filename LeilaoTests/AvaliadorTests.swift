//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Vinícius Tinajero Salomão on 07/07/21.
//

import XCTest
@testable import Leilao

class AvaliadorTests: XCTestCase {

    var leiloeiro = Avaliador()
    private var joao:Usuario!
    private var maria:Usuario!
    private var jose:Usuario!
    
    override func setUpWithError() throws {
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
        leiloeiro = Avaliador()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDeveEntenderLancesEmOrderCrescente() {
        // Cenario

        let leilao = Leilao(descricao: "PS5")
        leilao.propoe(lance: Lance(maria, 250.0))
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(jose, 400.0))

        // Acao
        try? leiloeiro.avalia(leilao: leilao)

        // Validacao
        
        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }

    func testDeveEntenderLeilaoComApenasUmLance() {
        let leilao = Leilao(descricao: "PS5")
        leilao.propoe(lance: Lance(joao, 1000.0))
        
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }
    
    func testDeveEncontrarOsTresMaioresLances() {
//        let leilao = Leilao(descricao: "PS5")
//        leilao.propoe(lance: Lance(joao, 300.0))
//        leilao.propoe(lance: Lance(maria, 400.0))
//        leilao.propoe(lance: Lance(joao, 500.0))
//        leilao.propoe(lance: Lance(maria, 600.0))

        let leilao = CriadorDeLeilao().para(descricao: "PS5")
                                      .lance(joao, 300.0)
                                      .lance(maria, 400.0)
                                      .lance(joao, 500.0 )
                                      .lance(maria, 600.0)
                                      .constroi()
        
        try? leiloeiro.avalia(leilao: leilao)
        
        let listaLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaLances.count)
        XCTAssertEqual(600.0, listaLances[0].valor)
        XCTAssertEqual(500.0, listaLances[1].valor)
        XCTAssertEqual(400.0, listaLances[2].valor)

    }
    
    func testDeveIgnorarLeilaoSemNenhumLance() {
        let leilao = CriadorDeLeilao().para(descricao: "PS5").constroi()
        
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Nao é possível avaliar um leilão sem lances") { (error) in
            print(error.localizedDescription)
        }
    }
}
