//
//  SlotViewController.swift
//  iparknow
//
//  Created by Elisio Simao on 10/22/24.
//  Copyright © 2024 Martinho Macovere. All rights reserved.
//

import UIKit

class SlotViewController: UIViewController {
    var slot: Int = 999
    let dbHelper = DatabaseManager()

    let lbn = UILabel()
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
        button.setTitle("Adicionar", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#00cc99")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    let nomeField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome do proprietario"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let placaField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Placa"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let marcaField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Marca"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        lbn.text = "Registrar"
        lbn.textColor = UIColor(hex: "#00cc99")
        lbn.textAlignment = .center
        lbn.font = UIFont.systemFont(ofSize: 25, weight: .bold)

        view.addSubview(lbn)

        print(slot)
        // Do any additional setup after loading the view.
        definirDataEHora()
        layout()
        
        servicosButton.addTarget(self, action: #selector(salvarDados), for: .touchUpInside)
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

        lbn.frame = CGRect(x: (largura - (largura-100))/2, y: 150, width: largura-100, height: 40)

        slotLabel.text = "\(slot)"
        dataLabel.frame = CGRect(x: 80, y: altura-150, width: 100, height: 20)
        horaLabel.frame = CGRect(x: 80, y: altura-170, width: 100, height: 20)
        slotLabel.frame = CGRect(x: 80, y: altura-190, width: 100, height: 20)

        dataRLabel.frame = CGRect(x: 40, y: altura-150, width: 100, height: 20)
        horaRLabel.frame = CGRect(x: 40, y: altura-170, width: 100, height: 20)
        slotRLabel.frame = CGRect(x: 40, y: altura-190, width: 100, height: 20)
        
        nomeField.frame = CGRect(x: (largura - (largura-80))/2, y: 230, width: largura-80, height: 50)
        placaField.frame = CGRect(x: (largura - (largura-80))/2, y: 290, width: largura-80, height: 50)
        marcaField.frame = CGRect(x: (largura - (largura-80))/2, y: 350, width: largura-80, height: 50)
        
        servicosButton.frame = CGRect(x: (largura - (largura-80))/2, y: altura-100, width: largura-80, height: 40)

        
        

    }
    
    func definirDataEHora() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dataAtual = Date()
        let dataString = dateFormatter.string(from: dataAtual)
        
        // Definir a data
        dataLabel.text = dataString
        
        // Definir a hora
        dateFormatter.dateFormat = "HH:mm"
        let horaString = dateFormatter.string(from: dataAtual)
        horaLabel.text = horaString
    }
    
    @objc func salvarDados() {
        let placa = placaField.text ?? ""
        let marca = marcaField.text ?? ""
        let nomePropri = nomeField.text ?? ""
        let numeroSlot = slot
        let data = dataLabel.text ?? ""
        let hora = horaLabel.text ?? ""
        
        
       // dbHelper.updateSlot(id: 1, placa: "BBB5678", marca: "Honda", nomeProprietario: "Maria", numeroSlot: 2, data: "2024-10-06", hora: "11:00", valor: 60.0)
        
        dbHelper.updateSlot(id: slot, placa: placa, marca: marca, nomeProprietario: nomePropri, numeroSlot: (slot-1), data: data, hora: hora, valor: 0)

        
        print("Dados salvos: Placa: \(placa), Marca: \(marca), Nome: \(nomePropri), Slot: \(numeroSlot), Data: \(data), Hora: \(hora)")
        let tela = HomeViewController()
        tela.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(tela, animated: true)
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
