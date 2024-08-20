# Domain model
![domain_model](https://github.com/user-attachments/assets/399f0e5b-f544-492d-998c-66c2626747cb)
---
```
@startuml

object user {
    name
    surname
    id
    team
    enum user_type
    enum mood
    enum sentiment
}

object user_type {
    employee
    FAS
    HR
}

object sentiment {
    enum sentiment_type
    enum sentiment_reason
    sentiment_comment
    sentiment_date
}

object mood {
    enum mood_type
    mood_date
    mood_id
}

object feedback {
    enum feedback_phrase
    feedback_comment
    sentiment
    user_sending
    user_receiving
}

object team {
    users[]
}

object gratitude {
    enum gratitude_phrase
    user_sending
    user_receiving
    gratitude_id
}

user -left- team : has
user_type -left- user : has
sentiment -- user : has
mood -- user : has
feedback -right- sentiment: can receive
feedback -- user : can give 
gratitude -- user : can give and receive

note bottom of feedback: inviato solo da user_type: FAS e HR

@enduml
```
