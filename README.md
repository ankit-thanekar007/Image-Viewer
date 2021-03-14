## Image Viewer

This application uses Objective-C with no 3rd party frameworks. This app is Portrait mode only.

Please watch the .mov files in repository!

In this project I've used Pixabay Open-Source Image API to view images. You can read more in documentation [https://pixabay.com/api/docs/#api_search_images]. The categories for images are pre-decided. They're Education, Nature, Food and Science. On selection you'll be taken to the detail page to view the photos. The photos contain some metadata information like number of views, number of likes, number of downloads and number of people who marked it as their favorite. 

You can swipe the view to cycle through images, The images are being cached using NSCache. NSCache manages memory pressure and releases memory as it wants. You can also swipe down on any image to load an image which is not currently present in your image stack. 

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-03-13 at 21 55 57](https://user-images.githubusercontent.com/26094255/111058981-1bddd780-8447-11eb-96d0-21eee12e0966.png)

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-03-13 at 21 56 04](https://user-images.githubusercontent.com/26094255/111058983-1e403180-8447-11eb-87da-692db64005de.png)

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-03-13 at 21 56 06](https://user-images.githubusercontent.com/26094255/111058984-1ed8c800-8447-11eb-98b6-db1b65d52845.png)

![Simulator Screen Shot - iPhone 12 Pro Max - 2021-03-13 at 21 56 09](https://user-images.githubusercontent.com/26094255/111058986-1f715e80-8447-11eb-98b0-0eed8f7f2b72.png)
