## Image Viewer

This is a demo application. This application uses Objective-C with no 3rd party frameworks. This app is Portrait mode only.

Please watch the .mov files in repository!

In this project I've used Pixabay Open-Source Image API to view images. You can read more in documentation [https://pixabay.com/api/docs/#api_search_images]. The categories for images are pre-decided. They're Education, Nature, Food and Science. On selection you'll be taken to the detail page to view the photos. The photos contain some metadata information like number of views, number of likes, number of downloads and number of people who marked it as their favorite. 

You can swipe the view to cycle through images, The images are being cached using NSCache. NSCache manages memory pressure and releases memory as it wants. You can also swipe down on any image to load an image which is not currently present in your image stack. 
