## SwiftMapKit Uygulama Kullanımı
![Ekran-Kaydı-2024-11-01-22 45 23_1](https://github.com/user-attachments/assets/6d23fc3f-9357-4430-8c48-e2aedba2b826)
 <details>
    <summary><h2>Uygulma Amacı</h2></summary>
    Proje Amacı
   Bu uygulama, kullanıcıların bir harita üzerinde belirli şehirleri görüntülemelerini ve şehirler hakkında bilgi edinmelerini sağlar. Kullanıcılar harita üzerinde uzun basarak kendi belirledikleri konumları ekleyebilir ve haritanın görünümünü standart veya uydu modları arasında değiştirebilir. Şehir bilgisi kutusundaki buton sayesinde kullanıcılar, şehir hakkında daha fazla bilgi almak için Wikipedia sayfasına yönlendirilir
  </details>  

  <details>
    <summary><h2>chooseLocation(gestureRecognizer:)</h2></summary>
    chooseLocation: Kullanıcı haritaya uzun bastığında çağrılır.
     Koordinat Dönüşümü: Dokunulan noktanın koordinatları alınır.
    UIAlertController: Kullanıcıdan yeni konum eklemek için başlık ve bilgi alır.
    Yeni Konum Ekleme: Kullanıcı "Ekle" seçeneğini seçerse, yeni bir Capital nesnesi oluşturulur ve haritaya eklenir.
    
    ```
    @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer) {
    if gestureRecognizer.state == .began {
        let touchPoint = gestureRecognizer.location(in: self.mapView)
        let coordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        
        let alert = UIAlertController(title: "Yeni Konum Ekle", message: "Başlık ve bilgi girin", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Başlık"
        }
        alert.addTextField { textField in
            textField.placeholder = "Bilgi"
        }
        
        let addAction = UIAlertAction(title: "Ekle", style: .default) { _ in
            guard let title = alert.textFields?[0].text, !title.isEmpty,
                  let info = alert.textFields?[1].text, !info.isEmpty else {
                return
            }
            
            let new = Capital(title: title, coordinate: coordinates, info: info , wikipediaURL: URL(string: "https://en.wikipedia.org/wiki/"))
            self.mapView.addAnnotation(new)
        }
        alert.addAction(addAction)
        
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    }


    ```
  </details> 

  <details>
    <summary><h2>letterTapped(_:)</h2></summary>
    Tıklanan butonun başlığını alır ve currentAnswer metin alanına ekler.Butonu activitedButton dizisine ekler ve görünürlüğünü gizler.

    
    ```
    @objc func letterTapped(_ sender: UIButton){
    guard let buttonTitle = sender.titleLabel?.text else { return }
    
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activitedButton.append(sender)
    sender.isHidden = true
    }

    ```
  </details> 

  <details>
    <summary><h2>changeMap()</h2></summary>
    changeMap: Haritanın görünümünü değiştirmek için bir uyarı penceresi açar. Kullanıcı "Standart" veya "Uydu" seçeneklerinden birini seçebilir ve haritanın görünümünü buna göre günceller.
    
    ```
     @objc func changeMap() {
    let alert = UIAlertController(title: "Gorunum", message: "Uydu Gorunumunu seciniz", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Standart", style: .default, handler: { action in
        self.mapView.mapType = .standard
    }))
    alert.addAction(UIAlertAction(title: "Uydu", style: .default, handler: { action in
        self.mapView.mapType = .satellite
    }))
    present(alert, animated: true)
    }

    
    ```
  </details> 


  <details>
    <summary><h2>Capital Sınıfı</h2></summary>
    title: Şehrin adını tutar. String? tipi, bu değişkenin opsiyonel olduğunu gösterir; yani, bu değişken boş olabilir.
    coordinate: Şehrin koordinatlarını tutar. CLLocationCoordinate2D yapısı, enlem ve boylam bilgilerini içerir.
    info: Şehir hakkında bilgi tutar. Bu bilgi, harita üzerinde gösterilecek açıklama veya detaylar için kullanılır.
    wikipediaURL: Şehirle ilgili Wikipedia sayfasının URL'sini tutar. Bu da opsiyonel bir değişkendir.
    subtitle: Bu bir computed property'dir. info değişkeninin değerini döndürerek, harita üzerindeki işaretçilerin alt başlık (subtitle) özelliğini sağlar.
    
    ```
    import UIKit
    import MapKit

    class Capital: NSObject , MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var wikipediaURL: URL?
    var subtitle: String? { return info }
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String ,wikipediaURL: URL?) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.wikipediaURL = wikipediaURL
    }
    
    }

    ```
  </details> 

  <details>
    <summary><h2>WebViewController Sınıfı</h2></summary>
    WebViewController sınıfı, belirtilen URL'ye ait bir web sayfasını görüntülemek için tasarlanmıştır. Uygulama, kullanıcının web içeriğini görüntülemesine olanak tanır. WKWebView, hızlı ve performanslı web sayfası yüklemeleri sağlayarak, modern iOS uygulamalarında yaygın olarak kullanılır. Bu sınıf, kullanıcıların belirli içeriklere erişimini kolaylaştırır ve etkileşimli bir deneyim sunar
    
    ```
    import UIKit
    import WebKit

    class WebViewController: UIViewController {
    
    var url: URL?
    @IBOutlet var webView: WKWebView!
    
    override func loadView() {
           webView = WKWebView()
           view = webView
       }
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = url {
                    webView.load(URLRequest(url: url))
                }
    }
    

    

    }

    ```
  </details> 


<details>
    <summary><h2>Uygulama Görselleri </h2></summary>
    
    
 <table style="width: 100%;">
    <tr>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">ANA Ekran</h4>
            <img src="https://github.com/user-attachments/assets/7b84828e-e9cf-4687-8734-24fd605f252e" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Oyunun Kategorisİ Seçilme Ekranı</h4>
            <img src="https://github.com/user-attachments/assets/fa3df7c9-19ef-447c-88e9-b0ed0c439648" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Seçilen Kategori Oyun Ekranı</h4>
            <img src="https://github.com/user-attachments/assets/78b2023b-4004-489a-b80c-4cd55370758f" style="width: 100%; height: auto;">
        </td>
      <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">ANA Ekran</h4>
            <img src="https://github.com/user-attachments/assets/e78c0fa4-8fd1-478a-ab9b-f39cf80c1e9d" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Oyunun Kategorisİ Seçilme Ekranı</h4>
            <img src="https://github.com/user-attachments/assets/255f6a8a-74f8-4309-9ae3-4823f3fcadc7" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Seçilen Kategori Oyun Ekranı</h4>
            <img src="https://github.com/user-attachments/assets/5680d341-cc3a-4d6b-bc57-67bbd8326b09" style="width: 100%; height: auto;">
        </td>
      <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">ANA Ekran</h4>
            <img src="https://github.com/user-attachments/assets/c6769ecf-50bf-4347-8d87-d9073ff57041" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Oyunun Kategorisİ Seçilme Ekranı</h4>
            <img src="https://github.com/user-attachments/assets/38f11f30-58dd-4f9e-87f2-2d6a4462b011" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Seçilen Kategori Oyun Ekranı</h4>
            <img src="https://github.com/user-attachments/assets/c0030ac4-7ece-4fd5-8214-537b64b02e88" style="width: 100%; height: auto;">
        </td>
    </tr>
</table>
  </details> 
