# ![](https://user-images.githubusercontent.com/1838420/82833707-bec46580-9eb6-11ea-88d8-2dd033cc742d.png) POKE - FLUTTER ![](https://user-images.githubusercontent.com/1838420/82833707-bec46580-9eb6-11ea-88d8-2dd033cc742d.png)

Proyecto realizado por el grupo 4.

## Getting Started

- El dispositivo utilizado por Victoria fue: Medium Phone Api 35
  - Properties:
avd.ini.displayname              Medium Phone API 35
avd.ini.encoding                 UTF-8
AvdId                            Medium_Phone_API_35
disk.dataPartition.size          6442450944
fastboot.chosenSnapshotFile      
fastboot.forceChosenSnapshotBoot no
fastboot.forceColdBoot           no
fastboot.forceFastBoot           yes
hw.accelerometer                 yes
hw.arc                           false
hw.audioInput                    yes
hw.battery                       yes
hw.camera.back                   virtualscene
hw.camera.front                  emulated
hw.cpu.ncore                     8
hw.device.hash2                  MD5:3db3250dab5d0d93b29353040181c7e9
hw.device.manufacturer           Generic
hw.device.name                   medium_phone
hw.dPad                          no
hw.gps                           yes
hw.gpu.enabled                   yes
hw.gpu.mode                      auto
hw.initialOrientation            portrait
hw.keyboard                      yes
hw.lcd.density                   420
hw.lcd.height                    2400
hw.lcd.width                     1080
hw.mainKeys                      no
hw.ramSize                       2G
hw.sdCard                        yes
hw.sensors.orientation           yes
hw.sensors.proximity             yes
hw.trackBall                     no
image.androidVersion.api         35
image.sysdir.1                   system-images\android-35\google_apis_playstore\x86_64\
PlayStore.enabled                true
runtime.network.latency          none
runtime.network.speed            full
showDeviceFrame                  yes
skin.dynamic                     yes
tag.display                      Google Play
tag.displaynames                 Google Play
tag.id                           google_apis_playstore
tag.ids                          google_apis_playstore
vm.heapSize                      336

- El dispositivo utilizado por Emiliano fue: ..

> [!IMPORTANT]
> Utilizamos JDK 17 y fue seteado únicamente para este proyecto con 'flutter config --jdk-dir=DIRECTORY'


# DIVISIÓN DE ARCHIVOS
* Archvios utilizados por Victoria:
   - pokemon_preferences,
   - pokemon_mock,
   - pokemon_list,
   - create_pokemon_card,
   - create_poke_alert
     
* Archivos utilizdos por Emiliano:
  
* Globales:
   - home_screen,
   - screens,
   - main,
   - menu

# EXPLICACIÓN ARCHIVOS
### pokemon_preferences
![image](https://github.com/user-attachments/assets/250d2d4a-c158-442d-bceb-e3a09711c383)
<br>
Se utilizó SharedPreferences para poder guardar los valores de los Pokemon favoritos y sus apodos pasando sus IDs; sumado a esto, se agregó un método para poder acceder a todos los Pokemon faovirtos para poder mostrarlos en el home.
<br>
![image](https://github.com/user-attachments/assets/7643c12d-733c-483d-b65a-a438bace9b2c)
![image](https://github.com/user-attachments/assets/734c4605-1dec-4233-ac06-bb7e7263db15)


### pokemon_mock
![image](https://github.com/user-attachments/assets/8f32f252-498f-471a-8f81-b21ac5a0ebf8)
<br>
Una lista con los primeros 50 Pokemon de Poke-Api, estan en el formato que habiamos estableicod en nuestra API.
El orden es el siguiente:
  - Id
  - Nombre
  - Xp
  - Link de su sprite

### pokemon_list
![image](https://github.com/user-attachments/assets/23dc8667-232c-4e6c-aa0c-50808ae23775)
<br>
Es una screen en donde se muestra en un grid de 2 columnas todos los Pokemon del mock, generandolo con un 'List.generate' y  pasandole los parametros de cada uno a un widget con una card.
<br>
![image](https://github.com/user-attachments/assets/05a9bad4-7d25-4992-b50a-89916a7c78d4)

### create_pokemon_card
![image](https://github.com/user-attachments/assets/440ec660-5a53-4115-93b3-6798b571e3b8)
<br>
Es un Stateful Widget el cual cuando se llama con sus parametros correspondientes (id, name, sprite, xp) organiza esta información en una tarjeta, sumado a si anteriormente agregamos el Pokemon a favoritos o no.
Cuando se presiona sobre uno de los Pokemon, se realiza una pequeña animación y luego de mostrarlo llama a 'PokemonAlert' para mostrar la información específica.
<br>
![image](https://github.com/user-attachments/assets/92af8030-5cc7-48c4-a634-a3f70475f632)

### create_poke_alert
![image](https://github.com/user-attachments/assets/f3f1e7c5-3582-492b-bf49-f9ff7bbd18ec)
<br>
Es otro StatefulWidget por el motivo de que tiene los valores de favorito y apodo de cada pokemon, sumado al text controller; para poder chequear, mantener y guardar estos valores.
Se forma una card en base a create_pokemon_card con la diferencia de que se muestra la 'XP' y la posibilidad de agregar el Pokemon a favoritos con un Switch y darle un apodo a través de un TextFormField.
<br>
![image](https://github.com/user-attachments/assets/5feae488-c5a2-4e94-98da-1e1bd36f0a4b)









     
     

