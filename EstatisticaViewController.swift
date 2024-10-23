//
//  ServicosViewController.swift
//  MecanicApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Cleyton&Samir. All rights reserved.
//

import UIKit

class EstatisticaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //let dbHelper = DBHelperServicos()
    let dbHelper = DBHelperStatistic()
    var slot: Int = 0
    let tableView = UITableView()
    var dados = [(id: Int, status: String)]() // Exemplo de tupla com os dados
    let lbn = UILabel()
    let servicosButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Slots", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#00cc99")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    let divLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = ""
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.backgroundColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        textLbn.textAlignment = .center
        return textLbn
    }()
    
    let sairButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sair", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#ffffff")
        button.tintColor = UIColor(hex: "#00cc99")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        lbn.text = "Estatisticas"
        lbn.textColor = UIColor(hex: "#00cc99")
        lbn.textAlignment = .center
        lbn.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        // Configuração da TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(lbn)
        // Exemplo de dados que você pode buscar do banco de dados
        let slots = dbHelper.fetchAllSlots()
        for slot in slots {
            print("Id: \(slot.0) Placa: \(slot.1), Marca: \(slot.2), Proprietário: \(slot.3), Slot: \(slot.4), Data: \(slot.5), Hora: \(slot.6), Valor: \(slot.7)")
            
            let id = slot.0
            let status = slot.3
            // print("Status: \(status)")
            if(status == "none"){
                dados.append((id: id, status: "Vazio"))
            }else{
                dados.append((id: id, status: status))
            }
        }
        
        
        lView()
        
        servicosButton.addTarget(self, action: #selector(estaTela), for: .touchUpInside)
        sairButton.addTarget(self, action: #selector(sairT), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dados.count
    }
    
    // Função que configura cada célula da tabela
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dado = dados[indexPath.row]
        cell.textLabel?.text = "Slot (\(dado.id)) - \(dado.status)"
        // print(dado)
        return cell
    }
    
    // Função que trata o clique em uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalheVC = DetalhesCarViewController()
        detalheVC.idUser = dados[indexPath.row].id // Passar os dados para o próximo ViewController
        navigationController?.pushViewController(detalheVC, animated: true) // Navegar para a nova tela
    }
    
    // Configura as constraints da TableView
    func lView() {
        
        view.addSubview(divLbn)
        view.addSubview(servicosButton)
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        lbn.frame = CGRect(x: (largura - (largura-100))/2, y: 150, width: largura-100, height: 40)
        tableView.frame = CGRect(x: 20, y: 230, width: largura-20, height: altura-150)
        divLbn.frame = CGRect(x: 0, y: 210, width: largura, height: 0.5)
        
        servicosButton.frame = CGRect(x: (largura - (largura-50))/2, y: altura-100, width: largura-50, height: 40)
        view.addSubview(sairButton)
        sairButton.frame = CGRect(x: (largura - (largura-50))/2, y: altura-140, width: largura-50, height: 40)
    }
    
    @objc func estaTela(){
        let tela = HomeViewController()
        tela.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(tela, animated: true)
    }
    
    @objc func sairT(){
        let tela = ViewController()
        tela.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(tela, animated: true)
    }
    
    
    
    @objc func telaAddServicos(){
        //        let t = AddViewController()
        //        t.modalPresentationStyle = .fullScreen
        //        self.navigationController?.pushViewController(t, animated: true)
        //        print("Servicos")
        
        dbHelper.insertSlot(placa: "none", marca: "none", nomeProprietario: "none", numeroSlot: slot, data: "none", hora: "none", valor: 0)
        print(slot)
        slot+=1
        
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
