# anadolupardus
# 🔥 thermal_guard - VM Tabanlı Termal Koruma Modülü

**thermal_guard**, Qubes OS altında çalışan VM’leri sistem sıcaklığına göre otomatik olarak koruyan bir modüldür. Kritik sıcaklık durumlarında snapshot alır, uyarı verir ve gerekirse VM’leri kapatır.

---

## 📦 Özellikler

- Sistem sıcaklığını belirli aralıklarla kontrol eder  
- Belirlenen eşik aşıldığında:
  - Uyarı gönderir (`notify-send`)
  - VM snapshot alır (`qvm-snapshot`)
  - Gerekirse VM kapatır (`qvm-shutdown`)  
- YAML tabanlı yapılandırma ile esnek kontrol  
- RAID snapshot ve veri güvenliği stratejileriyle entegre edilebilir

---

## ⚙️ Kurulum

1. `modules/thermal_guard.yaml` dosyasını yapılandır  
2. `scripts/thermal_guard.sh` betiğini çalıştırılabilir yap:
   ```bash
   chmod +x scripts/thermal_guard.sh
