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

- El dispositivo utilizado por Emiliano fue: Medium Phone Api 35
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
vm.heapSize                      336 -Google Emulator
-Celular Motorola G-52




> [!IMPORTANT]
> Utilizamos JDK 17 y fue seteado únicamente para este proyecto con 'flutter config --jdk-dir=DIRECTORY'


# DIVISIÓN DE ARCHIVOS
* Archivos utilizados por Victoria:
   - pokemon_preferences,
   - pokemon_mock,
   - pokemon_list (editado),
   - create_pokemon_card,
   - create_poke_alert,
   - pokemon_provider,
   - pokemon_model,
   - poke_response_model
     
* Archivos utilizdos por Emiliano:
   - habilidades_pokemon,
   - habilidades_screen,
   - pokemon_card,
   - pokemon_detail_screen
  
* Globales:
   - home_screen (editado),
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
> [!IMPORTANT]
> Este archivo fue modificado.
<br> </br>
![image](https://github.com/user-attachments/assets/23dc8667-232c-4e6c-aa0c-50808ae23775)
<br> <br>

Es una screen en donde se muestra en un grid de 2 columnas todos los Pokemon del mock, generandolo con un 'List.generate' y  pasandole los parametros de cada uno a un widget con una card.
<br>
![image](https://github.com/user-attachments/assets/05a9bad4-7d25-4992-b50a-89916a7c78d4)
<br>
Fue modificado para que sea un stateful widget y utilice el PokemonProvider, future builder para la petición, y un scroll controller, sumado a que hay un pequeño gif de carga debajo cuando se hace la petición para traer mas pokemon.
<br>
![image](https://github.com/user-attachments/assets/13cb382f-9526-4b9b-9de4-59d74477ae6b)


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

<br> </br>
> [!IMPORTANT]
> Los siguientes archivos fueron creados o modificados.

### home_screen
![image](https://github.com/user-attachments/assets/ae14079f-4de7-4761-bd5b-9defded5be04)
<br>
Este archivo fue modificado como 'pokemon_list' con el mimso objetivo, poder utilizar el future builder en la parte de los scroll horizontales y el funcionamiento de PokemonProvider para que traiga los primeros 10 pokemon.
<br>
Se modificó Horizontal Swipper para que el apartado de 'Lista de Pokemones' y 'Favoritos' se comporten de forma diferente. Se hace un chequeo de si cargaron por primera vez los pokemon y se chequea de que si son +10. 
<br>
Si se hace un scroll en 'Lista de Pokemones' te lleva a un card de 'Ver mas'.
<br>
![image](https://github.com/user-attachments/assets/3878e869-3b33-4260-8283-59d102bbb859)
<br>
Si se hace lo mismo se realiza en 'Favoritos', deberia de no verse ese elemento extra y mostrar los favoritos.
<br>
![image](https://github.com/user-attachments/assets/972cd22a-c62c-4f93-bea8-e2cd6c479bc3)


### pokemon_provider
![image](https://github.com/user-attachments/assets/b67ae45a-47ab-4b7f-9708-72a7b4f450b5)
<br>

Este provider tiene dos funcionalidades, la de obtener todos los pokemones u obtener cada uno de forma individual.
1. 'getPokemon': En el primero, la peticion se hace de a 10 y la paginacion con un 'offset' que se aumenta 10 unidades. Por cada pokemon se extrae su id desde la url para llamar a 'getPokemonById' para luego ser agregado a la lista que se devuelve con la información. Como se busca que se traiga de forma rápida, al final se ordenan por orden de id. En este caso se utiliza 'poke_response_model' para obtener la url.
2. 'getPokemonById': Utiliza 'pokemon_model' para devolver la infromación
3. '_extraerIdUrl': Es una función auxiliar para poder descomoponer la url y extraer correctamente el id. Posee varios flags para corrborar.
   
<br>

![image](https://github.com/user-attachments/assets/dc4458ff-bf3d-4fdc-90a0-82398aa6c2f8)


### pokemon_model
![image](https://github.com/user-attachments/assets/dc39da6a-33c6-45ce-a224-82aee9a2ac1d)
<br>
Se creó para parsear respuestas del siguiente tipo:
```
{
  "msg": "OK",
  "data": {
    "id": 86,
    "name": "seel",
    "xp": 65,
    "sprite": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/86.png"
  }
}
```

### poke_response_model
![image](https://github.com/user-attachments/assets/4f6329cc-1d94-4e1e-b3b1-7354075dd717)
<br>
Se creó para parsear respuestas del siguiente tipo:
```
{
  "msg": "OK",
  "data": {
    "count": 1304,
    "next": "https://pokeapi.co/api/v2/pokemon/?offset=3&limit=2",
    "previous": "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1",
    "results": [
      {
        "name": "ivysaur",
        "url": "https://pokeapi.co/api/v2/pokemon/2/"
      },
      {
        "name": "venusaur",
        "url": "https://pokeapi.co/api/v2/pokemon/3/"
      }
    ]
  }
}
```

--- 

### Emiliano Cortez
### habilidades_pokemon
Se hizo un llamado a la API de Pokémon utilizando el paquete http de Flutter para obtener datos de movimientos y detalles de Pokémon. Se realizó una solicitud GET a la URL de la API, se procesó la respuesta en formato JSON y se tomaron los datos como el nombre, tipo y movimientos de los Pokémon.
<br>

### habilidades_screen
Se implementó una pantalla en Flutter que muestra una lista de Pokémon utilizando un ListView.builder. Los datos se obtienen desde un servicio de API, se procesan y se renderizan en tarjetas personalizadas (PokemonCard), con colores según el tipo de Pokémon.
<br>

### pokemon_card
Se creó un widget personalizado (PokemonCard) que muestra la información de un Pokémon en una tarjeta estilizada con colores y un ícono SVG basado en su tipo. Al tocar la tarjeta, se navega a una pantalla de detalles del Pokémon
<br>
![Imagen](https://github.com/user-attachments/assets/390060b6-e01e-40e8-ac27-cefbfca3ea50)

### pokemon_detail_screen
Pantalla dinamica detallada con cada pokemon que permite personalizar apodos y guardar tu pokemon favorito utilizando shared preferences
<br>
![Imagen](https://github.com/user-attachments/assets/d79af76c-66f8-4f23-894d-c6beafaf5c52)










     
     

