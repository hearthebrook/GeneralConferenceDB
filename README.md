# Overview

For this project I'm developing an app with a variety of General Conference games along with a way for the user to keep track of their notes on the speaker.

To accomplish this, I had to create my own cloud database for the apostles because the Church of Jesus Christ of Latter Day Saints doesn't have one available. I used firestore to do this which has great instructions on how to connect it to my swift ios project.
{Describe your purpose for writing this software.}



[Software Demo Video](https://youtu.be/nesZNxlv-6I)

# Cloud Database
Like I said above, I'm using the Firebase platform to store my data. It is structured with each apostle having information about them, including a bio, ordination data, along with a few other things. 

The database has the following json format:

"Nelson": {
      "name": "Russell M. Nelson",
      "birthDate": "September 9, 1924",
      "ordinationDate": "April 7, 1984",
      "quorum": "Quorum of the Twelve Apostles",
      "position": "President of the Church",
      "biography": "Russell Marion Nelson Sr. is an American religious leader and former surgeon who is the 17th and current president of The Church of Jesus Christ of Latter-day Saints (LDS Church). He was a member of the Quorum of the Twelve Apostles for nearly 34 years and was the quorum president from 2015 to 2018. Nelson studied medicine and served as a thoracic surgeon, specializing in the treatment of heart disease."
      }

# Development Environment

For the start of this project I used SwiftUI integrated with Firebase.


# Useful Websites

- [Firebase and Swift set up](https://medium.com/cleansoftware/firebase-database-minimalistic-step-by-step-deployment-tutorial-using-swift-5-21e934209929)
- [Knowband fetching data](https://www.knowband.com/blog/tips/fetch-data-firebase-swift-language-ios/)
- [Apple documentation NSDictionary](https://developer.apple.com/documentation/foundation/nsdictionary)

# Future Work

- Get user interface set up so user can take notes
- Organize different screens for games
- Set up multi platform access for the user
