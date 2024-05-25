# QuantoTestApp

Demo Video of the App

https://github.com/Nurbo1/QuantoTestApp/assets/67631507/0c76680a-34ec-4ffd-aad0-7cfbecafc568


QuantoTestApp - это приложение для iOS, разработанное на языке Swift, которое загружает фотографии из внешнего API и отображает их в коллекции. Пользователи могут просматривать фотографии, искать по названиям, обновлять коллекцию жестом pull-to-refresh и увеличивать изображения для просмотра.

## Как запустить приложение

1. Клонируйте репозиторий на свой компьютер.
2. Откройте проект в Xcode.
3. Убедитесь, что ваше устройство или симулятор соответствует минимальным требованиям версии iOS (проверьте в файле `ViewController.swift`).
4. Запустите приложение на своем устройстве или симуляторе.

## Основные функции

- **Отображение фотографий**: Каждая ячейка в коллекции содержит фотографию, загруженную из внешнего API.
- **Отображение названий фотографий**: Каждая ячейка также отображает название фотографии.
- **Интеграция с внешним API**: Приложение взаимодействует с внешним API (https://jsonplaceholder.typicode.com/photos) для загрузки данных о фотографиях.
- **Адаптация под разные устройства**: Приложение адаптируется для работы как на устройствах iPhone, так и на iPad в портретной и альбомной ориентации.

## Дополнительные функции

- **Поиск фотографий**: Пользователи могут искать фотографии по названиям.
- **Обновление фотографий**: Пользователи могут обновить коллекцию фотографий, сделав жест pull-to-refresh.
- **Пагинация**: Реализован механизм пагинации нативным способом для iOS, загружающий контент при прокрутке вниз.

## Использование

1. **Просмотр фотографий**: После запуска приложения вы увидите коллекцию фотографий, каждая из которых содержит изображение и название. Прокручивайте вниз, чтобы просмотреть больше фотографий.

2. **Поиск фотографий**: В верхней части экрана есть строка поиска. Введите ключевое слово в поле поиска, чтобы отфильтровать фотографии по названию.

3. **Обновление фотографий**: Чтобы обновить коллекцию фотографий, потяните экран вниз, чтобы активировать жест pull-to-refresh.

4. **Увеличение изображения**: Нажмите на любую фотографию в коллекции, чтобы увидеть ее в увеличенном виде.

5. **Ориентация устройства**: Приложение поддерживает работу как в портретной, так и в альбомной ориентации на устройствах iPhone и iPad.


# QuantoTestApp

QuantoTestApp is an iOS application that loads photos from an external API and displays them in a collection view. Users can browse through the photos, search by photo titles, refresh the collection using pull-to-refresh, and view enlarged images.

## Running the App

1. Clone the repository to your computer.
2. Open the project in Xcode.
3. Ensure that your device or simulator meets the minimum iOS version requirements (check in the `ViewController.swift` file).
4. Run the application on your device or simulator.

## Features

### Core Features:

- **Display Photos**: Each cell in the collection view contains a photo loaded from the external API.
- **Display Photo Titles**: Each cell also displays the title of the photo.
- **API Integration**: The application interacts with an external API (https://jsonplaceholder.typicode.com/photos) to load photo data.
- **Device Adaptability**: The application adapts to work on both iPhone and iPad devices in both portrait and landscape orientations.

### Bonus Features:

- **Photo Search**: Users can search for photos by title.
- **Photo Refresh**: Users can refresh the photo collection by performing a pull-to-refresh gesture.
- **Pagination**: Implemented pagination mechanism natively for iOS, loading content as the user scrolls down.

## Usage

1. **Viewing Photos**: Upon launching the application, you'll see a collection of photos, each featuring an image and a title. Scroll down to view more photos.

2. **Searching Photos**: At the top of the screen, there's a search bar. Enter a keyword in the search field to filter photos by their titles.

3. **Refreshing Photos**: To refresh the collection of photos, simply pull down the screen to activate the pull-to-refresh gesture.

4. **Zooming Images**: Tap on any photo in the collection to view it in an enlarged format.

5. **Device Orientation**: The app supports both portrait and landscape orientations on iPhone and iPad devices.
