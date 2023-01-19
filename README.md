# Integrating Transformers into IOS applications

This repository explores several ways of integreating transformers models into ios applications using SwiftUI.


## Chatbot

Chatbot using the traditional server-client approach, with a listening RESTful API in [`api`](https://github.com/qiushiyan/ios-transformers/tree/main/api)

![](https://raw.githubusercontent.com/qiushiyan/ios-transformers/main/docs/images/gpt3.png)

## Question Answering

QA app with a CoreML model directly built into the bundle, converted from DistillBert. Users can first scan arbitrary text and then ask questions.

![](https://raw.githubusercontent.com/qiushiyan/ios-transformers/main/docs/images/QA.png)