# API
In risposta agli [use cases](use_cases.md)
- POST user/{id}/sentiment  
    {
        sentiment_type  
        sentiment_reason  
        sentiment_ comment  
        sentiment_date
    }  
[SENTIMENT_USER_01]

- GET user/{id}/sentiment/{sentiment_date}  
*Per ogni membro del team/dell'azienda in base all'user_type*  
[SENTIMENT_USER_02], [TEAM_EMPLOYEE_01], [TEAM_HR_01]

- PUT/DELETE user/{id}/sentiment/{sentiment_date}  
[SENTIMENT_USER_03]

- POST user/{id}/mood  
    {
        mood_type  
        mood_date
    }  
[SENTIMENT_USER_04], [SENTIMENT_USER_07]

- GET user/{id}/mood/{mood_id}  
*Per ogni membro del team*  
[SENTIMENT_USER_05], [TEAM_EMPLOYEE_02]

- PUT/DELETE user/{id}/mood/{mood_id}  
[SENTIMENT_USER_06]

- GET feedback/{user_receiving}  
[SENTIMENT_USER_08]

- POST gratitude  
    {
        gratitude_phrase  
        user_sending  
        user_receiving
        gratitude_id
    }  
[BOARD_USER_02]

- GET gratitude/{gratitude_id}  
[BOARD_USER_01]

- GET user/{id}/mood/{mood_id}  
*Per ogni membro del team*  
[TEAM_EMPLOYEE_02]

- POST feedback  
    {
        feedback_phrase  
        feedback_comment   
        sentiment  
        user_sending  
        user_receiving
    }   
[TEAM_FAS-HR_01]

- GET feedback/{user_sending}  
[TEAM_FAS-HR_02]
