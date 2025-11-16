# 📥 Nersis Roleplay Toplu Meslek Reposunu Kurulum Rehberi

Bu rehber, GitHub hesabınız üzerinden **özel** olan bu repoyu nasıl kullanacağınızı adım adım anlatır.
---
1, 2, 3, 4. adımlar ilk seferde kurulum için yapılacak olup, kurulum sonrası yaptığınız değişiklikler sırasında sadece 5. adımı uygulamak yeterlidir..


## 🛠️ 1. Gerekli Kurulum: Git

1. Aşağıdaki linke tıklayarak **Git** uygulamasını indirin:  
   👉 [https://git-scm.com/downloads](https://git-scm.com/downloads)

2. İndirilen `.exe` dosyasını çalıştırın ve tüm adımları **"Next"** diyerek geçin (varsayılan ayarlarla kurulması önerilir).

3. Kurulum tamamlandıktan sonra bilgisayarınızda **Git Bash** veya **Komut İstemi (CMD)** açabilirsiniz.

---

## 📁 2. Çalışma Klasörü Belirleme

1. Bilgisayarınızda repoyu nereye indireceğinizi (örneğin `C:\Projeler`) seçin veya yeni bir klasör oluşturun.

2. Bu klasörde boş bir alana **Shift + Sağ Tık** yapın ve  
   "PowerShell penceresini burada aç" veya "Komut Penceresini burada aç" seçeneğini seçin.


---


## 📦 3. Repoyu Bilgisayarınıza Klonlayın

Aşağıdaki komutu açtığınız komut ekranına sırasıyla yapıştırın ve `Enter`'a basın:

```bash
git clone https://github.com/nersisrp/job-system

```

```bash
git config --global user.email "isim@isim.com"
```


```bash
git config --global user.name "isim"

```

Proje bilgisayarınıza indirildi. Artık içerisinde rahatlıkla değişiklik yapabilirsiniz.

## 📦 4. Yaptığınız değişiklikleri yollayın.

Proje dosyanızda bir değişiklik yaptıktan sonra gonder.bat dosyasına çift tıklayın.

Gelen ekranda açıklama yazıp entera basarsanız veriler github reposuna gönderilecektir.

Sunucu repodaki veriler değiştiğinde otomatik alır ve discord yönetim kanalına bilgilendirir.

## 📦 5. Başkasının değişiklerini alma (GEREKİRSE)


Eğer sorumlu olduğunuz projede başkası değişiklik yaptıysa bu değişikleri bilgisayarınıza çekmeniz gerekir.

Bunun için cek.bat dosyasına çift tıklayın.
