---
date: "2020-10-27T15:07:56Z"
tags:
- database
- sql
- postgres
title: SQL and Asking Questions
---

**What's the difference between relational and NoSQL databases and when do you choose one over the other?**

Strangely, not many developers can give you some comprehensive and tangible answer for this question. I'm not going to delve into the details, because there's already so [many](https://www.mongodb.com/scale/nosql-vs-relational-databases) [places](https://docs.microsoft.com/en-us/dotnet/architecture/cloud-native/relational-vs-nosql-data) that explain the differences (mainly data model, data structure, scaling and development model).

I just decided to write this post because right now I found another very compelling reason for using relational database over document-based databases when I was listening to "The Change log" podcast, episode "[What's so exciting about Postgres?](https://changelog.com/podcast/417)"

![A Review of Postgres version 12 - Performance Monitoring - Blogs - Quest Community](https://www.quest.com/community/cfs-filesystemfile/__key/communityserver-components-secureimagefileviewer/communityserver-blogs-components-weblogfiles-00-00-00-00-39/Slide2.JPG_2D00_1100x500x2.jpg?_=637219525519183603)

**Analytics!** Or more simply, **asking questions**. Imagine you've got tons of data and now you want to find out about "How many users signed up during the last week?" If you're using a document db, now you've got to go and traverse through those documents three layers deep, something that might not be very much easy.

On the other hand, this is just so darn easy in relational databases, it's actually what SQL was designed to do. This might not be something you need right when you start your project, but as it gets bigger, you definitely want to ask more and more these sorts of questions.

It's not that you can't do these in NoSQL, but both the ease and also the efficiency makes relational databases the clear winner when it comes to analytics.