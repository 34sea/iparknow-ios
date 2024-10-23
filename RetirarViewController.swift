//
//  RetirarViewController.swift
//  iparknow
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import UIKit

class RetirarViewController: UIViewController {
    var idUser: Int = 999
    let dbHelper = DatabaseManager()
    let dbHelper2 = DBHelperStatistic()
    var valorT: Double = 0
    let lbn = UILabel()
    
    var horaNova: String = ""
    var dataNova: String = ""

    let valorLabel: UILabel = {
        let txt = UILabel()
        txt.text = "Valor: "
        txt.textColor = UIColor(hex: "#999999")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let valorRLabel: UILabel = {
        let txt = UILabel()
        txt.text = "0"
        txt.textColor = UIColor(hex: "#00cc99")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    
    let dataLabel: UILabel = {
        let txt = UILabel()
        txt.text = "data!"
        txt.textColor = UIColor(hex: "#00cc99")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let horaLabel: UILabel = {
        let txt = UILabel()
        txt.text = "hora!"
        txt.textColor = UIColor(hex: "#00cc99")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let slotLabel: UILabel = {
        let txt = UILabel()
        txt.text = "0!"
        txt.textColor = UIColor(hex: "#00cc99")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let dataRLabel: UILabel = {
        let txt = UILabel()
        txt.text = "Data: "
        txt.textColor = UIColor(hex: "#999999")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let horaRLabel: UILabel = {
        let txt = UILabel()
        txt.text = "Hora: "
        txt.textColor = UIColor(hex: "#999999")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let slotRLabel: UILabel = {
        let txt = UILabel()
        txt.text = "Slot: "
        txt.textColor = UIColor(hex: "#999999")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    
    
    let servicosButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retirar", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#00cc99")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    let nomeField: UILabel = {
        let txt = UILabel()
        txt.text = "Nome: "
        txt.textColor = UIColor(hex: "#999999")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let placaField: UILabel = {
        let txt = UILabel()
        txt.text = "Placa: "
        txt.textColor = UIColor(hex: "#999999")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let marcaField: UILabel = {
        let txt = UILabel()
        txt.text = "Marca: "
        txt.textColor = UIColor(hex: "#999999")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let nomeRField: UILabel = {
        let txt = UILabel()
        txt.text = "Nome: "
        txt.textColor = UIColor(hex: "#00cc99")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let placaRField: UILabel = {
        let txt = UILabel()
        txt.text = "Placa: "
        txt.textColor = UIColor(hex: "#00cc99")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    let marcaRField: UILabel = {
        let txt = UILabel()
        txt.text = "Marca: "
        txt.textColor = UIColor(hex: "#00cc99")
        txt.numberOfLines = 0
        txt.lineBreakMode = .byWordWrapping
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        return txt
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        definirDataEHora()
        dados()
        lbn.text = "Detalhes"
        lbn.textColor = UIColor(hex: "#00cc99")
        lbn.textAlignment = .center
        lbn.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        view.addSubview(lbn)
        
        layout()
        
        servicosButton.addTarget(self, action: #selector(retirarDados), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    func dados(){
        let slots = dbHelper.fetchAllSlots()
        for slot in slots {
            if(slot.0 == idUser){
                print(slot)
                dataLabel.text = slot.5
                horaLabel.text = slot.6
                
                nomeRField.text = slot.3
                marcaRField.text = slot.2
                placaRField.text = slot.1

            }
        }
    }

    func layout(){
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        
        view.addSubview(dataLabel)
        view.addSubview(horaLabel)
        view.addSubview(dataRLabel)
        view.addSubview(horaRLabel)
        view.addSubview(servicosButton)
        view.addSubview(slotLabel)
        view.addSubview(slotRLabel)
        
        view.addSubview(nomeField)
        view.addSubview(placaField)
        view.addSubview(marcaField)
        
        view.addSubview(nomeRField)
        view.addSubview(placaRField)
        view.addSubview(marcaRField)
        
        valorRLabel.text = "\(horaConvertido())"
        valorT = horaConvertido()
        view.addSubview(valorLabel)
        view.addSubview(valorRLabel)
        
        lbn.frame = CGRect(x: (largura - (largura-100))/2, y: 150, width: largura-100, height: 40)
        
        slotLabel.text = "\(idUser)"
        dataLabel.frame = CGRect(x: 80, y: 320, width: 100, height: 20)
        horaLabel.frame = CGRect(x: 80, y: 350, width: 100, height: 20)
        slotLabel.frame = CGRect(x: 80, y: 380, width: 100, height: 20)
        valorRLabel.frame = CGRect(x: 85, y: 410, width: 100, height: 20)

        dataRLabel.frame = CGRect(x: 40, y: 320, width: 100, height: 20)
        horaRLabel.frame = CGRect(x: 40, y: 350, width: 100, height: 20)
        slotRLabel.frame = CGRect(x: 40, y: 380, width: 100, height: 20)
        valorLabel.frame = CGRect(x: 40, y: 410, width: 100, height: 20)

        nomeField.frame = CGRect(x: 40, y: 230, width: 100, height: 20)
        placaField.frame = CGRect(x: 40, y: 260, width: 100, height: 20)
        marcaField.frame = CGRect(x: 40, y: 290, width: 100, height: 20)
        
        nomeRField.frame = CGRect(x: 88, y: 230, width: 100, height: 20)
        placaRField.frame = CGRect(x: 88, y: 260, width: 100, height: 20)
        marcaRField.frame = CGRect(x: 88, y: 290, width: 100, height: 20)
        
        servicosButton.frame = CGRect(x: (largura - (largura-80))/2, y: altura-100, width: largura-80, height: 40)
        
        
        
        
    }
    
    @objc func retirarDados() {
        let placa = placaRField.text ?? ""
        let marca = marcaRField.text ?? ""
        let nomePropri = nomeRField.text ?? ""
        let numeroSlot = idUser
        let data = dataNova
        let hora = horaNova
        let valorL = valorT
        
        // dbHelper.updateSlot(id: 1, placa: "BBB5678", marca: "Honda", nomeProprietario: "Maria", numeroSlot: 2, data: "2024-10-06", hora: "11:00", valor: 60.0)
        
       // dbHelper.updateSlot(id: slot, placa: placa, marca: marca, nomeProprietario: nomePropri, numeroSlot: (slot-1), data: data, hora: hora, valor: 0)
        dbHelper.updateSlot(id: idUser, placa: "none", marca: "none", nomeProprietario: "none", numeroSlot: (idUser-1), data: "none", hora: "none", valor: 0)
        dbHelper2.insertSlot(placa: placa, marca: marca, nomeProprietario: nomePropri, numeroSlot: (idUser-1), data: data, hora: hora, valor: valorL)

        
        print("Retirados: Placa: \(placa), Marca: \(marca), Nome: \(nomePropri), Slot: \(numeroSlot), Data: \(data), Hora: \(hora)")
        let tela = EstatisticaViewController()
        tela.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(tela, animated: true)
    }
    
    func horaValor(horaInicio: String, horaFim: String) -> Double?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let inicio = dateFormatter.date(from: horaInicio),
            let fim = dateFormatter.date(from: horaFim) else {
                print ("Erro ao converter as horas")
                return nil
        }
        
        let diferencaS = fim.timeIntervalSince(inicio)
        
        let dHoras = diferencaS / 3600.0
        
        return dHoras
    }
    
    func horaConvertido() -> Double{
        if let diferenca = horaValor(horaInicio: horaLabel.text!, horaFim: horaNova){
            //print("Diferenca em horas: \(diferenca)")
            return diferenca*200
        }
        return 0
    }
    
    func definirDataEHora() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dataAtual = Date()
        let dataString = dateFormatter.string(from: dataAtual)
        
        // Definir a data
        dataNova = dataString
        
        // Definir a hora
        dateFormatter.dateFormat = "HH:mm"
        let horaString = dateFormatter.string(from: dataAtual)
        horaNova = horaString
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
