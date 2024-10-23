//
//  ViewController.swift
//  iparknow
//
//  Created by Elisio Simao on 10/22/24.
//  Copyright © 2024 Martinho Macovere. All rights reserved.
//

import UIKit
extension UIColor{
    convenience init(hex: String, alpha: CGFloat = 1.0){
        var hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexColor = hexColor.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexColor).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16)/255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8)/255.0
        let blue = CGFloat((rgb & 0x0000FF))/255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
class ViewController: UIViewController {

    let logoImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "iparknow")
        return img
    }()
    
    let enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Comecar", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#00cc99")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        lView()
        
        if let diferenca = horaValor(horaInicio: "10:30", horaFim: "11:00"){
            print("Diferenca em horas: \(diferenca)")
        }else{
            print("Erro ao calcular diferenca")
        }
        
        enterButton.addTarget(self, action: #selector(comecar), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func lView(){
        let larguraTela = view.frame.size.width
        let alturaTela = view.frame.size.height
        
        view.addSubview(logoImg)
        view.addSubview(enterButton)

        
        
        logoImg.frame = CGRect(x: (larguraTela-250)/2, y: (alturaTela-300)/2, width: 250, height: 200)
        enterButton.frame = CGRect(x: (larguraTela-(larguraTela-100))/2, y: (alturaTela)/2, width: larguraTela-100, height: 40)

        
        
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
    @objc func comecar(){
        let login = LoginViewController()
        login.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(login, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

